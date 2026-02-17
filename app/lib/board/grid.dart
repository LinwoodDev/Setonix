import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/board/cell.dart';
import 'package:setonix/board/game.dart';
import 'package:setonix/helpers/vector.dart';

class BoardGrid extends PositionComponent
    with
        HasGameReference<BoardGame>,
        FlameBlocListenable<WorldBloc, ClientWorldState> {
  final Vector2 cellSize;
  static const _padding = 3.0;
  Rect? _lastViewport;
  bool _forceUpdate = false;

  BoardGrid({required this.cellSize});

  @override
  bool listenWhen(ClientWorldState previousState, ClientWorldState newState) {
    return previousState.table != newState.table;
  }

  @override
  void onNewState(ClientWorldState state) {
    _forceUpdate = true;
    _lastViewport = null;
  }

  Rect get viewport {
    final Rect viewport = game.camera.visibleWorldRect;
    final currentSize = cellSize;
    return Rect.fromLTRB(
      (viewport.left / currentSize.x - _padding).floor() * currentSize.x,
      (viewport.top / currentSize.y - _padding).floor() * currentSize.y,
      (viewport.right / currentSize.x + _padding).ceil() * currentSize.x,
      (viewport.bottom / currentSize.y + _padding).ceil() * currentSize.y,
    );
  }

  bool shouldReset() {
    // Check if the viewport is different by one pixel
    final Rect viewport = this.viewport;
    final Rect lastViewport = _lastViewport ?? Rect.zero;
    final bool shouldReset = viewport != lastViewport;
    return shouldReset || _forceUpdate;
  }

  void _updateGrid() {
    if (!shouldReset()) return;
    _forceUpdate = false;
    final viewport = this.viewport;
    final currentSize = cellSize;
    // Remove components that are out of the viewport
    removeAll(
      children.where((element) {
        if (element is! PositionComponent) return false;
        final Rect bounds = element.toRect();
        return !bounds.overlaps(viewport);
      }),
    );
    final last = _lastViewport ?? Rect.zero;
    final existingPositions = children
        .whereType<GameCell>()
        .map((e) => e.position)
        .fold<Set<Vector2>>({}, (set, pos) {
          set.add(pos);
          return set;
        });

    void tryAddCell(Vector2 position) {
      final definition = (position.clone()..divide(cellSize)).toDefinition();
      final parentDefinition = bloc.state.getLocalParentCell(definition);
      final parentPosition = parentDefinition.toVector()..multiply(cellSize);

      if (!existingPositions.contains(parentPosition)) {
        add(_createCell(position: parentPosition, size: currentSize));
        existingPositions.add(parentPosition);
      }
    }

    // Add components that are in the viewport
    // Top and bottom
    for (var x = viewport.left; x < viewport.right; x += currentSize.x) {
      for (var y = viewport.top; y < last.top; y += currentSize.y) {
        tryAddCell(Vector2(x, y));
      }
      for (var y = last.bottom; y < viewport.bottom; y += currentSize.y) {
        tryAddCell(Vector2(x, y));
      }
    }
    // Left and right
    for (var y = last.top; y < last.bottom; y += currentSize.y) {
      for (var x = viewport.left; x < last.left; x += currentSize.x) {
        tryAddCell(Vector2(x, y));
      }
      for (var x = last.right; x < viewport.right; x += currentSize.x) {
        tryAddCell(Vector2(x, y));
      }
    }

    _lastViewport = viewport;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _updateGrid();
  }

  @override
  void onParentResize(Vector2 maxSize) {
    super.onParentResize(maxSize);
    _lastViewport = null;
  }

  Component _createCell({required Vector2 position, required Vector2 size}) =>
      GameCell(position: position, size: size);
}
