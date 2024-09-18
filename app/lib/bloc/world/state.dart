import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart' show ColorScheme;
import 'package:networker/networker.dart';
import 'package:quokka/helpers/asset.dart';
import 'package:quokka/services/file_system.dart';
import 'package:quokka/bloc/multiplayer.dart';
import 'package:quokka_api/quokka_api.dart';

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
final class ClientWorldState extends WorldState with ClientWorldStateMappable {
  final MultiplayerCubit multiplayer;
  final GameAssetManager assetManager;
  final ColorScheme colorScheme;
  final VectorDefinition? selectedCell;
  final ItemLocation? selectedDeck;
  final bool showHand, switchCellOnMove;
  final DrawerView drawerView;
  final double zoom;

  const ClientWorldState({
    required this.multiplayer,
    required this.colorScheme,
    required this.assetManager,
    super.name,
    super.table,
    super.tableName,
    super.info,
    super.metadata,
    this.selectedCell,
    this.selectedDeck,
    this.showHand = false,
    this.switchCellOnMove = false,
    super.id,
    super.teamMembers,
    super.messages,
    required super.data,
    this.drawerView = DrawerView.chat,
    this.zoom = 1.0,
  });

  QuokkaFileSystem get fileSystem => assetManager.fileSystem;

  Iterable<MapEntry<String, QuokkaData>> get packs =>
      assetManager.packs.where((e) => info.packs.contains(e.key));
}
