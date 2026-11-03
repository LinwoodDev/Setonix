import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:native_toolchain_rust/native_toolchain_rust.dart';

import 'package:generate_leap/native.dart';

void main(List<String> args) async {
  await build(args, (input, output) async {
    await RustBuilder(
      assetName: 'src/rust/frb_generated.io.dart',
      cratePath: 'rust',
      extraCargoBuildArgs: const ['--locked'],
      extraCargoEnvironmentVariables: {
        ...reproducibleEnvironment(
          sourceRoot: input.packageRoot.resolve('../'),
          prefix: '/setonix',
          outputDirectory: input.outputDirectory.resolve('target/'),
          windows:
              input.config.buildCodeAssets &&
              input.config.code.targetOS == OS.windows,
        ),
        // Keep Rust and Luau's C++ code on Flutter's iOS deployment target.
        if (input.config.buildCodeAssets &&
            input.config.code.targetOS == OS.iOS)
          'IPHONEOS_DEPLOYMENT_TARGET':
              '${input.config.code.iOS.targetVersion}.0',
      },
    ).run(input: input, output: output);

    if (input.config.buildCodeAssets &&
        input.config.code.targetOS == OS.android) {
      // Luau links against the NDK's shared C++ runtime. RustBuilder only
      // bundles the Rust library, so declare its runtime dependency as well.
      final config = input.config.code;
      final triple = switch (config.targetArchitecture) {
        Architecture.arm => 'arm-linux-androideabi',
        Architecture.arm64 => 'aarch64-linux-android',
        Architecture.x64 => 'x86_64-linux-android',
        _ => throw UnsupportedError(
          'Unsupported Android architecture: ${config.targetArchitecture}',
        ),
      };
      final runtime = config.cCompiler!.compiler.resolve(
        '../sysroot/usr/lib/$triple/libc++_shared.so',
      );
      output.assets.code.add(
        CodeAsset(
          package: input.packageName,
          name: 'libc++_shared.so',
          linkMode: DynamicLoadingBundled(),
          file: runtime,
        ),
      );
      output.dependencies.add(runtime);
    }
  });
}
