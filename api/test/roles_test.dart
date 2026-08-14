import 'package:setonix_api/setonix_api.dart';
import 'package:test/test.dart';

void main() {
  test('users serialize multiple server roles', () {
    const user = SetonixUser(
      name: 'Dealer',
      roles: {'player', 'moderator', 'blackjack:dealer'},
    );

    final decoded = SetonixUserMapper.fromJson(user.toJson());

    expect(decoded.roles, {'player', 'moderator', 'blackjack:dealer'});
  });

  test('role change requests retain the player role', () {
    final request = ServerRoleChangeRequest(2, roles: {'moderator'});

    expect(request.effectiveRoles, {'player', 'moderator'});
  });

  test('player name change requests serialize their target and name', () {
    final request = PlayerNameChangeRequest(2, 'Alex');

    final decoded = WorldEventMapper.fromJson(request.toJson());

    expect(decoded, isA<PlayerNameChangeRequest>());
    expect((decoded as PlayerNameChangeRequest).player, 2);
    expect(decoded.name, 'Alex');
  });

  test('user managers rename users and reject duplicate names', () async {
    final manager = UserManager();
    final changes = manager.changes.take(3).toList();

    await manager.addUser(1, null, 'Guest 1');
    await manager.addUser(2, null, 'Guest 2');
    expect(await manager.changeName(1, 'Alex'), isTrue);
    expect(await manager.changeName(2, 'Alex'), isFalse);
    expect(manager.getUser(1)?.name, 'Alex');
    expect(await changes, hasLength(3));
  });
}
