import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart'
    show CustomPainter, Colors, Canvas, Size, Paint, PaintingStyle, Rect;
import 'package:quokka/bloc/board.dart';
import 'package:quokka/bloc/board_state.dart';
import 'package:quokka/board/game.dart';
import 'package:quokka/board/hand/deck.dart';
import 'package:quokka/board/hand/figure.dart';
import 'package:quokka/board/hand/item.dart';
import 'package:quokka/board/hand/object.dart';
import 'package:quokka/models/definitions/deck.dart';
import 'package:quokka/models/definitions/object.dart';
import 'package:quokka/models/definitions/pack.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/models/vector.dart';

class GameHandCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class GameHand extends CustomPainterComponent
    with
        HasGameRef<BoardGame>,
        DragCallbacks,
        FlameBlocListenable<BoardBloc, BoardState> {
  double _nextItemPos = 0;
  final _itemsChild = PositionComponent();

  GameHand()
      : super(
          anchor: Anchor.topLeft,
          painter: GameHandCustomPainter(),
        );

  @override
  void onLoad() {
    add(_itemsChild);
  }

  @override
  void onInitialState(BoardState state) => _buildHand(state);

  @override
  void onNewState(BoardState state) => _buildHand(state);

  @override
  void onParentResize(Vector2 maxSize) {
    width = maxSize.x;
    height = min(maxSize.y / 3, 128);
    position = Vector2(0, maxSize.y - height);
    _itemsChild.height = height;
  }

  @override
  bool listenWhen(BoardState previousState, BoardState newState) =>
      previousState.showHand != newState.showHand ||
      previousState.selectedDeck != newState.selectedDeck ||
      previousState.selectedCell != newState.selectedCell;

  void _buildHand(BoardState state) {
    _itemsChild.children
        .whereType<HandItem>()
        .forEach((e) => e.removeFromParent());
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
    for (final object in cell?.objects ?? []) {
      _addChild(GameObjectHandItem(item: MapEntry(location, object)));
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

  @override
  void onDragUpdate(DragUpdateEvent event) {
    scroll(event.localDelta.x);
  }
}
