import 'dart:async';

import 'package:flame/components.dart';

class GameCell extends PositionComponent {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(SpriteComponent(size: size));
  }
}
