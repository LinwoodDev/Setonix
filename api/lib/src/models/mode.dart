import 'package:dart_mappable/dart_mappable.dart';

import 'info.dart';
import 'table.dart';

part 'mode.mapper.dart';

@MappableClass()
final class GameMode with GameModeMappable {
  final String? script;
  final String? preview;

  final Map<String, GameTable> tables;
  final Map<String, GameTeam> teams;

  GameMode({
    this.script,
    this.preview,
    this.tables = const {},
    this.teams = const {},
  });
}
