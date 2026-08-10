import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/server.dart';

class RoleProgram extends ConsoleProgram {
  final SetonixServer server;

  RoleProgram(this.server);

  @override
  String getUsage() => '<User> <Role>';

  @override
  String getDescription() => 'Set the authorization role of a user.';

  @override
  Future<void> run(String label, List<String> args) async {
    if (args.length != 2) {
      server.log('Wrong usage, use ${getUsage()}', level: LogLevel.error);
      return;
    }
    final role = args[1];
    if (!server.configManager.serverRoles.containsKey(role)) {
      server.log('Unknown role: ${args[1]}', level: LogLevel.error);
      return;
    }
    if (!await server.userManager.changeRole(args[0], role)) {
      server.log('User not found: ${args[0]}', level: LogLevel.error);
      return;
    }
    await server.broadcastAllServerStates();
    server.log('Changed ${args[0]} role to $role', level: LogLevel.info);
  }
}
