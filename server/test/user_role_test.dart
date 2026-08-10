import 'dart:io';

import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/services/user/file.dart';
import 'package:setonix_server/src/services/user/migrations.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:test/test.dart';

void main() {
  test('file user service persists and updates roles', () async {
    final directory = await Directory.systemTemp.createTemp(
      'setonix-user-role-',
    );
    final service = FileUserService();
    addTearDown(() async {
      service.close();
      await directory.delete(recursive: true);
    });
    await service.setup(rootPath: directory.path);

    expect(
      service.updateUser(
        'fingerprint',
        name: 'player',
        roles: {'player', 'spectator'},
        createIfNotExists: true,
      ),
      isTrue,
    );
    expect(service.getUser('fingerprint')?.roles, {'player', 'spectator'});

    expect(
      service.updateUser(
        'fingerprint',
        roles: {'player', 'moderator', 'blackjack:dealer'},
      ),
      isTrue,
    );
    expect(service.getUser('fingerprint')?.roles, {
      'player',
      'moderator',
      'blackjack:dealer',
    });

    expect(service.replaceRole('moderator', 'spectator'), isTrue);
    expect(service.getUser('fingerprint')?.roles, {
      'player',
      'spectator',
      'blackjack:dealer',
    });

    final manager = UserManager(service: service);
    await manager.addUser(1, 'fingerprint');
    expect(await manager.addRole('#1', 'moderator'), isTrue);
    expect(await manager.removeRole('#1', 'spectator'), isTrue);
    expect(manager.getUser(1)?.roles, {
      'player',
      'moderator',
      'blackjack:dealer',
    });
  });

  test('custom role identifiers are preserved', () {
    final user = SetonixUserMapper.fromMap({
      'name': 'dealer',
      'roles': ['player', 'blackjack:dealer'],
    });

    expect(user.roles, {'player', 'blackjack:dealer'});
  });

  test('legacy single roles migrate into composable role sets', () async {
    final directory = await Directory.systemTemp.createTemp(
      'setonix-user-role-migration-',
    );
    addTearDown(() => directory.delete(recursive: true));
    final database = sqlite3.open('${directory.path}/setonix.db');
    database.execute(migrations[1]!);
    database.execute(migrations[2]!);
    database.execute(
      "INSERT INTO users (fingerprint, name, role) VALUES ('legacy', 'Legacy', 'moderator')",
    );
    database.execute('PRAGMA user_version = 2');
    database.close();

    final service = FileUserService();
    addTearDown(service.close);
    await service.setup(rootPath: directory.path);

    expect(service.getUser('legacy')?.roles, {'player', 'moderator'});
  });

  test('ban state supports permanent and expiring bans', () {
    const permanent = SetonixUser(
      name: 'permanent',
      banned: true,
      banReason: 'abuse',
    );
    final expired = SetonixUser(
      name: 'expired',
      banned: true,
      bannedUntil: DateTime.now().subtract(const Duration(minutes: 1)),
    );

    expect(permanent.isBanned, isTrue);
    expect(permanent.banReason, 'abuse');
    expect(expired.isBanned, isFalse);
  });
}
