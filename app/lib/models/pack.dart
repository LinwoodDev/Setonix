import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quokka/models/deck.dart';
import 'package:quokka/models/meta.dart';
import 'package:quokka/models/object.dart';

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

  @useResult
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

  @useResult
  Iterable<String> getDecks() => getAssets(kPackDecksPath);

  @useResult
  DeckDefinition? getDeck(String id) {
    final data = getAsset('$kPackDecksPath/$id.json');
    if (data == null) return null;
    final content = utf8.decode(data);
    return DeckDefinitionMapper.fromJson(content);
  }

  @useResult
  Iterable<String> getFigures() => getAssets(kPackFiguresPath);

  @useResult
  FigureDefinition? getFigure(String id) {
    final data = getAsset('$kPackFiguresPath/$id.json');
    if (data == null) return null;
    final content = utf8.decode(data);
    return FigureDefinitionMapper.fromJson(content);
  }

  @useResult
  Iterable<String> getBoards() => getAssets(kPackBoardsPath);

  @useResult
  BoardDefinition? getBoard(String id) {
    final data = getAsset('$kPackBoardsPath/$id.json');
    if (data == null) return null;
    final content = utf8.decode(data);
    return BoardDefinitionMapper.fromJson(content);
  }

  @useResult
  Uint8List? getTexture(String path) => getAsset('$kPackTexturesPath/$path');
}
