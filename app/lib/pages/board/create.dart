import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quokka/services/network.dart';

class CreateGameDialog extends StatelessWidget {
  final TextEditingController _portController = TextEditingController();

  CreateGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).create),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).port,
              hintText: kDefaultPort.toString(),
              filled: true,
            ),
            controller: _portController,
            keyboardType: TextInputType.number,
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
            context.read<NetworkingService>().startServer(
                  int.tryParse(_portController.text),
                );
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context).create),
        ),
      ],
    );
  }
}
