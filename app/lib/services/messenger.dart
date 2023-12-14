import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:networker/networker.dart';
import 'package:qeck/models/state.dart';
import 'package:rxdart/rxdart.dart';

abstract class NetworkMessenger<Event> {
  NetworkerBase get networker;
  RpcPlugin get rpc;
  @protected
  final BehaviorSubject<Map<int, NetworkingUser>> usersSubject =
      BehaviorSubject.seeded({});
  Stream<Map<int, NetworkingUser>> get usersStream => usersSubject.stream;
  Map<int, NetworkingUser> get users => usersSubject.value;
  int _currentId = kNetworkerConnectionIdAuthority;
  int get currentId => _currentId;

  NetworkMessenger() {
    rpc.addFunction('update', RpcFunction(RpcType.any, onUpdate, true));
    rpc.addFunction('join', RpcFunction(RpcType.authority, onJoin, true));
    rpc.addFunction('leave', RpcFunction(RpcType.authority, onLeave, true));
  }

  void onUpdate(RpcMessage message) {
    if (message.receiver != kNetworkerConnectionIdAny) return;
    final user = NetworkingUserMapper.fromMap(message.data);
    _currentId = message.you;
    usersSubject.add({
      ...users,
      message.client: user,
    });
  }

  void onJoin(RpcMessage message) {
    if (message.receiver != kNetworkerConnectionIdAny) return;
    final user = NetworkingUserMapper.fromMap(message.data);
    _currentId = message.you;
    usersSubject.add({
      ...users,
      message.client: user,
    });
  }

  void onLeave(RpcMessage message) {
    if (message.receiver != kNetworkerConnectionIdAny) return;
    _currentId = message.you;
    usersSubject.add(Map.from(users)..remove(message.client));
  }
}
