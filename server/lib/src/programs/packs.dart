import 'package:consoler/consoler.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/server.dart';

class PacksProgram extends ConsoleProgram {
  final SetonixServer server;
  PacksProgram(this.server);
  @override
  String getDescription() => 'List loaded content packs.';
  @override
  void run(String label, List<String> args) {
    if (args.isNotEmpty) throw const CommandUsageException();
    final packs = server.assetManager.packs.toList();
    server.log("${packs.length} loaded pack(s).");
    server.consoler.table(
      ["Pack", "Fingerprint"],
      [
        for (final pack in packs)
          [
            pack.key == kCorePackId ? "Core pack" : pack.key,
            pack.value.identifier,
          ],
      ],
    );
  }
}
