import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:town/cubits/settings.dart';
import 'package:town/models/server.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConnectionService {
  final SettingsCubit settingsCubit;

  ConnectionService(this.settingsCubit);

  Stream<List<GameServer>> fetchServers() async* {
    // Fetch lan servers from udp gateway broadcast
    if (kIsWeb) {
      yield [];
    } else {
      yield [];
    }
  }
}

class GameConnection {}

abstract class ClientGameConnect extends GameConnection {
  final WebSocketChannel channel;

  ClientGameConnect(this.channel);
}

abstract class ServerGameConnect extends GameConnection {
  final WebSocket socket;

  ServerGameConnect(this.socket);
}
