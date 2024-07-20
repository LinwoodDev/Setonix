import 'package:flame/components.dart';

abstract class HandItem<T> extends PositionComponent {
  final T item;

  HandItem({required this.item});
}
