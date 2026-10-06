import 'dart:math' as math;

/// Places cards within a merged cell, keeping a compact hand at most one
/// card-width apart and compressing it only when it no longer fits.
List<double> distributeCardPositions({
  required double extent,
  required double cardExtent,
  required int count,
  required bool fillVariableSpace,
  required bool reverse,
}) {
  if (count <= 0) return const [];
  if (count == 1) return [extent / 2];
  final available = math.max(0.0, extent - cardExtent);
  final step = fillVariableSpace
      ? available / (count - 1)
      : math.min(cardExtent, available / (count - 1));
  return List.generate(count, (i) {
    final index = reverse ? count - 1 - i : i;
    return extent / 2 + (index - (count - 1) / 2) * step;
  });
}
