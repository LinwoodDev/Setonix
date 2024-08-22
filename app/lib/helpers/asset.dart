import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:quokka/bloc/world/bloc.dart';
import 'package:quokka/helpers/vector.dart';
import 'package:quokka/services/file_system.dart';
import 'package:quokka_api/quokka_api.dart';

class GameAssetManager extends AssetManager {
  String currentLocale;
  final WorldBloc bloc;
  final Map<String, QuokkaData> _loadedPacks = {};
  final Map<String, TranslationsStore> _loadedTranslations = {};
  final Map<ItemLocation, Future<Image>> _cachedImages = {};

  QuokkaFileSystem get fileSystem => bloc.state.fileSystem;

  GameAssetManager({
    required this.bloc,
    this.currentLocale = 'en',
  });

  Iterable<MapEntry<String, QuokkaData>> get packs => _loadedPacks.entries;

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
  }) {
    Future<Image>? image = _cachedImages[location];
    if (image == null) {
      final texture = getTextureFromLocation(location);
      if (texture == null) return Future.value(null);
      image = _cachedImages[location] = decodeImageFromList(texture);
    }
    return image.then((e) => Sprite(
          e,
          srcPosition: srcPosition,
          srcSize: srcSize,
        ));
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

  @override
  QuokkaData? getPack(String key) => _loadedPacks[key];

  Future<QuokkaData?> loadPack(String key,
      {QuokkaData? pack, bool force = false}) async {
    final oldPack = _loadedPacks[key];
    if (!force && oldPack != null) return oldPack;
    pack ??= await fileSystem.getPack(key);
    if (pack == null) return null;
    unloadPack(key);
    _loadedPacks[key] = pack;
    _loadedTranslations[key] = TranslationsStore(
      translations: pack.getAllTranslations(),
      getLocale: () => currentLocale,
    );
    return pack;
  }

  TranslationsStore getTranslations(String key) =>
      _loadedTranslations[key] ??
      TranslationsStore(getLocale: () => currentLocale);

  void unloadPack(String key) {
    _loadedTranslations.remove(key);
    if (_loadedPacks.remove(key) != null) clearImagesFromNamespace(key);
  }

  void clearImagesFromNamespace(String namespace) => _cachedImages
    ..removeWhere((k, v) {
      if (namespace != k.namespace) return false;
      v.then((e) => e.dispose());
      return true;
    });

  void clearImages() => _cachedImages
    ..forEach((_, v) => v.then((e) => e.dispose()))
    ..clear();
}
