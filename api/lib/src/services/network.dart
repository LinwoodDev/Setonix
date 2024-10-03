import 'dart:io';

import 'package:quokka_api/event.dart';

Future<bool> Function(HttpRequest request) buildFilterConnections(
        {GameProperty? property}) =>
    (request) async {
      final response = request.response;
      response.headers.add("Access-Control-Allow-Origin", "*");
      response.headers.add("Access-Control-Allow-Methods", "GET,INFO");

      response.statusCode = HttpStatus.ok;
      String? sendMessage;
      try {
        final method = request.headers.value('X-Quokka-Method');
        if (method == 'info') {
          sendMessage = (property ?? GameProperty.defaultProperty).toJson();
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
