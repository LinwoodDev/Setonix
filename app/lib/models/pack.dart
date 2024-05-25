import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:flutter/services.dart';
import 'package:quokka/models/definitions/deck.dart';
import 'package:quokka/models/definitions/meta.dart';
import 'package:quokka/models/definitions/object.dart';

const kPackMetadataPath = 'pack.json';
const kPackDecksPath = 'decks';
const kPackFiguresPath = 'decks';
const kPackBoardsPath = 'boards';
const kPackTexturesPath = 'textures';

class PackData {
  final Archive archive;

  PackData(this.archive);

  factory PackData.fromData(Uint8List data) {
    return PackData(ZipDecoder().decodeBytes(data));
  }
  static Future<PackData?> getCorePack() async => PackData.fromData(
      (await rootBundle.load('assets/pack.qka')).buffer.asUint8List());

  Uint8List? getAsset(String path) => archive.findFile(path)?.content;

  PackMetadata? getMetadata() {
    final data = getAsset(kPackMetadataPath);
    if (data == null) {
      return null;
    }
    final content = utf8.decode(data);
    return PackMetadataMapper.fromJson(content);
  }

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

  Iterable<String> getDecks() => getAssets(kPackDecksPath);

  DeckDefinition? getDeck(String id) {
    final data = getAsset('$kPackDecksPath/$id.json');
    if (data == null) return null;
    final content = utf8.decode(data);
    return DeckDefinitionMapper.fromJson(content);
  }

  Iterable<String> getFigures() => getAssets(kPackFiguresPath);

  FigureDefinition? getFigure(String id) {
    final data = getAsset('$kPackFiguresPath/$id.json');
    if (data == null) return null;
    final content = utf8.decode(data);
    return FigureDefinitionMapper.fromJson(content);
  }

  Iterable<String> getBoards() => getAssets(kPackBoardsPath);

  BoardDefinition? getBoard(String id) {
    final data = getAsset('$kPackBoardsPath/$id.json');
    if (data == null) return null;
    final content = utf8.decode(data);
    return BoardDefinitionMapper.fromJson(content);
  }

  Uint8List? getTexture(String path) => getAsset('$kPackTexturesPath/$path');
}
