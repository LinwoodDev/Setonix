import 'package:flame/components.dart';
import 'package:quokka/game/board/hand/item.dart';
import 'package:quokka/models/definitions/deck.dart';
import 'package:quokka/models/definitions/pack.dart';

class DeckDefinitionHandItem extends HandItem<PackItem<DeckDefinition>> {
  DeckDefinitionHandItem({required super.item});

  @override
  String get label => item.id;

  @override
  void onTapUp(event) {
    hand.selectDeck(item);
  }

  @override
  Future<Sprite?> loadIcon() async {
    final front = item.item.figures.firstOrNull;
    if (front == null) return null;
    return assetManager.loadFigureSprite(front.name, front.variation);
  }
}
