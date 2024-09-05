import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart' show ColorScheme;
import 'package:networker/networker.dart';
import 'package:quokka/services/file_system.dart';
import 'package:quokka/bloc/multiplayer.dart';
import 'package:quokka_api/quokka_api.dart';

part 'state.mapper.dart';

@MappableEnum()
enum WorldOperationMode {
  figures,
  boards,
}

@MappableClass()
class ClientWorldState extends WorldState with ClientWorldStateMappable {
  final MultiplayerCubit multiplayer;
  final ColorScheme colorScheme;
  final QuokkaFileSystem fileSystem;
  final VectorDefinition? selectedCell;
  final ItemLocation? selectedDeck;
  final bool showHand, switchCellOnMove;

  const ClientWorldState({
    required this.multiplayer,
    required this.fileSystem,
    required this.colorScheme,
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
    required super.data,
  });
}
