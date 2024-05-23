import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:networker/networker.dart';
import 'package:quokka/models/message.dart';
import 'package:quokka/models/state.dart';
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
    rpc.addFunction('update', RpcFunction(RpcType.any, onUpdate, false));
    rpc.addFunction('join', RpcFunction(RpcType.authority, onJoin, true));
    rpc.addFunction('leave', RpcFunction(RpcType.authority, onLeave, true));
    rpc.addFunction('init', RpcFunction(RpcType.authority, onInit, false));
  }

  void onInit(RpcMessage message) {
    final networkMessage = NetworkInitMessageMapper.fromMap(message.message);
    _currentId = message.you;
    usersSubject.add(networkMessage.getUsers());
  }

  void onUpdate(RpcMessage message) {
    final networkMessage = NetworkUpdateMessageMapper.fromMap(message.message);
    if (message.receiver != kNetworkerConnectionIdAny &&
        (message.client == kNetworkerConnectionIdAuthority ||
            message.client == networkMessage.id)) return;
    _currentId = message.you;
    final current = users[networkMessage.id] ??
        NetworkingUser(name: message.you.toString());
    usersSubject.add({
      ...users,
      networkMessage.id: NetworkingUser(
        name: networkMessage.name ?? current.name,
        state: networkMessage.state ?? current.state,
        position: networkMessage.position ?? current.position,
        velocity: networkMessage.velocity ?? current.velocity,
      ),
    });
  }

  void onJoin(RpcMessage message) {
    if (message.receiver != kNetworkerConnectionIdAny) return;
    final networkMessage =
        NetworkPlayerJoinMessageMapper.fromMap(message.message);
    _currentId = message.you;
    usersSubject.add({
      ...users,
      networkMessage.id: networkMessage.user,
    });
  }

  void onLeave(RpcMessage message) {
    if (message.receiver != kNetworkerConnectionIdAny) return;
    final networkMessage =
        NetworkPlayerLeaveMessageMapper.fromMap(message.message);
    _currentId = message.you;
    usersSubject.add(Map.from(users)..remove(networkMessage.id));
  }
}
