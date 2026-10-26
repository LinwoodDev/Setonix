import 'dart:io';

import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/config.dart';
import 'package:test/test.dart';

void main() {
  test('an explicit empty proxy list clears file-configured trust', () async {
    final directory = await Directory.systemTemp.createTemp(
      'setonix-proxy-config-',
    );
    addTearDown(() => directory.delete(recursive: true));
    await File('${directory.path}/config.json')
        .writeAsString('{"trustedProxies": ["127.0.0.1"]}');
    final manager = ConfigManager(envConfig: const SetonixConfig());
    await manager.loadConfig(rootPath: directory.path);
    expect(manager.trustedProxies, ['127.0.0.1']);
    manager.setArgsConfig(const SetonixConfig(trustedProxies: []));
    expect(manager.trustedProxies, isEmpty);
  });
}
