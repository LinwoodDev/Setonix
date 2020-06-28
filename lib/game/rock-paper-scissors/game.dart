
import 'package:flame/game/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class RockPaperScissorsGame extends Game {
  Sprite bgSprite;
  Size screenSize;

  double tileSize;


  @override
  void render(Canvas canvas) {
    bgSprite = new Sprite("rock-paper-scissors/canyon.jpg");
    var bgRect = Rect.fromLTWH(0, screenSize.height - (tileSize * 23), tileSize * 9, tileSize * 23);
    bgSprite.renderRect(canvas, bgRect);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;

  }
}
