import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart'
    show Canvas, Color, Colors, CustomPainter, Paint, PaintingStyle, Rect, Size;
import 'package:flutter/painting.dart';
import 'package:quokka/bloc/world/bloc.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka/board/game.dart';
import 'package:quokka/board/hand/deck.dart';
import 'package:quokka/board/hand/figure.dart';
import 'package:quokka/board/hand/item.dart';
import 'package:quokka/board/hand/object.dart';
import 'package:quokka/helpers/scroll.dart';
import 'package:quokka_api/quokka_api.dart';

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
        FlameBlocListenable<WorldBloc, ClientWorldState>,
        TapCallbacks,
        ScrollCallbacks,
        CollisionCallbacks,
        HandItemDropZone {
  final _scrollView = ScrollViewComponent(direction: Axis.horizontal);

  /// Should hand be redrawn
  bool _isDirty = true;

  GameHand() : super(anchor: Anchor.topLeft, painter: GameHandCustomPainter());

  @override
  void onLoad() {
    super.onLoad();
    add(_scrollView);
  }

  @override
  void update(double dt) {
    if (_isDirty) {
      _isDirty = false;
      if (isMounted) {
        _buildHand(bloc.state);
      }
    }
  }

  @override
  void onInitialState(ClientWorldState state) => _isDirty = true;

  @override
  void onNewState(ClientWorldState state) => _isDirty = true;

  @override
  void onParentResize(Vector2 maxSize) {
    width = maxSize.x;
    height = min(maxSize.y / 3, 128);
    position = Vector2(0, maxSize.y - height);
    _scrollView.height = height;
    _scrollView.width = width;
  }

  @override
  bool listenWhen(ClientWorldState previousState, ClientWorldState newState) =>
      previousState.showHand != newState.showHand ||
      previousState.selectedDeck != newState.selectedDeck ||
      previousState.selectedCell != newState.selectedCell ||
      previousState.table.cells[previousState.selectedCell] !=
          newState.table.cells[newState.selectedCell] ||
      previousState.colorScheme != newState.colorScheme ||
      previousState.info.packs != newState.info.packs;

  void _buildHand(ClientWorldState state) {
    _scrollView.clearChildren();
    painter = GameHandCustomPainter(
        showHand: state.showHand, color: state.colorScheme.surface);
    if (!state.showHand) return;
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
    final decks = game.packs.expand((e) => e.value.getDeckItems(e.key));
    for (final deck in decks) {
      _scrollView.addChild(DeckDefinitionHandItem(item: deck));
    }
  }

  void _addFigures(Iterable<(PackItem<FigureDefinition>, String?)> figures) {
    for (final figure in figures) {
      _scrollView.addChild(FigureDefinitionHandItem(item: figure));
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
    for (final object
        in cell?.objects.asMap().entries ?? const Iterable.empty()) {
      _scrollView.addChild(
          GameObjectHandItem(item: (location, object.key, object.value)));
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

  void scroll(double delta) => _scrollView.scroll(delta);
}
