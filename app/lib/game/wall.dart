import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class BoardWall extends PositionComponent {
  BoardWall({
    super.position,
    super.size,
  });

  @override
  void onLoad() {
    add(RectangleHitbox()..collisionType = CollisionType.passive);
  }
}
