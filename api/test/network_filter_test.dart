import 'dart:io';

import 'package:setonix_api/setonix_api.dart';
import 'package:test/test.dart';

void main() {
  late HttpServer server;
  late Uri address;

  setUp(() async {
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    address = Uri(
      scheme: 'http',
      host: server.address.address,
      port: server.port,
    );
    final filter = buildFilterConnections(
      loadProperty: (_) => const GameProperty(
        protocolVersions: kSetonixServerProtocolVersions,
        protocolCapabilities: kSetonixProtocolCapabilities,
      ),
    );
    server.listen((request) async {
      if (await filter(request)) {
        request.response.statusCode = HttpStatus.noContent;
        await request.response.close();
      }
    });
  });

  tearDown(() => server.close(force: true));

  Future<HttpClientResponse> get(Uri uri, {String? method}) async {
    final client = HttpClient();
    addTearDown(client.close);
    final request = await client.getUrl(uri);
    if (method != null) request.headers.set('X-Setonix-Method', method);
    return request.close();
  }

  test('advertises the server protocol through the info endpoint', () async {
    final response = await get(address, method: kInfoMethod);
    final body = await response.transform(SystemEncoding().decoder).join();
    final property = GamePropertyMapper.fromJson(body);

    expect(response.statusCode, HttpStatus.ok);
    expect(property.protocolVersions, kSetonixServerProtocolVersions);
    expect(property.protocolCapabilities, kSetonixProtocolCapabilities);
  });

  test('rejects a connection without a protocol version', () async {
    final response = await get(address);

    expect(response.statusCode, HttpStatus.upgradeRequired);
    expect(
      response.headers.value('X-Setonix-Protocol-Versions'),
      kSetonixServerProtocolVersions.join(','),
    );
  });

  test('accepts the server protocol version', () async {
    final response = await get(addSetonixProtocolVersion(address));

    expect(response.statusCode, HttpStatus.noContent);
  });
}
