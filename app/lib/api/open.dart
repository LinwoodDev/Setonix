import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix/main.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix/services/file_system.dart';
import 'package:url_launcher/url_launcher.dart';

const kLaunchHost = 'launch.setonix.linwood.dev';

Uri getLaunchUri({
  String? path,
  List<String>? pathSegments,
  String? fragment,
  String? query,
  Map<String, dynamic>? queryParameters,
  String? userInfo,
}) => Uri(
  scheme: 'https',
  host: kLaunchHost,
  path: path,
  pathSegments: pathSegments,
  fragment: fragment,
  query: query,
  queryParameters: queryParameters,
  userInfo: userInfo,
);

Uri getConnectUri(String url, [String? type]) => getLaunchUri(
  pathSegments: ['connect'],
  queryParameters: {'url': url, 'type': ?type},
);

Uri parseConnectUri(Uri uri) {
  if (uri.host != kLaunchHost) {
    return uri;
  }
  final param = uri.queryParameters['url'];
  if (param == null) {
    return uri;
  }
  return Uri.parse(param);
}

Future<bool> openReleaseNotes() {
  return launchUrl(
    Uri(
      scheme: 'https',
      host: 'go.linwood.dev',
      pathSegments: ['setonix', applicationMinorVersion],
    ),
    mode: LaunchMode.externalApplication,
  );
}

Future<bool> openHelp(List<String> pageLocation, [String? fragment]) {
  return launchUrl(
    Uri(
      scheme: 'https',
      host: 'setonix.linwood.dev',
      fragment: fragment,
      pathSegments: ['docs', 'v1', ...pageLocation],
    ),
  );
}

Future<SetonixFile?> openFile() async {
  final result = await FilePicker.pickFiles(
    allowedExtensions: ['stnx'],
    withData: true,
  );
  if (result == null) return null;
  final file = result.files.firstOrNull;
  if (file == null) return null;
  final bytes = file.bytes;
  if (bytes == null) return null;
  final data = SetonixFile(bytes, file.name);
  return data;
}

Future<void> importFile(
  BuildContext context,
  SetonixFileSystem fileSystem,
) async {
  final data = await openFile();
  if (data == null) return;
  if (context.mounted) return importFileData(context, fileSystem, data);
}

Future<SetonixFile> getCorePack() async => SetonixFile(
  (await rootBundle.load('assets/pack.stnx')).buffer.asUint8List(),
  kCorePackId,
);

Future<void> importFileData(
  BuildContext context,
  SetonixFileSystem fileSystem,
  SetonixFile file,
) async {
  final data = file.load();
  final metadata = data.getMetadataOrDefault();
  final type = metadata.type;
  final loc = AppLocalizations.of(context);
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(switch (type) {
        SetonixFileType.pack => loc.importPack,
        SetonixFileType.game => loc.importGame,
        SetonixFileType.template => loc.importTemplate,
        SetonixFileType.accounts => loc.importAccounts,
      }),
      content: Text(switch (type) {
        SetonixFileType.pack => loc.importPackDescription,
        SetonixFileType.game => loc.importGameDescription,
        SetonixFileType.template => loc.importTemplateDescription,
        SetonixFileType.accounts => loc.importAccountsDescription,
      }),
      actions: [
        TextButton.icon(
          onPressed: () => Navigator.of(context).pop(false),
          label: Text(loc.cancel),
          icon: Icon(PhosphorIconsLight.prohibit),
        ),
        ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          label: Text(loc.import),
          icon: Icon(PhosphorIconsLight.boxArrowDown),
        ),
      ],
    ),
  );
  if (!(result ?? false)) return;
  final id = file.identifier;
  switch (type) {
    case SetonixFileType.pack:
      await fileSystem.packSystem.updateFile(id, file);
    case SetonixFileType.template:
      await fileSystem.templateSystem.createFile(metadata.name, data);
    case SetonixFileType.game:
      await fileSystem.worldSystem.createFile(metadata.name, data);
    case SetonixFileType.accounts:
      await fileSystem.importAccountsFromData(data);
  }
}
