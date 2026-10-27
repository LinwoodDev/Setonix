import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/programs/async.dart';

class WhitelistProgram extends AsyncServerProgram {
  WhitelistProgram(super.server);

  @override
  String getUsage() => '<add/remove> <User>';

  @override
  String getDescription() =>
      "Add or remove a user from the whitelist. "
      "Use 'add <User>' to add a user and 'remove <User>' to remove a user.";

  @override
  Future<void> runAsync(String label, List<String> args) async {
    if (args.length != 2) {
      throw const CommandUsageException();
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
        "User ${user.name} has no fingerprint.",
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
          "Failed to add ${user.name} to the whitelist.",
          level: LogLevel.error,
        );
        return;
      }
      server.log("Added ${user.name} to the whitelist.", level: LogLevel.info);
    } else if (action == 'remove') {
      final result = await server.userManager.service?.updateUser(
        fingerprint,
        onWhitelist: false,
      );
      if (result != true) {
        server.log(
          "Failed to remove ${user.name} from the whitelist.",
          level: LogLevel.error,
        );
        return;
      }
      server.log(
        "Removed ${user.name} from the whitelist.",
        level: LogLevel.info,
      );
    } else {
      throw const CommandUsageException();
    }
  }
}
