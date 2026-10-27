import 'package:consoler/consoler.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/server.dart';

class ModesProgram extends ConsoleProgram {
  final SetonixServer server;
  ModesProgram(this.server);
  @override
  String getDescription() => 'List available game modes.';
  @override
  void run(String label, List<String> args) {
    if (args.isNotEmpty) throw const CommandUsageException();
    final modes = server.assetManager.packs
        .expand(
          (pack) =>
              pack.value.getModes().map((mode) => ItemLocation(pack.key, mode)),
        )
        .toList();
    server.log("${modes.length} available game mode(s).");
    server.consoler.table(
      ["Game mode"],
      [
        for (final mode in modes) [mode],
      ],
    );
  }
}
