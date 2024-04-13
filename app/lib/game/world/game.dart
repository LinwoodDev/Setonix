import 'dart:async';
import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:qeck/game/world/inventory.dart';
import 'package:qeck/game/world/player.dart';
import 'package:qeck/game/world/wall.dart';
import 'package:qeck/services/network.dart';

class SpacedSpriteSheet {
  final ui.Image image;
  final Vector2 srcSize, spacing, margin;

  SpacedSpriteSheet({
    required this.image,
    required this.srcSize,
    required this.spacing,
    required this.margin,
  });

  Sprite getSprite(int x, int y) {
    return Sprite(image,
        srcPosition: Vector2(
          margin.x + x * (srcSize.x + spacing.x),
          margin.y + y * (srcSize.y + spacing.y),
        ),
        srcSize: srcSize);
  }
}

class GameWorld extends FlameGame with KeyboardEvents, HasCollisionDetection {
  final NetworkingService networkingService;
  final BoardPlayer _player = BoardPlayer(true);
  final Map<int, BoardPlayer> _players = <int, BoardPlayer>{};

  final Vector2 _tileSize = Vector2.all(16);
  Vector2 get tileSize => _tileSize;
  final VoidCallback onEscape;

  GameWorld({
    required this.networkingService,
    required this.onEscape,
  });

  StreamSubscription? _networkerSub, _updateSub;

  @override
  Future<void> onLoad() async {
    final component = await TiledComponent.load(
      'map.tmx',
      _tileSize,
      useAtlas: false,
    );

    final objects = component.tileMap.getLayer<ObjectGroup>('Objects')?.objects;
    final spawn = objects?.firstWhere(
      (object) => object.name == 'Spawn',
      orElse: () => TiledObject(
        name: 'Spawn',
        id: 0,
        x: 0,
        y: 0,
        width: 16,
        height: 16,
      ),
    );
    _player.position = Vector2(spawn?.x ?? 0, spawn?.y ?? 0);

    world.add(component);
    world.add(_player);
    camera.viewport.add(InventoryHud());
    camera.follow(_player.positionProvider);
    camera.viewfinder.zoom = 8;

    camera.setBounds(Rectangle.fromRect(component.toRect()));
    for (final object
        in component.tileMap.getLayer<ObjectGroup>('Collisions')?.objects ??
            <TiledObject>[]) {
      world.add(BoardWall(
        position: Vector2(object.x, object.y),
        size: Vector2(object.width, object.height),
      ));
    }
    _networkerSub?.cancel();
    _networkerSub = networkingService.stream.listen((messenger) {
      _updateSub?.cancel();
      _updateSub = messenger?.usersStream.listen((event) {
        final removed = _players.keys.toSet()..removeAll(event.keys);
        _removePlayers(removed);
        for (final id in event.entries) {
          if (id.key == messenger.currentId) {
            _player.onUpdate(id.value);
            continue;
          }
          final existed = _players[id.key];
          if (existed != null) {
            existed.onUpdate(id.value);
          } else {
            final player = BoardPlayer(false, id.value);
            world.add(player);
            _players[id.key] = player;
          }
        }
      });
      _removePlayers(_players.keys.toSet());
      _player.onUpdate(messenger?.users[messenger.currentId]);
    });
  }

  @override
  void onRemove() {
    _updateSub?.cancel();
    _networkerSub?.cancel();
  }

  void _removePlayers(Iterable<int> ids) {
    for (final id in ids) {
      world.remove(_players[id]!);
      _players.remove(id);
    }
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    var movement = Vector3.zero();
    var handled = false;
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA)) {
      movement.x -= 1;
      handled = true;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
      movement.x += 1;
      handled = true;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
        keysPressed.contains(LogicalKeyboardKey.keyW)) {
      movement.y -= 1;
      handled = true;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowDown) ||
        keysPressed.contains(LogicalKeyboardKey.keyS)) {
      movement.y += 1;
      handled = true;
    }
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      movement.z += 1;
      handled = true;
    }
    movement.normalize();
    if (event is KeyUpEvent && event.logicalKey == LogicalKeyboardKey.escape) {
      onEscape();
      movement = Vector3.zero();
    }
    if (event is KeyUpEvent && event.logicalKey == LogicalKeyboardKey.space) {
      _player.toggleSit();
    } else {
      _player.move(
          movement, keysPressed.contains(LogicalKeyboardKey.shiftLeft));
    }
    return handled ? KeyEventResult.handled : KeyEventResult.ignored;
  }
}
