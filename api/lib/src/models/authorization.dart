import 'package:dart_mappable/dart_mappable.dart';

part 'authorization.mapper.dart';

const kDefaultServerRole = 'player';

abstract final class ServerPermission {
  static const String play = 'play';
  static const String manageWorld = 'manageWorld';
  static const String kickPlayers = 'kickPlayers';
  static const String banPlayers = 'banPlayers';
  static const String manageRoles = 'manageRoles';
}

@MappableClass()
final class ServerRoleDefinition with ServerRoleDefinitionMappable {
  final String name;
  final Set<String> permissions;
  final int priority;

  const ServerRoleDefinition({
    required this.name,
    this.permissions = const {},
    this.priority = 0,
  });
}

const kDefaultServerRoles = <String, ServerRoleDefinition>{
  'spectator': ServerRoleDefinition(name: 'Spectator'),
  'player': ServerRoleDefinition(
    name: 'Player',
    permissions: {ServerPermission.play},
  ),
  'moderator': ServerRoleDefinition(
    name: 'Moderator',
    priority: 50,
    permissions: {
      ServerPermission.play,
      ServerPermission.manageWorld,
      ServerPermission.kickPlayers,
      ServerPermission.banPlayers,
    },
  ),
  'owner': ServerRoleDefinition(
    name: 'Owner',
    priority: 100,
    permissions: {
      ServerPermission.play,
      ServerPermission.manageWorld,
      ServerPermission.kickPlayers,
      ServerPermission.banPlayers,
      ServerPermission.manageRoles,
    },
  ),
};
