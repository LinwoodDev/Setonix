import 'dart:ui' as ui;

import 'package:flutter_test/flutter_test.dart';
import 'package:setonix/board/ui_image.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('blank board image is transparent', () async {
    final image = await createBoardUiImage(selection: false);
    addTearDown(image.dispose);
    expect(image.width, 36);
    expect(image.height, 36);
    final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    expect(data!.buffer.asUint8List(), everyElement(0));
  });

  test('selection image keeps a white border and transparent center', () async {
    final image = await createBoardUiImage(selection: true);
    addTearDown(image.dispose);
    final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    final pixels = data!.buffer.asUint8List();
    List<int> pixel(int x, int y) {
      final offset = (y * image.width + x) * 4;
      return pixels.sublist(offset, offset + 4);
    }

    expect(image.width, 36);
    expect(image.height, 36);
    for (final point in [(0, 0), (3, 18), (18, 3), (32, 18), (18, 32)]) {
      expect(pixel(point.$1, point.$2), [255, 255, 255, 255]);
    }
    for (final point in [(4, 4), (18, 18), (31, 31)]) {
      expect(pixel(point.$1, point.$2), [0, 0, 0, 0]);
    }
  });
}
