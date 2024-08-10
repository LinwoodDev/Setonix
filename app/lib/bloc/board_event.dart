import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/models/vector.dart';

part 'board_event.mapper.dart';

@MappableClass()
sealed class BoardEvent with BoardEventMappable {}

@MappableClass()
final class CellSwitched extends BoardEvent with CellSwitchedMappable {
  final VectorDefinition? cell;
  final bool toggle;

  CellSwitched(this.cell, {this.toggle = false});
}

@MappableClass()
final class ColorSchemeChanged extends BoardEvent
    with ColorSchemeChangedMappable {
  final ColorScheme? colorScheme;

  ColorSchemeChanged(this.colorScheme);
}

@MappableClass()
final class HandChanged extends BoardEvent with HandChangedMappable {
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
final class ObjectsSpawned extends BoardEvent with ObjectsSpawnedMappable {
  final VectorDefinition cell;
  final List<GameObject> objects;

  ObjectsSpawned(this.cell, this.objects);
}

@MappableClass()
final class ObjectsMoved extends BoardEvent with ObjectsMovedMappable {
  final List<int> objects;
  final VectorDefinition from, to;

  ObjectsMoved(this.objects, this.from, this.to);
}

@MappableClass()
final class CellHideChanged extends BoardEvent with CellHideChangedMappable {
  final VectorDefinition cell;
  final int? object;
  final bool? hide;

  CellHideChanged(this.cell, [this.object, this.hide]);
  CellHideChanged.show(this.cell, [this.object]) : hide = false;
  CellHideChanged.hide(this.cell, [this.object]) : hide = true;
}

@MappableClass()
final class CellShuffled extends BoardEvent with CellShuffledMappable {
  final VectorDefinition cell;

  CellShuffled(this.cell);
}

@MappableClass()
final class ObjectIndexChanged extends BoardEvent
    with ObjectIndexChangedMappable {
  final VectorDefinition cell;
  final int object;
  final int index;

  ObjectIndexChanged(this.cell, this.object, this.index);
}
