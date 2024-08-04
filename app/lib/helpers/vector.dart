import 'package:flame/components.dart';
import 'package:quokka/models/vector.dart';

extension VectorToDefinition on Vector2 {
  VectorDefinition toDefinition() => VectorDefinition(x.toInt(), y.toInt());
}
