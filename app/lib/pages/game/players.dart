import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../logic/connection/logic.dart';

class PlayersDialog extends StatelessWidget {
  final GameConnection connection;

  const PlayersDialog({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).players),
      scrollable: true,
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: connection.players
              .map(
                (player) => ListTile(
                  title: Text(player.name),
                  subtitle: Text(player.id),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
