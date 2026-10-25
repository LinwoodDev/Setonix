import 'dart:io';

import 'package:generate_leap/flutter_build.dart';

import 'build_web_service_worker.dart';
import 'generate.dart' as core_pack;

Future<void> main(List<String> args) =>
    runFlutterBuild(args, _SetonixBuild.new);

class _SetonixBuild extends FlutterBuild {
  _SetonixBuild(super.options)
    : super(
        name: 'setonix',
        root: File.fromUri(Platform.script).parent.parent,
        appDirectory: 'app',
      );

  @override
  String get defaultFlavor => 'production';
  @override
  File get flutterVersionFile => file('app/pubspec.yaml');
  @override
  RustBuild get rust => RustBuild(
    crate: Directory('${root.path}/plugin/rust'),
    sourceRoot: root,
    targets: {...super.rustTargets, 'web': 'wasm32-unknown-unknown'},
  );
  @override
  List<String> get platforms => [...super.platforms, 'server'];
  @override
  String get package => platform == 'server' ? 'server' : super.package;
  @override
  Iterable<File> get downloadedInputs {
    if (platform != 'server') return const [];
    final generated = Directory('${root.path}/server/.dart_tool');
    if (!generated.existsSync()) return const [];
    return generated
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .where((file) {
          final path = file.path.replaceAll('\\', '/');
          return path.contains('/sqlite3/') &&
              RegExp(r'/download-[0-9a-f]{8}/[^/]+$').hasMatch(path);
        });
  }

  @override
  List<String> get inputFiles => [
    'tools/pubspec.yaml',
    'tools/pubspec.lock',
    'tools/build_offline.dart',
    if (file('tools/pubspec_overrides.yaml').existsSync())
      'tools/pubspec_overrides.yaml',
    'api/pubspec.yaml',
    'plugin/pubspec.yaml',
    'plugin/pubspec.lock',
    'plugin/rust/Cargo.toml',
    'plugin/rust/Cargo.lock',
    'plugin/hook/build.dart',
    'rust-toolchain.toml',
    'tools/generate.dart',
    'tools/build_web_service_worker.dart',
    if (platform == 'web') 'plugin/web/build.sh',
    if (platform == 'server') ...['server/pubspec.yaml', 'server/pubspec.lock'],
  ];

  @override
  Future<void> checkTools(Map<String, String> env) async {
    if (platform != 'web') return;
    final sdk = env['WASI_SDK_PATH'];
    final version = sdk == null ? null : File('$sdk/VERSION');
    if (version == null ||
        !version.existsSync() ||
        version.readAsLinesSync().first != '34.0') {
      throw StateError(
        'Set WASI_SDK_PATH to WASI SDK 34.0 before preparing/building web.',
      );
    }
    final bindings = await command(
      env['WASM_BINDGEN'] ?? 'wasm-bindgen',
      ['--version'],
      env,
      capture: true,
    );
    if (bindings.trim() != 'wasm-bindgen 0.2.129') {
      throw StateError(
        'Install wasm-bindgen-cli 0.2.129, matching Cargo.lock.',
      );
    }
  }

  @override
  Future<void> beforeBuild(
    Map<String, String> env,
    List<String> targets,
  ) async {
    await core_pack.generate(root);
    if (platform == 'web') {
      await command('bash', [file('plugin/web/build.sh').path], env);
    }
  }

  @override
  Future<void> cleanExtraOutputs() async {
    if (platform != 'web') return;
    final generated = Directory('${root.path}/app/web/pkg');
    if (generated.existsSync()) generated.deleteSync(recursive: true);
  }

  @override
  Future<void> afterBuild(FileSystemEntity artifact) async {
    if (platform == 'web') await buildServiceWorker(artifact as Directory);
  }

  @override
  Future<FileSystemEntity?> buildCustomTarget(
    Map<String, String> env,
    List<String> targets,
  ) async {
    if (platform != 'server') return null;
    await command(Platform.resolvedExecutable, [
      'build',
      'cli',
      '--target=bin/setonix_server.dart',
    ], env);
    final arch = targets.single.split('-').last;
    final bundle = Directory(
      '${root.path}/server/build/cli/${Platform.operatingSystem}_$arch/bundle',
    );
    if (!bundle.existsSync()) {
      throw StateError('Missing server bundle: ${bundle.path}');
    }
    final packs = Directory('${bundle.path}/packs')..createSync();
    file('server/packs/core.stnx').copySync('${packs.path}/core.stnx');
    Directory('${bundle.path}/scripts').createSync();
    return bundle;
  }
}
