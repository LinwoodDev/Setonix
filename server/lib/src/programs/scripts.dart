import 'package:consoler/consoler.dart';
import 'package:setonix_server/setonix_server.dart';

class ScriptsProgram extends ConsoleProgram {
  final SetonixServer server;

  ScriptsProgram(this.server);

  @override
  String getDescription() => "Show all loaded scripts";

  @override
  String getUsage() => "[world]";

  @override
  void run(String label, List<String> args) {
    String world = defaultWorldName;
    if (args.length > 1) return print("Usage: $label [world]");
    if (args.length == 1) world = args[0];
    print("-----");
    final scripts = server.getWorld(world)?.pluginSystem.plugins.toList() ?? [];
    print("Loaded ${scripts.length} script(s).");
    for (final script in scripts) {
      print("> $script");
    }
    print("-----");
  }
}
