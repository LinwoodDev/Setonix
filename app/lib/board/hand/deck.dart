import 'package:flame/components.dart';
import 'package:quokka/bloc/world/local.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka/board/cell.dart';
import 'package:quokka/board/hand/item.dart';
import 'package:quokka_api/quokka_api.dart';

class DeckDefinitionHandItem extends HandItem<PackItem<DeckDefinition>> {
  DeckDefinitionHandItem({required super.item});

  @override
  String getLabel(ClientWorldState state) => getAssetManager(state)
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
    return getAssetManager(state).loadFigureSprite(
        ItemLocation.fromString(front.name, item.namespace), front.variation);
  }

  @override
  void moveItem(HandItemDropZone zone) {
    if (zone is! GameCell) return;
    final global = zone.toGlobalDefinition(bloc.state);
    final objects = <VectorDefinition, List<GameObject>>{};
    for (final e in item.item.figures) {
      final location = global.position + e.position;
      objects.putIfAbsent(location, () => []).add(GameObject(
            asset: ItemLocation(item.namespace, e.name),
            variation: e.variation,
          ));
    }
    bloc.process(ObjectsSpawned(bloc.state.tableName, objects));
    if (bloc.state.switchCellOnMove) {
      bloc.process(CellSwitched(global.position));
    }
  }
}
