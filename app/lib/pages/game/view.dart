import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qeck/logic/connection/client.dart';
import 'package:qeck/logic/state.dart';

import 'deck.dart';

class GameView extends StatelessWidget {
  final ClientGameConnection connection;

  const GameView({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GameState>(
        stream: connection.stateStream,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state == null) {
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
          return ListView(
            shrinkWrap: true,
            children: [
              Text(AppLocalizations.of(context).cards),
              SizedBox(
                height: 100,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    GameDeckView(
                      connection: connection,
                      deck: GameDeck(cards: GameCard.getClassicDeck()),
                      index: null,
                      seatIndex: null,
                    ),
                  ],
                ),
              ),
              Text(AppLocalizations.of(context).decks),
              SizedBox(
                height: 100,
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: state.decks
                        .asMap()
                        .entries
                        .map((e) => GameDeckView(
                              connection: connection,
                              deck: e.value,
                              index: e.key,
                              seatIndex: null,
                            ))
                        .toList()),
              )
            ],
          );
        });
  }
}
