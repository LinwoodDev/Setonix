import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:quokka/bloc/board.dart';
import 'package:quokka/bloc/board_event.dart';
import 'package:quokka/bloc/board_state.dart';
import 'package:quokka/board/background.dart';
import 'package:quokka/board/game.dart';
import 'package:quokka/board/grid.dart';
import 'package:quokka/helpers/vector.dart';
import 'package:quokka/models/vector.dart';

class GameCell extends PositionComponent
    with
        HasGameRef<BoardGame>,
        HoverCallbacks,
        TapCallbacks,
        DragCallbacks,
        FlameBlocListenable<BoardBloc, BoardState> {
  late final SpriteComponent _selectionComponent;
  final List<Effect> _effects = [];
  late final BoardGrid grid;

  GameCell({
    super.size,
    super.position,
  });

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
    super.onLoad();
    grid = findParent<BoardGrid>()!;
    add(GameBoardBackground(size: size));
    _selectionComponent = SpriteComponent(
      sprite: game.selectionSprite,
      size: size,
    );
    add(_selectionComponent..opacity = 0);
  }

  @override
  bool listenWhen(BoardState previousState, BoardState newState) {
    final definition = toDefinition();
    return (previousState.selectedCell == definition) !=
        (newState.selectedCell == definition);
  }

  bool get isSelected => bloc.state.selectedCell == toDefinition();

  @override
  void onHoverEnter() {
    if (!isSelected) {
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
    if (!isSelected) {
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
    bloc.add(CellSwitched(toDefinition(), toggle: true));
  }

  VectorDefinition toDefinition() =>
      (position.clone()..divide(grid.cellSize)).toDefinition();

  @override
  void onNewState(BoardState state) {
    final selected = state.selectedCell == toDefinition();
    final controller = EffectController(
      duration: 0.1,
    );
    final context = game.buildContext;
    final color =
        context == null ? Colors.green : Theme.of(context).colorScheme.primary;
    if (selected) {
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
