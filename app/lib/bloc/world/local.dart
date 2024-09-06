import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:quokka_api/quokka_api.dart';

part 'local.mapper.dart';

@MappableClass()
final class HandChanged extends LocalWorldEvent with HandChangedMappable {
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
final class CellSwitched extends LocalWorldEvent with CellSwitchedMappable {
  final VectorDefinition? cell;
  final bool toggle;

  CellSwitched(this.cell, {this.toggle = false});
}

@MappableClass()
final class ColorSchemeChanged extends LocalWorldEvent
    with ColorSchemeChangedMappable {
  final ColorScheme? colorScheme;

  ColorSchemeChanged(this.colorScheme);
}

@MappableClass()
final class SwitchCellOnMoveChanged extends LocalWorldEvent
    with SwitchCellOnMoveChangedMappable {
  final bool value;

  SwitchCellOnMoveChanged(this.value);
}

@MappableClass()
final class TableSwitched extends LocalWorldEvent with TableSwitchedMappable {
  final String name;

  TableSwitched([this.name = '']);
}
