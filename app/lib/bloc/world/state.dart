import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart' show ColorScheme;
import 'package:networker/networker.dart';
import 'package:quokka/models/data.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/models/vector.dart';
import 'package:quokka/services/file_system.dart';
import 'package:quokka/bloc/multiplayer.dart';

part 'state.mapper.dart';

@MappableEnum()
enum WorldOperationMode {
  figures,
  boards,
}

@MappableClass()
class WorldState with WorldStateMappable {
  final MultiplayerCubit multiplayer;
  final ColorScheme colorScheme;
  final QuokkaFileSystem fileSystem;
  final GameTable table;
  final String tableName;
  final GameInfo info;
  final VectorDefinition? selectedCell;
  final ItemLocation? selectedDeck;
  final bool showHand;
  final String? name;
  final Channel id;
  final Map<String, Set<Channel>> teamMembers;
  final QuokkaData data;

  const WorldState({
    required this.multiplayer,
    required this.fileSystem,
    required this.colorScheme,
    this.name,
    this.table = const GameTable(),
    this.tableName = '',
    this.info = const GameInfo(),
    this.selectedCell,
    this.selectedDeck,
    this.showHand = false,
    this.id = kAuthorityChannel,
    this.teamMembers = const {},
    required this.data,
  });

  bool isCellVisible(VectorDefinition cell, [Channel? id]) {
    bool isClaimed = false, isMyTeam = false;
    for (final entry in info.teams.entries) {
      final name = entry.key;
      final team = entry.value;
      if (team.claimedCells.contains(cell)) {
        isClaimed = true;
        if (teamMembers[name]?.contains(id ?? this.id) ?? false) {
          isMyTeam = true;
          break;
        }
      }
    }
    return !isClaimed || isMyTeam;
  }

  TableCell? restrictCell(VectorDefinition cell, Channel user) {
    final cellObject = table.cells[cell];
    if (cellObject == null) {
      return null;
    }
    final cellVisible = isCellVisible(cell, user);
    final objects = cellObject.objects
        .map((e) => e.copyWith(
            variation: cellVisible && !e.hidden ? e.variation : null))
        .toList();
    return cellObject.copyWith(objects: objects);
  }

  GameTable restrict(Channel user) {
    final cells =
        table.cells.keys.map((e) => MapEntry(e, restrictCell(e, user)!));
    return table.copyWith(cells: Map.fromEntries(cells));
  }

  QuokkaData save() => data.setTable(table, tableName);
}
