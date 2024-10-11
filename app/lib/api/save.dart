import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:setonix_api/setonix_api.dart';

Future<void> exportData(BuildContext context, SetonixData data, String name) =>
    exportFile(
      context: context,
      bytes: data.exportAsBytes(),
      fileExtension: 'stnx',
      fileName: name,
      label: AppLocalizations.of(context).game,
      mimeType: 'application/octet-stream',
      uniformTypeIdentifier: 'dev.linwood.setonix.pack',
    );
