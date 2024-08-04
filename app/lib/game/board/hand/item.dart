import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/painting.dart';
import 'package:quokka/game/board/game.dart';
import 'package:quokka/game/board/hand/view.dart';
import 'package:quokka/game/helpers/asset.dart';
import 'package:quokka/game/helpers/drag.dart';

abstract class HandItem<T> extends PositionComponent
    with TapCallbacks, HasGameRef<BoardGame>, DragCallbacks, LongDragCallbacks {
  final T item;
  late final SpriteComponent _sprite;

  HandItem({required this.item}) : super(size: Vector2(100, 0));

  GameHand get hand => findParent<GameHand>()!;

  String get label;

  Future<Sprite?> loadIcon();

  AssetManager get assetManager => game.assetManager;

  double get labelHeight => 20;

  @override
  Future<void> onLoad() async {
    add(TextComponent(
      text: label,
      size: Vector2(0, labelHeight),
      position: Vector2(50, 0),
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 14),
      ),
    ));
    _sprite = SpriteComponent(
      position: Vector2(0, labelHeight),
      size: Vector2(100, 0),
      sprite: await loadIcon(),
    );
    add(_sprite);
  }

  @override
  void onParentResize(Vector2 maxSize) {
    height = maxSize.y;
    _sprite.height = height - labelHeight;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (!isLongPressing) {
      hand.scroll(event.localDelta.x);
      return;
    }
  }
}
