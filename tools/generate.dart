import 'dart:io';

import 'package:archive/archive_io.dart';

Future<void> main() async {
  final encoder = ZipFileEncoder();
  final dir = Directory('app/pack');
  await encoder.zipDirectoryAsync(dir, filename: 'app/assets/pack.qka');
}
