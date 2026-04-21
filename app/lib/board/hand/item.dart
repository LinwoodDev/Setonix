import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart'
    show
        AdaptiveTextSelectionToolbar,
        ContextMenuButtonItem,
        TextSelectionToolbarAnchors,
        Colors;
import 'package:flutter/widgets.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/board/game.dart';
import 'package:setonix/board/hand/view.dart';
import 'package:setonix/helpers/asset.dart';
import 'package:setonix/helpers/secondary.dart';
import 'package:setonix/helpers/drag.dart';

class HandItemDragCursorHitbox extends PositionComponent
    with CollisionCallbacks {
  final HandItem item;

  HandItemDropZone? _lastZone;

  HandItemDropZone? get lastHit => _lastZone;

  HandItemDragCursorHitbox({required this.item, super.position});

  @override
  void onLoad() {
    add(CircleHitbox(collisionType: CollisionType.active, radius: 0));
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
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
    collisionType: CollisionType.passive,
    isSolid: true,
    size: size,
  );

  @override
  @mustCallSuper
  void onLoad() {
    add(hitbox);
  }

  @override
  @mustCallSuper
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
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

const priorityDragging = 10;
const priorityNormal = 0;

class HandItemLabel extends TextComponent<TextPaint> {
  ClientWorldState state;

  HandItemLabel({
    required super.text,
    required super.position,
    required super.anchor,
    required super.textRenderer,
    required this.state,
  });

  @override
  void render(Canvas canvas) {
    final rect = Rect.fromLTWH(-12, -4, size.x + 24, size.y + 8);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(12));

    canvas.drawShadow(Path()..addRRect(rrect), Colors.black, 6.0, true);

    canvas.drawRRect(rrect, Paint()..color = state.colorScheme.surface);

    canvas.drawRRect(
      rrect,
      Paint()
        ..color = state.colorScheme.onSurface.withOpacity(0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    super.render(canvas);
  }
}

abstract class HandItem<T> extends PositionComponent
    with
        HasGameReference<BoardGame>,
        CollisionCallbacks,
        HandItemDropZone,
        DragCallbacks,
        TapCallbacks,
        HoverCallbacks,
        LongDragCallbacks,
        DoubleTapCallbacks,
        SecondaryTapCallbacks,
        DetailsTapCallbacks,
        FlameBlocListenable<WorldBloc, ClientWorldState> {
  final T item;
  final SpriteComponent _sprite = SpriteComponent();
  late final HandItemLabel _label;

  Vector2? targetPosition;
  double? targetAngle;
  double? targetWidth;
  bool _isHovered = false;

  HandItem({required this.item})
    : super(size: Vector2(100, 0), anchor: Anchor.bottomCenter);

  GameHand get hand => findParent<GameHand>()!;

  String getLabel(ClientWorldState state);

  Future<Sprite?> loadIcon(ClientWorldState state);

  GameAssetManager getAssetManager(ClientWorldState state) =>
      state.assetManager;

  double get labelHeight => 20;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _sprite.size = Vector2.all(height - labelHeight);
    _sprite.sprite = game.blankSprite;
    add(_sprite);
  }

  void _resetPosition() {
    priority = priorityNormal;
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
    add(
      _label = HandItemLabel(
        text: getLabel(state),
        position: Vector2(50, -4),
        anchor: Anchor.topCenter,
        textRenderer: _buildPaint(state),
        state: state,
      ),
    );
    _sprite.sprite = await loadIcon(state) ?? game.blankSprite;
    _updateSpriteSize();
  }

  TextPaint _buildPaint(ClientWorldState state) => TextPaint(
    style: TextStyle(
      fontSize: 14,
      color: state.colorScheme.onSurface,
      fontWeight: FontWeight.w600,
    ),
  );

  @override
  void onNewState(ClientWorldState state) {
    _label.state = state;
    _label.textRenderer = _buildPaint(state);
  }

  @override
  void onParentResize(Vector2 maxSize) {
    height = maxSize.y;
    _updateSpriteSize();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (targetPosition != null) {
      if (position.distanceToSquared(targetPosition!) > 0.5) {
        position.lerp(targetPosition!, dt * 15);
      } else {
        position.setFrom(targetPosition!);
      }
    }
    if (targetAngle != null) {
      if ((angle - targetAngle!).abs() > 0.005) {
        angle = angle + (targetAngle! - angle) * dt * 15;
      } else {
        angle = targetAngle!;
      }
    }
    if (targetWidth != null) {
      if ((width - targetWidth!).abs() > 0.5) {
        width = width + (targetWidth! - width) * dt * 15;
        _label.x = width / 2;
        _updateSpriteSize();
      } else {
        width = targetWidth!;
      }
    }

    final targetScale = _isHovered ? 1.1 : 1.0;
    if ((scale.x - targetScale).abs() > 0.005) {
      scale.lerp(Vector2.all(targetScale), dt * 15);
    } else {
      scale.setValues(targetScale, targetScale);
    }
  }

  @override
  void onHoverEnter() {
    _isHovered = true;
  }

  @override
  void onHoverExit() {
    _isHovered = false;
  }

  void updateWidth(double width) {
    targetWidth = width;
  }

  void _updateSpriteSize() {
    final sprite = _sprite.sprite;
    if (sprite == null) return;
    final spriteSize = sprite.srcSize;
    if (spriteSize.x == 0 || spriteSize.y == 0) return;

    final availableWidth = width;
    final availableHeight = height - labelHeight;

    final scaleX = availableWidth / spriteSize.x;
    final scaleY = availableHeight / spriteSize.y;
    final spriteScale = scaleX < scaleY ? scaleX : scaleY;

    final newWidth = spriteSize.x * spriteScale;
    final newHeight = spriteSize.y * spriteScale;

    _sprite.size = Vector2(newWidth, newHeight);
    _sprite.position = Vector2(
      (availableWidth - newWidth) / 2,
      labelHeight + (availableHeight - newHeight) / 2,
    );
  }

  HandItemDragCursorHitbox? _cursorHitbox;
  SpriteComponent? _dragSprite;
  Vector2 _last = Vector2.zero();

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    game.world.add(
      _cursorHitbox = HandItemDragCursorHitbox(
        item: this,
        position: game.camera.globalToLocal(event.canvasPosition),
      ),
    );
    _last = event.canvasPosition;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (!(isMouseOrLongPressing ?? false)) {
      hand.dragScroll(event.localDelta.x);
      return;
    }
    if (_label.parent != null) _label.removeFromParent();
    priority = priorityDragging;
    final effectController = EffectController(duration: 0.5);
    final sprite = _dragSprite ??=
        SpriteComponent(
            sprite: _sprite.sprite,
            size: _sprite.size,
            anchor: Anchor.center,
          )
          ..add(
            ScaleEffect.by(
              Vector2.all(game.settingsCubit.state.zoom),
              effectController,
            ),
          )
          ..add(
            ColorEffect(
              bloc.state.colorScheme.primary,
              effectController,
              opacityTo: 0.5,
            ),
          );
    if (sprite.parent == null) {
      add(sprite);
    }
    sprite.position = event.localEndPosition;
    _last = event.canvasEndPosition;
    _cursorHitbox?.position = game.camera.globalToLocal(
      event.canvasEndPosition,
    );
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _dragSprite?.removeFromParent();
    _dragSprite = null;
    if (isMouseOrLongPressing ?? true) {
      final zone = game
          .componentsAtPoint(_last)
          .whereType<HandItemDropZone>()
          .firstOrNull;
      if (zone != null) moveItem(zone);
    }
    _resetPosition();
    super.onDragEnd(event);
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
            anchors: TextSelectionToolbarAnchors(
              primaryAnchor: position.toOffset(),
            ),
            buttonItems: items(context, onClose),
          ),
    );
  }

  List<ContextMenuButtonItem> Function(BuildContext, VoidCallback onClose)?
  contextItemsBuilder;

  void moveItem(HandItemDropZone zone) {}

  void changeLabelVisibility(bool visible) {
    if (visible) {
      _label.removeFromParent();
    } else if (_label.parent == null) {
      add(_label);
    }
  }
}
