import 'package:consoler/consoler.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/programs/async.dart';

class RoleProgram extends AsyncServerProgram {
  RoleProgram(super.server);

  @override
  String getUsage() =>
      '<User> <Role> | <list|add|remove|set> <User> [Roles...]';

  @override
  String getDescription() => 'List, add, remove, or set user roles.';

  @override
  Future<void> runAsync(String label, List<String> args) async {
    if (args.length < 2) {
      server.log('Wrong usage, use ${getUsage()}', level: LogLevel.error);
      return;
    }
    final operations = {'list', 'add', 'remove', 'set'};
    final operation = operations.contains(args.first) ? args.first : 'set';
    final userReference = operation == 'set' && !operations.contains(args.first)
        ? args.first
        : args[1];
    final requestedRoles =
        operation == 'set' && !operations.contains(args.first)
        ? args.skip(1).toSet()
        : args.skip(2).toSet();
    final user = await server.userManager.getUserByReference(userReference);
    if (user == null) {
      server.log('User not found: $userReference', level: LogLevel.error);
      return;
    }
    if (operation == 'list') {
      if (args.length != 2) {
        server.log('Wrong usage, use ${getUsage()}', level: LogLevel.error);
        return;
      }
      server.log(
        '$userReference roles: ${user.roles.join(', ')}',
        level: LogLevel.info,
      );
      return;
    }
    if (requestedRoles.isEmpty ||
        requestedRoles.any(
          (role) => !server.configManager.serverRoles.containsKey(role),
        )) {
      server.log('Unknown or missing role.', level: LogLevel.error);
      return;
    }
    var roles = Set<String>.from(user.roles);
    switch (operation) {
      case 'add':
        roles.addAll(requestedRoles);
      case 'remove':
        if (requestedRoles.contains(kDefaultServerRole)) {
          server.log(
            'The default role $kDefaultServerRole cannot be removed.',
            level: LogLevel.error,
          );
          return;
        }
        roles.removeAll(requestedRoles);
      case 'set':
        roles = requestedRoles;
    }
    roles.add(kDefaultServerRole);
    if (!await server.userManager.changeRoles(userReference, roles)) return;
    await server.broadcastAllServerStates();
    server.log(
      'Changed $userReference roles to ${roles.join(', ')}',
      level: LogLevel.info,
    );
  }
}
