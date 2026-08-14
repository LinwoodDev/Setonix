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
}
