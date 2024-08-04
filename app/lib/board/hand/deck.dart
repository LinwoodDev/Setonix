import 'package:flame/components.dart';
import 'package:quokka/bloc/board_event.dart';
import 'package:quokka/board/cell.dart';
import 'package:quokka/board/hand/item.dart';
import 'package:quokka/models/definitions/deck.dart';
import 'package:quokka/models/definitions/pack.dart';

class DeckDefinitionHandItem extends HandItem<PackItem<DeckDefinition>> {
  DeckDefinitionHandItem({required super.item});

  @override
  String get label => item.id;

  @override
  void onTapUp(event) {
    bloc.add(ChangeHandEvent(deck: item.location));
  }

  @override
  Future<Sprite?> loadIcon() async {
    final front = item.item.figures.firstOrNull;
    if (front == null) return null;
    return assetManager.loadFigureSprite(front.name, front.variation);
  }

  @override
  void moveItem(GameCell cell) {}
}
