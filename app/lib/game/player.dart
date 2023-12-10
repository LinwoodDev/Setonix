import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/text.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:qeck/game/board.dart';
import 'package:qeck/game/wall.dart';

enum PlayerState { idle, walking, jumping }

class _PreviousPlayerPositionComponent extends ReadOnlyPositionProvider {
  final BoardPlayer player;

  _PreviousPlayerPositionComponent(this.player);

  @override
  Vector2 get position => player.previousPosition;
}

class BoardPlayer extends SpriteAnimationGroupComponent<PlayerState>
    with HasGameRef<BoardGame>, CollisionCallbacks {
  BoardPlayer() : super(current: PlayerState.idle);
  late final ui.Image _image;
  late final TextComponent _text = TextComponent();

  ReadOnlyPositionProvider get positionProvider =>
      _PreviousPlayerPositionComponent(this);

  @override
  Future<void> onLoad() async {
    size = game.tileSize;
    anchor = Anchor.center;
    _image = await Flame.images.load('player.png');
    animations = {
      PlayerState.idle: _getAnimation(frames: [Vector2(0, 0)]),
      PlayerState.walking: _getAnimation(
        frames: [
          Vector2(1, 0),
          Vector2(2, 0),
        ],
        stepTime: 0.2,
      ),
      PlayerState.jumping: _getAnimation(frames: [Vector2(3, 0)]),
    };
    _text.text = 'Player';
    _text.anchor = Anchor.bottomCenter;
    _text.position = Vector2(game.tileSize.x / 2, 0);
    _text.textRenderer = TextPaint(
      style: const TextStyle(
        color: ui.Color(0xFFFFFFFF),
        fontSize: 8,
      ),
    );

    add(_text);
    add(RectangleHitbox(size: size));
  }

  SpriteAnimation _getAnimation({
    required List<Vector2> frames,
    double stepTime = double.infinity,
  }) {
    final size = Vector2.all(16);
    return SpriteAnimation.spriteList(
      frames
          .map(
            (vector) => Sprite(
              _image,
              srcSize: size,
              srcPosition: vector.clone()..multiply(size),
            ),
          )
          .toList(),
      stepTime: stepTime,
    );
  }

  Vector2 velocity = Vector2.zero(), previousPosition = Vector2.zero();

  @override
  void update(double dt) {
    previousPosition = position.clone();
    position.add(velocity.xy);
    if (velocity.x == 0 && velocity.y == 0) {
      current = PlayerState.idle;
    } else {
      current = PlayerState.walking;
    }
    super.update(dt);
  }

  void move(Vector3 velocity) {
    this.velocity = velocity.xy;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is BoardWall) {
      position = previousPosition;
    }
    super.onCollision(intersectionPoints, other);
  }
}
