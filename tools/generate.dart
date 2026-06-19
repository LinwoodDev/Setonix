import 'dart:io';

import 'package:generate_leap/generate_leap.dart';

Future<void> main() async {
  final dir = Directory('app/pack');
  await zipReproducable(dir, 'app/assets/pack.stnx');
  // Copy to server/packs
  final file = File('app/assets/pack.stnx');
  final output = File('server/packs/core.stnx');
  await output.parent.create(recursive: true);
  await output.writeAsBytes(await file.readAsBytes());
}
