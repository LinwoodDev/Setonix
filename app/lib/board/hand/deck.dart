import 'package:flame/components.dart';
import 'package:setonix/bloc/world/local.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/board/cell.dart';
import 'package:setonix/board/hand/item.dart';
import 'package:setonix/helpers/string.dart';
import 'package:setonix_api/setonix_api.dart';

class DeckDefinitionHandItem extends HandItem<PackItem<DeckDefinition>> {
  DeckDefinitionHandItem({required super.item});

  @override
  String getLabel(ClientWorldState state) => getAssetManager(state)
      .getTranslations(item.namespace)
      .getDeckTranslation(item.id)
      .name;

  bool matches(ClientWorldState state, String term) =>
      item.location.toString().equalsIgnoreCase(term) ||
      getLabel(state).equalsIgnoreCase(term);

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
            ItemLocation(item.namespace, e.name),
            variation: e.variation,
          ));
    }
    bloc.process(ObjectsSpawned(global.table, objects));
    final boards = <VectorDefinition, List<ItemLocation>>{};
    for (final e in item.item.boards) {
      final location = global.position + e.position;
      boards
          .putIfAbsent(location, () => [])
          .add(ItemLocation(item.namespace, e.name));
    }
    bloc.process(BoardsSpawnRequest(global.table, boards));
    if (bloc.state.switchCellOnMove) {
      bloc.process(CellSwitched(global.position));
    }
  }
}
