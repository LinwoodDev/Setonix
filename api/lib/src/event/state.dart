import 'package:dart_mappable/dart_mappable.dart';
import 'package:networker/networker.dart';
import 'package:quokka_api/quokka_api.dart';

part 'state.mapper.dart';

@MappableEnum()
enum WorldOperationMode {
  figures,
  boards,
}

@MappableClass()
class WorldState with WorldStateMappable {
  final GameTable table;
  final String tableName;
  final GameInfo info;
  final String? name;
  final Channel id;
  final Map<String, Set<Channel>> teamMembers;
  final FileMetadata metadata;
  final QuokkaData data;

  const WorldState({
    this.name,
    this.table = const GameTable(),
    this.tableName = '',
    this.info = const GameInfo(),
    this.metadata = const FileMetadata(),
    this.teamMembers = const {},
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
}
