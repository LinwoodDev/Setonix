import 'package:dart_mappable/dart_mappable.dart';
import 'vector.dart';

part 'deck.mapper.dart';

@MappableClass()
class DeckDefinition with DeckDefinitionMappable {
  final String? name;
  final String? description;
  final List<FigureDeckDefinition> figures;

  DeckDefinition({
    this.name,
    this.description,
    this.figures = const [],
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
