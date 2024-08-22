import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:quokka_api/quokka_api.dart';

class ServerAssetManager extends AssetManager {
  final Map<String, QuokkaData> _packs = {};

  Future<void> init({bool verbose = false}) async {
    _packs.clear();
    final directory = Directory('packs');
    if (!await directory.exists()) {
      await directory.create();
      print(
          'WARNING: No packs directory found. Please add packs to the server.');
    }
    await for (final file in directory.list()) {
      if (file is File) {
        final data = QuokkaData.fromData(await file.readAsBytes());
        final fileName = p.basenameWithoutExtension(file.path);
        _packs[fileName] = data;
      }
    }
    print('Loaded ${_packs.length} packs.');
    if (verbose) {
      print('Loaded packs: ${_packs.keys.join(', ')}');
    }
  }

  @override
  QuokkaData? getPack(String key) => _packs[key];
}
