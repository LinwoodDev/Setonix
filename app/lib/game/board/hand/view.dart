import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flame/components.dart';
import 'package:quokka/game/board/game.dart';
import 'package:quokka/game/board/hand/deck.dart';
import 'package:quokka/game/board/hand/figure.dart';
import 'package:quokka/game/board/hand/item.dart';
import 'package:quokka/game/board/hand/object.dart';
import 'package:quokka/models/definitions/deck.dart';
import 'package:quokka/models/definitions/object.dart';
import 'package:quokka/models/definitions/pack.dart';
import 'package:quokka/models/table.dart';

class GameHand extends PositionComponent with HasGameRef<BoardGame> {
  Vector2? _lastPosition;
  double _delta = 0, _nextItemPos = 0;
  bool _showing = false, _lastShowing = false;
  PackItem<DeckDefinition>? _selectedDeck;

  GameHand()
      : super(
          anchor: Anchor.bottomCenter,
        );

  @override
  void onLoad() {
    _updatePosition();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_showing != _lastShowing) {
      _updatePosition();
      _lastShowing = _showing;
    }
    if (_lastPosition == game.selectedCell) {
      return;
    }
    _lastPosition = game.selectedCell;
    removeAll(children);
    _buildHand();
    _repositionChildren();
  }

  void _updatePosition() {
    final game = gameRef;
    final size = game.canvasSize;
    width = size.x;
    height = min(size.y / 3, 256);
    position = Vector2(0, -height * (_showing ? 1 : 0.5));
  }

  void _repositionChildren() {
    _nextItemPos = _delta;
    for (final child in children) {
      if (child is! PositionComponent) {
        continue;
      }
      child.position = Vector2(_nextItemPos, 0);
      _nextItemPos += child.width;
    }
  }

  void _buildHand() {
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
    for (final deck in decks) {
      _addChild(DeckDefinitionHandItem(item: deck));
    }
  }

  void _addFigures(Iterable<PackItem<FigureDefinition>> figures) {
    for (final figure in figures) {
      _addChild(FigureDefinitionHandItem(item: figure));
    }
  }

  void _buildDeckHand(PackItem<DeckDefinition> deck) {
    final deckFigures = deck.item.figures;
    final figures = deckFigures
        .map((e) => deck.pack.getFigureItem(e.name, deck.namespace))
        .whereNotNull();
    _addFigures(figures);
  }

  void _buildCellHand(Vector2 cell) {
    final location = GridLocation(cell.x.toInt(), cell.y.toInt());
    final tableCell = game.table.cells[location];
    for (final object in tableCell?.objects ?? <GameObject>[]) {
      _addChild(GameObjectHandItem(item: MapEntry(location, object)));
    }
  }

  void _addChild(HandItem item) {
    item.position = Vector2(_nextItemPos, 0);
    _nextItemPos += item.size.x;
    add(item);
  }

  void show() {
    _showing = true;
    _delta = 0;
    _selectedDeck = null;
  }

  void hide() {
    _showing = false;
  }
}
