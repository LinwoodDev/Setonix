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

  test(
    'role change requests retain player and accept legacy role payloads',
    () {
      final current = ServerRoleChangeRequest(2, roles: {'moderator'});
      final legacy = ServerRoleChangeRequestMapper.fromMap({
        'player': 2,
        'role': 'moderator',
      });

      expect(current.effectiveRoles, {'player', 'moderator'});
      expect(legacy.effectiveRoles, {'player', 'moderator'});
    },
  );
}
