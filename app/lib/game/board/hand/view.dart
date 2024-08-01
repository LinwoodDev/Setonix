import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:quokka/game/board/game.dart';
import 'package:quokka/game/board/hand/deck.dart';
import 'package:quokka/game/board/hand/figure.dart';
import 'package:quokka/game/board/hand/item.dart';
import 'package:quokka/game/board/hand/object.dart';
import 'package:quokka/models/definitions/deck.dart';
import 'package:quokka/models/definitions/object.dart';
import 'package:quokka/models/definitions/pack.dart';
import 'package:quokka/models/table.dart';

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
    with HasGameRef<BoardGame>, DragCallbacks {
  Vector2? _lastPosition;
  double _nextItemPos = 0;
  bool _showing = false, _lastShowing = false;
  PackItem<DeckDefinition>? _selectedDeck;
  final _itemsChild = PositionComponent();

  GameHand()
      : super(
          anchor: Anchor.topLeft,
          painter: GameHandCustomPainter(),
        );

  @override
  void onLoad() {
    add(_itemsChild);
    _buildHand();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_showing != _lastShowing) {
      _lastShowing = _showing;
    }
    if (_lastPosition == game.selectedCell) {
      return;
    }
    _lastPosition = game.selectedCell;
    _buildHand();
  }

  @override
  void onParentResize(Vector2 maxSize) {
    width = maxSize.x;
    height = min(maxSize.y / 3, 256) * (_showing ? 1 : 0.5);
    position = Vector2(0, maxSize.y - height);
    _itemsChild.height = height;
  }

  void _buildHand() {
    removeAll(children.whereType<HandItem>());
    if (_lastPosition == null) {
      if (_selectedDeck != null) {
        _buildDeckHand(_selectedDeck!);
      } else {
        _buildFreeHand();
      }
    } else {
      _buildCellHand(_lastPosition!);
    }
  }

  void _buildFreeHand() {
    final game = gameRef;
    final decks = game.packs.expand((e) => e.value.getDeckItems());
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

  void _buildCellHand(Vector2 cell) {
    final location = GridLocation(cell.x.toInt(), cell.y.toInt());
    final tableCell = game.table.cells[location];
    _nextItemPos = 0;
    for (final object in tableCell?.objects ?? <GameObject>[]) {
      _addChild(GameObjectHandItem(item: MapEntry(location, object)));
    }
  }

  void _addChild(HandItem item) {
    _itemsChild.add(item);
    item.position = Vector2(_nextItemPos, 0);
    _nextItemPos += item.size.x;
  }

  void show() {
    _showing = true;
    _selectedDeck = null;
  }

  void hide() {
    _showing = false;
  }

  void selectDeck(PackItem<DeckDefinition> item) {
    _selectedDeck = item;
    _buildHand();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    _itemsChild.position.x += event.localDelta.x;
  }
}
