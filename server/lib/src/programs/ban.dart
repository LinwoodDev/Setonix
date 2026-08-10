import 'package:consoler/consoler.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/server.dart';

class BanProgram extends ConsoleProgram {
  final SetonixServer server;
  final bool banned;

  BanProgram(this.server, {required this.banned});

  @override
  String getUsage() => banned ? '<User> [Minutes] [Reason...]' : '<User>';

  @override
  String getDescription() => banned
      ? 'Persistently ban a registered user, optionally until a given time.'
      : 'Remove a persistent user ban.';

  @override
  Future<void> run(String label, List<String> args) async {
    if (args.isEmpty || (!banned && args.length != 1)) {
      server.log('Wrong usage, use ${getUsage()}', level: LogLevel.error);
      return;
    }
    final channel = await server.userManager.getUserIdByReference(args.first);
    final minutes = args.length > 1 ? int.tryParse(args[1]) : null;
    final reasonStart = minutes == null ? 1 : 2;
    final reason = args.length > reasonStart
        ? args.skip(reasonStart).join(' ')
        : null;
    final until = minutes == null
        ? null
        : DateTime.now().add(Duration(minutes: minutes));
    final changed = await server.userManager.changeBan(
      args.first,
      banned: banned,
      until: until,
      reason: reason,
    );
    if (!changed) {
      server.log(
        'User not found or has no fingerprint: ${args.first}',
        level: LogLevel.error,
      );
      return;
    }
    if (banned && channel != null) {
      server.kick(
        channel,
        KickMessage(reason: KickReason.ban, message: reason),
      );
    }
    server.log(
      '${banned ? 'Banned' : 'Unbanned'} ${args.first}',
      level: LogLevel.info,
    );
  }
}
