import 'package:flame/components.dart';
import 'package:quokka/bloc/world/local.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka/board/cell.dart';
import 'package:quokka/board/hand/item.dart';
import 'package:quokka_api/quokka_api.dart';

class DeckDefinitionHandItem extends HandItem<PackItem<DeckDefinition>> {
  DeckDefinitionHandItem({required super.item});

  @override
  String getLabel(ClientWorldState state) => assetManager
      .getTranslations(item.namespace)
      .getDeckTranslation(item.id)
      .name;

  @override
  void onTapUp(event) {
    bloc.process(HandChanged(deck: item.location));
  }

  @override
  Future<Sprite?> loadIcon(ClientWorldState state) async {
    final front = item.item.figures.firstOrNull;
    if (front == null) return null;
    return assetManager.loadFigureSprite(
        front.name, item.namespace, front.variation);
  }

  @override
  void moveItem(HandItemDropZone zone) {
    if (zone is! GameCell) return;
    final global = zone.toGlobalDefinition(bloc.state);
    bloc.process(ObjectsSpawned(
        global,
        item.item.figures
            .map((e) => GameObject(
                asset: ItemLocation(item.namespace, e.name),
                variation: e.variation))
            .toList()));
    if (bloc.state.switchCellOnMove) {
      bloc.process(CellSwitched(global.location));
    }
  }
}
