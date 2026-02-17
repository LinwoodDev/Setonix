import 'package:dart_mappable/dart_mappable.dart';
import '../helpers/equality.dart';
import 'cell.dart';
import 'vector.dart';

part 'table.mapper.dart';

@MappableClass()
class GameTable with GameTableMappable {
  static const int maxMergeSpan = 1000;
  @MappableField(key: "cells")
  final IgnoreEqualityBox<Map<VectorDefinition, TableCell>> cellsBox;
  final ItemLocation? background;

  const GameTable({
    this.cellsBox = const IgnoreEqualityBox({}),
    this.background,
  });

  Map<VectorDefinition, TableCell> get cells => cellsBox.content;

  TableCell getCell(VectorDefinition position) =>
      cells[position] ?? TableCell();

  int calculateSpan(VectorDefinition start, CellMergeDirection direction) {
    var current = start;
    for (var span = 1; span < maxMergeSpan; span++) {
      current = direction == CellMergeDirection.horizontal
          ? VectorDefinition(current.x + 1, current.y)
          : VectorDefinition(current.x, current.y + 1);
      final cell = cells[current];
      final strategy = cell?.merge;
      if (strategy is! MergedCellStrategy || strategy.direction != direction) {
        return span;
      }
    }
    return maxMergeSpan;
  }

  VectorDefinition getParentCell(VectorDefinition position) {
    var current = position;
    for (var depth = 0; depth < maxMergeSpan; depth++) {
      final cell = cells[current];
      final strategy = cell?.merge;
      if (strategy is MergedCellStrategy) {
        current = strategy.direction == CellMergeDirection.horizontal
            ? VectorDefinition(current.x - 1, current.y)
            : VectorDefinition(current.x, current.y - 1);
      } else {
        return current;
      }
    }
    return current;
  }
}
