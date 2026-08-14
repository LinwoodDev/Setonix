import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/programs/async.dart';

class BansProgram extends AsyncServerProgram {
  BansProgram(super.server);

  @override
  String getDescription() => 'List active user bans.';

  @override
  Future<void> runAsync(String label, List<String> args) async {
    if (args.isNotEmpty) {
      server.log('Wrong usage, use bans', level: LogLevel.error);
      return;
    }
    final users = await server.userManager.getBannedUsers();
    server.log('${users.length} active ban(s):', level: LogLevel.info);
    for (final user in users) {
      final expiry =
          user.bannedUntil?.toLocal().toIso8601String() ?? 'permanent';
      final reason = user.banReason?.isNotEmpty == true
          ? ' | ${user.banReason}'
          : '';
      server.log('@${user.name} | until $expiry$reason', level: LogLevel.info);
    }
  }
}
