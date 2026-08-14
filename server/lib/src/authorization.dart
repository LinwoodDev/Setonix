import 'package:setonix_api/setonix_api.dart';

String? requiredPermission(WorldEvent event) => switch (event) {
  AuthenticateRequest() ||
  MessageRequest() ||
  ImagesRequest() ||
  DialogCloseRequest() ||
  PlayerNameChangeRequest() => null,
  PacksChangeRequest() ||
  ModeChangeRequest() ||
  MetadataChanged() ||
  BackgroundChanged() ||
  TeamChanged() ||
  TeamRemoved() ||
  TableRenamed() ||
  TableRemoved() => ServerPermission.manageWorld,
  KickPlayerRequest() => ServerPermission.kickPlayers,
  BanPlayerRequest() || UnbanPlayerRequest() => ServerPermission.banPlayers,
  ServerRoleChangeRequest() => ServerPermission.manageRoles,
  GameRolesChangeRequest() => ServerPermission.manageWorld,
  _ => ServerPermission.play,
};

Set<String> permissionsForRole(
  String role,
  Map<String, ServerRoleDefinition> roles,
) => roles[role]?.permissions ?? const {};

Set<String> permissionsForRoles(
  Iterable<String> assignedRoles,
  Map<String, ServerRoleDefinition> roles,
) => assignedRoles.expand((role) => permissionsForRole(role, roles)).toSet();

bool roleAllowsPermission(
  String role,
  String? permission,
  Map<String, ServerRoleDefinition> roles,
) => permission == null || permissionsForRole(role, roles).contains(permission);

bool rolesAllowPermission(
  Iterable<String> assignedRoles,
  String? permission,
  Map<String, ServerRoleDefinition> roles,
) =>
    permission == null ||
    permissionsForRoles(assignedRoles, roles).contains(permission);

bool canProcessClientEvent(
  Iterable<String> assignedRoles,
  WorldEvent event,
  Map<String, ServerRoleDefinition> roles,
) => rolesAllowPermission(assignedRoles, requiredPermission(event), roles);

int highestRolePriority(
  Iterable<String> assignedRoles,
  Map<String, ServerRoleDefinition> roles,
) {
  int? highest;
  for (final role in assignedRoles) {
    final priority = roles[role]?.priority;
    if (priority != null && (highest == null || priority > highest)) {
      highest = priority;
    }
  }
  return highest ?? 0;
}

bool canManageServerRoles(
  Iterable<String> actorRoles,
  Iterable<String> targetRoles,
  Map<String, ServerRoleDefinition> roles,
) =>
    highestRolePriority(actorRoles, roles) >
    highestRolePriority(targetRoles, roles);

bool canAssignServerRole(
  Iterable<String> actorRoles,
  String newRole,
  Map<String, ServerRoleDefinition> roles,
) => highestRolePriority(actorRoles, roles) >= (roles[newRole]?.priority ?? 0);
