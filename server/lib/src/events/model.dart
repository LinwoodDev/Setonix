import 'dart:io';

import 'package:networker/networker.dart';
import 'package:quokka_api/quokka_api.dart';

import '../server.dart';

mixin ServerReference {
  QuokkaServer get server;

  void sendEvent(ServerWorldEvent event, [Channel target = kAnyChannel]) =>
      server.sendEvent(event, target);

  WorldState get state => server.state;

  GameTable? getTable(String name) => state.getTable(name);
  GameTable getTableOrDefault(String name) => state.getTableOrDefault(name);
}

base class Event<T> with ServerReference {
  @override
  final QuokkaServer server;
  final T clientEvent;
  final Channel source;
  ServerWorldEvent serverEvent;
  Channel target;
  bool cancelled = false;

  Event(this.server, this.serverEvent, this.target, this.clientEvent,
      this.source);

  Event<C> castEvent<C extends WorldEvent?>() {
    return _LinkedEvent<C>(this);
  }

  void cancel() {
    cancelled = true;
  }
}

final class _LinkedEvent<T extends WorldEvent?>
    with ServerReference
    implements Event<T> {
  final Event parent;

  _LinkedEvent(this.parent);

  @override
  bool get cancelled => parent.cancelled;
  @override
  set cancelled(bool value) => parent.cancelled = value;

  @override
  ServerWorldEvent get serverEvent => parent.serverEvent;
  @override
  set serverEvent(ServerWorldEvent value) => parent.serverEvent = value;

  @override
  Channel get target => parent.target;
  @override
  set target(Channel value) => parent.target = value;

  @override
  void cancel() => parent.cancel();

  @override
  Event<C> castEvent<C extends WorldEvent?>() => parent.castEvent();

  @override
  T get clientEvent => parent.clientEvent as T;

  @override
  QuokkaServer get server => parent.server;

  @override
  Channel get source => parent.source;
}

final class ServerPing {
  final Uri address;
  final HttpRequest request;
  GameProperty response;

  ServerPing({
    required this.address,
    required this.request,
    required this.response,
  });
}
