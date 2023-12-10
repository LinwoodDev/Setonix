import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:networker/networker.dart';
import 'package:qeck/cubits/settings.dart';
import 'package:qeck/models/server.dart';
import 'package:rxdart/rxdart.dart';

part 'network.mapper.dart';

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

@MappableClass()
class NetworkingUser with NetworkingUserMappable {
  final String name;
  final (double, double) position;

  const NetworkingUser({
    required this.name,
    required this.position,
  });
}

const kDefaultPort = 28005;
const kTimeout = Duration(seconds: 10);
typedef NetworkingState = (NetworkerBase, RpcPlugin);

class NetworkingService {
  final BehaviorSubject<NetworkingState?> _subject =
      BehaviorSubject.seeded(null);
  final BehaviorSubject<Set<ConnectionId>> _connections =
      BehaviorSubject.seeded({});
  final BehaviorSubject<Map<ConnectionId, NetworkingUser>> _users =
      BehaviorSubject.seeded({});

  Stream<NetworkingState?> get stream => _subject.stream;
  NetworkingState? get state => _subject.value;

  Stream<Set<ConnectionId>> get connectionsStream => _connections.stream;
  Set<ConnectionId> get connections => _connections.value;

  Stream<Map<ConnectionId, NetworkingUser>> get usersStream => _users.stream;
  Map<ConnectionId, NetworkingUser> get users => _users.value;
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
