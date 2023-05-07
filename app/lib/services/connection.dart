import 'package:flutter/foundation.dart';
import 'package:qeck/cubits/settings.dart';
import 'package:qeck/models/server.dart';

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
