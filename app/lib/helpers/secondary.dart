import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

mixin SecondaryTapCallbacks {
  bool onSecondaryTapUp(TapUpInfo info) => false;
}

mixin DetailsTapCallbacks on SecondaryTapCallbacks, DoubleTapCallbacks {
  Vector2? _position;

  @override
  @mustCallSuper
  bool onSecondaryTapUp(TapUpInfo info) {
    onContextMenu(info.eventPosition.global);
    return true;
  }

  @override
  @mustCallSuper
  void onDoubleTapDown(DoubleTapDownEvent event) {
    _position = event.deviceKind == PointerDeviceKind.touch
        ? event.devicePosition
        : null;
  }

  @override
  @mustCallSuper
  void onDoubleTapUp(DoubleTapEvent event) {
    final position = _position;
    if (position == null) return;
    onContextMenu(position);
  }

  void onContextMenu(Vector2 position);
}
