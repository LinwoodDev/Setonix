import 'package:dart_mappable/dart_mappable.dart';
import 'vector.dart';

part 'deck.mapper.dart';

@MappableClass()
class DeckDefinition with DeckDefinitionMappable {
  final String? name;
  final String? description;
  final List<FigureDeckDefinition> figures;
  final List<BoardDeckDefinition> boards;

  DeckDefinition({
    this.name,
    this.description,
    this.figures = const [],
    this.boards = const [],
  });
}

@MappableClass()
class FigureDeckDefinition with FigureDeckDefinitionMappable {
  final String name;
  final String? variation;
  final VectorDefinition location;

  FigureDeckDefinition({
    required this.name,
    this.variation,
    this.location = VectorDefinition.zero,
  });
}

@MappableClass()
class BoardDeckDefinition with BoardDeckDefinitionMappable {
  final String name;
  final VectorDefinition location;

  BoardDeckDefinition({
    required this.name,
    this.location = VectorDefinition.zero,
  });
}
