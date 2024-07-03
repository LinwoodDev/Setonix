import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:quokka/game/board/background.dart';
import 'package:quokka/game/board/cell.dart';
import 'package:quokka/game/board/grid.dart';
import 'package:quokka/models/definitions/pack.dart';
import 'package:quokka/services/pack.dart';

class BoardGame extends FlameGame with ScrollDetector, ScaleDetector {
  final PackService packService;
  final Map<String, PackData> _loadedPacks = {};

  BoardGame({
    required this.packService,
  });

  @override
  FutureOr<void> onLoad() {
    world
      ..add(GameBoardBackground())
      ..add(BoardGrid(cellSize: Vector2.all(64), createCell: GameCell.new));
  }

  void clampZoom(double zoom) {
    camera.viewfinder.zoom = zoom.clamp(0.5, 3.0);
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
}
