import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:quokka/game/board/hand/view.dart';

abstract class HandItem<T> extends PositionComponent with TapCallbacks {
  final T item;

  HandItem({required this.item}) : super(size: Vector2(100, 0));

  GameHand get hand => findParent<GameHand>()!;

  String get label;

  @override
  void onLoad() {
    add(TextComponent(text: label));
  }

  @override
  void onParentResize(Vector2 maxSize) {
    height = maxSize.y;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.x, size.y),
        Paint()
          ..color = Colors.green
          ..isAntiAlias = false);
  }
}
