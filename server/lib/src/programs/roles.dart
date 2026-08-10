import 'package:consoler/consoler.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/server.dart';

class RolesProgram extends ConsoleProgram {
  final SetonixServer server;

  RolesProgram(this.server);

  @override
  String getUsage() =>
      '<list|show|create|delete|rename|priority|permission> ...';

  @override
  String getDescription() =>
      'List and persistently manage server role definitions.';

  void _usage() => server.log('''Usage:
roles list
roles show <Role>
roles create <Role> <Priority> <Display name...>
roles delete <Role> [Replacement]
roles rename <Role> <Display name...>
roles priority <Role> <Priority>
roles permission <add|remove> <Role> <Permission>''', level: LogLevel.info);

  Future<void> _save(
    Map<String, ServerRoleDefinition> roles, {
    bool broadcast = true,
  }) async {
    await server.configManager.setServerRoles(roles);
    if (broadcast) await server.broadcastAllServerStates();
  }

  @override
  Future<void> run(String label, List<String> args) async {
    final action = args.firstOrNull?.toLowerCase() ?? 'list';
    final roles = Map<String, ServerRoleDefinition>.from(
      server.configManager.serverRoles,
    );
    switch (action) {
      case 'list':
        if (args.length > 1) return _usage();
        server.log('${roles.length} role(s):', level: LogLevel.info);
        for (final entry in roles.entries) {
          server.log(
            '${entry.key} | ${entry.value.name} | priority '
            '${entry.value.priority} | '
            '${entry.value.permissions.join(', ')}',
            level: LogLevel.info,
          );
        }
      case 'show':
        if (args.length != 2) return _usage();
        final role = roles[args[1]];
        if (role == null) return _unknownRole(args[1]);
        server.log(
          '${args[1]}\nName: ${role.name}\nPriority: ${role.priority}\n'
          'Permissions: ${role.permissions.join(', ')}',
          level: LogLevel.info,
        );
      case 'create':
        if (args.length < 4) return _usage();
        final id = args[1];
        if (roles.containsKey(id)) {
          server.log('Role already exists: $id', level: LogLevel.error);
          return;
        }
        final priority = int.tryParse(args[2]);
        if (priority == null) return _invalidPriority(args[2]);
        roles[id] = ServerRoleDefinition(
          name: args.skip(3).join(' '),
          priority: priority,
        );
        await _save(roles);
        server.log('Created role $id.', level: LogLevel.info);
      case 'delete':
        if (args.length < 2 || args.length > 3) return _usage();
        final id = args[1];
        if (!roles.containsKey(id)) return _unknownRole(id);
        if (id == kDefaultServerRole) {
          server.log(
            'The default role $kDefaultServerRole cannot be deleted.',
            level: LogLevel.error,
          );
          return;
        }
        final replacement = args.elementAtOrNull(2) ?? kDefaultServerRole;
        if (replacement == id || !roles.containsKey(replacement)) {
          return _unknownRole(replacement);
        }
        roles.remove(id);
        await _save(roles, broadcast: false);
        final changed = await server.userManager.replaceRole(id, replacement);
        await server.broadcastAllServerStates();
        server.log(
          'Deleted role $id and changed $changed connected user(s) to '
          '$replacement.',
          level: LogLevel.info,
        );
      case 'rename':
        if (args.length < 3) return _usage();
        final id = args[1];
        final role = roles[id];
        if (role == null) return _unknownRole(id);
        roles[id] = role.copyWith(name: args.skip(2).join(' '));
        await _save(roles);
        server.log('Renamed role $id.', level: LogLevel.info);
      case 'priority':
        if (args.length != 3) return _usage();
        final id = args[1];
        final role = roles[id];
        if (role == null) return _unknownRole(id);
        final priority = int.tryParse(args[2]);
        if (priority == null) return _invalidPriority(args[2]);
        roles[id] = role.copyWith(priority: priority);
        await _save(roles);
        server.log('Changed $id priority to $priority.', level: LogLevel.info);
      case 'permission':
        if (args.length != 4) return _usage();
        final operation = args[1].toLowerCase();
        final id = args[2];
        final permission = args[3];
        final role = roles[id];
        if (role == null) return _unknownRole(id);
        final permissions = Set<String>.from(role.permissions);
        switch (operation) {
          case 'add':
            if (!permissions.add(permission)) {
              server.log(
                '$id already has permission $permission.',
                level: LogLevel.error,
              );
              return;
            }
          case 'remove':
            if (!permissions.remove(permission)) {
              server.log(
                '$id does not have permission $permission.',
                level: LogLevel.error,
              );
              return;
            }
          default:
            return _usage();
        }
        roles[id] = role.copyWith(permissions: permissions);
        await _save(roles);
        server.log(
          '${operation == 'add' ? 'Added' : 'Removed'} $permission '
          '${operation == 'add' ? 'to' : 'from'} $id.',
          level: LogLevel.info,
        );
      default:
        _usage();
    }
  }

  void _unknownRole(String role) =>
      server.log('Unknown role: $role', level: LogLevel.error);

  void _invalidPriority(String priority) => server.log(
    'Priority must be an integer: $priority',
    level: LogLevel.error,
  );
}
