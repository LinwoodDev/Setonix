import 'package:consoler/consoler.dart';
import 'package:quokka_server/server.dart';

class KickProgram extends ConsoleProgram {
  final QuokkaServer server;

  KickProgram(this.server);

  @override
  String getDescription() => "Kick a player";

  @override
  String getUsage() => 'kick <ID>';

  @override
  void run(String label, List<String> args) {
    if (args.length != 1) {
      server.log("Wrong usage, use ${getUsage()}", level: LogLevel.error);
    }
    final arg = int.tryParse(args[0]);
    if (arg == null) {
      server.log("ID should be a number", level: LogLevel.error);
      return;
    }
    final result = server.kick(arg);
    if (result) {
      server.log("$arg successfully kicked.", level: LogLevel.info);
    } else {
      server.log("$arg could not be kicked.", level: LogLevel.error);
    }
  }
}
