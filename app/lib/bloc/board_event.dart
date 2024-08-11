import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/models/vector.dart';

part 'board_event.mapper.dart';

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

@MappableClass(
    discriminatorKey: 'type', hook: IgnoreKeysHook({'isRemoteEvent'}))
sealed class BoardEvent with BoardEventMappable {
  final bool isRemoteEvent;

  BoardEvent({this.isRemoteEvent = false});

  bool get isMultiplayer => false;
}

@MappableClass()
final class TableChanged extends BoardEvent with TableChangedMappable {
  final GameTable table;

  TableChanged(this.table, {super.isRemoteEvent});

  bool get isMultiplayer => true;
}

@MappableClass()
final class CellSwitched extends BoardEvent with CellSwitchedMappable {
  final VectorDefinition? cell;
  final bool toggle;

  CellSwitched(this.cell, {this.toggle = false, super.isRemoteEvent});
}

@MappableClass()
final class ColorSchemeChanged extends BoardEvent
    with ColorSchemeChangedMappable {
  final ColorScheme? colorScheme;

  ColorSchemeChanged(this.colorScheme, {super.isRemoteEvent});
}

@MappableClass()
final class HandChanged extends BoardEvent with HandChangedMappable {
  final ItemLocation? deck;
  final bool? show;

  HandChanged({
    this.deck,
    bool this.show = true,
    super.isRemoteEvent,
  });
  HandChanged.hide({super.isRemoteEvent})
      : deck = null,
        show = false;
  HandChanged.toggle({this.deck, super.isRemoteEvent}) : show = null;
}

@MappableClass()
final class ObjectsSpawned extends BoardEvent with ObjectsSpawnedMappable {
  final VectorDefinition cell;
  final List<GameObject> objects;

  ObjectsSpawned(this.cell, this.objects, {super.isRemoteEvent});

  bool get isMultiplayer => true;
}

@MappableClass()
final class ObjectsMoved extends BoardEvent with ObjectsMovedMappable {
  final List<int> objects;
  final VectorDefinition from, to;

  ObjectsMoved(this.objects, this.from, this.to, {super.isRemoteEvent});

  bool get isMultiplayer => true;
}

@MappableClass()
final class CellHideChanged extends BoardEvent with CellHideChangedMappable {
  final VectorDefinition cell;
  final int? object;
  final bool? hide;

  CellHideChanged(this.cell, {this.object, this.hide, super.isRemoteEvent});
  CellHideChanged.show(this.cell, {this.object, super.isRemoteEvent})
      : hide = false;
  CellHideChanged.hide(this.cell, {this.object, super.isRemoteEvent})
      : hide = true;

  bool get isMultiplayer => true;
}

@MappableClass()
final class CellShuffled extends BoardEvent with CellShuffledMappable {
  final VectorDefinition cell;
  final int seed;

  CellShuffled(this.cell, this.seed, {super.isRemoteEvent});
  CellShuffled.random(this.cell, {super.isRemoteEvent})
      : seed = DateTime.now().millisecondsSinceEpoch;

  bool get isMultiplayer => true;
}

@MappableClass()
final class ObjectIndexChanged extends BoardEvent
    with ObjectIndexChangedMappable {
  final VectorDefinition cell;
  final int object;
  final int index;

  ObjectIndexChanged(this.cell, this.object, this.index, {super.isRemoteEvent});

  bool get isMultiplayer => true;
}
