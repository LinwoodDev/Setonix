import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeck/models/server.dart';

class ConnectGameDialog extends StatelessWidget {
  const ConnectGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var currentAddress = '';
    var port = kDefaultPort;
    bool secure = false;
    return AlertDialog(
      title: Text(AppLocalizations.of(context).create),
      scrollable: true,
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(builder: (context, setState) => CheckboxListTile(
              title: Text(AppLocalizations.of(context).secure),
              value: secure,
              onChanged: (value) => setState(() => secure = value ?? secure),
            )),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).address,
                filled: true,
                icon: const PhosphorIcon(PhosphorIconsLight.textT),
              ),
              initialValue: currentAddress,
              onChanged: (value) => currentAddress = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).port,
                filled: true,
                icon: const PhosphorIcon(PhosphorIconsLight.textT),
              ),
              initialValue: port.toString(),
              onChanged: (value) => port = int.tryParse(value) ?? port,
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
            scheme: secure ? 'wss' : 'ws',
            host: currentAddress,
            port: port,
            path: '/connect',
          )),
          child: Text(AppLocalizations.of(context).create),
        ),
      ],
    );
  }
}
