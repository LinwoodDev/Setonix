import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart' show ColorScheme;
import 'package:networker/networker.dart';
import 'package:setonix/helpers/asset.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/bloc/multiplayer.dart';
import 'package:setonix_api/setonix_api.dart';

part 'state.mapper.dart';

@MappableEnum()
enum WorldOperationMode {
  figures,
  boards,
}

@MappableEnum()
enum DrawerView {
  chat,
  notes,
}

@MappableClass()
final class ClientWorldState with ClientWorldStateMappable {
  final WorldState world;
  final MultiplayerCubit multiplayer;
  final GameAssetManager assetManager;
  final ColorScheme colorScheme;
  final VectorDefinition? selectedCell;
  final ItemLocation? selectedDeck;
  final bool showHand, switchCellOnMove;
  final DrawerView drawerView;
  final String searchTerm;
  final bool showDuplicates;

  const ClientWorldState({
    required this.multiplayer,
    required this.colorScheme,
    required this.assetManager,
    required this.world,
    this.selectedCell,
    this.selectedDeck,
    this.showHand = false,
    this.switchCellOnMove = false,
    this.drawerView = DrawerView.chat,
    this.searchTerm = '',
    this.showDuplicates = false,
  });

  SetonixFileSystem get fileSystem => assetManager.fileSystem;

  Iterable<MapEntry<String, SetonixData>> get packs =>
      assetManager.packs.where((e) => world.info.packs.contains(e.key));

  GameTable get table => world.table;
  String get tableName => world.tableName;
  GameInfo get info => world.info;
  Map<String, Set<int>> get teamMembers => world.teamMembers;
  Channel get id => world.id;
  bool isCellVisible(GlobalVectorDefinition cell) =>
      world.isCellVisible(cell, id);
  GlobalVectorDefinition toGlobal(VectorDefinition position) =>
      world.toGlobal(position);
  List<ChatMessage> get messages => world.messages;
  String? get name => world.name;
  FileMetadata get metadata => world.metadata;
  SetonixData get data => world.data;
}
