import 'package:dart_mappable/dart_mappable.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/models/vector.dart';

part 'board_event.mapper.dart';

@MappableClass()
sealed class BoardEvent with BoardEventMappable {}

@MappableClass()
final class SwitchCellEvent extends BoardEvent with SwitchCellEventMappable {
  final VectorDefinition? cell;
  final bool toggle;

  SwitchCellEvent(this.cell, {this.toggle = false});
}

@MappableClass()
final class ChangeHandEvent extends BoardEvent with ChangeHandEventMappable {
  final ItemLocation? deck;
  final bool? show;

  ChangeHandEvent({
    this.deck,
    bool this.show = true,
  });
  ChangeHandEvent.hide()
      : deck = null,
        show = false;
  ChangeHandEvent.toggle({this.deck}) : show = null;
}
