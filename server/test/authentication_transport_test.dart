import 'dart:io';

import 'package:setonix_server/src/server.dart';
import 'package:test/test.dart';

void main() {
  test('insecure authentication is limited to loopback or explicit opt-in', () {
    expect(
      canUseInsecureAuthentication(InternetAddress.loopbackIPv4, false),
      isTrue,
    );
    expect(
      canUseInsecureAuthentication(InternetAddress.anyIPv4, false),
      isFalse,
    );
    expect(canUseInsecureAuthentication(InternetAddress.anyIPv6, true), isTrue);
  });
}
