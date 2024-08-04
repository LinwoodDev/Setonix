import 'package:dart_mappable/dart_mappable.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/models/vector.dart';

part 'board_state.mapper.dart';

@MappableClass()
class BoardState with BoardStateMappable {
  final GameTable table;
  final VectorDefinition? selectedCell;
  final ItemLocation? selectedDeck;
  final bool showHand;

  const BoardState({
    this.table = const GameTable(),
    this.selectedCell,
    this.selectedDeck,
    this.showHand = false,
  });
}
