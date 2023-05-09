import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../logic/connection/client.dart';
import '../../logic/connection/logic.dart';
import '../../logic/state.dart';

class CardsOperationDialog extends StatelessWidget {
  final ClientGameConnection connection;
  final List<CardIndex> cards;

  const CardsOperationDialog(
      {super.key, required this.cards, required this.connection});

  @override
  Widget build(BuildContext context) {
    int? deckIndex, seatIndex;
    bool showRemove =
        cards.whereNot((element) => element is AvailableCardIndex).isNotEmpty;
    return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
              title: Text(AppLocalizations.of(context).cardsOperation),
              content: SizedBox(
                  width: 500,
                  height: 500,
                  child: DefaultTabController(
                      length: showRemove ? 3 : 2,
                      child: Column(
                        children: [
                          TabBar(tabs: [
                            Tab(
                              text: AppLocalizations.of(context).moveToDeck,
                            ),
                            Tab(
                              text: AppLocalizations.of(context).moveToSeatDeck,
                            ),
                            if (showRemove)
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
                                      labelText:
                                          AppLocalizations.of(context).deck,
                                      filled: true,
                                      icon: const PhosphorIcon(
                                          PhosphorIconsLight.textT),
                                    ),
                                    items: connection.state.decks
                                        .asMap()
                                        .entries
                                        .map((e) => DropdownMenuItem(
                                            value: e.key,
                                            child: Text(e.value.name)))
                                        .toList(),
                                    onChanged: (value) => setState(() {
                                      deckIndex = value;
                                      seatIndex = null;
                                    }),
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
                                      labelText:
                                          AppLocalizations.of(context).seat,
                                      filled: true,
                                      icon: const PhosphorIcon(
                                          PhosphorIconsLight.user),
                                    ),
                                    items: connection.state.seats
                                        .asMap()
                                        .entries
                                        .map((e) => DropdownMenuItem(
                                            value: e.key,
                                            child: Text(e.value.name)))
                                        .toList(),
                                    onChanged: (value) => setState(() {
                                      seatIndex = value;
                                      deckIndex = null;
                                    }),
                                  ),
                                  DropdownButtonFormField<int>(
                                    decoration: InputDecoration(
                                      labelText:
                                          AppLocalizations.of(context).deck,
                                      filled: true,
                                      icon: const PhosphorIcon(
                                          PhosphorIconsLight.textT),
                                    ),
                                    items: seatIndex == null
                                        ? []
                                        : connection
                                            .state.seats[seatIndex!].decks
                                            .asMap()
                                            .entries
                                            .map((e) => DropdownMenuItem(
                                                value: e.key,
                                                child: Text(e.value.name)))
                                            .toList(),
                                    onChanged: (value) {
                                      deckIndex = value;
                                    },
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (deckIndex == null ||
                                          seatIndex == null) {
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
                                if (showRemove)
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
            ));
  }
}

class PutCardsDialog extends StatelessWidget {
  final ClientGameConnection connection;
  final int deckIndex;
  final int? seatIndex;

  const PutCardsDialog(
      {super.key,
      required this.connection,
      required this.deckIndex,
      this.seatIndex});

  @override
  Widget build(BuildContext context) {
    int? movedDeckIndex, movedSeatIndex;
    var count = 1;
    var location = PickLocation.top;
    return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
              title: Text(AppLocalizations.of(context).putCards),
              content: SizedBox(
                  width: 500,
                  height: 500,
                  child: Column(
                    children: [
                      DropdownButtonFormField<PickLocation>(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).location,
                          filled: true,
                          icon: const PhosphorIcon(PhosphorIconsLight.textT),
                        ),
                        items: PickLocation.values
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e.name)))
                            .toList(),
                        onChanged: (value) => location = value ?? location,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).count,
                          filled: true,
                          icon: const PhosphorIcon(PhosphorIconsLight.textT),
                        ),
                        initialValue: count.toString(),
                        onChanged: (value) =>
                            count = int.tryParse(value) ?? count,
                      ),
                      Expanded(
                        child: DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                TabBar(tabs: [
                                  Tab(
                                    text:
                                        AppLocalizations.of(context).moveToDeck,
                                  ),
                                  Tab(
                                    text: AppLocalizations.of(context)
                                        .moveToSeatDeck,
                                  ),
                                ]),
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      ListView(children: [
                                        DropdownButtonFormField<int>(
                                          decoration: InputDecoration(
                                            labelText:
                                                AppLocalizations.of(context)
                                                    .deck,
                                            filled: true,
                                            icon: const PhosphorIcon(
                                                PhosphorIconsLight.textT),
                                          ),
                                          items: connection.state.decks
                                              .asMap()
                                              .entries
                                              .map((e) => DropdownMenuItem(
                                                  value: e.key,
                                                  child: Text(e.value.name)))
                                              .toList(),
                                          onChanged: (value) => setState(() {
                                            movedDeckIndex = value;
                                            movedSeatIndex = null;
                                          }),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (movedDeckIndex == null) return;
                                            connection.putCards(
                                                deckIndex,
                                                seatIndex,
                                                location,
                                                count,
                                                movedDeckIndex!,
                                                null);
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
                                            labelText:
                                                AppLocalizations.of(context)
                                                    .seat,
                                            filled: true,
                                            icon: const PhosphorIcon(
                                                PhosphorIconsLight.user),
                                          ),
                                          items: connection.state.seats
                                              .asMap()
                                              .entries
                                              .map((e) => DropdownMenuItem(
                                                  value: e.key,
                                                  child: Text(e.value.name)))
                                              .toList(),
                                          onChanged: (value) => setState(() {
                                            movedSeatIndex = value;
                                            movedDeckIndex = null;
                                          }),
                                        ),
                                        DropdownButtonFormField<int>(
                                          decoration: InputDecoration(
                                            labelText:
                                                AppLocalizations.of(context)
                                                    .deck,
                                            filled: true,
                                            icon: const PhosphorIcon(
                                                PhosphorIconsLight.textT),
                                          ),
                                          items: movedSeatIndex == null
                                              ? []
                                              : connection.state
                                                  .seats[movedSeatIndex!].decks
                                                  .asMap()
                                                  .entries
                                                  .map((e) => DropdownMenuItem(
                                                      value: e.key,
                                                      child:
                                                          Text(e.value.name)))
                                                  .toList(),
                                          onChanged: (value) {
                                            movedDeckIndex = value;
                                          },
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (movedDeckIndex == null ||
                                                movedSeatIndex == null) {
                                              return;
                                            }
                                            connection.putCards(
                                                deckIndex,
                                                seatIndex,
                                                location,
                                                count,
                                                movedDeckIndex!,
                                                movedSeatIndex!);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            AppLocalizations.of(context).move,
                                          ),
                                        )
                                      ]),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  )),
            ));
  }
}
