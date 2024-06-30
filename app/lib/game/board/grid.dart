import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class BoardGrid extends Component with HasGameRef {
  final Vector2 cellSize;
  Rect? _lastViewport;
  final PositionComponent Function(
      {required Vector2 position, required Vector2 size}) createCell;

  BoardGrid({
    required this.cellSize,
    required this.createCell,
  });

  Rect get viewport {
    final Rect viewport = game.camera.visibleWorldRect;
    return Rect.fromLTRB(
      (viewport.left / cellSize.x).floor() * cellSize.x,
      (viewport.top / cellSize.y).floor() * cellSize.y,
      (viewport.right / cellSize.x).ceil() * cellSize.x,
      (viewport.bottom / cellSize.y).ceil() * cellSize.y,
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
    final viewport = this.viewport;
    // Remove components that are out of the viewport
    removeAll(children);
    for (var y = viewport.top; y < viewport.bottom; y += cellSize.y) {
      for (var x = viewport.left; x < viewport.right; x += cellSize.x) {
        add(createCell(
          position: Vector2(x, y),
          size: cellSize,
        ));
      }
    }
    _lastViewport = viewport;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _updateGrid();
  }
}
