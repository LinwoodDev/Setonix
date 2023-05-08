import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeck/logic/connection/client.dart';
import 'package:qeck/logic/state.dart';
import 'package:qeck/pages/game/card.dart';

class CardLocation {
  final GameDeck deck;
  final GameCard card;
  final int index;
  final int? deckIndex;
  final int? seatIndex;

  CardLocation(
      this.deck, this.card, this.index, this.deckIndex, this.seatIndex);
}

class GameDeckView extends StatelessWidget {
  final GameDeck deck;
  final int? index;
  final int? seatIndex;
  final ClientGameConnection connection;

  const GameDeckView({
    super.key,
    required this.deck,
    required this.index,
    required this.connection,
    required this.seatIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: deck.cards
                .asMap()
                .entries
                .map((e) => CardView(
                      card: e.value,
                    ))
                .toList(),
          ),
        ),
        Row(children: [
          Expanded(child: Text(deck.name)),
          MenuAnchor(
            builder: (context, controller, child) => IconButton(
              icon: const PhosphorIcon(PhosphorIconsLight.list),
              onPressed: () =>
                  controller.isOpen ? controller.close() : controller.open(),
            ),
            menuChildren: [
              MenuItemButton(
                child: Text(AppLocalizations.of(context).shuffle),
              )
            ],
          ),
        ]),
      ],
    );
  }
}
