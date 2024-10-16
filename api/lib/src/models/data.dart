import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:lw_file_system_api/lw_file_system_api.dart';
import 'background.dart';
import 'deck.dart';
import 'info.dart';
import 'meta.dart';
import 'definition.dart';
import 'table.dart';
import 'translation.dart';

const kPackMetadataPath = 'pack.json';
const kPackInfoPath = 'info.json';
const kPackDecksPath = 'decks';
const kPackFiguresPath = 'figures';
const kPackBoardsPath = 'boards';
const kPackTexturesPath = 'textures';
const kPackTranslationsPath = 'translations';
const kPackBackgroundsPath = 'backgrounds';

const kGameTablePath = 'tables';
const kGameTeamPath = 'teams.json';
const kGameNotesPath = 'notes';

class SetonixData extends ArchiveData<SetonixData> {
  SetonixData(super.archive, {super.state});
  SetonixData.empty() : super.empty();

  factory SetonixData.fromData(Uint8List data) {
    return SetonixData(ZipDecoder().decodeBytes(data));
  }

  GameTable? getTable([String name = '']) {
    final data = getAsset('$kGameTablePath/$name.json');
    if (data == null) return null;
    final content = utf8.decode(data);
    return GameTableMapper.fromJson(content);
  }

  GameTable getTableOrDefault([String name = '']) =>
      getTable(name) ?? GameTable();

  SetonixData setTable(GameTable table, [String name = '']) => setAsset(
        '$kGameTablePath/$name.json',
        utf8.encode(table.toJson()),
      );

  SetonixData removeTable(String name) =>
      removeAsset('$kGameTablePath/$name.json');

  Iterable<String> getTables() => getAssets(kGameTablePath, true);

  String? getNote(String name) {
    final data = getAsset('$kGameNotesPath/$name.md');
    if (data == null) return null;
    return utf8.decode(data);
  }

  SetonixData setNote(String name, String content) => setAsset(
        '$kGameNotesPath/$name.md',
        utf8.encode(content),
      );

  SetonixData removeNote(String name) =>
      removeAsset('$kGameNotesPath/$name.md');

  Iterable<String> getNotes() => getAssets(kGameNotesPath, true);

  FileMetadata? getMetadata() {
    final data = getAsset(kPackMetadataPath);
    if (data == null) {
      return null;
    }
    final content = utf8.decode(data);
    return FileMetadataMapper.fromJson(content);
  }

  GameInfo? getInfo() {
    final data = getAsset(kPackInfoPath);
    if (data == null) return null;
    final content = utf8.decode(data);
    return GameInfoMapper.fromJson(content);
  }

  GameInfo getInfoOrDefault() => getInfo() ?? const GameInfo();

  SetonixData setInfo(GameInfo info) =>
      setAsset(kPackInfoPath, utf8.encode(info.toJson()));

  FileMetadata getMetadataOrDefault() => getMetadata() ?? const FileMetadata();

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

  PackItem<BoardDefinition>? getBoardItem(String id, [String namespace = '']) =>
      PackItem.wrap(
        pack: this,
        namespace: namespace,
        id: id,
        item: getBoard(id),
      );

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

  SetonixData setFileMetadata(FileMetadata metadata) => setAsset(
        kPackMetadataPath,
        utf8.encode(metadata.toJson()),
      );

  @override
  SetonixData updateState(ArchiveState state) =>
      SetonixData(archive, state: state);

  Digest getChecksum() {
    final metadata = getMetadataOrDefault().toJson();
    return sha512256.convert(utf8.encode(metadata));
  }

  TranslationsStore getTranslationsStore(
          {required String Function() getLocale}) =>
      TranslationsStore(
        translations: getAllTranslations(),
        getLocale: getLocale,
      );
}

final class PackItem<T> {
  final SetonixData pack;
  final ItemLocation location;
  final T item;

  PackItem({
    required this.pack,
    required this.location,
    required this.item,
  });

  factory PackItem.fromRaw(
          {required SetonixData pack,
          required String namespace,
          required String path,
          required T item}) =>
      PackItem(
        item: item,
        pack: pack,
        location: ItemLocation(namespace, path),
      );

  static PackItem<T>? wrap<T>(
      {required SetonixData pack,
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

  PackItem<E> withItem<E>(E backgroundTranslation) => PackItem(
        pack: pack,
        location: location,
        item: backgroundTranslation,
      );
}
