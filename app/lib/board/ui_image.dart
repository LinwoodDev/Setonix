import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

/// Creates the board's blank or selection image without a GPU pixel readback.
/// Picture.toImage uses WebGL readPixels in CanvasKit, which Firefox's canvas
/// privacy protection can block before the user interacts with the page.
Future<ui.Image> createBoardUiImage({required bool selection}) {
  const size = 36;
  const border = 4;
  final pixels = Uint8List(size * size * 4);
  if (selection) {
    for (var y = 0; y < size; y++) {
      for (var x = 0; x < size; x++) {
        if (x < border ||
            x >= size - border ||
            y < border ||
            y >= size - border) {
          final offset = (y * size + x) * 4;
          pixels.fillRange(offset, offset + 4, 255);
        }
      }
    }
  }
  final result = Completer<ui.Image>();
  ui.decodeImageFromPixels(
    pixels,
    size,
    size,
    ui.PixelFormat.rgba8888,
    result.complete,
  );
  return result.future;
}
