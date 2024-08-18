import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:networker/networker.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/models/vector.dart';

part 'world_event.mapper.dart';

class IgnoreKeysHook extends MappingHook {
  final Set<String> keys;

  const IgnoreKeysHook(this.keys);

  Object? _removeKeys(Object? value) {
    if (value is! Map<String, dynamic>) {
      return value;
    }
    return Map<String, dynamic>.fromEntries(
        value.entries.where((entry) => !keys.contains(entry.key)));
  }

  @override
  Object? beforeDecode(Object? value) => _removeKeys(value);

  @override
  Object? afterEncode(Object? value) => _removeKeys(value);
}

@MappableClass(discriminatorKey: 'type', hook: IgnoreKeysHook({'user'}))
sealed class WorldEvent with WorldEventMappable {
  WorldEvent();

  bool get isMultiplayer => false;
}

@MappableClass()
final class TableChanged extends WorldEvent with TableChangedMappable {
  final GameTable table;

  TableChanged(this.table);

  @override
  bool get isMultiplayer => true;
}

@MappableClass()
final class CellSwitched extends WorldEvent with CellSwitchedMappable {
  final VectorDefinition? cell;
  final bool toggle;

  CellSwitched(this.cell, {this.toggle = false});
}

@MappableClass()
final class ColorSchemeChanged extends WorldEvent
    with ColorSchemeChangedMappable {
  final ColorScheme? colorScheme;

  ColorSchemeChanged(this.colorScheme);
}

@MappableClass()
final class BackgroundChanged extends WorldEvent
    with BackgroundChangedMappable {
  final ItemLocation background;

  BackgroundChanged(this.background);
}

@MappableClass()
final class HandChanged extends WorldEvent with HandChangedMappable {
  final ItemLocation? deck;
  final bool? show;

  HandChanged({
    this.deck,
    bool this.show = true,
  });
  HandChanged.hide()
      : deck = null,
        show = false;
  HandChanged.toggle({this.deck}) : show = null;
}

@MappableClass()
final class ObjectsSpawned extends WorldEvent with ObjectsSpawnedMappable {
  final VectorDefinition cell;
  final List<GameObject> objects;

  ObjectsSpawned(this.cell, this.objects);

  @override
  bool get isMultiplayer => true;
}

@MappableClass()
final class ObjectsMoved extends WorldEvent with ObjectsMovedMappable {
  final List<int> objects;
  final VectorDefinition from, to;

  ObjectsMoved(this.objects, this.from, this.to);

  @override
  bool get isMultiplayer => true;
}

@MappableClass()
final class CellHideChanged extends WorldEvent with CellHideChangedMappable {
  final VectorDefinition cell;
  final int? object;
  final bool? hide;

  CellHideChanged(this.cell, {this.object, this.hide});
  CellHideChanged.show(this.cell, {this.object}) : hide = false;
  CellHideChanged.hide(this.cell, {this.object}) : hide = true;

  @override
  bool get isMultiplayer => true;
}

@MappableClass()
final class CellShuffled extends WorldEvent with CellShuffledMappable {
  final VectorDefinition cell;
  final int seed;

  CellShuffled(this.cell, this.seed);
  CellShuffled.random(this.cell) : seed = DateTime.now().millisecondsSinceEpoch;

  @override
  bool get isMultiplayer => true;
}

@MappableClass()
final class ObjectIndexChanged extends WorldEvent
    with ObjectIndexChangedMappable {
  final VectorDefinition cell;
  final int object;
  final int index;

  ObjectIndexChanged(this.cell, this.object, this.index);

  @override
  bool get isMultiplayer => true;
}

@MappableClass()
sealed class UserBasedEvent extends WorldEvent with UserBasedEventMappable {
  final Channel? user;

  UserBasedEvent({this.user});

  @override
  bool get isMultiplayer => true;
}

@MappableClass()
final class TeamChanged extends WorldEvent with TeamChangedMappable {
  final String name;
  final GameTeam team;

  TeamChanged(this.name, this.team);
}

@MappableClass()
final class TeamRemoved extends WorldEvent with TeamRemovedMappable {
  final String team;

  TeamRemoved(this.team);
}

@MappableClass()
final class TeamJoined extends UserBasedEvent with TeamJoinedMappable {
  final String team;

  TeamJoined(this.team, {super.user});
}

@MappableClass()
final class TeamLeft extends UserBasedEvent with TeamLeftMappable {
  final String team;

  TeamLeft(this.team, {super.user});
}
