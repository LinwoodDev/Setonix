import 'package:dart_mappable/dart_mappable.dart';
import '../helpers/equality.dart';
import 'cell.dart';
import 'vector.dart';

part 'table.mapper.dart';

@MappableClass()
class GameTable with GameTableMappable {
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
}
