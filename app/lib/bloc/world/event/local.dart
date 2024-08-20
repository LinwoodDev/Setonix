part of '../event.dart';

@MappableClass()
sealed class LocalWorldEvent extends WorldEvent
    with LocalWorldEventMappable
    implements PlayableWorldEvent {}

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
