import 'dart:convert';
import 'dart:io';

import 'package:quokka_api/event.dart';

Future<bool> Function(HttpRequest request) buildFilterConnections(
        {GameProperty? property}) =>
    (request) async {
      final response = request.response;
      response.headers.add("Access-Control-Allow-Origin", "*");
      response.headers.add("Access-Control-Allow-Methods", "GET,INFO");

      response.statusCode = HttpStatus.ok;
      final body =
          request.contentLength < 0 ? '' : await utf8.decodeStream(request);
      String? sendMessage;
      try {
        final bodyData = jsonDecode(body);
        final type = bodyData['type'].toString().toLowerCase();
        if (type == 'info') {
          sendMessage =
              jsonEncode((property ?? GameProperty.defaultProperty).toJson());
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
