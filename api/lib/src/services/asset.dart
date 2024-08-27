import 'package:quokka_api/quokka_api.dart';

abstract class AssetManager {
  QuokkaData? getPack(String key);
  Future<QuokkaData?> loadPack(String key) => Future.value(getPack(key));

  Iterable<MapEntry<String, QuokkaData>> get packs;

  Future<bool> isServerSupported(Map<String, String> signature) async {
    if (signature.isEmpty) return false;
    for (final entry in signature.entries) {
      final pack = await loadPack(entry.key);
      if (pack == null || pack.getChecksum().toString() != entry.value) {
        return false;
      }
    }
    return true;
  }

  Map<String, String> createSignature() {
    final signature = <String, String>{};
    for (final entry in packs) {
      signature[entry.key] = entry.value.getChecksum().toString();
    }
    return signature;
  }

  void setAllowedPacks(Set<String> packs) {}
}
