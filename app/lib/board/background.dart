import 'dart:ui';

import 'package:flame/components.dart';
import 'package:quokka/board/game.dart';

class GameBoardBackground extends SpriteComponent
    with HasGameReference<BoardGame> {
  GameBoardBackground({super.size})
      : super(paint: Paint()..isAntiAlias = false);
  @override
  void onLoad() {
    sprite = game.gridSprite;
  }
}
