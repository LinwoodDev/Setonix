import 'package:dart_mappable/dart_mappable.dart';

part 'vector.mapper.dart';

@MappableClass(hook: VectorDefinitionHook())
class VectorDefinition with VectorDefinitionMappable {
  final int x, y;

  const VectorDefinition(this.x, this.y);

  static const zero = VectorDefinition(0, 0);
  static const one = VectorDefinition(1, 1);

  String toDisplayString() => '($x, $y)';

  operator +(VectorDefinition other) =>
      VectorDefinition(x + other.x, y + other.y);
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
