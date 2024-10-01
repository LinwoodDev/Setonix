import 'dart:async';

import 'package:networker/networker.dart';
import 'package:quokka_server/server.dart';

typedef ListenerResult<S> = (S, Channel)?;

typedef EventListener<T, S> = FutureOr<ListenerResult<S>> Function(
  S serverEvent,
  Channel target,
  T clientEvent,
  Channel source,
  QuokkaServer server,
);

final class EventSystem<T, S> {
  final Map<T, List<EventListener<T, S>>> _listeners = {};

  void addListener(T event, EventListener<T, S> listener) {
    _listeners.putIfAbsent(event, () => []).add(listener);
  }

  void removeListener(T event, EventListener<T, S> listener) {
    _listeners[event]?.remove(listener);
  }

  Future<ListenerResult<S>> dispatch(
    S serverEvent,
    Channel target,
    T clientEvent,
    Channel source,
    QuokkaServer server,
  ) async {
    final listeners = _listeners[clientEvent];
    if (listeners == null) return null;
    ListenerResult<S> result = (serverEvent, target);
    for (final listener in listeners) {
      if (result == null) return null;
      result =
          await listener(result.$1, result.$2, clientEvent, source, server);
    }
    return result;
  }
}
