import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/programs/async.dart';

class BansProgram extends AsyncServerProgram {
  BansProgram(super.server);
  @override
  String getDescription() => 'List active user bans.';
  @override
  Future<void> runAsync(String label, List<String> args) async {
    if (args.isNotEmpty) throw const CommandUsageException();
    final users = await server.userManager.getBannedUsers();
    server.log("${users.length} active ban(s).");
    server.consoler.table(
      ["Name", "Until", "Reason"],
      [
        for (final user in users)
          [
            '@${user.name}',
            user.bannedUntil?.toLocal().toIso8601String() ?? "permanent",
            user.banReason ?? '',
          ],
      ],
    );
  }
}
