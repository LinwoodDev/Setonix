import 'package:setonix_api/setonix_api.dart';
import 'package:test/test.dart';

void main() {
  test('game roles can be replaced and removed dynamically', () {
    final state = WorldState(
      data: SetonixData.empty(),
      gameRoleMembers: const {
        'dealer': {2},
        'spectator': {2, 3},
      },
    );

    final changed = processServerEvent(
      const GameRolesChanged(2, {'player'}),
      state,
      signature: const [],
    ).state!;

    expect(changed.getGameRoles(2), {'player'});
    expect(changed.getGameRoles(3), {'spectator'});

    final removed = processServerEvent(
      const GameRolesChanged(2),
      changed,
      signature: const [],
    ).state!;

    expect(removed.getGameRoles(2), isEmpty);
    expect(removed.gameRoleMembers.containsKey('player'), isFalse);
  });
}
