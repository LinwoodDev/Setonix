import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:quokka/models/definitions/pack.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/services/pack.dart';

class AssetManager {
  final PackService packService;
  final Map<String, PackData> _loadedPacks = {};
  final Map<ItemLocation, Image> _cachedImages = {};

  Iterable<MapEntry<String, PackData>> get loadedPacks => _loadedPacks.entries;

  AssetManager({
    required this.packService,
  });

  Iterable<MapEntry<String, PackData>> get packs => _loadedPacks.entries;

  Uint8List? getTexture(String key) =>
      getTextureFromLocation(ItemLocation.fromString(key));

  Uint8List? getTextureFromLocation(ItemLocation location) {
    final pack = _loadedPacks[location.namespace];
    if (pack == null) return null;
    final asset = pack.getTexture(location.id);
    if (asset == null) return null;
    return asset;
  }

  Future<Sprite?> loadSprite(
    String key, {
    Vector2? srcPosition,
    Vector2? srcSize,
  }) =>
      loadSpriteFromLocation(
        ItemLocation.fromString(key),
        srcPosition: srcPosition,
        srcSize: srcSize,
      );

  Future<Sprite?> loadSpriteFromLocation(
    ItemLocation location, {
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

  Future<Sprite?> loadFigureSprite(String key, [String? variation]) =>
      loadFigureSpriteFromLocation(ItemLocation.fromString(key), variation);

  Future<Sprite?> loadFigureSpriteFromLocation(ItemLocation location,
      [String? variation]) async {
    final figure = (await loadPack(location.namespace))?.getFigure(location.id);
    if (figure == null) return null;
    final definition = figure.variations[variation] ?? figure.back;
    return loadSprite(
      definition.texture,
      srcPosition: definition.offset.toVector(),
      srcSize: definition.size?.toVector(),
    );
  }

  PackData? getPack(String key) => _loadedPacks[key];

  Future<PackData?> loadPack(String key,
      {PackData? pack, bool force = false}) async {
    final oldPack = _loadedPacks[key];
    if (!force && oldPack != null) return oldPack;
    pack ??= await packService.loadPack(key);
    if (pack == null) return null;
    unloadPack(key);
    _loadedPacks[key] = pack;
    return pack;
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
