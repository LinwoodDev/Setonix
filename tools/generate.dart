import 'dart:io';

import 'package:generate_leap/generate_leap.dart';

Future<void> main() async {
  final dir = Directory('app/pack');
  await zipReproducable(dir, 'app/assets/pack.stnx');
}
