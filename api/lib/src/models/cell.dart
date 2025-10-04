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
