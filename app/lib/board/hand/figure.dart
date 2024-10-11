import 'package:flame/widgets.dart';
import 'package:setonix/bloc/world/local.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/board/cell.dart';
import 'package:setonix/board/hand/item.dart';
import 'package:setonix_api/setonix_api.dart';

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
      GameObject(ItemLocation(item.$1.namespace, item.$1.id),
          variation: item.$2)
    ]));
    if (bloc.state.switchCellOnMove) {
      bloc.process(CellSwitched(global.position));
    }
  }
}
