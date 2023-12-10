import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/geometry.dart';
import 'package:flame/text.dart';
import 'package:qeck/game/board.dart';
import 'package:qeck/game/wall.dart';
import 'package:qeck/services/network.dart';

class _PreviousPlayerPositionComponent extends ReadOnlyPositionProvider {
  final BoardPlayer player;

  _PreviousPlayerPositionComponent(this.player);

  @override
  Vector2 get position => player.position;
}

enum PlayerDirection { front, left, right }

extension RendererExtension on PlayerState {
  List<int> get frames {
    switch (this) {
      case PlayerState.idle:
        return [0];
      case PlayerState.walking:
        return [1, 2];
      case PlayerState.sitting:
        return [3];
    }
  }

  double get stepTime {
    switch (this) {
      case PlayerState.idle:
        return double.infinity;
      case PlayerState.walking:
        return 0.1;
      case PlayerState.sitting:
        return double.infinity;
    }
  }
}

class BoardPlayer
    extends SpriteAnimationGroupComponent<(PlayerState, PlayerDirection)>
    with HasGameRef<BoardGame>, CollisionCallbacks {
  BoardPlayer() : super(current: (PlayerState.idle, PlayerDirection.front));
  late final ui.Image _image;
  late final TextComponent _text = TextComponent();

  ReadOnlyPositionProvider get positionProvider =>
      _PreviousPlayerPositionComponent(this);

  @override
  Future<void> onLoad() async {
    size = game.tileSize;
    anchor = Anchor.center;
    _image = await Flame.images.load('player.png');
    animations = _getAnimations();
    _text.text = 'Player';
    _text.anchor = Anchor.bottomCenter;
    _text.position = Vector2(game.tileSize.x / 2, 0);
    _text.textRenderer = TextPaint(
      style: const TextStyle(
        color: ui.Color(0xFFFFFFFF),
        fontSize: 4,
      ),
    );

    add(_text);
    final realSize = Vector2.all(16);
    add(RectangleHitbox(
      size: realSize,
    ));
  }

  Map<(PlayerState, PlayerDirection), SpriteAnimation> _getAnimations() {
    return PlayerDirection.values.fold({}, (map, direction) {
      final spriteY = min(1, direction.index);
      return {
        ...map,
        ...PlayerState.values.fold({}, (map, state) {
          final frames = state.frames
              .map((frame) => Vector2(frame.toDouble(), spriteY.toDouble()))
              .toList();
          return {
            ...map,
            (state, direction): _getAnimation(
              frames: frames,
              stepTime: state.stepTime,
            ),
          };
        }),
      };
    });
  }

  Vector2 _getSpritePosition(Vector2 position) {
    return position.clone()
      ..multiply(Vector2.all(18))
      ..add(Vector2.all(1));
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
              srcPosition: _getSpritePosition(vector),
            ),
          )
          .toList(),
      stepTime: stepTime,
    );
  }

  Vector2 velocity = Vector2.zero(), previousPosition = Vector2.zero();
  PlayerDirection get direction => current?.$2 ?? PlayerDirection.front;
  PlayerState get state => current?.$1 ?? PlayerState.idle;
  final double _speed = 50;

  @override
  void update(double dt) {
    previousPosition = position.clone();
    final next = velocity.xy * dt * _speed;
    final length = next.length;
    if (length != 0) {
      final ray = Ray2(
        direction: next.normalized(),
        origin: position,
      );
      final result =
          game.collisionDetection.raycast(ray, maxDistance: length + 4);
      if (result == null) {
        position.add(next);
      }
    }
    if (velocity.x == 0 && velocity.y == 0) {
      current = (PlayerState.idle, direction);
    } else {
      current = (PlayerState.walking, direction);
    }
    super.update(dt);
  }

  bool get wasFlipped => direction == PlayerDirection.left;

  void move(Vector3 velocity) {
    this.velocity = velocity.xy;
    final lastFlipped = wasFlipped;
    if (velocity.x > 0) {
      current = (state, PlayerDirection.right);
    } else if (velocity.x < 0) {
      current = (state, PlayerDirection.left);
    } else {
      current = (state, PlayerDirection.front);
    }
    if (wasFlipped != lastFlipped) {
      flipHorizontally();
      _text.flipHorizontally();
    }
  }
}
