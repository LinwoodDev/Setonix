import 'dart:async';
import 'dart:io';

import 'package:setonix_api/event.dart';

Future<bool> Function(HttpRequest request) buildFilterConnections({
  FutureOr<GameProperty?> Function(HttpRequest request)? loadProperty,
}) =>
    (request) async {
      final response = request.response;
      response.headers.add("Access-Control-Allow-Origin", "*");
      response.headers.add("Access-Control-Allow-Methods", "GET,INFO");

      response.statusCode = HttpStatus.ok;
      String? sendMessage;
      try {
        final method = request.headers.value('X-Setonix-Method');
        if (method == 'info') {
          sendMessage = ((await loadProperty?.call(request)) ??
                  GameProperty.defaultProperty)
              .toJson();
        }
      } catch (_) {}
      if (sendMessage != null) {
        response.statusCode = HttpStatus.ok;
        response.write(sendMessage);
        response.close();
        return false;
      }
      return true;
    };
