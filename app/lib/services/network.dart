import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:networker_socket/client.dart';
import 'package:networker_socket/server.dart';
import 'package:quokka/cubits/settings.dart';
import 'package:quokka/models/server.dart';
import 'package:quokka/services/client.dart';
import 'package:quokka/services/server.dart';
import 'package:rxdart/rxdart.dart';

enum NetworkingSide {
  server,
  client,
}

enum NetworkingType {
  webSocket,
  webRtc;

  Future<bool> isCompatible() async => switch (this) {
        NetworkingType.webRtc => kIsWeb ||
            !Platform.isAndroid ||
            (await DeviceInfoPlugin().androidInfo).version.sdkInt >= 28,
        NetworkingType.webSocket => !kIsWeb,
      };
}

const kDefaultPort = 28005;
const kTimeout = Duration(seconds: 10);

class NetworkingService {
  final BehaviorSubject<GenericClientMessenger?> _subject =
      BehaviorSubject.seeded(null);
  Stream<GenericClientMessenger?> get stream => _subject.stream;
  GenericClientMessenger? get value => _subject.value;
  final SettingsCubit settingsCubit;

  NetworkingService(this.settingsCubit);

  Future<void> startServer([int? port]) async {
    port ??= kDefaultPort;
    final server = await HttpServer.bind(InternetAddress.anyIPv4, port);
    final networker = NetworkerSocketServer(server);
    _subject.add(ClientServerMessenger(networker));
  }

  void startClient(Uri uri) {
    if (!uri.hasPort) {
      uri = uri.replace(port: kDefaultPort);
    }
    final networker = NetworkerSocketClient(uri);
    _subject.add(ClientMessenger(networker));
  }

  void closeNetworking() {
    _subject.value?.networker.close();
    _subject.add(null);
  }

  Stream<List<GameServer>> fetchServers() async* {
    // Fetch lan servers from udp gateway broadcast
    if (kIsWeb) {
      yield [];
    } else {
      yield [];
    }
  }
}
