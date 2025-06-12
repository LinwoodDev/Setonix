import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:cryptography_plus/cryptography_plus.dart';

Future<String> generateFingerprint(Uint8List publicKeyBytes,
    [bool short = false]) async {
  final digest = await Sha256().hash(publicKeyBytes);
  var hexString = hex.encode(digest.bytes);
  if (short) {
    hexString = hexString.substring(0, 32);
  }
  final output = hexString.replaceAllMapped(
    RegExp(r'.{2}'),
    (match) => '${match.group(0)!}:',
  );

  return output.endsWith(':') ? output.substring(0, output.length - 1) : output;
}
