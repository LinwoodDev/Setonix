import 'package:flame/components.dart';
import 'package:flame/events.dart';

abstract class HandItem<T> extends PositionComponent with TapCallbacks {
  final T item;

  HandItem({required this.item}) : super(size: Vector2(100, 0));

  String get label;

  @override
  void onLoad() {
    add(TextComponent(text: label));
  }

  @override
  void onParentResize(Vector2 maxSize) {
    height = maxSize.y;
  }
}
