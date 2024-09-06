import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart' as fs;
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quokka/main.dart';
import 'package:quokka_api/quokka_api.dart';
import 'package:quokka/services/file_system.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> openReleaseNotes() {
  return launchUrl(
      Uri(
          scheme: 'https',
          host: 'go.linwood.dev',
          pathSegments: ['quokka', applicationMinorVersion]),
      mode: LaunchMode.externalApplication);
}

Future<bool> openHelp(List<String> pageLocation, [String? fragment]) {
  return launchUrl(
    Uri(
        scheme: 'https',
        host: 'quokka.linwood.dev',
        fragment: fragment,
        pathSegments: ['docs', 'v1', ...pageLocation]),
  );
}

Future<void> importFile(
    BuildContext context, QuokkaFileSystem fileSystem) async {
  final result = await fs.openFile(
    acceptedTypeGroups: [
      fs.XTypeGroup(
        label: AppLocalizations.of(context).packs,
        extensions: const ['qka'],
        uniformTypeIdentifiers: const ['dev.linwood.quokka.pack'],
        mimeTypes: const ['application/octet-stream', 'application/zip'],
      )
    ],
  );
  if (result == null) return;
  final bytes = await result.readAsBytes();
  final data = QuokkaData.fromData(bytes);
  if (context.mounted) return importFileData(context, fileSystem, data);
}

Future<QuokkaData?> getCorePack() async => QuokkaData.fromData(
    (await rootBundle.load('assets/pack.qka')).buffer.asUint8List());

Future<void> importFileData(
    BuildContext context, QuokkaFileSystem fileSystem, QuokkaData data) async {
  final metadata = data.getMetadataOrDefault();
  final type = metadata.type;
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(switch (type) {
        FileType.pack => AppLocalizations.of(context).importPack,
        FileType.game => AppLocalizations.of(context).importGame,
        FileType.template => AppLocalizations.of(context).importTemplate,
      }),
      content: Text(switch (type) {
        FileType.pack => AppLocalizations.of(context).importPackDescription,
        FileType.game => AppLocalizations.of(context).importGameDescription,
        FileType.template =>
          AppLocalizations.of(context).importTemplateDescription,
      }),
    ),
  );
  if (!(result ?? false)) return;
  final namespace = metadata.namespace;
  switch (type) {
    case FileType.pack:
      await fileSystem.packSystem.updateFile(namespace, data);
    case FileType.template:
      await fileSystem.templateSystem.updateFile(namespace, data);
    case FileType.game:
      await fileSystem.worldSystem.createFile(metadata.name, data);
  }
}
