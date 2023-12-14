import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:qeck/cubits/settings.dart';
import 'package:qeck/models/server.dart';
import 'package:qeck/services/messenger.dart';
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
  final BehaviorSubject<NetworkMessenger?> _subject =
      BehaviorSubject.seeded(null);
  Stream<NetworkMessenger?> get stream => _subject.stream;
  NetworkMessenger? get value => _subject.value;
  final SettingsCubit settingsCubit;

  NetworkingService(this.settingsCubit);

  Stream<List<GameServer>> fetchServers() async* {
    // Fetch lan servers from udp gateway broadcast
    if (kIsWeb) {
      yield [];
    } else {
      yield [];
    }
  }
}
