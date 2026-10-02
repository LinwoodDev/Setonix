import 'dart:io';

/// Apply native package names before building from a clean checkout.
void main(List<String> arguments) {
  const platforms = {'windows', 'linux', 'macos', 'ios'};
  if (arguments.length != 2 || !platforms.contains(arguments[1])) {
    stderr.writeln(
      'Usage: dart run tools/apply_branding.dart '
      '<production|nightly> <windows|linux|macos|ios>',
    );
    exitCode = 64;
    return;
  }
  final flavor = arguments[0];
  final platform = arguments[1];
  if (flavor == 'production') return;
  if (!const {'nightly', 'development', 'dev'}.contains(flavor)) {
    stderr.writeln('Unsupported branding flavor: $flavor');
    exitCode = 64;
    return;
  }
  final app = File.fromUri(Platform.script).parent.parent.uri.resolve('app/');
  void replace(String path, Map<String, String> replacements) {
    final file = File.fromUri(app.resolve(path));
    var content = file.readAsStringSync();
    for (final MapEntry(key: from, value: to) in replacements.entries) {
      content = content.replaceAll(to, from);
      if (!content.contains(from)) {
        throw StateError('Expected branding value missing in $path: $from');
      }
      content = content.replaceAll(from, to);
    }
    file.writeAsStringSync(content);
  }

  switch (platform) {
    case 'windows':
      replace('pubspec.yaml', {
        'display_name: Linwood Setonix':
            'display_name: Linwood Setonix Nightly',
        'identity_name: LinwoodDevelopment.linwood-setonix':
            'identity_name: LinwoodDevelopment.linwood-setonix-nightly',
      });
    case 'linux':
      replace(
        'linux/debian/usr/share/applications/dev.linwood.setonix.desktop',
        {'Name=Linwood Setonix': 'Name=Linwood Setonix Nightly'},
      );
      replace(
        'linux/debian/usr/share/metainfo/dev.linwood.setonix.appdata.xml',
        {
          '<name>Linwood Setonix</name>':
              '<name>Linwood Setonix Nightly</name>',
        },
      );
      replace('linux/rpm/linwood-setonix.desktop', {
        'Name=Linwood Setonix': 'Name=Linwood Setonix Nightly',
      });
    case 'macos':
      replace('macos/Runner/Configs/AppInfo.xcconfig', {
        'PRODUCT_BUNDLE_IDENTIFIER = dev.linwood.setonix':
            'PRODUCT_BUNDLE_IDENTIFIER = dev.linwood.setonix.nightly',
        'APP_DISPLAY_NAME = Linwood Setonix':
            'APP_DISPLAY_NAME = Linwood Setonix Nightly',
      });
    case 'ios':
      replace('ios/Runner/Info.plist', {
        '<string>Setonix</string>': '<string>Setonix Nightly</string>',
      });
      replace('ios/Runner.xcodeproj/project.pbxproj', {
        'PRODUCT_BUNDLE_IDENTIFIER = dev.linwood.setonix;':
            'PRODUCT_BUNDLE_IDENTIFIER = dev.linwood.setonix.nightly;',
      });
  }
  stdout.writeln('Applied Setonix Nightly branding for $platform.');
}
