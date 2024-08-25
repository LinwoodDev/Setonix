import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:quokka/bloc/world/bloc.dart';
import 'package:quokka/bloc/world/local.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka/board/background.dart';
import 'package:quokka/board/game.dart';
import 'package:quokka/board/grid.dart';
import 'package:quokka/board/hand/item.dart';
import 'package:quokka/helpers/scroll.dart';
import 'package:quokka/helpers/secondary.dart';
import 'package:quokka/helpers/vector.dart';
import 'package:quokka/helpers/visualizer.dart';
import 'package:quokka_api/quokka_api.dart';

class GameCell extends PositionComponent
    with
        HasGameRef<BoardGame>,
        HoverCallbacks,
        TapCallbacks,
        DragCallbacks,
        DoubleTapCallbacks,
        SecondaryTapCallbacks,
        DetailsTapCallbacks,
        CollisionCallbacks,
        HandItemDropZone,
        FlameBlocListenable<WorldBloc, ClientWorldState>,
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
    add(_selectionComponent);
  }

  @override
  bool listenWhen(ClientWorldState previousState, ClientWorldState newState) {
    final definition = toDefinition();
    return (previousState.selectedCell == definition) !=
            (newState.selectedCell == definition) ||
        previousState.table.cells[definition] !=
            newState.table.cells[definition] ||
        previousState.teamMembers != newState.teamMembers ||
        previousState.info.teams != newState.info.teams ||
        previousState.colorScheme != newState.colorScheme;
  }

  bool get isSelected => isMounted && bloc.state.selectedCell == toDefinition();

  void _fadeIn() => _updateEffects([
        OpacityEffect.fadeIn(
          EffectController(
            duration: 0.1,
          ),
          target: _selectionComponent,
        )
      ]);
  @override
  void onHoverEnter() {
    if (!isSelected) {
      _fadeIn();
    }
  }

  @override
  void onDragOver(HandItem handItem) => _fadeIn();

  void _fadeOut() => _updateEffects([
        OpacityEffect.fadeOut(
          EffectController(
            duration: 0.1,
          ),
          target: _selectionComponent,
        )
      ]);

  @override
  void onHoverExit() {
    if (!isSelected) {
      _fadeOut();
    }
  }

  @override
  void onDragOverEnd(HandItem handItem) => _fadeOut();

  @override
  void onTapUp(TapUpEvent event) {
    if (isSelected) {
      bloc.process(HandChanged.hide());
    } else {
      bloc.process(CellSwitched(toDefinition(), toggle: true));
    }
  }

  VectorDefinition toDefinition() =>
      (position.clone()..divide(grid.cellSize)).toDefinition();

  GlobalVectorDefinition toGlobalDefinition(ClientWorldState state) =>
      GlobalVectorDefinition.fromLocal(state.tableName, toDefinition());

  @override
  void onInitialState(ClientWorldState state) {
    if (state.selectedCell != toDefinition()) _selectionComponent.opacity = 0;
    _updateTop(state);
  }

  bool isClaimed(ClientWorldState state) => state.info.teams.entries.any(
      (entry) => entry.value.claimedCells.contains(toGlobalDefinition(state)));

  bool isAllowed(ClientWorldState state) => state.teamMembers.entries
      .where((entry) => entry.value.contains(state.id))
      .any((entry) =>
          state.info.teams[entry.key]?.claimedCells
              .contains(toGlobalDefinition(state)) ??
          false);

  @override
  Future<void> onNewState(ClientWorldState state) async {
    final selected = state.selectedCell == toDefinition();
    final controller = EffectController(
      duration: 0.1,
    );
    final color = isClaimed(state)
        ? isAllowed(state)
            ? state.colorScheme.secondary
            : state.colorScheme.error
        : state.colorScheme.primary;
    if (selected) {
      _updateEffects([
        OpacityEffect.fadeIn(controller, target: _selectionComponent),
        ColorEffect(color, controller),
      ]);
    } else {
      _updateEffects([
        OpacityEffect.fadeOut(controller, target: _selectionComponent),
        ColorEffect(color, controller, opacityFrom: 1, opacityTo: 0),
      ]);
    }
    await _updateTop(state);
  }

  Future<void> _updateTop(ClientWorldState state) async {
    final top = state.table.cells[toDefinition()]?.objects.firstOrNull;
    if (_cardComponent != null) {
      remove(_cardComponent!);
      _cardComponent = null;
    }
    if (top != null) {
      _cardComponent = SpriteComponent(
          sprite: await game.assetManager.loadFigureSpriteFromLocation(
              top.asset,
              top.hidden || !state.isCellVisible(toDefinition())
                  ? null
                  : top.variation),
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
    final delta = event.canvasDelta
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
                      bloc.process(CellHideChanged(toDefinition()));
                      onClose();
                    },
                  ),
                  ContextMenuButtonItem(
                    label: AppLocalizations.of(context).shuffle,
                    onPressed: () {
                      bloc.process(ShuffleCellRequest(toDefinition()));
                      onClose();
                    },
                  ),
                  ContextMenuButtonItem(
                    label: AppLocalizations.of(context).teams,
                    onPressed: () {
                      onClose();
                      showLeapBottomSheet(
                        context: context,
                        titleBuilder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(AppLocalizations.of(context).teams),
                            Text(toDefinition().toDisplayString(),
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                        childrenBuilder: (context) => [
                          BlocBuilder<WorldBloc, ClientWorldState>(
                            bloc: bloc,
                            buildWhen: (previous, current) =>
                                previous.info.teams != current.info.teams,
                            builder: (context, state) {
                              final teams = state.info.teams.entries.toList();
                              if (teams.isEmpty) {
                                return Center(
                                  child: Text(
                                    AppLocalizations.of(context).noTeams,
                                  ),
                                );
                              }
                              final anyClaimed = teams.any((entry) => entry
                                  .value.claimedCells
                                  .contains(toDefinition()));
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    anyClaimed
                                        ? AppLocalizations.of(context)
                                            .claimedCell
                                        : AppLocalizations.of(context)
                                            .publicCell,
                                  ),
                                  ...teams.map((entry) {
                                    final selected = entry.value.claimedCells
                                        .contains(toDefinition());
                                    return ListTile(
                                      title: Text(entry.key),
                                      leading: ColorButton(
                                        color: entry.value.color?.color ??
                                            Colors.transparent,
                                        size: 24,
                                      ),
                                      selected: selected,
                                      onTap: () => bloc.process(TeamChanged(
                                          entry.key,
                                          entry.value.copyWith(
                                            claimedCells: selected
                                                ? entry.value.claimedCells
                                                    .difference({
                                                    toGlobalDefinition(state)
                                                  })
                                                : entry.value.claimedCells
                                                    .union({
                                                    toGlobalDefinition(state)
                                                  }),
                                          ))),
                                    );
                                  }),
                                ],
                              );
                            },
                          )
                        ],
                      );
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
