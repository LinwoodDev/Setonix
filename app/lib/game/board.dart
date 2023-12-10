import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qeck/game/player.dart';
import 'package:qeck/game/wall.dart';
import 'package:qeck/services/network.dart';

class BoardGame extends FlameGame with KeyboardEvents, HasCollisionDetection {
  final NetworkingService networkingService;
  final BoardPlayer _player = BoardPlayer();

  final Vector2 _tileSize = Vector2.all(16);
  Vector2 get tileSize => _tileSize;

  BoardGame({
    required this.networkingService,
  });

  @override
  Future<void> onLoad() async {
    final component = await TiledComponent.load('map.tmx', _tileSize);

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
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
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
    _player.move(movement);
    return handled ? KeyEventResult.handled : KeyEventResult.ignored;
  }
}
