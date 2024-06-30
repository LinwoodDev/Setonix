import 'dart:async';

import 'package:flame/game.dart';
import 'package:quokka/game/board/cell.dart';
import 'package:quokka/game/board/grid.dart';

class BoardGame extends FlameGame {
  @override
  FutureOr<void> onLoad() {
    world.add(BoardGrid(cellSize: Vector2.all(64), createCell: GameCell.new));
  }
}
