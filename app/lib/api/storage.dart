import 'dart:io';

import 'package:path_provider/path_provider.dart';

const setonixSubDirectory = '/Linwood/Setonix';

Future<String> getSetonixDirectory() async {
  String? path;
  if (Platform.isAndroid) {
    path ??= (await getExternalStorageDirectory())?.path;
  }
  path ??= (await getApplicationDocumentsDirectory()).path;
  path += setonixSubDirectory;
  return path;
}
