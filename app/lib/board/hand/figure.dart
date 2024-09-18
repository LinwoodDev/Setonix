import 'package:flame/widgets.dart';
import 'package:quokka/bloc/world/local.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka/board/cell.dart';
import 'package:quokka/board/hand/item.dart';
import 'package:quokka_api/quokka_api.dart';

class FigureDefinitionHandItem
    extends HandItem<(PackItem<FigureDefinition>, String?)> {
  FigureDefinitionHandItem({required super.item});

  @override
  String getLabel(ClientWorldState state) {
    final translation =
        getAssetManager(state).getTranslations(item.$1.namespace);
    final variation = item.$2;
    if (variation != null) {
      return translation
          .getFigureVariationTranslation(item.$1.id, variation)
          .name;
    }
    return translation.getFigureTranslation(item.$1.id).name;
  }

  @override
  Future<Sprite?> loadIcon(ClientWorldState state) =>
      getAssetManager(state).loadFigureSprite(item.$1.location, item.$2);
  @override
  void moveItem(HandItemDropZone zone) {
    if (zone is! GameCell) return;
    final global = zone.toGlobalDefinition(bloc.state);
    bloc.process(ObjectsSpawned.single(global, [
      GameObject(
          asset: ItemLocation(item.$1.namespace, item.$1.id),
          variation: item.$2)
    ]));
    if (bloc.state.switchCellOnMove) {
      bloc.process(CellSwitched(global.position));
    }
  }
}
