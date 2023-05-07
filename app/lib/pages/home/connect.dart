import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:town/models/server.dart';

class ConnectGameDialog extends StatelessWidget {
  const ConnectGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var currentAddress = '';
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
                labelText: AppLocalizations.of(context).address,
                filled: true,
                icon: const PhosphorIcon(PhosphorIconsLight.textT),
              ),
              initialValue: currentAddress,
              onChanged: (value) => currentAddress = value,
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
          onPressed: () => Navigator.of(context).pop(Uri(
            scheme: 'ws',
            host: currentAddress,
            port: kDefaultPort,
          )),
          child: Text(AppLocalizations.of(context).create),
        ),
      ],
    );
  }
}
