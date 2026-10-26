import 'dart:io';

import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/proxy.dart';
import 'package:setonix_server/src/server.dart';
import 'package:test/test.dart';

void main() {
  String resolve(List<String> trusted, String peer, List<String> forwarded) =>
      TrustedProxies(trusted)
          .resolveClientAddress(InternetAddress(peer), forwardedFor: forwarded)
          .address;

  test('ignores forwarded headers by default and from untrusted peers', () {
    expect(resolve([], '127.0.0.1', ['198.51.100.1']), '127.0.0.1');
    expect(resolve(['127.0.0.1'], '192.0.2.1', ['198.51.100.1']), '192.0.2.1');
  });

  test('accepts exact IPv4 and IPv6 proxy addresses', () {
    expect(
      resolve(['127.0.0.1'], '127.0.0.1', ['198.51.100.1']),
      '198.51.100.1',
    );
    expect(resolve(['::1'], '::1', ['2001:db8::1']), '2001:db8::1');
    expect(resolve(['::1'], '::2', ['2001:db8::1']), '::2');
  });

  test('matches IPv4 and IPv6 CIDR boundaries', () {
    for (final peer in ['192.0.2.128', '192.0.2.255']) {
      expect(
        resolve(['192.0.2.128/25'], peer, ['198.51.100.1']),
        '198.51.100.1',
      );
    }
    for (final peer in ['192.0.2.127', '192.0.3.0']) {
      expect(resolve(['192.0.2.128/25'], peer, ['198.51.100.1']), peer);
    }
    expect(
      resolve(['2001:db8::/63'], '2001:db8:0:1::1', ['198.51.100.1']),
      '198.51.100.1',
    );
    expect(
      resolve(['2001:db8::/63'], '2001:db8:0:2::1', ['198.51.100.1']),
      '2001:db8:0:2::1',
    );
    expect(
      resolve(['0.0.0.0/0'], '192.0.2.1', ['198.51.100.1']),
      '198.51.100.1',
    );
    expect(resolve(['::/0'], '2001:db8::1', ['198.51.100.1']), '198.51.100.1');
  });

  test('normalizes IPv4-mapped IPv6 addresses', () {
    expect(
      resolve(['127.0.0.1'], '::ffff:127.0.0.1', ['::ffff:198.51.100.1']),
      '198.51.100.1',
    );
    expect(
      resolve(['::ffff:127.0.0.1/128'], '127.0.0.1', ['198.51.100.1']),
      '198.51.100.1',
    );
  });

  test('canonicalizes equivalent IPv6 spellings for authentication limits', () {
    expect(
      resolve(['127.0.0.1'], '127.0.0.1', ['2001:DB8:0:0:0:0:0:1']),
      resolve(['127.0.0.1'], '127.0.0.1', ['2001:db8::1']),
    );
  });

  test('walks trusted hops from the right and ignores a spoofed prefix', () {
    expect(
      resolve(
        ['127.0.0.1', '10.0.0.0/8'],
        '127.0.0.1',
        ['203.0.113.99, 198.51.100.1, 10.0.0.2'],
      ),
      '198.51.100.1',
    );
    expect(
      resolve(['127.0.0.1'], '127.0.0.1', ['198.51.100.1, 10.0.0.2']),
      '10.0.0.2',
    );
    expect(
      resolve(
        ['127.0.0.1', '10.0.0.0/8'],
        '127.0.0.1',
        ['198.51.100.1', '10.0.0.2'],
      ),
      '198.51.100.1',
    );
  });

  test('missing or malformed forwarding falls back to the socket peer', () {
    for (final headers in <List<String>>[
      [],
      [''],
      ['unknown'],
      ['198.51.100.1:443'],
      ['[2001:db8::1]'],
      ['fe80::1%eth0'],
      ['198.51.100.1,'],
      ['198.51.100.1, invalid'],
    ]) {
      expect(resolve(['127.0.0.1'], '127.0.0.1', headers), '127.0.0.1');
    }
  });

  test('rejects invalid proxy configuration', () {
    for (final entry in [
      '',
      'localhost',
      '*',
      '127.0.0.1:80',
      '192.0.2.1/33',
      '192.0.2.1/-1',
      '::1/129',
      '::1/abc',
      '::1/64/2',
    ]) {
      expect(
        () => TrustedProxies([entry]),
        throwsFormatException,
        reason: entry,
      );
    }
  });

  test('server uses forwarded IPs for connection metadata and authentication limits', () async {
    final directory = await Directory.systemTemp.createTemp('setonix-proxy-');
    final server = await SetonixServer.load(
      rootPath: directory.path,
      argsConfig: SetonixConfig(
        host: '127.0.0.1',
        port: 0,
        accountRequired: false,
        trustedProxies: ['127.0.0.1'],
        autosave: false,
      ),
    );
    addTearDown(() async {
      await server.close();
      await directory.delete(recursive: true);
    });
    await server.init();
    final uri = addSetonixProtocolVersion(server.address!);
    for (final clientIp in ['198.51.100.1', '198.51.100.2', '198.51.100.1']) {
      final socket = await WebSocket.connect(
        uri.toString(),
        headers: {'X-Forwarded-For': '203.0.113.99, $clientIp'},
      );
      socket.listen((_) {});
    }
    expect(server.players, hasLength(3));
    expect(server.players.values.map((info) => info.address.host), [
      '198.51.100.1',
      '198.51.100.2',
      '198.51.100.1',
    ]);
    final channels = server.players.keys.toList();
    for (var i = 0; i < kDefaultAuthenticationRateLimit; i++) {
      server.allowAuthenticationAttempt(channels.first);
    }
    expect(server.allowAuthenticationAttempt(channels.first), isFalse);
    expect(server.allowAuthenticationAttempt(channels[1]), isTrue);
    expect(server.allowAuthenticationAttempt(channels[2]), isFalse);
  });
}
