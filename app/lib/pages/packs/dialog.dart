import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';

class PacksDialog extends StatelessWidget {
  const PacksDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).packs),
      content: const Column(
        children: [],
      ),
    );
  }
}
