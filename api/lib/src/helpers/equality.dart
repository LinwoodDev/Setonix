import 'package:dart_mappable/dart_mappable.dart';

part 'equality.mapper.dart';

@MappableClass(
  includeCustomMappers: [IgnoreForEquality()],
  generateMethods:
      GenerateMethods.all &
      ~GenerateMethods.equals &
      ~GenerateMethods.stringify,
)
class IgnoreEqualityBox<T> with IgnoreEqualityBoxMappable<T> {
  final T content;

  const IgnoreEqualityBox(this.content);
}

class IgnoreForEquality extends SimpleMapper1<IgnoreEqualityBox> {
  const IgnoreForEquality();
  @override
  // use the type parameter [T] in the return type [GenericBox<T>]
  IgnoreEqualityBox<T> decode<T>(dynamic value) {
    // use the type parameter [T] in your decoding logic
    T content = MapperContainer.globals.fromValue<T>(value);
    return IgnoreEqualityBox<T>(content);
  }

  @override
  // use the type parameter [T] in the parameter type [GenericBox<T>]
  dynamic encode<T>(IgnoreEqualityBox<T> self) {
    // use the type parameter [T] in your encoding logic
    return MapperContainer.globals.toValue<T>(self.content);
  }

  // In case of generic types, we also must specify a type factory. This is a special type of
  // function used internally to construct generic instances of your type.
  // Specify any type arguments in alignment to the decode/encode functions.
  @override
  Function get typeFactory =>
      <T>(f) => f<IgnoreEqualityBox<T>>();

  @override
  bool equals(value, other, MappingContext context) => value == other;

  @override
  int hash(value, MappingContext context) => value.hashCode;

  @override
  String stringify(value, MappingContext context) => value.toString();
}
