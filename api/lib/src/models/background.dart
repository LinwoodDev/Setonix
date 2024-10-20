import 'package:dart_mappable/dart_mappable.dart';
import 'vector.dart';
import 'visual.dart';

part 'background.mapper.dart';

@MappableClass()
class BackgroundDefinition with BackgroundDefinitionMappable, VisualDefinition {
  @override
  final VectorDefinition offset;
  @override
  final VectorDefinition? size;
  @override
  final String texture;
  final int priority;

  BackgroundDefinition({
    this.offset = VectorDefinition.zero,
    this.size,
    required this.texture,
    this.priority = 0,
  });
}
