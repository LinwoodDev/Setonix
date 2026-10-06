import 'dart:ui';

/// Keep the visible area inside the table, centering axes where the viewport
/// is larger than the board so small tables remain reachable at every zoom.
Offset constrainBoardCamera(Rect board, Size viewport, Offset position) {
  double constrain(double value, double start, double end, double extent) {
    if (extent >= end - start) return (start + end) / 2;
    return value.clamp(start + extent / 2, end - extent / 2);
  }

  return Offset(
    constrain(position.dx, board.left, board.right, viewport.width),
    constrain(position.dy, board.top, board.bottom, viewport.height),
  );
}
