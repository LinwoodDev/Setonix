import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:lw_file_system_api/lw_file_system_api.dart';
import 'background.dart';
import 'deck.dart';
import 'meta.dart';
import 'object.dart';
import 'table.dart';
import 'translation.dart';

const kPackMetadataPath = 'pack.json';
const kPackDecksPath = 'decks';
const kPackFiguresPath = 'figures';
const kPackBoardsPath = 'boards';
const kPackTexturesPath = 'textures';
const kPackTranslationsPath = 'translations';
const kPackBackgroundsPath = 'backgrounds';

const kGameTablePath = 'tables';
const kGameTeamPath = 'teams.json';

class QuokkaData extends ArchiveData<QuokkaData> {
  QuokkaData(super.archive, {super.state});
  QuokkaData.empty() : super.empty();

  factory QuokkaData.fromData(Uint8List data) {
    return QuokkaData(ZipDecoder().decodeBytes(data));
  }

  GameTable? getTable() {
    final data = getAsset('$kGameTablePath/.json');
    if (data == null) return null;
    final content = utf8.decode(data);
    return GameTableMapper.fromJson(content);
  }

  GameTable getTableOrDefault() => getTable() ?? GameTable();

  QuokkaData setTable(GameTable table, String name) => setAsset(
        '$kGameTablePath/$name.json',
        utf8.encode(table.toJson()),
      );

  FileMetadata? getMetadata() {
    final data = getAsset(kPackMetadataPath);
    if (data == null) {
      return null;
    }
    final content = utf8.decode(data);
    return FileMetadataMapper.fromJson(content);
  }

  FileMetadata getMetadataOrDefault() => getMetadata() ?? const FileMetadata();

  Iterable<String> getAssets(String path, [bool removeExtension = false]) => {
        ...archive.files.map((e) => e.name),
      }
          .where((e) => e.startsWith(path))
          .map((e) => e.substring(path.length))
          .map((e) {
        if (e.startsWith('/')) e = e.substring(1);
        if (!removeExtension) return e;
        final startExtension = e.lastIndexOf('.');
        if (startExtension == -1) return e;
        return e.substring(0, startExtension);
      });

  Iterable<String> getDecks() => getAssets(kPackDecksPath, true);

  DeckDefinition? getDeck(String id) {
    final data = getAsset('$kPackDecksPath/$id.json');
    if (data == null) return null;
    final content = utf8.decode(data);
    return DeckDefinitionMapper.fromJson(content);
  }

  PackItem<DeckDefinition>? getDeckItem(String id, [String namespace = '']) =>
      PackItem.wrap(
        pack: this,
        namespace: namespace,
        id: id,
        item: getDeck(id),
      );

  Iterable<PackItem<DeckDefinition>> getDeckItems([String namespace = '']) =>
      getDecks().map((e) => getDeckItem(e, namespace)).nonNulls;

  Iterable<String> getFigures() => getAssets('$kPackFiguresPath/', true);

  FigureDefinition? getFigure(String id) {
    final data = getAsset('$kPackFiguresPath/$id.json');
    if (data == null) return null;
    final content = utf8.decode(data);
    return FigureDefinitionMapper.fromJson(content);
  }

  PackItem<FigureDefinition>? getFigureItem(String id,
          [String namespace = '']) =>
      PackItem.wrap(
        pack: this,
        namespace: namespace,
        id: id,
        item: getFigure(id),
      );

  Iterable<PackItem<FigureDefinition>> getFigureItems(
          [String namespace = '']) =>
      getDecks().map((e) => getFigureItem(e, namespace)).nonNulls;

  Iterable<String> getBoards() => getAssets(kPackBoardsPath, true);

  BoardDefinition? getBoard(String id) {
    try {
      final data = getAsset('$kPackBoardsPath/$id.json');
      if (data == null) return null;
      final content = utf8.decode(data);
      return BoardDefinitionMapper.fromJson(content);
    } catch (e) {
      return null;
    }
  }

  Iterable<String> getBackgrounds() =>
      getAssets('$kPackBackgroundsPath/', true);

  BackgroundDefinition? getBackground(String id) {
    final data = getAsset('$kPackBackgroundsPath/$id.json');
    if (data == null) return null;
    final content = utf8.decode(data);
    return BackgroundDefinitionMapper.fromJson(content);
  }

  PackItem<BackgroundDefinition>? getBackgroundItem(String id,
          [String namespace = '']) =>
      PackItem.wrap(
        pack: this,
        namespace: namespace,
        id: id,
        item: getBackground(id),
      );

  Iterable<PackItem<BackgroundDefinition>> getBackgroundItems(
          [String namespace = '']) =>
      getBackgrounds().map((e) => getBackgroundItem(e, namespace)).nonNulls;

  Uint8List? getTexture(String path) => getAsset('$kPackTexturesPath/$path');

  Iterable<MapEntry<String, PackTranslation>> getAllTranslations() =>
      getAssets(kPackTranslationsPath, true).map((e) {
        final translation = getTranslation(e);
        if (translation == null) return null;
        return MapEntry(e, translation);
      }).nonNulls;

  PackTranslation? getTranslation(String id) {
    final data = getAsset('$kPackTranslationsPath/$id.json');
    if (data == null) return null;
    final content = utf8.decode(data);
    return PackTranslationMapper.fromJson(content);
  }

  QuokkaData setFileMetadata(FileMetadata metadata) => setAsset(
        kPackMetadataPath,
        utf8.encode(metadata.toJson()),
      );

  @override
  QuokkaData updateState(ArchiveState state) =>
      QuokkaData(archive, state: state);

  Digest getChecksum() {
    final metadata = getMetadataOrDefault().toJson();
    return sha512256.convert(utf8.encode(metadata));
  }
}

final class PackItem<T> {
  final QuokkaData pack;
  final ItemLocation location;
  final T item;

  PackItem({
    required this.pack,
    required this.location,
    required this.item,
  });

  factory PackItem.fromRaw(
          {required QuokkaData pack,
          required String namespace,
          required String path,
          required T item}) =>
      PackItem(
        item: item,
        pack: pack,
        location: ItemLocation(namespace, path),
      );

  static PackItem<T>? wrap<T>(
      {required QuokkaData pack,
      required String namespace,
      T? item,
      String? id}) {
    if (item == null || id == null) return null;
    return PackItem(
      pack: pack,
      location: ItemLocation(namespace, id),
      item: item,
    );
  }

  String get namespace => location.namespace;
  String get id => location.id;
}
