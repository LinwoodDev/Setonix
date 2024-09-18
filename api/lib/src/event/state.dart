import 'package:dart_mappable/dart_mappable.dart';
import 'package:networker/networker.dart';

import '../models/chat.dart';
import '../models/data.dart';
import '../models/info.dart';
import '../models/meta.dart';
import '../models/table.dart';
import '../models/vector.dart';

part 'state.mapper.dart';

@MappableEnum()
enum WorldOperationMode {
  figures,
  boards,
}

@MappableClass()
final class WorldState with WorldStateMappable {
  final GameTable table;
  final String tableName;
  final GameInfo info;
  final String? name;
  final Channel id;
  final Map<String, Set<Channel>> teamMembers;
  final FileMetadata metadata;
  final QuokkaData data;
  final List<ChatMessage> messages;

  const WorldState({
    this.name,
    this.table = const GameTable(),
    this.tableName = '',
    this.info = const GameInfo(),
    this.metadata = const FileMetadata(),
    this.teamMembers = const {},
    this.messages = const [],
    this.id = kAuthorityChannel,
    required this.data,
  });

  GlobalVectorDefinition toGlobal(VectorDefinition position) =>
      GlobalVectorDefinition.fromLocal(tableName, position);

  bool isCellVisible(GlobalVectorDefinition cell, [Channel? id]) {
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
    final cellVisible = isCellVisible(toGlobal(cell), user);
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

  QuokkaData save() =>
      data.setTable(table, tableName).setInfo(info).setFileMetadata(metadata);

  GameTable? getTable(String name) =>
      name == tableName ? table : data.getTable(name);
  GameTable getTableOrDefault(String name) =>
      name == tableName ? table : data.getTableOrDefault(name);

  WorldState updateTable(String name, GameTable table) {
    if (name == tableName) return copyWith(table: table);
    return copyWith(
      data: data.setTable(table, name),
    );
  }

  WorldState mapTable(String name, GameTable Function(GameTable?) mapper) =>
      updateTable(name, mapper(getTable(name)));

  WorldState mapTableOrDefault(
          String name, GameTable Function(GameTable) mapper) =>
      updateTable(name, mapper(getTableOrDefault(name)));
}
