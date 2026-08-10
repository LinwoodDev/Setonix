import 'package:setonix_api/setonix_api.dart';

String? requiredPermission(WorldEvent event) => switch (event) {
  AuthenticateRequest() ||
  MessageRequest() ||
  ImagesRequest() ||
  DialogCloseRequest() => null,
  PacksChangeRequest() ||
  ModeChangeRequest() ||
  MetadataChanged() ||
  BackgroundChanged() ||
  TeamChanged() ||
  TeamRemoved() ||
  TableRenamed() ||
  TableRemoved() => ServerPermission.manageWorld,
  KickPlayerRequest() => ServerPermission.kickPlayers,
  BanPlayerRequest() => ServerPermission.banPlayers,
  ServerRoleChangeRequest() => ServerPermission.manageRoles,
  GameRolesChangeRequest() => ServerPermission.manageWorld,
  _ => ServerPermission.play,
};

Set<String> permissionsForRole(
  String role,
  Map<String, ServerRoleDefinition> roles,
) => roles[role]?.permissions ?? const {};

bool roleAllowsPermission(
  String role,
  String? permission,
  Map<String, ServerRoleDefinition> roles,
) => permission == null || permissionsForRole(role, roles).contains(permission);

bool canProcessClientEvent(
  String role,
  WorldEvent event,
  Map<String, ServerRoleDefinition> roles,
) => roleAllowsPermission(role, requiredPermission(event), roles);

bool canManageServerRole(
  String actorRole,
  String targetRole,
  Map<String, ServerRoleDefinition> roles,
) => (roles[actorRole]?.priority ?? 0) > (roles[targetRole]?.priority ?? 0);

bool canAssignServerRole(
  String actorRole,
  String newRole,
  Map<String, ServerRoleDefinition> roles,
) => (roles[actorRole]?.priority ?? 0) >= (roles[newRole]?.priority ?? 0);
