import 'package:dart_mappable/dart_mappable.dart';
import 'vector.dart';

part 'table.mapper.dart';

class VectorMapHook extends MappingHook {
  const VectorMapHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is! List<dynamic>) {
      return value;
    }
    return Map.fromEntries(value.map((entry) => MapEntry(entry, entry)));
  }

  @override
  Object? afterEncode(Object? value) {
    if (value is! Map) {
      return value;
    }
    return value.entries.map((entry) {
      final key = entry.key;
      final value = entry.value;
      return {
        if (key is Map) ...key,
        if (value is Map) ...value,
      };
    }).toList();
  }
}

@MappableClass()
class GameTable with GameTableMappable {
  @MappableField(hook: VectorMapHook())
  final Map<VectorDefinition, TableCell> cells;
  final ItemLocation? background;

  const GameTable({
    this.cells = const {},
    this.background,
  });

  TableCell getCell(VectorDefinition position) =>
      cells[position] ?? TableCell();
}

@MappableClass()
class GlobalVectorDefinition with GlobalVectorDefinitionMappable {
  final String table;
  final VectorDefinition position;

  GlobalVectorDefinition(
    this.table,
    int x,
    int y,
  ) : position = VectorDefinition(x, y);

  GlobalVectorDefinition.fromLocal(this.table, this.position);

  int get x => position.x;
  int get y => position.y;
}

@MappableClass()
class GameSeat with GameSeatMappable {
  final int? color;

  GameSeat({
    this.color,
  });
}

@MappableClass()
class TableCell with TableCellMappable {
  final List<GameObject> objects;
  final List<BoardTile> boards;
  final String? team;
  final int reveal;
  final int? teamReveal;

  TableCell({
    this.objects = const [],
    this.boards = const [],
    this.team,
    this.reveal = -1,
    this.teamReveal,
  });

  int get teamRevealValue => teamReveal ?? reveal;
}

@MappableClass()
class GameObject with GameObjectMappable {
  final ItemLocation asset;
  final String? variation;
  final bool hidden;

  GameObject({
    required this.asset,
    this.variation,
    this.hidden = false,
  });
}

@MappableClass()
class BoardTile with BoardTileMappable {
  final ItemLocation asset;
  final VectorDefinition tile;

  BoardTile({
    required this.asset,
    required this.tile,
  });
}

@MappableClass()
class ItemLocation with ItemLocationMappable {
  final String namespace, id;

  ItemLocation(this.namespace, this.id);
  factory ItemLocation.fromString(String location, String namespace) {
    final splitted = location.split(':');
    if (splitted.length < 2) {
      return ItemLocation(namespace, splitted[0]);
    }
    return ItemLocation(splitted[0], splitted[1]);
  }

  @override
  String toString() => namespace.isEmpty ? id : '$namespace:$id';
}
