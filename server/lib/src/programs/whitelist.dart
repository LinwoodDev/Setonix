import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/server.dart';

class WhitelistProgram extends ConsoleProgram {
  final SetonixServer server;

  WhitelistProgram(this.server);

  @override
  String getUsage() => '<add/remove> <User>';

  @override
  String getDescription() =>
      "Add or remove a user from the whitelist. "
      "Use 'add <User>' to add a user and 'remove <User>' to remove a user.";

  @override
  Future<void> run(String label, List<String> args) async {
    if (args.length != 2) {
      server.log("Wrong usage, use ${getUsage()}", level: LogLevel.error);
      return;
    }
    final action = args[0].toLowerCase();
    final user = await server.userManager.getUserByReference(args[1]);
    if (user == null) {
      server.log("User not found: ${args[1]}", level: LogLevel.error);
      return;
    }
    final fingerprint = user.fingerprint;
    if (fingerprint == null) {
      server.log(
        "User $user does not have a fingerprint. Cannot add to whitelist.",
        level: LogLevel.error,
      );
      return;
    }

    if (action == 'add') {
      final result = await server.userManager.service?.updateUser(
        fingerprint,
        onWhitelist: true,
      );
      if (result != true) {
        server.log(
          "Failed to add user $user to whitelist",
          level: LogLevel.error,
        );
        return;
      }
      server.log("User $user added to whitelist", level: LogLevel.info);
    } else if (action == 'remove') {
      final result = await server.userManager.service?.updateUser(
        fingerprint,
        onWhitelist: false,
      );
      if (result != true) {
        server.log(
          "Failed to remove user $user from whitelist",
          level: LogLevel.error,
        );
        return;
      }
      server.log("User $user removed from whitelist", level: LogLevel.info);
    } else {
      server.log(
        "Unknown action: $action. Use 'add' or 'remove'.",
        level: LogLevel.error,
      );
    }
  }
}
