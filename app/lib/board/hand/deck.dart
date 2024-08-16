import 'package:flame/components.dart';
import 'package:quokka/bloc/world_event.dart';
import 'package:quokka/board/cell.dart';
import 'package:quokka/board/hand/item.dart';
import 'package:quokka/models/deck.dart';
import 'package:quokka/models/data.dart';
import 'package:quokka/models/table.dart';

class DeckDefinitionHandItem extends HandItem<PackItem<DeckDefinition>> {
  DeckDefinitionHandItem({required super.item});

  @override
  String get label => game.assetManager
      .getTranslations(item.namespace)
      .getDeckTranslation(item.id)
      .name;

  @override
  void onTapUp(event) {
    bloc.send(HandChanged(deck: item.location));
  }

  @override
  Future<Sprite?> loadIcon() async {
    final front = item.item.figures.firstOrNull;
    if (front == null) return null;
    return assetManager.loadFigureSprite(front.name, front.variation);
  }

  @override
  void moveItem(HandItemDropZone zone) {
    if (zone is! GameCell) return;
    bloc.send(ObjectsSpawned(
        zone.toDefinition(),
        item.item.figures
            .map((e) => GameObject(
                asset: ItemLocation(item.namespace, e.name),
                variation: e.variation))
            .toList()));
  }
}
