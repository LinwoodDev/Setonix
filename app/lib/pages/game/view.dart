import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeck/logic/connection/client.dart';
import 'package:qeck/logic/state.dart';

import 'deck.dart';
import 'seat.dart';

class GameView extends StatelessWidget {
  final ClientGameConnection connection;

  const GameView({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    bool showOtherSeats = false;
    return StreamBuilder<GameState>(
        stream: connection.stateStream,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state == null) {
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
          return StatefulBuilder(
            builder: (context, setState) => ListView(
              shrinkWrap: true,
              children: [
                Text(AppLocalizations.of(context).available,
                    style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(
                  height: 180,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      GameDeckView(
                        connection: connection,
                        deck: GameDeck(
                            cards: GameCard.getClassicDeck(),
                            name: AppLocalizations.of(context).classic),
                        index: null,
                        seatIndex: null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(AppLocalizations.of(context).decks,
                    style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(
                  height: 150,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...state.decks.asMap().entries.map((e) => GameDeckView(
                            connection: connection,
                            deck: e.value,
                            index: e.key,
                            seatIndex: null,
                          )),
                      AddDeckView(connection: connection),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context).seats,
                        style: Theme.of(context).textTheme.headlineSmall),
                    IconButton(
                      icon: const PhosphorIcon(PhosphorIconsLight.gear),
                      onPressed: () => showDialog(
                          context: context,
                          builder: (context) => SeatsDialog(
                                connection: connection,
                              )),
                    ),
                  ],
                ),
                ...connection.getMySeats().asMap().entries.expand((se) => [
                      const SizedBox(height: 16),
                      SeatView(
                        connection: connection,
                        seat: se.value,
                        index: se.key,
                      ),
                    ]),
                // Add other seats
                ExpansionPanelList(
                  expansionCallback: (index, isExpanded) {
                    setState(() {
                      showOtherSeats = !showOtherSeats;
                    });
                  },
                  children: [
                    ExpansionPanel(
                      headerBuilder: (context, isExpanded) => ListTile(
                        title: Text(AppLocalizations.of(context).otherSeats),
                      ),
                      body: ListView(
                        shrinkWrap: true,
                        children: [
                          ...state.seats
                              .asMap()
                              .entries
                              .where((e) => !e.value.players
                                  .contains(connection.playerId))
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: SeatView(
                                      connection: connection,
                                      seat: e.value,
                                      index: e.key,
                                    ),
                                  )),
                        ],
                      ),
                      isExpanded: showOtherSeats,
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
