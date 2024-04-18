import 'package:dart_mappable/dart_mappable.dart';
import 'package:qeck/models/vector.dart';

part 'object.mapper.dart';

sealed class GameObjectDefinition {}

abstract class VisualDefinition {
  final String texture;
  final VectorDefinition offset;
  final VectorDefinition? size;

  VisualDefinition({
    required this.texture,
    this.offset = VectorDefinition.zero,
    this.size,
  });
}

@MappableClass()
class FigureDefinition extends GameObjectDefinition
    with FigureDefinitionMappable {
  final FigureBackDefinition back;
  final Map<String, VariationDefinition> variations;

  FigureDefinition({
    this.variations = const {},
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
class VariationDefinition
    with VariationDefinitionMappable
    implements VisualDefinition {
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
class FigureBackDefinition
    with FigureBackDefinitionMappable
    implements VisualDefinition {
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
