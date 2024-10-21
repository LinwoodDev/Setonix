import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:setonix/bloc/settings.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:rxdart/rxdart.dart';

const kTimeoutDelay = Duration(seconds: 5);
const kBroadcastDelay = Duration(seconds: 1);

class NetworkService {
  final SettingsCubit settingsCubit;
  RawDatagramSocket? _server;

  final BehaviorSubject<List<(GameServer, LanProperty?)>> _servers =
      BehaviorSubject.seeded([]);

  NetworkService(this.settingsCubit);

  Future<void> init() async {
    if (!kIsWeb) {
      try {
        _server = (await RawDatagramSocket.bind(
            InternetAddress.anyIPv4, kBroadcastPort))
          ..broadcastEnabled = true;
      } catch (_) {}
    }
    _fetchServers().listen((event) {
      _servers.add(event);
    });
  }

  void dispose() {
    if (kIsWeb) return;
    _server?.close();
  }

  Stream<List<(GameServer, LanProperty?)>> _fetchServers({
    bool list = true,
  }) async* {
    List<(GameServer, LanProperty?)> buildServers(
        [List<(GameServer, LanProperty?)> other = const []]) {
      return [
        if (list) ...settingsCubit.state.servers.map((e) => (e, null)),
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

    final settingsStream = settingsCubit.stream.map((event) => buildServers());

    if (kIsWeb) {
      yield* settingsStream;
      return;
    }
    final serverStream = _server
        ?.where((event) => event == RawSocketEvent.read)
        .map((RawSocketEvent event) {
      removeOld();
      final datagram = _server?.receive();
      if (datagram != null) {
        final message = String.fromCharCodes(datagram.data);
        final property = LanPropertyMapper.fromJson(message);
        networkedServers[datagram.address.address] = (DateTime.now(), property);
      }
      return buildServers(
        networkedServers.entries
            .map((e) => (
                  LanGameServer(
                    address: '${e.key}:${e.value.$2.port}',
                    secure: false,
                  ),
                  e.value.$2
                ))
            .toList(),
      );
    });
    yield* Rx.merge([if (serverStream != null) serverStream, settingsStream]);
  }

  (Timer, RawDatagramSocket)? _broadcast;

  Future<void> sendServerInfo(LanProperty property) async {
    if (kIsWeb) return;
    cancelServerInfo();
    final message = property.toJson();
    final data = message.codeUnits;
    final destination = InternetAddress('255.255.255.255');
    final socket =
        await RawDatagramSocket.bind(InternetAddress.anyIPv4, kBroadcastPort);
    socket.broadcastEnabled = true;
    _broadcast = (
      Timer.periodic(kBroadcastDelay, (_) {
        socket.send(data, destination, kBroadcastPort);
      }),
      socket
    );
  }

  void cancelServerInfo() {
    _broadcast?.$1.cancel();
    _broadcast?.$2.close();
    _broadcast = null;
  }

  Future<GameProperty?> fetchInfo(Uri address) async {
    try {
      final response = await http.get(address, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'X-Setonix-Method': 'info',
      });
      if (response.statusCode != HttpStatus.ok) return null;

      return GamePropertyMapper.fromJson(response.body);
    } catch (_) {
      return null;
    }
  }

  Stream<Map<GameServer, GameProperty?>> fetchServersWithProperties({
    bool list = true,
  }) async* {
    Map<GameServer, Future<GameProperty?>> cached = {};
    Future<GameProperty?> fetch(
        GameServer server, LanProperty? property) async {
      property ??= const LanProperty();
      return cached[server] ??
          switch (server) {
            LanGameServer() =>
              Future.value(GameProperty(description: property.description)),
            ListGameServer() => cached[server] =
                fetchInfo(server.buildAddress(webSockets: false))
                    .onError((_, __) => null),
          };
    }

    final returned = <GameServer, GameProperty?>{};
    yield returned;

    await for (final event in _servers) {
      returned.removeWhere((key, value) => !event.any((e) => e.$1 == key));
      for (final (server, _) in event) {
        returned[server] = const GameProperty();
      }
      yield returned;

      if (event.isEmpty) {
        continue;
      }

      for (final e in event) {
        try {
          returned[e.$1] = await fetch(e.$1, e.$2);
        } catch (_) {
          returned[e.$1] = null;
        }
        yield returned;
      }
    }
  }
}
