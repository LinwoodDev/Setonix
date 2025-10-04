import 'package:dart_mappable/dart_mappable.dart';

import 'vector.dart';

part 'cell.mapper.dart';

@MappableClass()
class TableCell with TableCellMappable {
  final List<GameObject> objects;
  final List<BoardTile> tiles;

  TableCell({this.objects = const [], this.tiles = const []});

  bool get isEmpty => objects.isEmpty && tiles.isEmpty;
}

@MappableClass()
class GameObject with GameObjectMappable {
  final ItemLocation asset;
  final String? variation;
  final bool hidden;

  GameObject(this.asset, {this.variation, this.hidden = false});
}

@MappableClass()
class BoardTile with BoardTileMappable {
  final ItemLocation asset;
  final VectorDefinition tile;

  BoardTile(this.asset, this.tile);
}

@MappableClass()
sealed class CellMergeStrategy with CellMergeStrategyMappable {
  const CellMergeStrategy();
}

@MappableClass()
final class StackedCellMergeStrategy extends CellMergeStrategy
    with StackedCellMergeStrategyMappable {
  final int visiblePercentage;
  final bool reverse;

  const StackedCellMergeStrategy({
    this.visiblePercentage = 10,
    this.reverse = false,
  });
}

@MappableClass()
final class DistributeCellMergeStrategy extends CellMergeStrategy
    with DistributeCellMergeStrategyMappable {
  final int maxCards;
  final bool reverse;
  final bool fillVariableSpace;

  const DistributeCellMergeStrategy({
    this.maxCards = 5,
    this.reverse = false,
    this.fillVariableSpace = true,
  });
}

@MappableClass()
enum CellMergeDirection { horizontal, vertical }

@MappableClass()
final class DirectionalCellMerge extends CellMergeStrategy
    with DirectionalCellMergeMappable {
  final CellMergeDirection direction;
  const DirectionalCellMerge(this.direction);
}
