import 'package:dart_mappable/dart_mappable.dart';

import 'table.dart';
import 'waypoint.dart';

part 'info.mapper.dart';

@MappableClass()
class GameInfo with GameInfoMappable {
  final Map<String, GameTeam> teams;
  final List<String> packs;
  final ItemLocation? gameMode;
  final List<Waypoint> waypoints;

  const GameInfo({
    this.teams = const {},
    this.packs = const [],
    this.gameMode,
    this.waypoints = const [],
  });
}

@MappableEnum()
enum TeamColor {
  pink,
  red,
  orange,
  yellow,
  green,
  blue,
  indigo,
  purple,
  brown,
  white,
  black,
}

@MappableClass()
class GameTeam with GameTeamMappable {
  final String description;
  final TeamColor? color;
  final Set<GlobalVectorDefinition> claimedCells;
  final List<Waypoint> waypoints;

  GameTeam({
    this.description = '',
    this.color,
    this.claimedCells = const {},
    this.waypoints = const [],
  });
}
