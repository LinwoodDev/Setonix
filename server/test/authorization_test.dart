import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/authorization.dart';
import 'package:test/test.dart';

void main() {
  const roles = kDefaultServerRoles;

  group('server authorization', () {
    test('spectators can observe and chat but cannot mutate the world', () {
      expect(
        canProcessClientEvent('spectator', MessageRequest('hello'), roles),
        isTrue,
      );
      expect(
        canProcessClientEvent(
          'spectator',
          CellRollRequest(GlobalVectorDefinition('', 0, 0)),
          roles,
        ),
        isFalse,
      );
    });

    test('players can play but cannot change world configuration', () {
      expect(
        canProcessClientEvent('player', TeamJoinRequest('players'), roles),
        isTrue,
      );
      expect(
        canProcessClientEvent('player', PacksChangeRequest(const []), roles),
        isFalse,
      );
      expect(
        canProcessClientEvent('player', ModeChangeRequest(null), roles),
        isFalse,
      );
    });

    test('moderators and owners can manage world configuration', () {
      final event = PacksChangeRequest(const []);

      expect(canProcessClientEvent('moderator', event, roles), isTrue);
      expect(canProcessClientEvent('owner', event, roles), isTrue);
    });

    test('new unclassified client events default to play permission', () {
      final event = ToolbarActionRequest('test');

      expect(requiredPermission(event), ServerPermission.play);
      expect(canProcessClientEvent('spectator', event, roles), isFalse);
      expect(canProcessClientEvent('player', event, roles), isTrue);
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
          'dealer',
          PacksChangeRequest(const []),
          customRoles,
        ),
        isTrue,
      );
      expect(
        canProcessClientEvent('dealer', KickPlayerRequest(2), customRoles),
        isFalse,
      );
      expect(roleAllowsPermission('dealer', deal, customRoles), isTrue);
      expect(
        roleAllowsPermission('dealer', 'blackjack:shuffle', customRoles),
        isFalse,
      );
    });

    test('role hierarchy prevents managing peers and higher roles', () {
      expect(canManageServerRole('moderator', 'player', roles), isTrue);
      expect(canManageServerRole('moderator', 'moderator', roles), isFalse);
      expect(canManageServerRole('moderator', 'owner', roles), isFalse);
      expect(canManageServerRole('owner', 'moderator', roles), isTrue);
    });

    test('roles can only assign roles at or below their priority', () {
      expect(canAssignServerRole('moderator', 'moderator', roles), isTrue);
      expect(canAssignServerRole('moderator', 'owner', roles), isFalse);
      expect(canAssignServerRole('owner', 'owner', roles), isTrue);
    });

    test('custom roles survive server configuration serialization', () {
      const config = SetonixConfig(
        serverRoles: {
          'blackjack:dealer': ServerRoleDefinition(
            name: 'Blackjack dealer',
            priority: 25,
            permissions: {
              ServerPermission.play,
              ServerPermission.manageWorld,
              'blackjack:deal',
            },
          ),
        },
      );

      final decoded = SetonixConfigMapper.fromMap(config.toMap());
      final dealer = decoded.serverRoles?['blackjack:dealer'];

      expect(dealer?.name, 'Blackjack dealer');
      expect(dealer?.priority, 25);
      expect(dealer?.permissions, {
        ServerPermission.play,
        ServerPermission.manageWorld,
        'blackjack:deal',
      });
      expect(config.toMap()['serverRoles']['blackjack:dealer']['permissions'], [
        'play',
        'manageWorld',
        'blackjack:deal',
      ]);
    });
  });
}
