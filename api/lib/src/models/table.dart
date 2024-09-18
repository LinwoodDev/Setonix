import 'package:dart_mappable/dart_mappable.dart';
import 'vector.dart';

part 'table.mapper.dart';

@MappableClass()
class GameTable with GameTableMappable {
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

  bool get isEmpty => objects.isEmpty && boards.isEmpty;
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
