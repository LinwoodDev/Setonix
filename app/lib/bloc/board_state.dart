import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:quokka/models/data.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/models/vector.dart';
import 'package:quokka/services/file_system.dart';
import 'package:quokka/bloc/multiplayer.dart';

part 'board_state.mapper.dart';

@MappableClass()
class BoardState with BoardStateMappable {
  final MultiplayerCubit multiplayer;
  final ColorScheme? colorScheme;
  final QuokkaFileSystem fileSystem;
  final GameTable table;
  final VectorDefinition? selectedCell;
  final ItemLocation? selectedDeck;
  final bool showHand;
  final String? name;
  final QuokkaData data;

  const BoardState({
    required this.multiplayer,
    required this.fileSystem,
    this.name,
    this.colorScheme,
    this.table = const GameTable(),
    this.selectedCell,
    this.selectedDeck,
    this.showHand = false,
    required this.data,
  });
}
