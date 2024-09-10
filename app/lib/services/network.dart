import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:quokka/bloc/settings.dart';
import 'package:quokka_api/quokka_api.dart';

const kTimeoutDelay = Duration(seconds: 5);

class NetworkService {
  final SettingsCubit settingsCubit;
  late final RawDatagramSocket _server;

  NetworkService(this.settingsCubit);

  Future<void> init() async {
    if (kIsWeb) return;
    _server =
        await RawDatagramSocket.bind(InternetAddress.anyIPv4, kBroadcastPort);
    _server.broadcastEnabled = true;
  }

  Stream<List<GameServer>> fetchServers({
    bool list = true,
  }) async* {
    List<GameServer> buildServers([List<GameServer> other = const []]) {
      return [
        if (list) ...settingsCubit.state.servers,
        ...other,
      ];
    }

    yield buildServers();

    final networkedServers = <String, (DateTime, LanProperty)>{};

    void removeOld() {
      final now = DateTime.now();
      networkedServers.removeWhere((key, value) {
        return now.difference(value.$1) > kTimeoutDelay;
      });
    }

    if (!kIsWeb) return;
    yield* _server
        .where((event) => event == RawSocketEvent.read)
        .map((RawSocketEvent event) {
      final datagram = _server.receive();
      if (datagram != null) {
        final message = String.fromCharCodes(datagram.data);
        final property = LanPropertyMapper.fromJson(message);
        networkedServers[datagram.address.address] = (DateTime.now(), property);
      }
      removeOld();
      return buildServers(
        networkedServers.entries
            .map((e) => LanGameServer(
                  address: '${e.key}:${e.value.$2.port}',
                  secure: true,
                  description: e.value.$2.description,
                ))
            .toList(),
      );
    });
  }

  Future<GameProperty?> fetchInfo(Uri address) async {
    final response = await http.get(address, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'X-Quokka-Method': 'info',
    });
    return GamePropertyMapper.fromJson(response.body);
  }

  Stream<Map<GameServer, GameProperty?>> fetchServersWithProperties({
    bool list = true,
  }) async* {
    Map<GameServer, Future<GameProperty?>> cached = {};
    Future<GameProperty?> fetch(GameServer server) async {
      return cached[server] = cached[server] ??
          switch (server) {
            LanGameServer() =>
              Future.value(GameProperty(description: server.description)),
            ListGameServer() =>
              fetchInfo(server.toHttps()).onError((_, __) => null),
          };
    }

    await for (final event in fetchServers(list: list)) {
      final returned = <GameServer, GameProperty?>{};
      for (final server in event) {
        returned[server] = const GameProperty();
      }

      yield* Stream.fromFutures(event.map((e) async {
        returned[e] = await fetch(e);
        return returned;
      }));
    }
  }
}
