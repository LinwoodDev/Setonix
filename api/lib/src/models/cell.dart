import 'package:dart_mappable/dart_mappable.dart';

import 'vector.dart';

part 'cell.mapper.dart';

@MappableClass()
class TableCell with TableCellMappable {
  final List<GameObject> objects;
  final List<BoardTile> tiles;
  final CellMergeStrategy? merge;

  TableCell({this.objects = const [], this.tiles = const [], this.merge});

  bool get isEmpty => objects.isEmpty && tiles.isEmpty && merge == null;
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

@MappableEnum()
enum CellMergeDirection { horizontal, vertical }

@MappableClass()
sealed class CellMergeStrategy with CellMergeStrategyMappable {
  final CellMergeDirection direction;
  const CellMergeStrategy({this.direction = CellMergeDirection.vertical});
}

@MappableClass()
final class MergedCellStrategy extends CellMergeStrategy
    with MergedCellStrategyMappable {
  const MergedCellStrategy(CellMergeDirection direction)
    : super(direction: direction);
}

@MappableClass()
sealed class LayoutCellMergeStrategy extends CellMergeStrategy
    with LayoutCellMergeStrategyMappable {
  final bool reverse;
  const LayoutCellMergeStrategy({super.direction, this.reverse = false});
}

@MappableClass()
final class StackedCellMergeStrategy extends LayoutCellMergeStrategy
    with StackedCellMergeStrategyMappable {
  final int visiblePercentage;

  const StackedCellMergeStrategy({
    this.visiblePercentage = 10,
    super.reverse,
    super.direction,
  });
}

@MappableClass()
final class DistributeCellMergeStrategy extends LayoutCellMergeStrategy
    with DistributeCellMergeStrategyMappable {
  final int maxCards;
  final bool fillVariableSpace;

  const DistributeCellMergeStrategy({
    this.maxCards = 5,
    this.fillVariableSpace = true,
    super.reverse,
    super.direction = CellMergeDirection.horizontal,
  });
}
