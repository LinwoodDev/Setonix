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
  });
}
