import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qeck/pages/game/logic/logic.dart';

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
        child: FutureBuilder<List<GamePlayer>>(
          future: Future.value(connection.getPlayers()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Align(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null) {
              return Align(
                child: Text(AppLocalizations.of(context).noPlayers),
              );
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: snapshot.data!
                  .map(
                    (player) => ListTile(
                      title: Text(player.name),
                      subtitle: Text(player.id),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
