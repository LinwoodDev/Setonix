import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:setonix_api/setonix_api.dart';

class EditInfoDialog extends StatelessWidget {
  final FileMetadata value;
  const EditInfoDialog({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    var info = value;
    return ResponsiveAlertDialog(
      constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
      content: ListView(
        shrinkWrap: true,
        children: [
          TextFormField(
            decoration: InputDecoration(
                filled: true, labelText: AppLocalizations.of(context).name),
            onChanged: (value) => info = info.copyWith(name: value),
            initialValue: info.name,
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: AppLocalizations.of(context).description,
            ),
            maxLines: 3,
            onChanged: (value) => info = info.copyWith(description: value),
            initialValue: info.description,
          )
        ],
      ),
      title: Text(AppLocalizations.of(context).editInfo),
      actions: [
        TextButton.icon(
          label: Text(AppLocalizations.of(context).cancel),
          icon: const Icon(PhosphorIconsLight.prohibit),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton.icon(
          label: Text(AppLocalizations.of(context).edit),
          icon: const Icon(PhosphorIconsLight.pencil),
          onPressed: () => Navigator.of(context).pop(info),
        ),
      ],
    );
  }
}
