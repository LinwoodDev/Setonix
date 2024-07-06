import 'package:flame/components.dart';
import 'package:quokka/game/board/game.dart';

class GameBoardBackground extends SpriteComponent
    with HasGameReference<BoardGame> {
  GameBoardBackground({super.size});
  @override
  void onLoad() {
    sprite = game.gridSprite;
  }
}
