import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setonix/pages/game/waypoint.dart';
import 'package:setonix/pages/game/merge.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/local.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/board/background.dart';
import 'package:setonix/board/game.dart';
import 'package:setonix/board/grid.dart';
import 'package:setonix/board/hand/item.dart';
import 'package:setonix/helpers/scroll.dart';
import 'package:setonix/helpers/secondary.dart';
import 'package:setonix/helpers/vector.dart';
import 'package:setonix/helpers/visualizer.dart';
import 'package:setonix_api/setonix_api.dart';

class GameCell extends PositionComponent
    with
        HasGameReference<BoardGame>,
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
  late final NineTileBoxComponent _selectionComponent;
  TextElementComponent? _waypointComponent;
  GameBoardBackground? _backgroundComponent;
  late final BoardGrid grid;
  List<Effect>? _effects;

  GameCell({super.size, super.position});

  void _updateEffects(List<Effect> effects) {
    _effects = effects;
  }

  @override
  void update(double dt) {
    super.update(dt);
    final effects = _effects;
    if (effects != null) {
      _selectionComponent.removeWhere((e) => e is Effect);
      _selectionComponent.addAll(effects);
      _effects = null;
    }
    if (isMounted) {
      _updateTop();
    }
  }

  void _buildWaypointComponent(ClientWorldState state) {
    final visible = state.showWaypoints;
    _waypointComponent?.removeFromParent();
    _waypointComponent = null;
    if (!visible) {
      return;
    }
    final global = toGlobalDefinition(state);
    final globalWaypoints = state.info.waypoints
        .where((waypoint) => waypoint.position == global)
        .map<InlineTextNode>((e) => PlainTextNode(e.name))
        .toList();
    final teamWaypoints = state.world.getTeams().expand((name) {
      final team = state.info.teams[name];
      if (team == null) return Iterable<InlineTextNode>.empty();
      return team.waypoints
          .where((waypoint) => waypoint.position == global)
          .map<InlineTextNode>(
            (e) => CustomInlineTextNode(
              PlainTextNode(e.name),
              styleName: 'team-$name',
            ),
          );
    }).toList();
    if (globalWaypoints.isEmpty && teamWaypoints.isEmpty) {
      return;
    }
    final blocks = <BlockNode>[
      ParagraphNode.group(globalWaypoints),
      ParagraphNode.group(teamWaypoints),
    ];
    final document = DocumentRoot(blocks);
    final component = _waypointComponent = TextElementComponent.fromDocument(
      document: document,
      size: size,
      priority: 2,
      style: DocumentStyle(
        paragraph: BlockStyle(textAlign: TextAlign.center),
        customStyles: {
          for (final entry in state.world.getTeams())
            'team-$entry': InlineTextStyle(
              color:
                  state.info.teams[entry]?.color?.color ??
                  state.colorScheme.primary,
            ),
        },
        text: InlineTextStyle(
          shadows: [
            Shadow(
              color: Colors.black,
              offset: const Offset(0, 0),
              blurRadius: 2,
            ),
          ],
        ),
      ),
    );
    add(component);
  }

  @override
  void onLoad() {
    super.onLoad();
    grid = findParent<BoardGrid>()!;
    _backgroundComponent = GameBoardBackground(size: size);
    add(_backgroundComponent!);
    _selectionComponent = NineTileBoxComponent(
      nineTileBox: NineTileBox(game.selectionSprite, tileSize: 12),
      size: size,
      priority: 1,
    );
    add(_selectionComponent);
  }

  @override
  bool listenWhen(ClientWorldState previousState, ClientWorldState newState) {
    final definition = toDefinition();
    return previousState.isCellSelected(definition) !=
            newState.isCellSelected(definition) ||
        previousState.table.cells[definition] !=
            newState.table.cells[definition] ||
        previousState.teamMembers != newState.teamMembers ||
        previousState.colorScheme != newState.colorScheme ||
        previousState.showWaypoints != newState.showWaypoints;
  }

  bool get isSelected => isMounted && bloc.state.isCellSelected(toDefinition());

  void _fadeIn() =>
      _updateEffects([OpacityEffect.fadeIn(EffectController(duration: 0.2))]);
  @override
  void onHoverEnter() {
    if (!isSelected) {
      _fadeIn();
    }
  }

  @override
  void onDragOver(HandItem handItem) => _fadeIn();

  void _fadeOut() =>
      _updateEffects([OpacityEffect.fadeOut(EffectController(duration: 0.2))]);

  @override
  void onHoverExit() {
    if (!isSelected) {
      _fadeOut();
    }
  }

  @override
  void onDragOverEnd(HandItem handItem) {
    if (!isSelected) {
      _fadeOut();
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (isSelected) {
      bloc.process(HandChanged.hide());
    } else {
      bloc.process(CellSwitched(isSelected ? null : toDefinition()));
    }
  }

  VectorDefinition toDefinition() =>
      (position.clone()..divide(grid.cellSize)).toDefinition();

  GlobalVectorDefinition toGlobalDefinition(ClientWorldState state) =>
      GlobalVectorDefinition.fromLocal(state.tableName, toDefinition());

  @override
  void onInitialState(ClientWorldState state) {
    if (state.selectedCell != toDefinition()) _selectionComponent.opacity = 0;
    _buildWaypointComponent(state);
  }

  bool isClaimed(ClientWorldState state) => state.info.teams.entries.any(
    (entry) => entry.value.claimedCells.contains(toGlobalDefinition(state)),
  );

  bool isAllowed(ClientWorldState state) => state.teamMembers.entries
      .where((entry) => entry.value.contains(state.id))
      .any(
        (entry) =>
            state.info.teams[entry.key]?.claimedCells.contains(
              toGlobalDefinition(state),
            ) ??
            false,
      );

  List<GameObject>? _currentObjects;
  CellMergeStrategy? _currentStrategy;
  BoardTile? _currentTile;
  bool _currentVisible = true;

  @override
  void onNewState(ClientWorldState state) {
    final selected = state.isCellSelected(toDefinition());
    final color = isClaimed(state)
        ? isAllowed(state)
              ? state.colorScheme.secondary
              : state.colorScheme.error
        : state.colorScheme.primary;
    if (selected) {
      _updateEffects([
        OpacityEffect.fadeIn(EffectController(duration: 0.2)),
        ColorEffect(color, EffectController(duration: 0.2)),
      ]);
    } else {
      _updateEffects([
        OpacityEffect.fadeOut(EffectController(duration: 0.2)),
        ColorEffect(
          color,
          EffectController(duration: 0.2),
          opacityFrom: 1,
          opacityTo: 0,
        ),
      ]);
    }
    _buildWaypointComponent(state);
  }

  int? _currentSpan;

  Future<void> _updateTop() async {
    final state = bloc.state;
    final cellDefinition = toDefinition();
    final cell = state.table.cells[cellDefinition];
    final objects = cell?.objects ?? const [];
    final strategy = cell?.merge;
    final visible = state.isCellVisible(toGlobalDefinition(state));
    final tile = cell?.tiles.lastOrNull;

    if (strategy is MergedCellStrategy) {
      if (_currentVisible) {
        _currentVisible = false;
        size = Vector2.zero();
        _backgroundComponent?.size = Vector2.zero();
        _selectionComponent.size = Vector2.zero();
        removeWhere((e) => e is _GameCellObjectComponent);
        removeWhere((e) => e is _GameCellTileComponent);
        _currentObjects = null;
        _currentStrategy = null;
        _currentSpan = null;
        _currentTile = null;
      }
      return;
    }

    int? newSpan;
    if (strategy is LayoutCellMergeStrategy) {
      final direction = strategy is StackedCellMergeStrategy
          ? strategy.direction
          : (strategy as DistributeCellMergeStrategy).direction;
      final span = state.calculateLocalSpan(cellDefinition, direction);
      newSpan = span;
      final s = grid.cellSize.clone();
      if (direction == CellMergeDirection.horizontal) {
        s.x *= span;
      } else {
        s.y *= span;
      }
      if (size != s) {
        size = s;
        _backgroundComponent?.size = s;
        _selectionComponent.size = s;
        priority = 100;
      }
    } else {
      _currentVisible = true;
      if (size != grid.cellSize) {
        size = grid.cellSize;
        _backgroundComponent?.size = size;
        _selectionComponent.size = size;
        priority = 0;
      }
    }

    if (const ListEquality().equals(objects, _currentObjects) &&
        strategy == _currentStrategy &&
        newSpan == _currentSpan &&
        visible == _currentVisible &&
        tile == _currentTile) {
      return;
    }
    _currentObjects = objects;
    _currentStrategy = strategy;
    _currentSpan = newSpan;
    _currentVisible = visible;
    _currentTile = tile;
    final paint = Paint()..isAntiAlias = false;

    removeWhere((e) => e is _GameCellTileComponent);

    if (newSpan != null && newSpan > 1 && strategy is LayoutCellMergeStrategy) {
      final direction = strategy.direction;
      var current = cellDefinition;
      for (var i = 0; i < newSpan; i++) {
        if (i > 0) {
          current = direction == CellMergeDirection.horizontal
              ? VectorDefinition(current.x + 1, current.y)
              : VectorDefinition(current.x, current.y + 1);
        }

        final targetCell = state.table.cells[current];
        final targetTile = targetCell?.tiles.lastOrNull;

        if (targetTile != null) {
          final component = _GameCellTileComponent(paint: paint, priority: 0);
          component.sprite =
              await state.assetManager.loadBoardSprite(
                targetTile.asset,
                targetTile.tile,
              ) ??
              game.blankSprite;
          component.size = grid.cellSize;

          double tx = 0;
          double ty = 0;
          if (direction == CellMergeDirection.horizontal) {
            tx = i * grid.cellSize.x;
          } else {
            ty = i * grid.cellSize.y;
          }
          component.position = Vector2(tx, ty);
          add(component);
        }
      }
    } else if (tile != null) {
      final component = _GameCellTileComponent(paint: paint, priority: 0);
      component.sprite =
          await state.assetManager.loadBoardSprite(tile.asset, tile.tile) ??
          game.blankSprite;
      component.size = grid.cellSize;
      component.position = Vector2.zero();
      add(component);
    } else {
      // Clear if no tile
    }
    removeWhere((e) => e is _GameCellObjectComponent);
    if (objects.isEmpty) return;

    var displayObjects = switch (strategy) {
      DistributeCellMergeStrategy(maxCards: final maxCards) => objects.take(
        maxCards,
      ),
      _ => strategy == null ? [objects.first] : objects,
    }.toList();

    final bool reverse;
    final CellMergeDirection? direction;
    if (strategy is LayoutCellMergeStrategy) {
      reverse = strategy.reverse;
      direction = strategy.direction;
    } else {
      reverse = false;
      direction = null;
    }

    final renderObjects = displayObjects
        .asMap()
        .entries
        .toList()
        .reversed
        .toList();
    final cellRect = size.toRect();

    for (final entry in renderObjects) {
      final i = entry.key;
      final object = entry.value;

      final double x, y;
      switch (strategy) {
        case StackedCellMergeStrategy(
          visiblePercentage: final visiblePercentage,
        ):
          final offsetStep = visiblePercentage / 100.0;
          final count = displayObjects.length;

          if (direction == CellMergeDirection.vertical) {
            x = size.x / 2;
            if (!reverse) {
              final startY = grid.cellSize.y / 2;
              y = startY + i * offsetStep * grid.cellSize.y;
            } else {
              final startY = size.y - grid.cellSize.y / 2;
              y = startY - (count - 1 - i) * offsetStep * grid.cellSize.y;
            }
          } else {
            y = size.y / 2;
            if (!reverse) {
              final startX = grid.cellSize.x / 2;
              x = startX + i * offsetStep * grid.cellSize.x;
            } else {
              final startX = size.x - grid.cellSize.x / 2;
              x = startX - (count - 1 - i) * offsetStep * grid.cellSize.x;
            }
          }
        case DistributeCellMergeStrategy(
          fillVariableSpace: final fillVariableSpace,
        ):
          final count = displayObjects.length;
          if (count == 1) {
            x = size.x / 2;
            y = size.y / 2;
          } else {
            var factor = i / (count - 1);
            // Center factor to -0.5 ... 0.5 range
            factor -= 0.5;
            if (reverse) factor = -factor;

            if (fillVariableSpace) {
              factor *= 2; // -1 to 1
            } else {
              factor = (i - (count - 1) / 2.0) * 0.4;
            }

            if (direction == CellMergeDirection.vertical) {
              x = size.x / 2;
              y = size.y / 2 + (size.y - grid.cellSize.y) / 2 * factor;
            } else {
              x = size.x / 2 + (size.x - grid.cellSize.x) / 2 * factor;
              y = size.y / 2;
            }
          }
        default:
          x = size.x / 2;
          y = size.y / 2;
      }

      final cRect = Rect.fromCenter(
        center: Offset(x, y),
        width: grid.cellSize.x,
        height: grid.cellSize.y,
      );

      // Relaxed check to handle floating point precision
      final bounds = cellRect.inflate(1);
      if (bounds.contains(cRect.topLeft) &&
          bounds.contains(cRect.bottomRight)) {
        final component = _GameCellObjectComponent(paint: paint, priority: 1);
        final sprite =
            await state.assetManager.loadFigureSprite(
              object.asset,
              object.hidden || !visible ? null : object.variation,
            ) ??
            game.blankSprite;
        component.sprite = sprite;

        final scale =
            (grid.cellSize.x / sprite.srcSize.x) <
                (grid.cellSize.y / sprite.srcSize.y)
            ? (grid.cellSize.x / sprite.srcSize.x)
            : (grid.cellSize.y / sprite.srcSize.y);
        component.size = sprite.srcSize * scale;
        component.anchor = Anchor.center;
        component.position = Vector2(x, y);
        add(component);
      } else {
        // Optimization: Break if we are moving away from bounds
        bool decreasing = true;
        if (strategy is LayoutCellMergeStrategy && reverse) {
          decreasing = false;
        }

        if (decreasing) {
          if (direction == CellMergeDirection.horizontal) {
            if (cRect.right < bounds.left) break;
          } else {
            if (cRect.bottom < bounds.top) break;
          }
        } else {
          if (direction == CellMergeDirection.horizontal) {
            if (cRect.left > bounds.right) break;
          } else {
            if (cRect.top > bounds.bottom) break;
          }
        }
      }
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    final delta = event.canvasDelta
      ..negate()
      ..divide(Vector2.all(game.camera.viewfinder.zoom));
    game.camera.moveBy(delta);
  }

  bool anyRollable(ClientWorldState state) {
    final assetManager = state.assetManager;
    final global = toGlobalDefinition(state);
    final local = global.position;
    final cell = state.table.getCell(local);
    if (!state.isCellVisible(global)) return false;
    return cell.objects.any(
      (object) =>
          (assetManager.getFigure(object.asset)?.rollable ?? false) &&
          state.isCellVisible(global),
    );
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
                  bloc.process(CellHideChanged(toGlobalDefinition(bloc.state)));
                  onClose();
                },
              ),
              ContextMenuButtonItem(
                label: AppLocalizations.of(context).shuffle,
                onPressed: () {
                  bloc.process(
                    ShuffleCellRequest(toGlobalDefinition(bloc.state)),
                  );
                  onClose();
                },
              ),
              if (anyRollable(bloc.state))
                ContextMenuButtonItem(
                  label: AppLocalizations.of(context).roll,
                  onPressed: () {
                    bloc.process(
                      CellRollRequest(toGlobalDefinition(bloc.state)),
                    );
                    onClose();
                  },
                ),
              ContextMenuButtonItem(
                label: AppLocalizations.of(context).merge,
                onPressed: () {
                  onClose();
                  showDialog(
                    context: context,
                    builder: (context) => BlocProvider.value(
                      value: bloc,
                      child: MergeDialog(
                        cell: toGlobalDefinition(bloc.state),
                        initialStrategy:
                            bloc.state.table.cells[toDefinition()]?.merge,
                        initialSpan: () {
                          final strategy =
                              bloc.state.table.cells[toDefinition()]?.merge;
                          if (strategy is LayoutCellMergeStrategy) {
                            return bloc.state.calculateLocalSpan(
                              toDefinition(),
                              strategy.direction,
                            );
                          }
                          return 1;
                        }(),
                      ),
                    ),
                  );
                },
              ),
              ContextMenuButtonItem(
                label: AppLocalizations.of(context).remove,
                onPressed: () {
                  bloc.process(ObjectsRemoved(toGlobalDefinition(bloc.state)));
                  onClose();
                },
              ),
              ContextMenuButtonItem(
                label: AppLocalizations.of(context).addWaypoint,
                onPressed: () {
                  onClose();
                  showDialog(
                    context: context,
                    builder: (context) => BlocProvider.value(
                      value: bloc,
                      child: WaypointDialog(
                        position: toGlobalDefinition(bloc.state),
                      ),
                    ),
                  );
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
                        Text(
                          toDefinition().toDisplayString(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
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
                              child: Text(AppLocalizations.of(context).noTeams),
                            );
                          }
                          final anyClaimed = teams.any(
                            (entry) => entry.value.claimedCells.contains(
                              toGlobalDefinition(state),
                            ),
                          );
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                anyClaimed
                                    ? AppLocalizations.of(context).claimedCell
                                    : AppLocalizations.of(context).publicCell,
                              ),
                              ...teams.map((entry) {
                                final selected = entry.value.claimedCells
                                    .contains(toGlobalDefinition(state));
                                return ListTile(
                                  title: Text(entry.key),
                                  leading: ColorButton(
                                    color:
                                        entry.value.color?.color ??
                                        Colors.transparent,
                                    size: 24,
                                  ),
                                  selected: selected,
                                  onTap: () => bloc.process(
                                    TeamChanged(
                                      entry.key,
                                      entry.value.copyWith(
                                        claimedCells: selected
                                            ? entry.value.claimedCells
                                                  .difference({
                                                    toGlobalDefinition(state),
                                                  })
                                            : entry.value.claimedCells.union({
                                                toGlobalDefinition(state),
                                              }),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
            anchors: TextSelectionToolbarAnchors(
              primaryAnchor: position.toOffset(),
            ),
          ),
    );
  }

  @override
  bool onScroll(PointerScrollInfo info) {
    var delta = info.scrollDelta.global.clone()..divide(Vector2.all(4));
    if (game.isShifting) {
      delta = Vector2(delta.y, delta.x);
    }
    game.camera.moveBy(delta / game.settingsCubit.state.scrollSensitivity);
    return false;
  }
}

class _GameCellObjectComponent extends SpriteComponent {
  _GameCellObjectComponent({super.paint, super.priority});
}

class _GameCellTileComponent extends SpriteComponent {
  _GameCellTileComponent({super.paint, super.priority});
}
