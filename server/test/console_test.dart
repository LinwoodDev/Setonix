import 'dart:convert';
import 'dart:io';

import 'package:consoler/consoler.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/server.dart';
import 'package:test/test.dart';

void main() {
  late Directory directory;
  late SetonixServer server;
  late BufferConsoleOutput output;
  setUp(() async {
    directory = await Directory.systemTemp.createTemp('setonix-console-');
    output = BufferConsoleOutput();
    server = await SetonixServer.load(
      rootPath: directory.path,
      consoleOutput: output,
      argsConfig: const SetonixConfig(
        host: '127.0.0.1',
        port: 0,
        accountRequired: false,
      ),
    );
    await server.init();
    output.clear();
  });
  tearDown(() async {
    await server.close();
    await directory.delete(recursive: true);
  });

  test('installs five modules with categorized help', () async {
    expect(server.consoler.modules.map((m) => m.id), [
      'server',
      'worlds',
      'moderation',
      'roles',
      'content',
    ]);
    expect((await server.consoler.execute('HELP')).isSuccess, isTrue);
    expect(output.toString(), contains('Worlds'));
    expect(output.toString(), contains('active user bans'));
    output.clear();
    await server.consoler.execute('help roles permission add');
    expect(
      output.toString(),
      contains('roles permission add <Role> <Permission>'),
    );
  });
  test('status JSON has stable keys', () async {
    await server.consoler.execute('STATUS --json');
    final status = jsonDecode(output.toString()) as Map<String, dynamic>;
    expect(status['state'], 'running');
    expect(status['players'], 0);
    expect(status['worlds'], greaterThanOrEqualTo(1));
    expect(status['uptimeSeconds'], isNonNegative);
    expect(status['address'], startsWith('ws://'));
  });
  test(
    'mixed-case subcommands preserve case of role identifiers and names',
    () async {
      final result = await server.consoler.execute(
        'ROLES CREATE MyRole 20 "Meine Rolle"',
      );
      expect(result.isSuccess, isTrue);
      expect(server.configManager.serverRoles['MyRole']?.name, 'Meine Rolle');
      await server.consoler.execute('roles PERMISSION ADD MyRole MyPack:Play');
      expect(
        server.configManager.serverRoles['MyRole']!.permissions,
        contains('MyPack:Play'),
      );
      expect(server.configManager.serverRoles.containsKey('myrole'), isFalse);
    },
  );
  test(
    'invalid inputs return structured results with useful messages',
    () async {
      expect(
        (await server.consoler.execute('name')).status,
        CommandStatus.usage,
      );
      expect(output.toString(), contains('Usage: name'));
      output.clear();
      expect(
        (await server.consoler.execute('players --world MissingWorld')).status,
        CommandStatus.error,
      );
      expect(output.toString(), contains('Unknown world: MissingWorld'));
      expect(
        (await server.consoler.execute('players --invalid')).status,
        CommandStatus.usage,
      );
    },
  );
  test('world flags coexist with positional syntax', () async {
    final world = server.worldNames.first;
    expect(
      (await server.consoler.execute('players --world "$world"')).isSuccess,
      isTrue,
    );
    expect(
      (await server.consoler.execute('players "$world"')).isSuccess,
      isTrue,
    );
    expect(
      (await server.consoler.execute('players --world "$world" "$world"'))
          .status,
      CommandStatus.usage,
    );
  });
  test(
    'role updates are complete before execute returns and are persisted',
    () async {
      await server.consoler.execute('roles create helper 10 "Helper"');
      await server.consoler.execute('roles priority helper 25');
      await server.consoler.execute('roles rename helper "Updated Helper"');
      expect(server.configManager.serverRoles['helper']!.priority, 25);
      expect(
        server.configManager.serverRoles['helper']!.name,
        'Updated Helper',
      );
      final config = jsonDecode(
        await File('${directory.path}/config.json').readAsString(),
      );
      expect(config.toString(), contains('Updated Helper'));
      expect(
        (await server.consoler.execute('roles delete player')).status,
        CommandStatus.error,
      );
    },
  );
  test(
    'uninstalling a module removes its commands and keeps others usable',
    () async {
      await server.consoler.uninstall('content');
      expect(
        (await server.consoler.execute('packs')).status,
        CommandStatus.unknown,
      );
      expect(
        (await server.consoler.execute('status --json')).isSuccess,
        isTrue,
      );
    },
  );
  test('stop command completes without lifecycle deadlock', () async {
    expect(
      (await server.consoler
              .execute('stop')
              .timeout(const Duration(seconds: 5)))
          .isSuccess,
      isTrue,
    );
    expect(server.isClosing, isTrue);
  });
}
