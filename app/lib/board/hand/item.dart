import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart'
    show
        AdaptiveTextSelectionToolbar,
        ContextMenuButtonItem,
        TextSelectionToolbarAnchors;
import 'package:flutter/widgets.dart';
import 'package:quokka/bloc/world/bloc.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka/board/game.dart';
import 'package:quokka/board/hand/view.dart';
import 'package:quokka/helpers/asset.dart';
import 'package:quokka/helpers/secondary.dart';
import 'package:quokka/helpers/drag.dart';

class HandItemDragCursorHitbox extends PositionComponent
    with CollisionCallbacks {
  final HandItem item;

  HandItemDropZone? _lastZone;

  HandItemDropZone? get lastHit => _lastZone;

  HandItemDragCursorHitbox({required this.item, super.position});

  @override
  void onLoad() {
    add(CircleHitbox(
      collisionType: CollisionType.active,
      radius: 1,
    ));
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is! HandItemDropZone) return;
    _lastZone = other;
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other == _lastZone) {
      _lastZone = null;
    }
  }
}

//  Disable it for now, see https://github.com/flame-engine/flame/issues/3270
mixin HandItemDropZone on PositionComponent, CollisionCallbacks {
  Component get hitbox => RectangleHitbox(
      collisionType: CollisionType.passive, isSolid: true, size: size);

  @override
  @mustCallSuper
  void onLoad() {
    add(hitbox);
  }

  @override
  @mustCallSuper
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is! HandItemDragCursorHitbox) return;

    onDragOver(other.item);
  }

  @override
  @mustCallSuper
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is HandItemDragCursorHitbox) onDragOverEnd(other.item);
  }

  void onDragOverEnd(HandItem handItem) {}
  void onDragOver(HandItem handItem) {}
}

abstract class HandItem<T> extends PositionComponent
    with
        HasGameRef<BoardGame>,
        CollisionCallbacks,
        HandItemDropZone,
        DragCallbacks,
        TapCallbacks,
        LongDragCallbacks,
        DoubleTapCallbacks,
        SecondaryTapCallbacks,
        DetailsTapCallbacks,
        FlameBlocListenable<WorldBloc, ClientWorldState> {
  final T item;
  final SpriteComponent _sprite = SpriteComponent();
  late final TextComponent<TextPaint> _label;

  HandItem({required this.item}) : super(size: Vector2(100, 0));

  GameHand get hand => findParent<GameHand>()!;

  String getLabel(ClientWorldState state);

  Future<Sprite?> loadIcon(ClientWorldState state);

  GameAssetManager get assetManager => game.assetManager;

  double get labelHeight => 20;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _sprite.sprite = game.blankSprite;
    add(_sprite);
  }

  void _resetPosition() {
    _sprite.position = Vector2(0, labelHeight);
    if (!_label.isMounted) add(_label);
    final cursor = _cursorHitbox;
    if (cursor != null) cursor.removeFromParent();
    _cursorHitbox = null;
  }

  @override
  bool listenWhen(ClientWorldState previousState, ClientWorldState newState) =>
      previousState.colorScheme != newState.colorScheme;

  @override
  void onInitialState(ClientWorldState state) async {
    add(_label = TextComponent(
        text: getLabel(state),
        size: Vector2(0, labelHeight),
        position: Vector2(50, 0),
        anchor: Anchor.topCenter,
        textRenderer: _buildPaint(state)));
    _sprite.sprite = await loadIcon(state) ?? game.blankSprite;
  }

  _buildPaint(ClientWorldState state) => TextPaint(
        style: TextStyle(fontSize: 14, color: state.colorScheme.onSurface),
      );

  @override
  void onNewState(ClientWorldState state) {
    _label.textRenderer = _buildPaint(state);
  }

  @override
  void onParentResize(Vector2 maxSize) {
    height = maxSize.y;
    final size = height - labelHeight;
    _sprite.size = Vector2.all(size);
    _sprite.x = (100 - size) / 2;
    _sprite.y = labelHeight;
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    game.world.add(_cursorHitbox =
        HandItemDragCursorHitbox(item: this, position: event.localPosition));
  }

  HandItemDragCursorHitbox? _cursorHitbox;
  Vector2 _last = Vector2.zero();
  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (!(isMouseOrLongPressing ?? false)) {
      hand.scroll(event.localDelta.x);
      return;
    }
    if (_label.parent != null) _label.removeFromParent();
    _sprite.position += event.localDelta;
    _last = event.canvasEndPosition;
    _cursorHitbox?.position =
        game.camera.globalToLocal(event.canvasEndPosition);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    if (isMouseOrLongPressing ?? true) {
      final zone = game
          .componentsAtPoint(_last)
          .whereType<HandItemDropZone>()
          .firstOrNull;
      if (zone != null) moveItem(zone);
    }
    _resetPosition();
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    _resetPosition();
  }

  @override
  void onContextMenu(Vector2 position) {
    final items = contextItemsBuilder;
    if (items == null) return;
    game.showContextMenu(
      contextMenuBuilder: (context, onClose) =>
          AdaptiveTextSelectionToolbar.buttonItems(
        anchors:
            TextSelectionToolbarAnchors(primaryAnchor: position.toOffset()),
        buttonItems: items(context, onClose),
      ),
    );
  }

  List<ContextMenuButtonItem> Function(BuildContext, VoidCallback onClose)?
      contextItemsBuilder;

  void moveItem(HandItemDropZone zone) {}
}
