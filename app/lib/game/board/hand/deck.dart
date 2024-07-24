import 'package:flame/components.dart';
import 'package:quokka/game/board/game.dart';
import 'package:quokka/game/board/hand/item.dart';
import 'package:quokka/game/board/hand/view.dart';
import 'package:quokka/models/definitions/deck.dart';
import 'package:quokka/models/definitions/pack.dart';

class DeckDefinitionHandItem extends HandItem<PackItem<DeckDefinition>>
    with HasGameRef<BoardGame> {
  DeckDefinitionHandItem({required super.item});

  @override
  String get label => item.id;

  @override
  void onTapUp(event) {
    final hand = parent;
    if (hand is GameHand) {
      hand.selectDeck(item);
    }
  }
}
