import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quokka/bloc/board.dart';
import 'package:quokka/bloc/board_event.dart';
import 'package:quokka/bloc/board_state.dart';
import 'package:quokka/board/background.dart';
import 'package:quokka/board/game.dart';
import 'package:quokka/board/grid.dart';
import 'package:quokka/board/hand/item.dart';
import 'package:quokka/helpers/scroll.dart';
import 'package:quokka/helpers/secondary.dart';
import 'package:quokka/helpers/vector.dart';
import 'package:quokka/models/vector.dart';

class GameCell extends HandItemDropZone
    with
        HasGameRef<BoardGame>,
        HoverCallbacks,
        TapCallbacks,
        DragCallbacks,
        DoubleTapCallbacks,
        SecondaryTapCallbacks,
        DetailsTapCallbacks,
        FlameBlocListenable<BoardBloc, BoardState>,
        ScrollCallbacks {
  late final SpriteComponent _selectionComponent;
  SpriteComponent? _cardComponent;
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
            (newState.selectedCell == definition) ||
        newState.table.cells[definition] !=
            previousState.table.cells[definition];
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
    if (isSelected) {
      bloc.add(HandChanged.hide());
    } else {
      bloc.add(CellSwitched(toDefinition(), toggle: true));
    }
  }

  VectorDefinition toDefinition() =>
      (position.clone()..divide(grid.cellSize)).toDefinition();

  @override
  void onInitialState(BoardState state) => _updateTop(state);

  @override
  Future<void> onNewState(BoardState state) async {
    final selected = state.selectedCell == toDefinition();
    final controller = EffectController(
      duration: 0.1,
    );
    final color = state.colorScheme?.primary ?? Colors.green.withOpacity(0.5);
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
    await _updateTop(state);
  }

  Future<void> _updateTop(BoardState state) async {
    final top = state.table.cells[toDefinition()]?.objects.firstOrNull;
    if (_cardComponent != null) {
      remove(_cardComponent!);
      _cardComponent = null;
    }
    if (top != null) {
      _cardComponent = SpriteComponent(
          sprite: await game.assetManager.loadFigureSpriteFromLocation(
              top.asset, top.hidden ? null : top.variation),
          size: size);
      await add(_cardComponent!);
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

  @override
  void onContextMenu(Vector2 position) {
    game.showContextMenu(
        contextMenuBuilder: (context, onClose) =>
            AdaptiveTextSelectionToolbar.buttonItems(
                buttonItems: [
                  ContextMenuButtonItem(
                    label: AppLocalizations.of(context).toggleHide,
                    onPressed: () {
                      bloc.add(CellHideChanged(toDefinition()));
                      onClose();
                    },
                  ),
                  ContextMenuButtonItem(
                    label: AppLocalizations.of(context).shuffle,
                    onPressed: () {
                      bloc.add(CellShuffled.random(toDefinition()));
                      onClose();
                    },
                  ),
                ],
                anchors: TextSelectionToolbarAnchors(
                    primaryAnchor: position.toOffset())));
  }

  @override
  bool onScroll(PointerScrollInfo info) {
    var delta = info.scrollDelta.global.clone()..divide(Vector2.all(4));
    if (game.isShifting) {
      delta = Vector2(delta.y, delta.x);
    }
    game.camera.moveBy(delta);
    return false;
  }
}
