import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart' as fs;
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

Future<void> importFile(
  BuildContext context,
  SetonixFileSystem fileSystem,
) async {
  final result = await fs.openFile(
    acceptedTypeGroups: [
      fs.XTypeGroup(
        label: AppLocalizations.of(context).packs,
        extensions: const ['stnx'],
        uniformTypeIdentifiers: const ['dev.linwood.setonix.pack'],
        mimeTypes: const ['application/octet-stream', 'application/zip'],
      ),
    ],
  );
  if (result == null) return;
  final bytes = await result.readAsBytes();
  final data = SetonixFile(bytes);
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
        FileType.pack => loc.importPack,
        FileType.game => loc.importGame,
        FileType.template => loc.importTemplate,
        FileType.accounts => loc.importAccounts,
      }),
      content: Text(switch (type) {
        FileType.pack => loc.importPackDescription,
        FileType.game => loc.importGameDescription,
        FileType.template => loc.importTemplateDescription,
        FileType.accounts => loc.importAccountsDescription,
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
    case FileType.pack:
      await fileSystem.packSystem.updateFile(id, file);
    case FileType.template:
      await fileSystem.templateSystem.createFile(metadata.name, data);
    case FileType.game:
      await fileSystem.worldSystem.createFile(metadata.name, data);
    case FileType.accounts:
      await fileSystem.importAccountsFromData(data);
  }
}
