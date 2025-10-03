import 'package:dart_mappable/dart_mappable.dart';

import 'table.dart';

part 'waypoint.mapper.dart';

@MappableClass()
final class Waypoint with WaypointMappable {
  final String name;
  final GlobalVectorDefinition position;

  Waypoint({required this.name, required this.position});
}
