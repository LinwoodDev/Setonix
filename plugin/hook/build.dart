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
      extraCargoEnvironmentVariables: reproducibleEnvironment(
        sourceRoot: input.packageRoot.resolve('../'),
        prefix: '/setonix',
        outputDirectory: input.outputDirectory.resolve('target/'),
        windows:
            input.config.buildCodeAssets &&
            input.config.code.targetOS == OS.windows,
      ),
    ).run(input: input, output: output);
  });
}
