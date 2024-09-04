import 'package:quokka_api/quokka_api.dart';

const kCorePackId = "core";

abstract class AssetManager {
  QuokkaData? getPack(String key);
  bool hasPack(String key);

  Iterable<MapEntry<String, QuokkaData>> get packs;

  bool isServerSupported(Map<String, FileMetadata> signature) {
    if (signature.isEmpty) return false;
    for (final entry in signature.entries) {
      final pack = getPack(entry.key);
      if (pack == null || pack.getMetadataOrDefault() != entry.value) {
        return false;
      }
    }
    return true;
  }

  Map<String, FileMetadata> createSignature(Set<String> packs) {
    final signature = <String, FileMetadata>{};
    for (final entry in this.packs) {
      if (!packs.contains(entry.key)) continue;
      signature[entry.key] = entry.value.getMetadataOrDefault();
    }
    return signature;
  }
}
