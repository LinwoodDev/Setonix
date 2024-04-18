import 'package:dart_mappable/dart_mappable.dart';
import 'package:qeck/models/vector.dart';

part 'deck.mapper.dart';

@MappableClass()
class DeckDefinition with DeckDefinitionMappable {
  final String? name;
  final String? description;

  DeckDefinition({
    this.name,
    this.description,
  });
}

@MappableClass()
class FigureDeckDefinition with FigureDeckDefinitionMappable {
  final String name;
  final VectorDefinition location;

  FigureDeckDefinition({
    required this.name,
    this.location = VectorDefinition.zero,
  });
}
