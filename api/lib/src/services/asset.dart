import 'package:setonix_api/setonix_api.dart';

const kCorePackId = "core";

abstract class AssetManager {
  SetonixData? getPack(String key);
  bool hasPack(String key);

  Iterable<MapEntry<String, SetonixData>> get packs;

  Map<String, FileMetadata> createSignature([Set<String>? packs]) {
    final signature = <String, FileMetadata>{};
    for (final entry in this.packs) {
      if (!(packs?.contains(entry.key) ?? true)) continue;
      signature[entry.key] = entry.value.getMetadataOrDefault();
    }
    return signature;
  }
}
