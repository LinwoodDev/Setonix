import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeck/logic/connection/client.dart';
import 'package:qeck/logic/state.dart';
import 'package:qeck/pages/game/card.dart';

class DeckLocation {
  final GameDeck deck;
  final int? index;
  final int? seatIndex;

  DeckLocation(this.deck, this.index, this.seatIndex);
}

class CardLocation {
  final GameCard card;
  final int index;
  final DeckLocation location;

  CardLocation(this.card, this.index, this.location);
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
    final firstCard = deck.cards.firstOrNull;
    return SizedBox(
      width: 120,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (firstCard != null)
                Expanded(
                  child: Draggable(
                    data: DeckLocation(deck, index, seatIndex),
                    feedback: Material(
                      child: Text(deck.name),
                    ),
                    child: CardView(
                      card: firstCard,
                    ),
                  ),
                ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(deck.name),
                MenuAnchor(
                  builder: (context, controller, child) => IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.list),
                    onPressed: () => controller.isOpen
                        ? controller.close()
                        : controller.open(),
                  ),
                  menuChildren: [
                    MenuItemButton(
                      child: Text(AppLocalizations.of(context).shuffle),
                    )
                  ],
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class AddDeckView extends StatelessWidget {
  final ClientGameConnection connection;
  const AddDeckView({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => showDialog(
            context: context,
            builder: (context) => AddDeckDialog(
              connection: connection,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              child: PhosphorIcon(PhosphorIconsLight.plus, size: 32),
            ),
          ),
        ),
      ),
    );
  }
}

class AddDeckDialog extends StatelessWidget {
  final ClientGameConnection connection;
  final int? seatIndex;

  const AddDeckDialog({super.key, required this.connection, this.seatIndex});

  @override
  Widget build(BuildContext context) {
    GameDeck deck = const GameDeck();
    return AlertDialog(
      title: Text(AppLocalizations.of(context).addDeck),
      scrollable: true,
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).name,
              ),
              onChanged: (value) => deck = deck.copyWith(name: value),
            ),
            DropdownButtonFormField<DeckVisibility>(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).visibility,
              ),
              value: deck.visibility,
              items: DeckVisibility.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      ))
                  .toList(),
              onChanged: (value) =>
                  deck = deck.copyWith(visibility: value ?? deck.visibility),
            ),
            if (seatIndex != null)
              StatefulBuilder(
                builder: (context, setState) => Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<DeckVisibility>(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).ownVisibility,
                        ),
                        value: deck.ownVisibility,
                        items: DeckVisibility.values
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name),
                                ))
                            .toList(),
                        onChanged: (value) => setState(() => deck =
                            deck.copyWith(
                                ownVisibility: value ?? deck.ownVisibility)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const PhosphorIcon(PhosphorIconsLight.trash),
                      onPressed: () => setState(
                          () => deck = deck.copyWith(ownVisibility: null)),
                    ),
                  ],
                ),
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
          onPressed: () {
            connection.addDeck(deck, seatIndex);
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context).create),
        ),
      ],
    );
  }
}
