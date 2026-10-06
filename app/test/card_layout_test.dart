import 'package:flutter_test/flutter_test.dart';
import 'package:setonix/board/card_layout.dart';

void main() {
  List<double> positions(
    int count, {
    bool fill = false,
    bool reverse = false,
  }) => distributeCardPositions(
    extent: 768,
    cardExtent: 128,
    count: count,
    fillVariableSpace: fill,
    reverse: reverse,
  );

  test('compresses long hands and keeps every card inside the row', () {
    for (final count in [7, 21, 52]) {
      final centers = positions(count);
      expect(centers, hasLength(count));
      expect(centers.first, closeTo(64, 0.00001));
      expect(centers.last, closeTo(704, 0.00001));
      expect(centers, orderedEquals([...centers]..sort()));
    }
  });

  test('reverses both compact and full-width layouts', () {
    for (final fill in [false, true]) {
      expect(
        positions(4, fill: fill, reverse: true),
        positions(4, fill: fill).reversed.toList(),
      );
    }
  });
}
