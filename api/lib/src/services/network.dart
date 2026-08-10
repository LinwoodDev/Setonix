import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:setonix_api/event.dart';

const kThumbnailMethod = 'thumbnail';
const kInfoMethod = 'info';
const kMaxThumbnailSize = 512 * 1024;
const kAllowedThumbnailContentTypes = {'image/png', 'image/jpeg', 'image/webp'};

final class ServerThumbnail {
  final Uint8List bytes;
  final String contentType;

  const ServerThumbnail({required this.bytes, required this.contentType});
}

Future<bool> Function(HttpRequest request) buildFilterConnections({
  FutureOr<GameProperty> Function(HttpRequest request)? loadProperty,
  FutureOr<ServerThumbnail?> Function(HttpRequest request)? loadThumbnail,
  List<int> supportedProtocolVersions = kSetonixServerProtocolVersions,
}) => (request) async {
  final response = request.response;
  response.headers.add("Access-Control-Allow-Origin", "*");
  response.headers.add("Access-Control-Allow-Methods", "GET,OPTIONS");
  response.headers.add("Access-Control-Allow-Headers", "X-Setonix-Method");
  response.headers.add("Access-Control-Expose-Headers", "Content-Length");

  response.statusCode = HttpStatus.ok;
  if (request.method == 'OPTIONS') {
    response.close();
    return false;
  }
  String? sendMessage;
  try {
    final method = request.headers.value('X-Setonix-Method');
    if (method == kInfoMethod) {
      sendMessage =
          ((await loadProperty?.call(request)) ?? GameProperty.defaultProperty)
              .toJson();
    } else if (method == kThumbnailMethod) {
      final thumbnail = await loadThumbnail?.call(request);
      if (thumbnail == null) {
        response.statusCode = HttpStatus.notFound;
        response.close();
        return false;
      }
      if (!kAllowedThumbnailContentTypes.contains(thumbnail.contentType) ||
          thumbnail.bytes.length > kMaxThumbnailSize) {
        response.statusCode = HttpStatus.unsupportedMediaType;
        response.close();
        return false;
      }
      response.headers.contentType = ContentType.parse(thumbnail.contentType);
      response.headers.contentLength = thumbnail.bytes.length;
      response.add(thumbnail.bytes);
      response.close();
      return false;
    }
  } catch (_) {}
  if (sendMessage != null) {
    response.statusCode = HttpStatus.ok;
    response.write(sendMessage);
    response.close();
    return false;
  }
  final clientProtocolVersion = readSetonixProtocolVersion(request.uri);
  if (clientProtocolVersion == null ||
      !supportedProtocolVersions.contains(clientProtocolVersion)) {
    response.statusCode = HttpStatus.upgradeRequired;
    response.headers.set(
      'X-Setonix-Protocol-Versions',
      supportedProtocolVersions.join(','),
    );
    response.write(
      KickMessage(
        message:
            'Incompatible Setonix protocol. Expected one of '
            '${supportedProtocolVersions.join(', ')}, '
            'received ${clientProtocolVersion ?? 'none'}.',
      ).toJson(),
    );
    response.close();
    return false;
  }
  return true;
};
