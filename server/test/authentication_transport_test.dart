import 'dart:io';

import 'package:setonix_server/src/server.dart';
import 'package:test/test.dart';

void main() {
  group('authentication origin', () {
    test('uses a concrete bind host without extra configuration', () {
      expect(
        resolveAuthenticationOrigin(
          publicAddress: '',
          host: 'play.example.com',
          port: 28006,
          tlsEnabled: true,
        ),
        'wss://play.example.com:28006',
      );
    });

    test('requires the public origin for wildcard binds', () {
      expect(
        () => resolveAuthenticationOrigin(
          publicAddress: '',
          host: InternetAddress.anyIPv4.address,
          port: 28006,
          tlsEnabled: true,
        ),
        throwsStateError,
      );
    });

    test('uses an explicit public WSS origin behind a proxy', () {
      expect(
        resolveAuthenticationOrigin(
          publicAddress: 'https://PLAY.example.com:443/path',
          host: InternetAddress.loopbackIPv4.address,
          port: 28006,
          tlsEnabled: false,
        ),
        'wss://play.example.com:443',
      );
    });

    test('rejects a plaintext origin when direct TLS is enabled', () {
      expect(
        () => resolveAuthenticationOrigin(
          publicAddress: 'ws://play.example.com:28006',
          host: InternetAddress.anyIPv4.address,
          port: 28006,
          tlsEnabled: true,
        ),
        throwsStateError,
      );
    });
  });
}
