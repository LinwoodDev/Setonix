import 'dart:async';
import 'dart:io';

import 'package:quokka_api/quokka_api.dart';

import 'model.dart';

final class EventSystem {
  final StreamController<Event> _controller =
      StreamController.broadcast(sync: true);
  final StreamController<ServerPing> _pingController =
      StreamController.broadcast(sync: true);

  Stream<Event<T>> on<T extends WorldEvent?>() {
    if (T == dynamic) {
      return _controller.stream as Stream<Event<T>>;
    }
    return _controller.stream
        .where((event) => event.clientEvent is T)
        .map((event) => event.castEvent<T>());
  }

  Stream<ServerPing> get ping => _pingController.stream;

  void fire(Event event) {
    _controller.add(event);
  }

  GameProperty runPing(HttpRequest request, GameProperty property) {
    final ping = ServerPing(request: request, response: property);
    _pingController.add(ping);
    return ping.response;
  }

  void dispose() {
    _controller.close();
    _pingController.close();
  }
}
