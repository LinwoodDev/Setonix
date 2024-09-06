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
  final Map<ItemLocation?, Future<Image>> _cachedImages = {};

  QuokkaFileSystem get fileSystem => bloc.state.fileSystem;

  GameAssetManager({
    required this.bloc,
    this.currentLocale = 'en',
  });

  @override
  Iterable<MapEntry<String, QuokkaData>> get packs => _loadedPacks.entries;

  Uint8List? getTexture(String key, String namespace) =>
      getTextureFromLocation(ItemLocation.fromString(key, namespace));

  Uint8List? getTextureFromLocation(ItemLocation location) {
    final pack = _loadedPacks[location.namespace];
    if (pack == null) return null;
    final asset = pack.getTexture(location.id);
    if (asset == null) return null;
    return asset;
  }

  Future<Sprite?> loadSprite(
    String key,
    String namespace, {
    Vector2? srcPosition,
    Vector2? srcSize,
  }) =>
      loadSpriteFromLocation(
        ItemLocation.fromString(key, namespace),
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

  Future<Sprite?> loadFigureSprite(String key, String namespace,
          [String? variation]) =>
      loadFigureSpriteFromLocation(
          ItemLocation.fromString(key, namespace), variation);

  Future<Sprite?> loadFigureSpriteFromLocation(ItemLocation location,
      [String? variation]) async {
    final figure = getPack(location.namespace)?.getFigure(location.id);
    if (figure == null) return null;
    final definition = figure.variations[variation] ?? figure.back;
    return loadSprite(
      definition.texture,
      location.namespace,
      srcPosition: definition.offset.toVector(),
      srcSize: definition.size?.toVector(),
    );
  }

  @override
  QuokkaData? getPack(String key) => _loadedPacks[key];

  Future<void> loadPacks() async {
    final files = await fileSystem.getPacks();
    unloadPacks(_loadedPacks.keys
        .where((e) => !files.any((f) => f.pathWithoutLeadingSlash == e)));
    for (final file in files) {
      try {
        final key = file.pathWithoutLeadingSlash;
        final pack = file.data!;
        _loadedPacks[key] = pack;
        _loadedTranslations[key] = TranslationsStore(
          translations: pack.getAllTranslations(),
          getLocale: () => currentLocale,
        );
      } catch (_) {}
    }
  }

  TranslationsStore getTranslations(String key) =>
      _loadedTranslations[key] ??
      TranslationsStore(getLocale: () => currentLocale);

  void unloadPacks(Iterable<String> keys) {
    _loadedTranslations.removeWhere((e, _) => keys.contains(e));
    for (final key in keys) {
      if (_loadedPacks.remove(key) != null) clearImagesFromNamespace(key);
    }
  }

  void clearImagesFromNamespace(String namespace) => _cachedImages
    ..removeWhere((k, v) {
      if (namespace != k?.namespace) return false;
      v.then((e) => e.dispose());
      return true;
    });

  void clearImages() => _cachedImages
    ..forEach((_, v) => v.then((e) => e.dispose()))
    ..clear();

  @override
  bool hasPack(String key) => _loadedPacks.containsKey(key);
}
