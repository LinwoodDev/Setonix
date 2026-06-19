import 'package:consoler/consoler.dart';
import 'package:setonix_api/event.dart';
import 'package:setonix_server/src/server.dart';

class KickProgram extends ConsoleProgram {
  final SetonixServer server;

  KickProgram(this.server);

  @override
  String getDescription() => "Kick a player";

  @override
  String getUsage() => '<User> [<Reason>] [<Link>]';

  @override
  Future<void> run(String label, List<String> args) async {
    if (args.isEmpty || args.length > 3) {
      server.log("Wrong usage, use ${getUsage()}", level: LogLevel.error);
    }
    final arg = await server.userManager.getUserIdByReference(args[0]);
    if (arg == null) {
      server.log("ID should be a number", level: LogLevel.error);
      return;
    }
    KickMessage? reason;
    if (args.length > 1) {
      final reasonText = args[1];
      final link = args.length > 2 ? args[2] : null;
      reason = KickMessage(message: reasonText, link: link);
    }
    final result = server.kick(arg, reason);
    if (result) {
      server.log("$arg successfully kicked.", level: LogLevel.info);
    } else {
      server.log("$arg could not be kicked.", level: LogLevel.error);
    }
  }
}
