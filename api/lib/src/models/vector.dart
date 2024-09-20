import 'package:dart_mappable/dart_mappable.dart';

part 'vector.mapper.dart';

@MappableClass(hook: VectorDefinitionHook())
class VectorDefinition with VectorDefinitionMappable {
  final int x, y;

  const VectorDefinition(this.x, this.y);

  factory VectorDefinition.fromDisplay(String displayString) {
    final parts = displayString
        .replaceAll('(', '')
        .replaceAll(')', '')
        .split(',')
        .map((e) => e.trim())
        .toList();
    final x = int.parse(parts[0]);
    final y = int.parse(parts[1]);
    return VectorDefinition(x, y);
  }

  static const zero = VectorDefinition(0, 0);
  static const one = VectorDefinition(1, 1);

  String toDisplayString() => '($x, $y)';

  operator +(VectorDefinition other) =>
      VectorDefinition(x + other.x, y + other.y);
  operator -(VectorDefinition other) =>
      VectorDefinition(x - other.x, y - other.y);
}

class VectorDefinitionHook extends MappingHook {
  const VectorDefinitionHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is Iterable) {
      return VectorDefinition(value.first as int, value.last as int);
    }
    if (value is! String) {
      return value;
    }
    return VectorDefinition.fromDisplay(value);
  }

  @override
  Object? beforeEncode(Object? value) {
    if (value is! VectorDefinition) {
      return value;
    }
    return value.toDisplayString();
  }
}
