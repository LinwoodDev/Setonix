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
  final Map<String, GameSeat> seats;
  final Map<String, GamePlayer> players;

  const GameTable({
    this.cells = const {},
    this.boards = const {},
    this.seats = const {},
    this.players = const {},
  });
}

@MappableClass()
class GamePlayer with GamePlayerMappable {
  final String name;
  final List<String>? teams;

  GamePlayer({
    required this.name,
    this.teams = const [],
  });
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
  final String? team;
  final int reveal;
  final int? teamReveal;

  TableCell({
    this.objects = const [],
    this.team,
    this.reveal = -1,
    this.teamReveal,
  });

  int get teamRevealValue => teamReveal ?? reveal;
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
  factory AssetLocation.fromString(String location) {
    final splitted = location.split(':');
    return AssetLocation(splitted[0], splitted[1]);
  }

  @override
  String toString() => '$namespace:$id';
}
