import 'dart:io';

import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/services/user/file.dart';
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
        role: 'spectator',
        createIfNotExists: true,
      ),
      isTrue,
    );
    expect(service.getUser('fingerprint')?.role, 'spectator');

    expect(service.updateUser('fingerprint', role: 'moderator'), isTrue);
    expect(service.getUser('fingerprint')?.role, 'moderator');

    expect(service.updateUser('fingerprint', role: ''), isTrue);
    expect(service.getUser('fingerprint')?.role, kDefaultServerRole);
  });

  test('custom role identifiers are preserved', () {
    final user = SetonixUserMapper.fromMap({
      'name': 'dealer',
      'role': 'blackjack-dealer',
    });

    expect(user.role, 'blackjack-dealer');
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
