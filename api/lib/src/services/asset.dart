import 'package:quokka_api/quokka_api.dart';

const kCorePackId = "core";

abstract class AssetManager {
  QuokkaData? getPack(String key);
  bool hasPack(String key);

  Iterable<MapEntry<String, QuokkaData>> get packs;

  Map<String, FileMetadata> createSignature([Set<String>? packs]) {
    final signature = <String, FileMetadata>{};
    for (final entry in this.packs) {
      if (!(packs?.contains(entry.key) ?? true)) continue;
      signature[entry.key] = entry.value.getMetadataOrDefault();
    }
    return signature;
  }
}
