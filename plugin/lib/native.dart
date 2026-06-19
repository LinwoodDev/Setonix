import 'dart:io';

import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:path/path.dart' as p;

/// Load the setonix_plugin library from the lib/ directory relative to the executable.
/// This is used for compiled server binaries where the library is bundled alongside sqlite3.
Future<ExternalLibrary?> loadExternalPluginLibrary() async {
  try {
    // Get the directory containing the executable
    final executablePath = Platform.resolvedExecutable;
    final executableDir = p.dirname(executablePath);
    // Look for the library in ../lib/ relative to the executable (same as sqlite3)
    final libDir = p.join(executableDir, '..', 'lib');

    String libraryName;
    if (Platform.isWindows) {
      libraryName = 'setonix_plugin.dll';
    } else if (Platform.isMacOS) {
      libraryName = 'libsetonix_plugin.dylib';
    } else {
      libraryName = 'libsetonix_plugin.so';
    }

    final libraryPath = p.join(libDir, libraryName);
    if (await File(libraryPath).exists()) {
      return ExternalLibrary.open(libraryPath);
    }
    // Fallback: try the default loading mechanism
    return null;
  } catch (_) {
    // Fallback: try the default loading mechanism
    return null;
  }
}
