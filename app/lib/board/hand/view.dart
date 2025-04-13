import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart'
    show Canvas, Color, Colors, CustomPainter, Paint, PaintingStyle, Rect, Size;
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/board/game.dart';
import 'package:setonix/board/hand/board.dart';
import 'package:setonix/board/hand/deck.dart';
import 'package:setonix/board/hand/figure.dart';
import 'package:setonix/board/hand/item.dart';
import 'package:setonix/board/hand/object.dart';
import 'package:setonix/board/hand/tile.dart';
import 'package:setonix/helpers/scroll.dart';
import 'package:setonix_api/setonix_api.dart';

class GameHandCustomPainter extends CustomPainter {
  final bool showHand;
  final Color color;

  GameHandCustomPainter({this.showHand = false, this.color = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    if (!showHand) return;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(GameHandCustomPainter oldDelegate) =>
      showHand != oldDelegate.showHand || color != oldDelegate.color;
}

class GameHand extends CustomPainterComponent
    with
        DragCallbacks,
        FlameBlocListenable<WorldBloc, ClientWorldState>,
        TapCallbacks,
        ScrollCallbacks,
        CollisionCallbacks,
        HandItemDropZone,
        HasGameRef<BoardGame> {
  double _currentScroll = 0;

  /// Should hand be redrawn
  bool _isDirty = true, _needsLayout = true;

  GameHand() : super(anchor: Anchor.topLeft, painter: GameHandCustomPainter());

  @override
  void update(double dt) {
    if (_needsLayout) {
      _layoutChildren();
      _needsLayout = false;
    }
    if (_isDirty) {
      _isDirty = false;
      if (isMounted) {
        _buildHand(bloc.state);
      }
      _needsLayout = true;
    }
  }

  @override
  void onInitialState(ClientWorldState state) => _isDirty = true;

  @override
  void onNewState(ClientWorldState state) => _isDirty = true;

  @override
  void onParentResize(Vector2 maxSize) {
    width = maxSize.x;
    height = min(maxSize.y / 3, 256);
    position = Vector2(0, maxSize.y - height);
  }

  @override
  bool listenWhen(ClientWorldState previousState, ClientWorldState newState) =>
      previousState.showHand != newState.showHand ||
      previousState.selectedDeck != newState.selectedDeck ||
      previousState.selectedCell != newState.selectedCell ||
      previousState.table.cells[previousState.selectedCell] !=
          newState.table.cells[newState.selectedCell] ||
      previousState.colorScheme != newState.colorScheme ||
      previousState.info.packs != newState.info.packs ||
      previousState.info.teams != newState.info.teams ||
      previousState.showDuplicates != newState.showDuplicates ||
      previousState.searchTerm != newState.searchTerm;
  static const itemAngle = 0.01;
  static const activeItemWidth = 95;
  static const itemWidth = 60;
  static const itemYOffset = 3;
  void _layoutChildren() {
    final childrenLength = children.length;
    if (childrenLength == 0) return;
    final center = Vector2(width / 2, height);
    final double active = _currentScroll.clamp(0, childrenLength - 1);

    children.toList().whereType<HandItem>().forEachIndexed((index, element) {
      final double activeRelative = active - index;
      final angle = activeRelative * itemAngle;
      element.angle = angle;
      // Figure out how "active" this item is (0 = fully active, 1 = inactive)
      final progress = 1 - activeRelative.abs().clamp(0, 1);
      final currentWidth = itemWidth + (activeItemWidth - itemWidth) * progress;

      final offset = activeRelative <= -1 ? -activeItemWidth / 2 : 0;
      final y = center.y + itemYOffset * activeRelative.abs();
      final x = center.x + offset + activeRelative * currentWidth;

      element.changeLabelVisibility(activeRelative.abs() >= 1);

      element.position = Vector2(x, y);
    });
  }

  void _buildHand(ClientWorldState state) {
    for (final child in children) {
      child.removeFromParent();
    }
    painter = GameHandCustomPainter(
        showHand: state.showHand, color: state.colorScheme.surface);
    if (!state.showHand) return;
    final selected = state.selectedCell;
    final cell = state.table.cells[selected];
    if (selected == null) {
      final deck = state.selectedDeck;
      final packItem =
          deck != null ? state.assetManager.getDeckItem(deck) : null;
      if (packItem != null) {
        _buildDeckHand(state, packItem, state.showDuplicates);
      } else {
        _buildFreeHand(state);
      }
    } else {
      _buildCellHand(selected, cell);
    }
  }

  void _buildFreeHand(ClientWorldState state) {
    final decks = state.packs.expand((e) => e.value.getDeckItems(e.key));
    for (final deck in decks) {
      final item = DeckDefinitionHandItem(item: deck);
      if (item.matches(state, state.searchTerm)) add(item);
    }
  }

  void _addFigures(ClientWorldState state,
      Iterable<(PackItem<FigureDefinition>, String?)> figures) {
    for (final figure in figures) {
      final item = FigureDefinitionHandItem(item: figure);
      if (item.matches(state, state.searchTerm)) add(item);
    }
  }

  void _buildDeckHand(ClientWorldState state, PackItem<DeckDefinition> deck,
      bool showDuplicates) {
    Iterable<FigureDeckDefinition> deckFigures = deck.item.figures;
    Iterable<BoardDeckDefinition> boards = deck.item.boards;
    if (!showDuplicates) {
      boards = boards.fold<Set<BoardDeckDefinition>>(
        <BoardDeckDefinition>{},
        (previousValue, element) {
          if (!previousValue.any((e) => element.name == e.name)) {
            previousValue.add(element);
          }
          return previousValue;
        },
      );
      deckFigures = deckFigures.fold<Set<FigureDeckDefinition>>(
        <FigureDeckDefinition>{},
        (previousValue, element) {
          if (!previousValue.any((e) =>
              element.name == e.name && element.variation == e.variation)) {
            previousValue.add(element);
          }
          return previousValue;
        },
      );
    }
    for (final board in deck.item.boards) {
      final definition = deck.pack.getBoardItem(board.name, deck.namespace);
      if (definition == null) continue;
      add(BoardDefinitionHandItem(item: definition));
    }
    final figures = deckFigures.map((e) {
      final figure = deck.pack.getFigureItem(e.name, deck.namespace);
      if (figure == null) return null;
      return (figure, e.variation);
    }).nonNulls;
    _addFigures(state, figures);
  }

  void _buildCellHand(VectorDefinition location, TableCell? cell) {
    for (final tile in cell?.tiles.asMap().entries ?? const Iterable.empty()) {
      add(BoardTileHandItem(item: (location, tile.key, tile.value)));
    }
    for (final object
        in cell?.objects.asMap().entries ?? const Iterable.empty()) {
      add(GameObjectHandItem(item: (location, object.key, object.value)));
    }
  }

  bool get isShowing => bloc.state.showHand;

  @override
  void onDragStart(DragStartEvent event) {
    if (!isShowing) {
      event
        ..handled = false
        ..continuePropagation = true;
      return;
    }
    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (!isShowing) {
      event
        ..handled = false
        ..continuePropagation = true;
      return;
    }
    scroll(event.localDelta.x);
  }

  @override
  bool onScroll(PointerScrollInfo info) {
    if (!isShowing) {
      return false;
    }
    var delta = info.scrollDelta.global.x;
    if (delta == 0) {
      delta = info.scrollDelta.global.y;
    }
    delta /= 4;
    scroll(-delta / game.settingsCubit.state.scrollSensitivity);
    return true;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (!isShowing) {
      event
        ..handled = false
        ..continuePropagation = true;
      return;
    }
    super.onDragEnd(event);
  }

  void scroll(double delta) {
    if (!isShowing) return;
    _currentScroll += delta < 0 ? -1 : 1;
    _needsLayout = true;
  }
}
