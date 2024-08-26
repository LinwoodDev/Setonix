import 'package:quokka_api/quokka_api.dart';

abstract class AssetManager {
  QuokkaData? getPack(String key);

  bool isServerSupported(Map<String, String> signature) {
    if (signature.isEmpty) return false;
    for (final entry in signature.entries) {
      final pack = getPack(entry.key);
      if (pack == null || pack.getChecksum().toString() != entry.value) {
        return false;
      }
    }
    return true;
  }
}
