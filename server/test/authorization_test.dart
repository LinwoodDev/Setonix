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

    test('peer-host authority can rename connected players', () async {
      final state = WorldState(data: SetonixData.empty());
      final users = UserManager();
      await users.addUser(2, null, 'Guest 1');

      await processClientEvent(
        PlayerNameChangeRequest(2, 'Alex'),
        kAuthorityChannel,
        state,
        assetManager: _EmptyAssetManager(),
        userManager: users,
      );

      expect(users.getUser(2)?.name, 'Alex');
    });

    test('players can rename themselves but not another player', () async {
      final state = WorldState(data: SetonixData.empty());
      final users = UserManager();
      await users.addUser(2, null, 'Guest 1');
      await users.addUser(3, null, 'Guest 2');

      final selfResponse = await processClientEvent(
        PlayerNameChangeRequest(2, 'Alex'),
        2,
        state,
        assetManager: _EmptyAssetManager(),
        userManager: users,
      );
      final otherResponse = await processClientEvent(
        PlayerNameChangeRequest(3, 'Mallory'),
        2,
        state,
        assetManager: _EmptyAssetManager(),
        userManager: users,
      );

      expect(selfResponse, isA<UpdateServerResponse>());
      expect(otherResponse, isNull);
      expect(users.getUser(2)?.name, 'Alex');
      expect(users.getUser(3)?.name, 'Guest 2');
    });

    test('management payloads enforce text, role, and expiry limits', () {
      final state = WorldState(data: SetonixData.empty());
      final assets = _EmptyAssetManager();
      bool valid(ClientWorldEvent event) => isValidClientEvent(
        event,
        2,
        state,
        assetManager: assets,
        allowManagementRequests: true,
      );
      String text(int length) => List.filled(length, 'a').join();

      expect(valid(KickPlayerRequest(3, reason: text(2000))), isTrue);
      expect(valid(KickPlayerRequest(3, reason: text(2001))), isFalse);
      expect(
        valid(
          BanPlayerRequest(
            3,
            expiresAt: DateTime.now().add(const Duration(days: 30)),
          ),
        ),
        isTrue,
      );
      expect(
        valid(
          BanPlayerRequest(
            3,
            expiresAt: DateTime.now().subtract(const Duration(minutes: 1)),
          ),
        ),
        isFalse,
      );
      expect(valid(BanPlayerRequest(3)), isTrue);
      expect(valid(UnbanPlayerRequest('fingerprint')), isTrue);
      expect(valid(UnbanPlayerRequest('')), isFalse);
      expect(valid(UnbanPlayerRequest(text(257))), isFalse);
      expect(valid(PlayerNameChangeRequest(3, 'Named player')), isTrue);
      expect(valid(PlayerNameChangeRequest(3, '')), isFalse);
      expect(valid(PlayerNameChangeRequest(3, ' padded ')), isFalse);
      expect(valid(PlayerNameChangeRequest(3, text(257))), isFalse);
      expect(
        valid(
          BanPlayerRequest(
            3,
            expiresAt: DateTime.now().add(const Duration(days: 3651)),
          ),
        ),
        isFalse,
      );
      expect(
        valid(
          ServerRoleChangeRequest(
            3,
            roles: {for (var i = 0; i < 33; i++) 'test:role$i'},
          ),
        ),
        isFalse,
      );
      expect(valid(GameRolesChangeRequest(3, {text(257)})), isFalse);
      expect(
        isValidClientEvent(
          ServerRoleChangeRequest(3, roles: {'moderator'}),
          2,
          state,
          assetManager: assets,
        ),
        isFalse,
      );
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

    test('unbanning requires the ban permission', () {
      final event = UnbanPlayerRequest('fingerprint');

      expect(canProcessClientEvent({'moderator'}, event, roles), isTrue);
      expect(canProcessClientEvent({'spectator'}, event, roles), isFalse);
    });

    test('renaming yourself does not require a management permission', () {
      final event = PlayerNameChangeRequest(2, 'Alex');

      expect(canProcessClientEvent({'moderator'}, event, roles), isTrue);
      expect(canProcessClientEvent({'owner'}, event, roles), isTrue);
      expect(canProcessClientEvent({'player'}, event, roles), isTrue);
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
