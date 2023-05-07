import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:town/models/server.dart';

class CreateGameDialog extends StatelessWidget {
  const CreateGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var currentProperty = const GameProperty();
    return AlertDialog(
      title: Text(AppLocalizations.of(context).create),
      scrollable: true,
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).name,
                filled: true,
                icon: const PhosphorIcon(PhosphorIconsLight.textT),
              ),
              initialValue: currentProperty.name,
              onChanged: (value) =>
                  currentProperty = currentProperty.copyWith(name: value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).description,
                border: const OutlineInputBorder(),
                icon: const PhosphorIcon(PhosphorIconsLight.fileText),
              ),
              initialValue: currentProperty.description,
              onChanged: (value) => currentProperty =
                  currentProperty.copyWith(description: value),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(currentProperty),
          child: Text(AppLocalizations.of(context).create),
        ),
      ],
    );
  }
}
