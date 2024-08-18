import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart'
    show Canvas, Color, Colors, CustomPainter, Paint, PaintingStyle, Rect, Size;
import 'package:quokka/bloc/world.dart';
import 'package:quokka/bloc/world_state.dart';
import 'package:quokka/board/game.dart';
import 'package:quokka/board/hand/deck.dart';
import 'package:quokka/board/hand/figure.dart';
import 'package:quokka/board/hand/item.dart';
import 'package:quokka/board/hand/object.dart';
import 'package:quokka/helpers/scroll.dart';
import 'package:quokka/models/deck.dart';
import 'package:quokka/models/object.dart';
import 'package:quokka/models/data.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/models/vector.dart';

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
        HasGameRef<BoardGame>,
        DragCallbacks,
        FlameBlocListenable<WorldBloc, WorldState>,
        TapCallbacks,
        ScrollCallbacks,
        CollisionCallbacks,
        HandItemDropZone {
  double _nextItemPos = 0;
  final _itemsChild = PositionComponent();

  GameHand() : super(anchor: Anchor.topLeft, painter: GameHandCustomPainter());

  @override
  void onLoad() {
    super.onLoad();
    add(_itemsChild);
  }

  @override
  void onInitialState(WorldState state) => _buildHand(state);

  @override
  void onNewState(WorldState state) => _buildHand(state);

  @override
  void onParentResize(Vector2 maxSize) {
    width = maxSize.x;
    height = min(maxSize.y / 3, 128);
    position = Vector2(0, maxSize.y - height);
    _itemsChild.height = height;
  }

  @override
  bool listenWhen(WorldState previousState, WorldState newState) =>
      previousState.showHand != newState.showHand ||
      previousState.selectedDeck != newState.selectedDeck ||
      previousState.selectedCell != newState.selectedCell ||
      previousState.table.cells[previousState.selectedCell] !=
          newState.table.cells[newState.selectedCell] ||
      previousState.colorScheme != newState.colorScheme;

  void _buildHand(WorldState state) {
    _itemsChild.children
        .whereType<HandItem>()
        .forEach((e) => e.removeFromParent());
    painter = GameHandCustomPainter(
        showHand: state.showHand, color: state.colorScheme.surface);
    if (!state.showHand) return;
    _itemsChild.x = 0;
    final selected = state.selectedCell;
    final cell = state.table.cells[selected];
    if (selected == null) {
      final deck = state.selectedDeck;
      final packItem = deck != null
          ? game.assetManager
              .getPack(deck.namespace)
              ?.getDeckItem(deck.id, deck.namespace)
          : null;
      if (packItem != null) {
        _buildDeckHand(packItem);
      } else {
        _buildFreeHand();
      }
    } else {
      _buildCellHand(selected, cell);
    }
  }

  void _buildFreeHand() {
    final game = gameRef;
    final decks =
        game.assetManager.packs.expand((e) => e.value.getDeckItems(e.key));
    _nextItemPos = 0;
    for (final deck in decks) {
      _addChild(DeckDefinitionHandItem(item: deck));
    }
  }

  void _addFigures(Iterable<(PackItem<FigureDefinition>, String?)> figures) {
    _nextItemPos = 0;
    for (final figure in figures) {
      _addChild(FigureDefinitionHandItem(item: figure));
    }
  }

  void _buildDeckHand(PackItem<DeckDefinition> deck) {
    final deckFigures = deck.item.figures;
    final figures = deckFigures.map((e) {
      final figure = deck.pack.getFigureItem(e.name, deck.namespace);
      if (figure == null) return null;
      return (figure, e.variation);
    }).whereNotNull();
    _addFigures(figures);
  }

  void _buildCellHand(VectorDefinition location, TableCell? cell) {
    _nextItemPos = 0;
    for (final object
        in cell?.objects.asMap().entries ?? const Iterable.empty()) {
      _addChild(GameObjectHandItem(item: (location, object.key, object.value)));
    }
  }

  void _addChild(HandItem item) {
    _itemsChild.add(item);
    item.position = Vector2(_nextItemPos, 0);
    _nextItemPos += item.size.x;
  }

  void scroll(double delta) {
    _itemsChild.position.x =
        (delta + _itemsChild.position.x).clamp(min(width - _nextItemPos, 0), 0);
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
    scroll(-delta);
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
}
