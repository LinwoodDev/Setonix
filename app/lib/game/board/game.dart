import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';
import 'package:quokka/game/board/cell.dart';
import 'package:quokka/game/board/grid.dart';
import 'package:quokka/game/board/hand/view.dart';
import 'package:quokka/models/definitions/pack.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/services/pack.dart';

class BoardGame extends FlameGame with ScrollDetector, ScaleDetector {
  final PackService packService;
  final GameTable table;
  final Map<String, PackData> _loadedPacks = {};
  Vector2? selectedCell;
  late final Sprite gridSprite;
  late final GameHand _hand;

  BoardGame({
    required this.packService,
    this.table = const GameTable(),
  });

  @override
  FutureOr<void> onLoad() async {
    final pack = await loadPack('');
    if (pack == null) {
      return;
    }
    final data = pack.getAsset('textures/backgrounds/grid.png');
    if (data == null) {
      return;
    }
    final image = await decodeImageFromList(data);
    gridSprite = Sprite(image);
    _hand = GameHand();
    camera.viewport.add(_hand);
    world.add(BoardGrid(cellSize: Vector2.all(256), createCell: GameCell.new));
  }

  void clampZoom(double zoom) {
    camera.viewfinder.zoom = zoom.clamp(0.3, 3.0);
  }

  static const zoomPerScrollUnit = 0.02;

  @override
  void onScroll(PointerScrollInfo info) {
    clampZoom(camera.viewfinder.zoom +
        info.scrollDelta.global.y.sign * zoomPerScrollUnit);
  }

  late double startZoom;

  @override
  void onScaleStart(ScaleStartInfo info) {
    startZoom = camera.viewfinder.zoom;
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    final currentScale = info.scale.global;
    if (!currentScale.isIdentity()) {
      clampZoom(startZoom * currentScale.y);
    } else {
      final delta = info.delta.global
        ..negate()
        ..divide(Vector2.all(camera.viewfinder.zoom));
      camera.moveBy(delta);
    }
  }

  Iterable<MapEntry<String, PackData>> get packs => _loadedPacks.entries;

  Future<PackData?> loadPack(String packId) async {
    var pack = _loadedPacks[packId];
    if (pack != null) {
      return pack;
    }

    pack = await packService.getPack(packId);
    if (pack == null) {
      return null;
    }
    _loadedPacks[packId] = pack;
    return pack;
  }

  void showAdd() {
    selectedCell = null;
  }
}
