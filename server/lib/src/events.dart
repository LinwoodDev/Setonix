import 'dart:async';

import 'package:networker/networker.dart';
import 'package:quokka_api/quokka_api.dart';
import 'package:quokka_server/src/server.dart';

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

final class EventSystem {
  final StreamController<Event> _controller =
      StreamController.broadcast(sync: true);

  Stream<Event<T>> on<T extends WorldEvent?>() {
    if (T == dynamic) {
      return _controller.stream as Stream<Event<T>>;
    }
    return _controller.stream
        .where((event) => event.clientEvent is T)
        .map((event) => event.castEvent<T>());
  }

  void fire(Event event) {
    _controller.add(event);
  }

  void dispose() {
    _controller.close();
  }
}
