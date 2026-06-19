import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

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
