import 'dart:io';

import 'package:generate_leap/generate_leap.dart';

Future<void> main() => generate(Directory.current);

Future<void> generate(Directory root) async {
  final dir = Directory('${root.path}/app/pack');
  await zipReproducable(dir, '${root.path}/app/assets/pack.stnx');
  // Copy to server/packs
  final file = File('${root.path}/app/assets/pack.stnx');
  final output = File('${root.path}/server/packs/core.stnx');
  await output.parent.create(recursive: true);
  await output.writeAsBytes(await file.readAsBytes());
}
