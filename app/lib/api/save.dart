import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:quokka/models/data.dart';

Future<void> exportData(BuildContext context, QuokkaData data, String name) =>
    exportFile(
      context: context,
      bytes: data.exportAsBytes(),
      fileExtension: 'qka',
      fileName: name,
      label: AppLocalizations.of(context).game,
      mimeType: 'application/octet-stream',
      uniformTypeIdentifier: 'dev.linwood.quokka.pack',
    );
