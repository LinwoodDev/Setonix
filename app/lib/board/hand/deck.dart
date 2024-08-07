import 'package:flame/components.dart';
import 'package:quokka/bloc/board_event.dart';
import 'package:quokka/board/cell.dart';
import 'package:quokka/board/hand/item.dart';
import 'package:quokka/models/deck.dart';
import 'package:quokka/models/data.dart';
import 'package:quokka/models/table.dart';

class DeckDefinitionHandItem extends HandItem<PackItem<DeckDefinition>> {
  DeckDefinitionHandItem({required super.item});

  @override
  String get label => item.id;

  @override
  void onTapUp(event) {
    bloc.add(HandChanged(deck: item.location));
  }

  @override
  Future<Sprite?> loadIcon() async {
    final front = item.item.figures.firstOrNull;
    if (front == null) return null;
    return assetManager.loadFigureSprite(front.name, front.variation);
  }

  @override
  void moveItem(GameCell cell) {
    bloc.add(ObjectsSpawned(
        cell.toDefinition(),
        item.item.figures
            .map((e) => GameObject(
                asset: ItemLocation(item.namespace, e.name),
                variation: e.variation))
            .toList()));
  }
}
