import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeck/logic/connection/client.dart';
import 'package:qeck/logic/state.dart';

import '../../logic/connection/logic.dart';

class CardView extends StatelessWidget {
  final GameCard card;

  const CardView({required this.card, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      width: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryContainer,
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: Text(card.toString(), style: const TextStyle(fontSize: 10)),
    );
  }
}

class CardsOperationDialog extends StatelessWidget {
  final ClientGameConnection connection;
  final List<CardIndex> cards;

  const CardsOperationDialog(
      {super.key, required this.cards, required this.connection});

  @override
  Widget build(BuildContext context) {
    int? deckIndex, seatIndex;
    return AlertDialog(
      title: Text(AppLocalizations.of(context).cardsOperation),
      content: SizedBox(
          width: 500,
          height: 500,
          child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(tabs: [
                    Tab(
                      text: AppLocalizations.of(context).moveToDeck,
                    ),
                    Tab(
                      text: AppLocalizations.of(context).moveToSeatDeck,
                    ),
                    Tab(
                      text: AppLocalizations.of(context).remove,
                    ),
                  ]),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ListView(children: [
                          DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).deck,
                              filled: true,
                              icon:
                                  const PhosphorIcon(PhosphorIconsLight.textT),
                            ),
                            items: connection.state.decks
                                .asMap()
                                .entries
                                .map((e) => DropdownMenuItem(
                                    value: e.key, child: Text(e.value.name)))
                                .toList(),
                            onChanged: (value) => deckIndex = value,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (deckIndex == null) return;
                              connection.addCards(cards, deckIndex!);
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context).move,
                            ),
                          )
                        ]),
                        ListView(children: [
                          DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).deck,
                              filled: true,
                              icon:
                                  const PhosphorIcon(PhosphorIconsLight.textT),
                            ),
                            items: connection.state.decks
                                .asMap()
                                .entries
                                .map((e) => DropdownMenuItem(
                                    value: e.key, child: Text(e.value.name)))
                                .toList(),
                            onChanged: (value) => deckIndex = value,
                          ),
                          DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).seat,
                              filled: true,
                              icon: const PhosphorIcon(PhosphorIconsLight.user),
                            ),
                            items: connection.state.seats
                                .asMap()
                                .entries
                                .map((e) => DropdownMenuItem(
                                    value: e.key, child: Text(e.value.name)))
                                .toList(),
                            onChanged: (value) => seatIndex = value,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (deckIndex == null || seatIndex == null) {
                                return;
                              }
                              connection.addCards(
                                  cards, deckIndex!, seatIndex!);
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context).move,
                            ),
                          )
                        ]),
                        ListView(children: [
                          ElevatedButton(
                            onPressed: () {
                              connection.removeCards(cards);
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context).remove,
                            ),
                          )
                        ]),
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
