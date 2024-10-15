import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix_api/setonix_api.dart';

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

@MappableClass()
final class DrawerViewChanged extends LocalWorldEvent
    with DrawerViewChangedMappable {
  final DrawerView view;

  DrawerViewChanged(this.view);
}

@MappableClass()
final class SearchTermChanged extends LocalWorldEvent
    with SearchTermChangedMappable {
  final String term;

  SearchTermChanged(this.term);
}

@MappableClass()
final class ShowDuplicatesChanged extends LocalWorldEvent
    with ShowDuplicatesChangedMappable {
  final bool? value;

  ShowDuplicatesChanged(this.value);
  ShowDuplicatesChanged.toggle() : value = null;
}
