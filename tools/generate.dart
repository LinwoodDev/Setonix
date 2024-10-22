import 'dart:io';

import 'package:archive/archive_io.dart';

Future<void> main() async {
  final dir = Directory('app/pack');
  await zipDirectory(dir, 'app/assets/pack.stnx');
}

Future<void> zipDirectory(Directory dir, String path) async {
  final archive = Archive();

  Future<void> addDirectory(Directory dir, String prefix) async {
    final files = List.from(await dir.list().toList())
      ..sort((a, b) {
        if (a is Directory && b is File) {
          return -1;
        } else if (a is File && b is Directory) {
          return 1;
        } else {
          return a.path.compareTo(b.path);
        }
      });
    for (final file in files) {
      if (file is File) {
        final filename = file.path.substring(dir.path.length + 1);
        final fileData = await file.readAsBytes();
        archive.addFile(
            ArchiveFile('$prefix/$filename', fileData.length, fileData)
              ..lastModTime = 0);
      } else if (file is Directory) {
        await addDirectory(
            file, '$prefix/${file.path.substring(dir.path.length + 1)}');
      }
    }
  }

  await addDirectory(dir, '');
  final encoder = ZipEncoder();
  final zip = encoder.encode(archive);
  final file = File(path);
  await file.writeAsBytes(zip!);
}
