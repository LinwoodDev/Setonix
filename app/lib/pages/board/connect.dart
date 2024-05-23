import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quokka/services/network.dart';

class ConnectGameDialog extends StatelessWidget {
  final TextEditingController _urlController = TextEditingController();

  ConnectGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).connect),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).url,
              filled: true,
            ),
            controller: _urlController,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<NetworkingService>().startClient(Uri.parse(
                  _urlController.text,
                ));
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context).create),
        ),
      ],
    );
  }
}
