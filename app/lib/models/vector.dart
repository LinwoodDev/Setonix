import 'package:dart_mappable/dart_mappable.dart';
import 'package:flame/components.dart';

part 'vector.mapper.dart';

@MappableClass(hook: VectorDefinitionHook())
class VectorDefinition with VectorDefinitionMappable {
  final int x, y;

  const VectorDefinition(this.x, this.y);

  static const zero = VectorDefinition(0, 0);
  static const one = VectorDefinition(1, 1);

  Vector2 toVector() => Vector2(x.toDouble(), y.toDouble());
}

class VectorDefinitionHook extends MappingHook {
  const VectorDefinitionHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is List) {
      return VectorDefinition(value[0] as int, value[1] as int);
    }
    return value;
  }
}
