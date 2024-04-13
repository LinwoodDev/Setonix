import 'package:dart_mappable/dart_mappable.dart';

part 'table.mapper.dart';

@MappableClass()
class GridLocation with GridLocationMappable {
  final int x, y;

  GridLocation(this.x, this.y);
}

@MappableClass()
class GameTable with GameTableMappable {
  final Map<GridLocation, TableCell> cells;
  final Map<GridLocation, GameBoard> boards;

  GameTable({
    this.cells = const {},
    this.boards = const {},
  });
}

@MappableClass()
class TableCell with TableCellMappable {
  final List<GameObject> objects;

  TableCell(this.objects);
}

@MappableClass()
class GameBoard with GameBoardMappable {
  final AssetLocation asset;

  GameBoard(this.asset);
}

@MappableClass()
class GameObject with GameObjectMappable {
  final AssetLocation asset;
  final String? variation;

  GameObject({
    required this.asset,
    this.variation,
  });
}

@MappableClass()
class AssetLocation with AssetLocationMappable {
  final String namespace, id;

  AssetLocation(this.namespace, this.id);
}
