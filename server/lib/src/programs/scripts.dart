import 'package:consoler/consoler.dart';
import 'package:setonix_server/setonix_server.dart';

class ScriptsProgram extends ConsoleProgram {
  final SetonixServer server;
  ScriptsProgram(this.server);
  @override
  String getDescription() => 'List loaded scripts.';
  @override
  String getUsage() => '[World]';
  @override
  void run(String label, List<String> args) {
    if (args.length > 1) throw const CommandUsageException();
    final name = args.firstOrNull ?? defaultWorldName;
    final world = server.getWorld(name);
    if (world == null) {
      throw CommandFailure("Unknown world: $name");
    }
    final scripts = world.pluginSystem.plugins.toList();
    server.log("${scripts.length} loaded script(s).");
    server.consoler.table(
      ["Script"],
      [
        for (final script in scripts) [script],
      ],
    );
  }
}
