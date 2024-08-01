import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:quokka/models/definitions/pack.dart';
import 'package:quokka/models/table.dart';

class PackAssetBundle {
  final Map<String, PackData> _loadedPacks = {};
  final Map<AssetLocation, Image> _cachedImages = {};

  Iterable<MapEntry<String, PackData>> get loadedPacks => _loadedPacks.entries;

  PackAssetBundle();

  Uint8List? getTexture(String key) =>
      getTextureFromLocation(AssetLocation.fromString(key));

  Uint8List? getTextureFromLocation(AssetLocation location) {
    final pack = _loadedPacks[location.namespace];
    if (pack == null) return null;
    final asset = pack.getTexture(location.id);
    if (asset == null) return null;
    return asset;
  }

  Future<Sprite?> loadSprite(String key) =>
      loadSpriteFromLocation(AssetLocation.fromString(key));

  Future<Sprite?> loadSpriteFromLocation(
    AssetLocation location, {
    Vector2? srcPosition,
    Vector2? srcSize,
  }) async {
    Image? image = _cachedImages[location];
    if (image == null) {
      final texture = getTextureFromLocation(location);
      if (texture == null) return null;
      image = _cachedImages[location] = await decodeImageFromList(texture);
    }
    return Sprite(
      image,
      srcPosition: srcPosition,
      srcSize: srcSize,
    );
  }

  void loadPack(String key, PackData pack) {
    unloadPack(key);
    _loadedPacks[key] = pack;
  }

  void unloadPack(String key) {
    if (_loadedPacks.remove(key) != null) clearImagesFromNamespace(key);
  }

  void clearImagesFromNamespace(String namespace) => _cachedImages
    ..removeWhere((k, v) {
      if (namespace != k.namespace) return false;
      v.dispose();
      return true;
    });

  void clearImages() => _cachedImages
    ..forEach((_, v) => v.dispose())
    ..clear();
}
