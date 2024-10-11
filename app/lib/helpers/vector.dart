import 'package:flame/components.dart';
import 'package:setonix_api/setonix_api.dart';

extension VectorToDefinition on Vector2 {
  VectorDefinition toDefinition() => VectorDefinition(x.round(), y.round());
}

extension DefinitionToVector on VectorDefinition {
  Vector2 toVector() => Vector2(x.toDouble(), y.toDouble());
}
