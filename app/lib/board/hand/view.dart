import 'dart:math';
import 'dart:ui';

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
import 'package:setonix_api/setonix_api.dart';

class GameHandCustomPainter extends CustomPainter {
  final bool showHand;
  final Color color;

  GameHandCustomPainter({this.showHand = false, this.color = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    if (!showHand) return;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndCorners(
      rect,
      topLeft: const Radius.circular(24),
      topRight: const Radius.circular(24),
    );

    // Draw shadow
    canvas.drawShadow(Path()..addRRect(rrect), Colors.black, 12.0, true);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRRect(rrect, paint);

    // Optional subtle top highlight/border
    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawRRect(rrect, borderPaint);
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
        HasGameReference<BoardGame> {
  double _currentScroll = 0;

  /// Should hand be redrawn
  bool _isDirty = true, _needsLayout = true;

  GameHand() : super(anchor: Anchor.topLeft, painter: GameHandCustomPainter());

  @override
  Future<void> update(double dt) async {
    if (_needsLayout) {
      _layoutChildren();
      _needsLayout = false;
    }
    if (_isDirty) {
      _isDirty = false;
      if (isMounted) {
        await _buildHand(bloc.state);
      }
      _needsLayout = true;
    }
  }

  @override
  void onInitialState(ClientWorldState state) => _isDirty = true;

  @override
  void onNewState(ClientWorldState state) {
    _isDirty = true;
    _currentScroll = 0;
  }

  @override
  void onParentResize(Vector2 maxSize) {
    width = maxSize.x;
    height = min(maxSize.y / 3, 192);
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
  static const activeItemWidth = 100;
  static const simpleItemWidth = 180;
  static const itemWidth = 80;
  static const itemYOffset = 3;
  void _layoutChildren() {
    final childrenLength = children.length;
    if (childrenLength == 0) return;
    final center = Vector2(width / 2, height);
    final double active = (_currentScroll - childrenLength + 1).abs().clamp(
      0,
      childrenLength - 1,
    );

    children.toList().whereType<HandItem>().forEachIndexed((index, element) {
      final double activeRelative = active - index;
      // Figure out how "active" this item is (0 = fully active, 1 = inactive)
      var x = center.x + simpleItemWidth * activeRelative;
      var y = center.y;
      var width = simpleItemWidth.toDouble();
      if (game.settingsCubit.state.stackedCards) {
        final offset = activeRelative <= -1 ? -activeItemWidth / 2 : 0;
        y = center.y + itemYOffset * activeRelative.abs();
        x = center.x + offset + activeRelative * itemWidth;
        element.targetAngle = activeRelative * itemAngle;
      } else {
        element.targetAngle = 0;
      }
      element.updateWidth(width);

      element.changeLabelVisibility(activeRelative.abs() > 0.5);

      element.targetPosition = Vector2(x, y);
    });
  }

  Future<void> _addChildren(Iterable<Component> items) {
    final reversed = items.toList().reversed;
    return addAll(reversed);
  }

  Future<void> _buildHand(ClientWorldState state) {
    for (final child in children) {
      child.removeFromParent();
    }
    painter = GameHandCustomPainter(
      showHand: state.showHand,
      color: state.colorScheme.surface,
    );
    if (!state.showHand) return Future.value();
    final selected = state.selectedCell;
    final cell = state.table.cells[selected];
    if (selected == null) {
      final deck = state.selectedDeck;
      final packItem = deck != null
          ? state.assetManager.getDeckItem(deck)
          : null;
      if (packItem != null) {
        return _buildDeckHand(state, packItem, state.showDuplicates);
      } else {
        return _buildFreeHand(state);
      }
    } else {
      return _buildCellHand(selected, cell);
    }
  }

  Future<void> _buildFreeHand(ClientWorldState state) {
    final decks = state.packs.expand((e) => e.value.getDeckItems(e.key));
    return _addChildren(
      decks
          .map((e) => DeckDefinitionHandItem(item: e))
          .where((e) => e.matches(state, state.searchTerm)),
    );
  }

  Future<void> _addFigures(
    ClientWorldState state,
    Iterable<(PackItem<FigureDefinition>, String?)> figures,
  ) {
    return _addChildren(
      figures
          .map((e) => FigureDefinitionHandItem(item: e))
          .where((e) => e.matches(state, state.searchTerm)),
    );
  }

  Future<void> _buildDeckHand(
    ClientWorldState state,
    PackItem<DeckDefinition> deck,
    bool showDuplicates,
  ) {
    Iterable<FigureDeckDefinition> deckFigures = deck.item.figures;
    Iterable<BoardDeckDefinition> boards = deck.item.boards;
    if (!showDuplicates) {
      boards = boards.fold<Set<BoardDeckDefinition>>(<BoardDeckDefinition>{}, (
        previousValue,
        element,
      ) {
        if (!previousValue.any((e) => element.name == e.name)) {
          previousValue.add(element);
        }
        return previousValue;
      });
      deckFigures = deckFigures.fold<Set<FigureDeckDefinition>>(
        <FigureDeckDefinition>{},
        (previousValue, element) {
          if (!previousValue.any(
            (e) => element.name == e.name && element.variation == e.variation,
          )) {
            previousValue.add(element);
          }
          return previousValue;
        },
      );
    }
    return Future.wait([
      _addFigures(
        state,
        deckFigures.map((e) {
          final figure = deck.pack.getFigureItem(e.name, deck.namespace);
          if (figure == null) return null;
          return (figure, e.variation);
        }).nonNulls,
      ),
      _addChildren(
        boards
            .map((e) => deck.pack.getBoardItem(e.name, deck.namespace))
            .nonNulls
            .map((e) => BoardDefinitionHandItem(item: e))
            .where((e) => e.matches(state, state.searchTerm)),
      ),
    ]);
  }

  Future<void> _buildCellHand(VectorDefinition location, TableCell? cell) {
    return Future.wait([
      _addChildren(
        cell?.tiles.asMap().entries.map(
              (e) => BoardTileHandItem(item: (location, e.key, e.value)),
            ) ??
            const Iterable.empty(),
      ),
      _addChildren(
        cell?.objects.asMap().entries.map(
              (e) => GameObjectHandItem(item: (location, e.key, e.value)),
            ) ??
            const Iterable.empty(),
      ),
    ]);
  }

  bool get isShowing => bloc.state.showHand;

  @override
  void onTapDown(TapDownEvent event) {
    if (!isShowing) {
      event.continuePropagation = true;
      return;
    }
    final isOverItem = componentsAtPoint(
      event.localPosition,
    ).whereType<HandItem>().isNotEmpty;
    if (isOverItem) {
      event.continuePropagation = true;
    }
  }

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
    dragScroll(event.localDelta.x);
  }

  @override
  void onScroll(ScrollEvent event) {
    if (!isShowing) {
      event.continuePropagation = true;
      return;
    }
    var delta = event.scrollDelta.x;
    if (delta == 0) {
      delta = event.scrollDelta.y;
    }
    scroll(-delta * 0.01);
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

  void dragScroll(double delta) => scroll(delta * 0.025);

  void scroll(double delta) {
    if (!isShowing) return;
    _currentScroll = (_currentScroll - delta).clamp(
      0,
      max(0, children.length - 1),
    );
    _needsLayout = true;
  }

  void moveLeft() => scroll(1);
  void moveRight() => scroll(-1);
}
