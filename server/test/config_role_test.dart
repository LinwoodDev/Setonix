import 'dart:io';

import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/config.dart';
import 'package:test/test.dart';

void main() {
  test('role definition changes persist to config.json', () async {
    final directory = await Directory.systemTemp.createTemp(
      'setonix-role-config-',
    );
    addTearDown(() => directory.delete(recursive: true));

    final manager = ConfigManager(
      envConfig: const SetonixConfig(),
      argsConfig: const SetonixConfig(),
    );
    await manager.loadConfig(rootPath: directory.path);
    await manager.setServerRoles({
      ...manager.serverRoles,
      'blackjack:dealer': const ServerRoleDefinition(
        name: 'Dealer',
        priority: 25,
        permissions: {'blackjack:deal'},
      ),
    });

    final reloaded = ConfigManager(
      envConfig: const SetonixConfig(),
      argsConfig: const SetonixConfig(),
    );
    await reloaded.loadConfig(rootPath: directory.path);

    expect(reloaded.serverRoles['blackjack:dealer']?.priority, 25);
    expect(reloaded.serverRoles['blackjack:dealer']?.permissions, {
      'blackjack:deal',
    });
  });
}
