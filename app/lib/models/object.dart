import 'package:dart_mappable/dart_mappable.dart';
import 'package:quokka/models/vector.dart';
import 'package:quokka/models/visual.dart';

part 'object.mapper.dart';

sealed class GameObjectDefinition {}

@MappableClass()
class FigureDefinition extends GameObjectDefinition
    with FigureDefinitionMappable {
  final FigureBackDefinition back;
  final bool rollable;
  final Map<String, VariationDefinition> variations;

  FigureDefinition({
    this.variations = const {},
    this.rollable = false,
    required this.back,
  });
}

@MappableClass()
class BoardDefinition extends GameObjectDefinition
    with BoardDefinitionMappable {
  final Map<String, VariationDefinition> variations;
  final VectorDefinition size;

  BoardDefinition({
    this.variations = const {},
    this.size = VectorDefinition.one,
  });
}

@MappableClass()
class VariationDefinition with VariationDefinitionMappable, VisualDefinition {
  final String? category;
  @override
  final String texture;
  @override
  final VectorDefinition offset;
  @override
  final VectorDefinition? size;

  VariationDefinition({
    this.category,
    required this.texture,
    this.offset = VectorDefinition.zero,
    this.size,
  });
}

@MappableClass()
class FigureBackDefinition with FigureBackDefinitionMappable, VisualDefinition {
  @override
  final String texture;
  @override
  final VectorDefinition offset;
  @override
  final VectorDefinition? size;

  FigureBackDefinition({
    required this.texture,
    this.offset = VectorDefinition.zero,
    this.size,
  });
}
