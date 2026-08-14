import 'dart:async';
import 'dart:io';

import 'package:networker/networker.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_plugin/events.dart';
import 'package:setonix_plugin/src/events/model.dart';

typedef EventHandler<T extends WorldEvent> = Future<void> Function(
  Event<T> event,
);

final class EventSubscription<T extends WorldEvent> {
  final EventHandler<T> _handler;
  final EventBus<T> _bus;

  EventSubscription(this._bus, this._handler);

  void cancel() {
    _bus._handlers.remove(_handler);
  }
}

final class EventBus<T extends WorldEvent> {
  final Set<EventHandler<T>> _handlers = {};

  EventSubscription<T> on<U extends WorldEvent>(
    FutureOr<void> Function(Event<U>) handler,
  ) {
    Future<void> wrappedHandler(Event<T> event) async {
      if (event.clientEvent is U) {
        await handler(event.castEvent<U>());
      }
    }

    _handlers.add(wrappedHandler);
    return EventSubscription<T>(this, wrappedHandler);
  }

  Future<void> fire(Event<T> event) async {
    for (final handler in _handlers) {
      await handler(event);
    }
  }

  void clear() {
    _handlers.clear();
  }

  LinkedEventBus<U> castBus<U extends WorldEvent>() {
    return LinkedEventBus<U>();
  }
}

final class LinkedEventBus<T extends WorldEvent> {
  final EventBus<T> _bus = EventBus<T>();

  EventSubscription<T> on<U extends WorldEvent>(
    Future<void> Function(Event<U>) handler,
  ) {
    return _bus.on<U>(handler);
  }

  Future<void> fire(Event<T> event) async {
    await _bus.fire(event);
  }

  void clear() {
    _bus.clear();
  }
}

final class EventSystem extends EventBus {
  final StreamController<ServerPing> _pingController =
      StreamController.broadcast();
  final StreamController<UserLeaveCallback> _leaveController =
      StreamController.broadcast();

  Stream<ServerPing> get ping => _pingController.stream;
  Stream<UserLeaveCallback> get leave => _leaveController.stream;

  GameProperty runPing(HttpRequest request, GameProperty property) {
    if (_pingController.isClosed) return property;
    final ping = ServerPing(request: request, response: property);
    _pingController.add(ping);
    return ping.response;
  }

  void runLeaveCallback(Channel channel, ConnectionInfo info) {
    if (_leaveController.isClosed) return;
    final callback = UserLeaveCallback(channel: channel, info: info);
    _leaveController.add(callback);
  }

  void dispose() {
    if (!_pingController.isClosed) _pingController.close();
    if (!_leaveController.isClosed) _leaveController.close();
  }
}
