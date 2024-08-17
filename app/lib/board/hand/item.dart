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
import 'package:quokka/bloc/world.dart';
import 'package:quokka/bloc/world_state.dart';
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
  FutureOr<void> onLoad() {
    //add(hitbox);
  }

  @override
  @mustCallSuper
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    /*if (other is! HandItemDragCursorHitbox) return;

    onDragOver(other.item);*/
  }

  @override
  @mustCallSuper
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    //if (other is HandItemDragCursorHitbox) onDragOverEnd(other.item);
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
        FlameBlocListenable<WorldBloc, WorldState> {
  final T item;
  late final SpriteComponent _sprite;
  late final TextComponent<TextPaint> _label;

  HandItem({required this.item}) : super(size: Vector2(100, 0));

  GameHand get hand => findParent<GameHand>()!;

  String get label;

  Future<Sprite?> loadIcon();

  AssetManager get assetManager => game.assetManager;

  double get labelHeight => 20;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _sprite = SpriteComponent(
      position: Vector2(0, labelHeight),
      size: Vector2(100, 0),
      sprite: await loadIcon(),
    );
    add(_sprite);
  }

  void _resetPosition() {
    _sprite.position = Vector2(0, labelHeight);
    if (!_label.isMounted) add(_label);
    //final cursor = _cursorHitbox;
    //if (cursor != null) cursor.removeFromParent();
    //_cursorHitbox = null;
  }

  @override
  bool listenWhen(WorldState previousState, WorldState newState) =>
      previousState.colorScheme != newState.colorScheme;

  @override
  void onInitialState(WorldState state) {
    add(_label = TextComponent(
        text: label,
        size: Vector2(0, labelHeight),
        position: Vector2(50, 0),
        anchor: Anchor.topCenter,
        textRenderer: _buildPaint(state)));
  }

  _buildPaint(WorldState state) => TextPaint(
        style: TextStyle(fontSize: 14, color: state.colorScheme.onSurface),
      );

  @override
  void onNewState(WorldState state) {
    _label.textRenderer = _buildPaint(state);
  }

  @override
  void onParentResize(Vector2 maxSize) {
    height = maxSize.y;
    _sprite.height = height - labelHeight;
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    remove(_label);
    /*game.world.add(_cursorHitbox =
        HandItemDragCursorHitbox(item: this, position: event.localPosition));*/
  }

  //HandItemDragCursorHitbox? _cursorHitbox;
  Vector2 _last = Vector2.zero();
  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (!(isMouseOrLongPressing ?? false)) {
      hand.scroll(event.localDelta.x);
      return;
    }
    _sprite.position += event.localDelta;
    _last = event.canvasEndPosition;
    //_cursorHitbox?.position = event.localEndPosition;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    if (!(isMouseOrLongPressing ?? true)) return;

    final zone =
        game.componentsAtPoint(_last).whereType<HandItemDropZone>().firstOrNull;
    if (zone != null) moveItem(zone);
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
