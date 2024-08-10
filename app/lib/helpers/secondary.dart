import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

mixin SecondaryTapCallbacks {
  bool onSecondaryTapUp(TapUpInfo info) => false;
}

mixin DetailsTapCallbacks on SecondaryTapCallbacks, DoubleTapCallbacks {
  Vector2 _position = Vector2.zero();

  @override
  @mustCallSuper
  bool onSecondaryTapUp(TapUpInfo info) {
    onContextMenu(info.eventPosition.global);
    return true;
  }

  @override
  @mustCallSuper
  void onDoubleTapDown(DoubleTapDownEvent event) {
    _position = event.devicePosition;
  }

  @override
  @mustCallSuper
  void onDoubleTapUp(DoubleTapEvent event) => onContextMenu(_position);

  void onContextMenu(Vector2 position);
}
