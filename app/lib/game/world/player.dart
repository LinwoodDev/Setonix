import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/text.dart';
import 'package:quokka/game/world/game.dart';
import 'package:quokka/game/world/wall.dart';
import 'package:quokka/models/message.dart';
import 'package:quokka/models/state.dart';

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
    with HasGameRef<GameWorld>, CollisionCallbacks {
  final bool isSelf;
  NetworkingUser _user;

  BoardPlayer(this.isSelf, [this._user = const NetworkingUser(name: '')])
      : super(current: (PlayerState.idle, PlayerDirection.front));

  late final TextComponent _text = TextComponent();
  late final SpacedSpriteSheet _spriteSheet;

  ReadOnlyPositionProvider get positionProvider =>
      _PreviousPlayerPositionComponent(this);

  final RectangleHitbox collisionHitbox =
      RectangleHitbox(position: Vector2.all(2), size: Vector2.all(12))
        ..debugMode = true;

  @override
  Future<void> onLoad() async {
    size = game.tileSize;
    anchor = Anchor.center;
    final image = await Flame.images.load('player.png');
    _spriteSheet = SpacedSpriteSheet(
      image: image,
      srcSize: Vector2.all(16),
      spacing: Vector2.all(2),
      margin: Vector2.all(1),
    );
    animations = _getAnimations();
    _text.text = '';
    _text.anchor = Anchor.bottomCenter;
    _text.position = Vector2(game.tileSize.x / 2, 0);
    _text.textRenderer = TextPaint(
      style: const TextStyle(
        color: ui.Color(0xFFFFFFFF),
        fontSize: 4,
      ),
    );

    add(_text);
    add(collisionHitbox);
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

  SpriteAnimation _getAnimation({
    required List<Vector2> frames,
    double stepTime = double.infinity,
  }) {
    return SpriteAnimation.spriteList(
      frames
          .map(
            (vector) =>
                _spriteSheet.getSprite(vector.x.toInt(), vector.y.toInt()),
          )
          .toList(),
      stepTime: stepTime,
    );
  }

  Vector2 velocity = Vector2.zero();
  PlayerDirection get direction => current?.$2 ?? PlayerDirection.front;
  PlayerState get state => current?.$1 ?? PlayerState.idle;
  final double _speed = 50;
  final Set<PositionComponent> _collidesXPos = {},
      _collidesXNeg = {},
      _collidesYPos = {},
      _collidesYNeg = {};

  @override
  void update(double dt) {
    final next = velocity.xy * dt * _speed;
    if (_collidesXPos.isNotEmpty && next.x > 0 ||
        _collidesXNeg.isNotEmpty && next.x < 0) {
      next.x = 0;
    }
    if (_collidesYPos.isNotEmpty && next.y > 0 ||
        _collidesYNeg.isNotEmpty && next.y < 0) {
      next.y = 0;
    }
    position.add(next);
    _sendUpdate();
    if (state != PlayerState.sitting) {
      if (velocity.x == 0 && velocity.y == 0) {
        current = (PlayerState.idle, direction);
      } else {
        current = (PlayerState.walking, direction);
      }
    }
    super.update(dt);
  }

  bool get wasFlipped => direction == PlayerDirection.left;

  static const sprintModifier = 1.5;

  void move(Vector3 velocity, [bool isSprinting = false]) {
    final lastFlipped = wasFlipped;
    velocity = velocity.normalized();
    if (isSprinting) {
      velocity *= sprintModifier;
    }
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
    if (state == PlayerState.sitting) {
      return;
    }
    this.velocity = velocity.xy;
  }

  void toggleSit() {
    if (state == PlayerState.sitting) {
      current = (PlayerState.idle, direction);
    } else {
      current = (PlayerState.sitting, direction);
      velocity = Vector2.zero();
    }
  }

  void _toggleSetElement<T>(Set<T> set, T element, bool value) {
    if (value) {
      set.add(element);
    } else {
      set.remove(element);
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is BoardWall) {
      other.debugMode = true;
      collisionHitbox.debugMode = true;

      Rect intersection =
          collisionHitbox.toAbsoluteRect().intersect(other.toAbsoluteRect());
      final dx = intersection.width;
      final dy = intersection.height;
      if (dx > dy) {
        if (position.y < other.position.y) {
          position.y -= dy;
        } else {
          position.y += dy;
        }
      } else {
        if (position.x < other.position.x) {
          position.x -= dx;
        } else {
          position.x += dx;
        }
      }
      _toggleSetElement(
          _collidesYPos, other, dx > dy && position.y < other.position.y);
      _toggleSetElement(
          _collidesYNeg, other, dx > dy && position.y > other.position.y);
      _toggleSetElement(
          _collidesXPos, other, dx < dy && position.x < other.position.x);
      _toggleSetElement(
          _collidesXNeg, other, dx < dy && position.x > other.position.x);
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    _collidesXPos.remove(other);
    _collidesXNeg.remove(other);
    _collidesYPos.remove(other);
    _collidesYNeg.remove(other);
  }

  void onUpdate(NetworkingUser? user) {
    if (_user == user) {
      return;
    }
    user ??= _user.copyWith(name: '');
    _user = user;
    position = Vector2(user.position.$1, user.position.$2);
    velocity = Vector2(user.velocity.$1, user.velocity.$2);
    current = (user.state, direction);
    _text.text = user.name;
  }

  void _sendUpdate() {
    final currentId = game.networkingService.value?.currentId;
    if (!isSelf || currentId == null) return;
    if (position.x == _user.position.$1 &&
        position.y == _user.position.$2 &&
        state == _user.state &&
        velocity.x == _user.velocity.$1 &&
        velocity.y == _user.velocity.$2) {
      return;
    }
    _user = NetworkingUser(
      name: _user.name,
      position: (position.x, position.y),
      state: state,
      velocity: (velocity.x, velocity.y),
    );
    game.networkingService.value?.sendUpdate(NetworkUpdateMessage(
      id: currentId,
      name: _user.name,
      state: _user.state,
      position: (position.x, position.y),
      velocity: (velocity.x, velocity.y),
    ));
  }
}
