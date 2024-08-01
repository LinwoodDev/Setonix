import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:quokka/game/board/background.dart';
import 'package:quokka/game/board/game.dart';

class GameCell extends PositionComponent
    with HasGameRef<BoardGame>, HoverCallbacks, TapCallbacks, DragCallbacks {
  late final SpriteComponent _selectionComponent;
  final List<Effect> _effects = [];
  bool _selected = false;

  GameCell({super.size, super.position});

  void _updateEffects(List<Effect> effects) {
    for (final e in _effects) {
      e.removeFromParent();
    }
    _effects.clear();
    for (final e in effects) {
      _selectionComponent.add(e);
      _effects.add(e);
    }
  }

  @override
  Future<void> onLoad() async {
    add(GameBoardBackground(size: size));
    _selectionComponent = SpriteComponent(
      sprite: game.selectionSprite,
      size: size,
    );
    add(_selectionComponent..opacity = 0);
  }

  @override
  void onHoverEnter() {
    if (!_selected) {
      _updateEffects([
        OpacityEffect.to(
          1,
          EffectController(
            duration: 0.1,
          ),
        )
      ]);
    }
  }

  @override
  void onHoverExit() {
    if (!_selected) {
      _updateEffects([
        OpacityEffect.to(
          0,
          EffectController(
            duration: 0.1,
          ),
        )
      ]);
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.selectedCell = _selected ? null : position;
  }

  @override
  void update(double dt) {
    if (_selected == (game.selectedCell == position)) return;
    _selected = !_selected;
    final controller = EffectController(
      duration: 0.1,
    );
    final context = game.buildContext;
    final color =
        context == null ? Colors.green : Theme.of(context).colorScheme.primary;
    if (_selected) {
      _updateEffects([
        OpacityEffect.to(1, controller),
        ColorEffect(color, controller),
      ]);
    } else {
      _updateEffects([
        OpacityEffect.to(0, controller),
        ColorEffect(color, controller, opacityFrom: 1, opacityTo: 0),
      ]);
    }
  }

  late double startZoom;

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    startZoom = game.camera.viewfinder.zoom;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    final delta = event.localDelta
      ..negate()
      ..divide(Vector2.all(game.camera.viewfinder.zoom));
    game.camera.moveBy(delta);
  }
}
