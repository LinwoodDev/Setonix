import 'package:consoler/consoler.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/programs/async.dart';

typedef _RoleAction = Future<void> Function(List<String> args);

class RolesProgram extends AsyncServerProgram {
  RolesProgram(super.server);
  @override
  String getUsage() =>
      '<list|show|create|delete|rename|priority|permission> ...';
  @override
  String getDescription() => 'Manage persistent role definitions.';

  Map<String, ServerRoleDefinition> get _roles =>
      Map.from(server.configManager.serverRoles);
  void _expect(List<String> args, int min, [int? max]) {
    if (args.length < min || (max != null && args.length > max)) {
      throw const CommandUsageException();
    }
  }

  Never _unknown(String id) => throw CommandFailure("Unknown role: $id");
  int _priority(String value) =>
      int.tryParse(value) ??
      (throw CommandFailure("Priority must be an integer: $value"));
  void _log(String message) => server.log(message, level: LogLevel.info);
  Future<void> _save(Map<String, ServerRoleDefinition> roles) async {
    await server.configManager.setServerRoles(roles);
    await server.broadcastAllServerStates();
  }

  @override
  Future<void> runAsync(String label, List<String> args) async {
    final actions = <String, _RoleAction>{
      'list': _list,
      'show': _show,
      'create': _create,
      'delete': _delete,
      'rename': _rename,
      'priority': _setPriority,
      'permission': _permission,
    };
    final action = args.firstOrNull ?? 'list';
    final handler = actions[action];
    if (handler == null) throw const CommandUsageException();
    await handler(args.isEmpty ? [] : args.sublist(1));
  }

  Future<void> _list(List<String> args) async {
    _expect(args, 0, 0);
    final roles = _roles;
    _log("${roles.length} role(s).");
    server.consoler.table(
      ["ID", "Name", "Priority", "Permissions"],
      [
        for (final role in roles.entries)
          [
            role.key,
            role.value.name,
            role.value.priority,
            role.value.permissions.join(', '),
          ],
      ],
    );
  }

  Future<void> _show(List<String> args) async {
    _expect(args, 1, 1);
    final role = _roles[args.first] ?? _unknown(args.first);
    server.consoler.table(
      [args.first, ''],
      [
        ["Name", role.name],
        ["Priority", role.priority],
        ["Permissions", role.permissions.join(', ')],
      ],
    );
  }

  Future<void> _create(List<String> args) async {
    _expect(args, 3);
    final roles = _roles;
    final id = args.first;
    if (roles.containsKey(id)) {
      throw CommandFailure("Role already exists: $id");
    }
    roles[id] = ServerRoleDefinition(
      name: args.skip(2).join(' '),
      priority: _priority(args[1]),
    );
    await _save(roles);
    _log("Created role $id.");
  }

  Future<void> _delete(List<String> args) async {
    _expect(args, 1, 2);
    final roles = _roles;
    final id = args.first;
    if (!roles.containsKey(id)) _unknown(id);
    if (id == kDefaultServerRole) {
      throw CommandFailure("The default role $id cannot be removed.");
    }
    final replacement = args.elementAtOrNull(1) ?? kDefaultServerRole;
    if (replacement == id || !roles.containsKey(replacement)) {
      _unknown(replacement);
    }
    roles.remove(id);
    await server.configManager.setServerRoles(roles);
    final count = await server.userManager.replaceRole(id, replacement);
    await server.broadcastAllServerStates();
    _log("Deleted role $id; changed $count connected user(s) to $replacement.");
  }

  Future<void> _rename(List<String> args) async {
    _expect(args, 2);
    final roles = _roles;
    final id = args.first;
    final role = roles[id] ?? _unknown(id);
    roles[id] = role.copyWith(name: args.skip(1).join(' '));
    await _save(roles);
    _log("Renamed role $id.");
  }

  Future<void> _setPriority(List<String> args) async {
    _expect(args, 2, 2);
    final roles = _roles;
    final id = args.first;
    final role = roles[id] ?? _unknown(id);
    final priority = _priority(args[1]);
    roles[id] = role.copyWith(priority: priority);
    await _save(roles);
    _log("Changed $id priority to $priority.");
  }

  Future<void> _permission(List<String> args) async {
    _expect(args, 3, 3);
    if (!{'add', 'remove'}.contains(args.first)) {
      throw const CommandUsageException();
    }
    final roles = _roles;
    final id = args[1];
    final permission = args[2];
    final role = roles[id] ?? _unknown(id);
    final permissions = Set<String>.from(role.permissions);
    final add = args.first == 'add';
    final changed = add
        ? permissions.add(permission)
        : permissions.remove(permission);
    if (!changed) {
      throw CommandFailure(
        add
            ? "Role $id already has permission $permission."
            : "Role $id does not have permission $permission.",
      );
    }
    roles[id] = role.copyWith(permissions: permissions);
    await _save(roles);
    _log(add ? "Added $permission to $id." : "Removed $permission from $id.");
  }
}
