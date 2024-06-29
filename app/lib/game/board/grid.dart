import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class BoardGrid extends Component {
  late CameraComponent? _camera;
  final Vector2 cellSize;
  Rect? _lastViewport;
  final PositionComponent Function(
      {required Vector2 position, required Vector2 size}) createCell;

  BoardGrid({
    required this.cellSize,
    required this.createCell,
  });

  Rect get viewport {
    final Rect viewport = _camera?.visibleWorldRect ?? Rect.zero;
    return Rect.fromLTWH(
      (viewport.left / cellSize.x).floor() * cellSize.x,
      (viewport.top / cellSize.y).floor() * cellSize.y,
      (viewport.width / cellSize.x).ceil() * cellSize.x,
      (viewport.height / cellSize.y).ceil() * cellSize.y,
    );
  }

  bool shouldReset() {
    // Check if the viewport is different by one pixel
    final Rect viewport = this.viewport;
    final Rect lastViewport = _lastViewport ?? Rect.zero;
    final bool shouldReset = viewport != lastViewport;
    return shouldReset;
  }

  void _updateGrid() {
    if (!shouldReset()) return;
    final camera = _camera;
    if (camera == null) return;
    final viewport = this.viewport;
    final last = _lastViewport ?? viewport;
    // Remove components that are out of the viewport
    for (final child in children) {
      if (child is! PositionComponent) continue;
      if (!camera.canSee(child)) {
        remove(child);
      }
    }

    // Top and bottom edges
    for (var x = viewport.left; x < viewport.right; x += cellSize.x) {
      for (var y = viewport.top; y < last.top; y += cellSize.y) {
        add(createCell(
          position: Vector2(x, y),
          size: cellSize,
        ));
      }
      for (var y = last.bottom; y < viewport.bottom; y += cellSize.y) {
        add(createCell(
          position: Vector2(x, y),
          size: cellSize,
        ));
      }
    }
    // Side edges without corners
    for (var y = last.top + cellSize.y;
        y < last.bottom - cellSize.y;
        y += cellSize.y) {
      for (var x = viewport.left; x < last.left; x += cellSize.x) {
        add(createCell(
          position: Vector2(x, y),
          size: cellSize,
        ));
      }
      for (var x = last.right; x < viewport.right; x += cellSize.x) {
        add(createCell(
          position: Vector2(x, y),
          size: cellSize,
        ));
      }
    }
    _lastViewport = viewport;
  }

  @override
  FutureOr<void> onLoad() {
    _camera = findGame()?.camera;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _updateGrid();
  }
}
