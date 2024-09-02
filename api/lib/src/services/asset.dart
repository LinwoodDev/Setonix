import 'package:quokka_api/quokka_api.dart';

const kCorePackId = "core";

abstract class AssetManager {
  QuokkaData? getPack(String key);
  Future<QuokkaData?> loadPack(String key) => Future.value(getPack(key));

  Iterable<MapEntry<String, QuokkaData>> get packs;

  Future<bool> isServerSupported(Map<String, FileMetadata> signature) async {
    if (signature.isEmpty) return false;
    for (final entry in signature.entries) {
      final pack = await loadPack(entry.key);
      if (pack == null || pack.getMetadataOrDefault() != entry.value) {
        return false;
      }
    }
    return true;
  }

  Map<String, FileMetadata> createSignature() {
    final signature = <String, FileMetadata>{};
    for (final entry in packs) {
      signature[entry.key] = entry.value.getMetadataOrDefault();
    }
    return signature;
  }

  void setAllowedPacks(Set<String> packs) {}
}
