import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/painting.dart';
import 'package:quokka/game/board/game.dart';
import 'package:quokka/models/table.dart';

class GameBoardBackground extends Component with HasGameReference<BoardGame> {
  late Sprite _sprite;
  Rect lastRect = Rect.zero;

  @override
  Future<void> onLoad() async {
    final pack = await game.loadPack('');
    if (pack == null) {
      return;
    }
    final data = pack.getAsset('textures/backgrounds/grid.png');
    if (data == null) {
      return;
    }
    final image = await decodeImageFromList(data);
    _sprite = Sprite(image);
  }

  @override
  void update(double dt) {
    final viewport = game.camera.visibleWorldRect;
    if (lastRect.left <= viewport.left &&
        lastRect.right >= viewport.right &&
        lastRect.top <= viewport.top &&
        lastRect.bottom >= viewport.bottom) {
      return;
    }
    print('Updating background');
    final imageSize = Vector2(
        _sprite.image.width.toDouble(), _sprite.image.height.toDouble());
    children.map((c) => c.removeFromParent());
    final imageViewport = Rect.fromLTRB(
      (viewport.left / imageSize.x).floor() * imageSize.x,
      (viewport.top / imageSize.y).floor() * imageSize.y,
      (viewport.right / imageSize.x).ceil() * imageSize.x,
      (viewport.bottom / imageSize.y).ceil() * imageSize.y,
    );
    for (var y = imageViewport.top;
        y < imageViewport.bottom;
        y += imageSize.y) {
      for (var x = imageViewport.left;
          x < imageViewport.right;
          x += imageSize.x) {
        add(SpriteComponent(
          sprite: _sprite,
          size: imageSize,
          position: Vector2(x, y),
        ));
      }
    }
    lastRect = imageViewport;
  }
}
