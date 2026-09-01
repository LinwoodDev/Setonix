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

Future<String?> requestAccountBackupPassphrase(
  BuildContext context, {
  required bool confirm,
}) async {
  final passphraseController = TextEditingController();
  final confirmationController = TextEditingController();
  String? error;
  final result = await showDialog<String>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        final loc = AppLocalizations.of(context);
        return AlertDialog(
          title: Text(loc.accountBackupPassphrase),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(loc.accountBackupPassphraseDescription),
              const SizedBox(height: 16),
              TextField(
                controller: passphraseController,
                obscureText: true,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: loc.accountBackupPassphrase,
                ),
              ),
              if (confirm)
                TextField(
                  controller: confirmationController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: loc.accountBackupConfirmPassphrase,
                    errorText: error,
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(loc.cancel),
            ),
            FilledButton(
              onPressed: () {
                final passphrase = passphraseController.text;
                if (passphrase.isEmpty) return;
                if (confirm && passphrase != confirmationController.text) {
                  setState(() => error = loc.accountBackupPassphraseMismatch);
                  return;
                }
                Navigator.pop(context, passphrase);
              },
              child: Text(loc.confirm),
            ),
          ],
        );
      },
    ),
  );
  passphraseController.dispose();
  confirmationController.dispose();
  return result;
}

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
  final result = await FilePicker.pickFiles(allowedExtensions: ['stnx']);
  final file = result.firstOrNull;
  if (file == null) return null;
  final bytes = await file.readAsBytes();
  final data = SetonixFile(bytes);
  return data;
}

String _sanitizeImportedName(String name, String fallback) {
  var sanitized = name.trim();
  if (sanitized.isEmpty) {
    sanitized = fallback.trim();
  }
  sanitized = sanitized.split('/').last.split(r'\').last.trim();
  const suffix = '.stnx';
  if (sanitized.toLowerCase().endsWith(suffix)) {
    sanitized = sanitized.substring(0, sanitized.length - suffix.length);
  }
  if (sanitized.isEmpty || sanitized == '.' || sanitized == '..') {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
  return sanitized;
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
      await fileSystem.templateSystem.createFile(
        _sanitizeImportedName(metadata.name, file.identifier),
        data,
      );
    case SetonixFileType.game:
      await fileSystem.worldSystem.createFile(
        _sanitizeImportedName(metadata.name, file.identifier),
        data,
      );
    case SetonixFileType.accounts:
      if (!context.mounted) return;
      final passphrase = await requestAccountBackupPassphrase(
        context,
        confirm: false,
      );
      if (passphrase == null) return;
      try {
        await fileSystem.importAccountsFromData(data, passphrase);
      } catch (error) {
        if (!context.mounted) return;
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context).error),
            content: Text(error.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context).close),
              ),
            ],
          ),
        );
      }
  }
}
