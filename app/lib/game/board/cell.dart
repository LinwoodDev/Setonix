import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/foundation.dart';

class GameCell extends PositionComponent with HasGameRef, HoverCallbacks {
  late final Sprite _selectionSprite;
  late final SpriteComponent _selectionComponent;

  GameCell({super.size, super.position});

  @override
  Future<void> onLoad() async {
    _selectionSprite = await Sprite.load('selection.png');
    _selectionComponent = SpriteComponent(
      sprite: _selectionSprite,
      size: size,
    );
    add(_selectionComponent);
  }

  @override
  void onHoverEnter() {
    if (kDebugMode) {
      print('hover enter on $position');
    }
  }

  @override
  void onHoverExit() {}
}
