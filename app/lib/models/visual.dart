import 'package:quokka/models/vector.dart';

mixin VisualDefinition {
  String get texture;
  VectorDefinition get offset;
  VectorDefinition? get size;
}
