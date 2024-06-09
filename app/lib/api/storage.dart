import 'dart:io';

import 'package:path_provider/path_provider.dart';

const quokkaSubDirectory = '/Linwood/Quokka';

Future<String> getQuokkaDirectory() async {
  String? path;
  if (Platform.isAndroid) {
    path ??= (await getExternalStorageDirectory())?.path;
  }
  path ??= (await getApplicationDocumentsDirectory()).path;
  path += quokkaSubDirectory;
  return path;
}
