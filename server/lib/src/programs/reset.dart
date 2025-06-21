import 'package:consoler/consoler.dart';
import 'package:setonix_server/setonix_server.dart';

class ResetProgram extends ConsoleProgram {
  final SetonixServer server;

  ResetProgram(this.server);

  @override
  String getDescription() =>
      "Reset the world. Specify a game mode to allow playing games.";

  @override
  String getUsage() => '[<World>]';

  @override
  Future<void> run(String label, List<String> args) async {
    if (args.length > 1) {
      server.log("Wrong usage, use ${getUsage()}", level: LogLevel.error);
    }
    final worldName = args.elementAtOrNull(0) ?? defaultWorldName;
    server.log("Resetting world...", level: LogLevel.info);
    await server.getWorld(worldName)?.resetWorld();
    server.log("World reset successful", level: LogLevel.info);
  }
}
