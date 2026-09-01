import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

const _authenticationDomain = 'setonix-auth';

Uint8List buildAuthenticationTranscript({
  required int version,
  required String serverId,
  required int channel,
  required DateTime issuedAt,
  required DateTime expiresAt,
  required Uint8List challenge,
}) {
  final serverIdBytes = utf8.encode(serverId);
  if (serverIdBytes.length > 0xffff) {
    throw ArgumentError.value(serverId, 'serverId', 'Server ID is too long.');
  }
  final domainBytes = utf8.encode(_authenticationDomain);
  final builder = BytesBuilder(copy: false)
    ..addByte(domainBytes.length)
    ..add(domainBytes);
  final fixed = ByteData(2 + 2 + 8 + 8 + 8)
    ..setUint16(0, version, Endian.big)
    ..setUint16(2, serverIdBytes.length, Endian.big)
    ..setInt64(4, channel, Endian.big)
    ..setInt64(12, issuedAt.toUtc().microsecondsSinceEpoch, Endian.big)
    ..setInt64(20, expiresAt.toUtc().microsecondsSinceEpoch, Endian.big);
  builder
    ..add(fixed.buffer.asUint8List())
    ..add(serverIdBytes)
    ..add(challenge);
  return builder.toBytes();
}

String generateFingerprint(
  Uint8List publicKeyBytes, {
  bool short = false,
  bool pretty = false,
}) {
  final digest = sha256.convert(publicKeyBytes);
  var hexString = hex.encode(digest.bytes);
  if (short) {
    hexString = hexString.substring(0, 32);
  }
  if (!pretty) {
    return hexString;
  }
  final output = hexString.replaceAllMapped(
    RegExp(r'.{2}'),
    (match) => '${match.group(0)!}:',
  );

  return output.endsWith(':') ? output.substring(0, output.length - 1) : output;
}
