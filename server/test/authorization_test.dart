import 'package:networker/networker.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/authorization.dart';
import 'package:test/test.dart';

void main() {
  const roles = kDefaultServerRoles;

  group('server authorization', () {
    test('spectators can observe and chat but cannot mutate the world', () {
      expect(
        canProcessClientEvent({'spectator'}, MessageRequest('hello'), roles),
        isTrue,
      );
      expect(
        canProcessClientEvent(
          {'spectator'},
          CellRollRequest(GlobalVectorDefinition('', 0, 0)),
          roles,
        ),
        isFalse,
      );
    });

    test('players can play but cannot change world configuration', () {
      expect(
        canProcessClientEvent({'player'}, TeamJoinRequest('players'), roles),
        isTrue,
      );
      expect(
        canProcessClientEvent({'player'}, PacksChangeRequest(const []), roles),
        isFalse,
      );
      expect(
        canProcessClientEvent({'player'}, ModeChangeRequest(null), roles),
        isFalse,
      );
    });

    test('moderators and owners can manage world configuration', () {
      final event = PacksChangeRequest(const []);

      expect(canProcessClientEvent({'moderator'}, event, roles), isTrue);
      expect(canProcessClientEvent({'owner'}, event, roles), isTrue);
    });

    test('authorized remote users can broadcast mode changes', () async {
      final state = WorldState(data: SetonixData.empty());
      final assets = _EmptyAssetManager();
      final event = ModeChangeRequest.plain();

      expect(
        isValidClientEvent(event, 2, state, assetManager: assets),
        isFalse,
      );
      expect(
        isValidClientEvent(
          event,
          2,
          state,
          assetManager: assets,
          allowManagementRequests: true,
        ),
        isTrue,
      );

      final response = await processClientEvent(
        event,
        2,
        state,
        assetManager: assets,
        allowManagementRequests: true,
      );

      expect(response, isA<UpdateServerResponse>());
      expect((response as UpdateServerResponse).main?.channel, kAnyChannel);
      expect(response.main?.data, isA<WorldInitialized>());
    });

    test('new unclassified client events default to play permission', () {
      final event = ToolbarActionRequest('test');

      expect(requiredPermission(event), ServerPermission.play);
      expect(canProcessClientEvent({'spectator'}, event, roles), isFalse);
      expect(canProcessClientEvent({'player'}, event, roles), isTrue);
    });

    test('custom server roles are capability-driven', () {
      const deal = 'blackjack:deal';
      const customRoles = {
        'dealer': ServerRoleDefinition(
          name: 'Dealer',
          permissions: {
            ServerPermission.play,
            ServerPermission.manageWorld,
            deal,
          },
        ),
      };

      expect(
        canProcessClientEvent(
          {'dealer'},
          PacksChangeRequest(const []),
          customRoles,
        ),
        isTrue,
      );
      expect(
        canProcessClientEvent({'dealer'}, KickPlayerRequest(2), customRoles),
        isFalse,
      );
      expect(roleAllowsPermission('dealer', deal, customRoles), isTrue);
      expect(
        roleAllowsPermission('dealer', 'blackjack:shuffle', customRoles),
        isFalse,
      );
    });

    test('role hierarchy prevents managing peers and higher roles', () {
      expect(
        canManageServerRoles({'player', 'moderator'}, {'player'}, roles),
        isTrue,
      );
      expect(
        canManageServerRoles({'moderator'}, {'moderator'}, roles),
        isFalse,
      );
      expect(
        canManageServerRoles({'moderator'}, {'player', 'owner'}, roles),
        isFalse,
      );
      expect(
        canManageServerRoles({'player', 'owner'}, {'moderator'}, roles),
        isTrue,
      );
    });

    test('roles can only assign roles at or below their priority', () {
      expect(
        canAssignServerRole({'player', 'moderator'}, 'moderator', roles),
        isTrue,
      );
      expect(canAssignServerRole({'moderator'}, 'owner', roles), isFalse);
      expect(canAssignServerRole({'player', 'owner'}, 'owner', roles), isTrue);
    });

    test('multiple roles union their permissions', () {
      expect(
        permissionsForRoles({'spectator', 'moderator'}, roles),
        containsAll({
          ServerPermission.play,
          ServerPermission.manageWorld,
          ServerPermission.kickPlayers,
        }),
      );
    });
  });
}

final class _EmptyAssetManager extends AssetManager {
  @override
  Iterable<MapEntry<String, SetonixData>> get packs => const [];

  @override
  SetonixData? getPack(String key) => null;

  @override
  bool hasPack(String key) => false;
}
