import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:setonix/bloc/world/local.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/board/cell.dart';
import 'package:setonix/board/hand/item.dart';
import 'package:setonix/board/hand/view.dart';
import 'package:setonix_api/setonix_api.dart';

class GameObjectHandItem extends HandItem<(VectorDefinition, int, GameObject)> {
  GameObjectHandItem({required super.item});

  GlobalVectorDefinition toGlobalDefinition(ClientWorldState state) =>
      GlobalVectorDefinition.fromLocal(state.tableName, item.$1);

  @override
  String getLabel(ClientWorldState state) {
    final object = item.$3;
    final translation =
        getAssetManager(state).getTranslations(object.asset.namespace);
    final variation = object.variation;
    if (variation != null &&
        !item.$3.hidden &&
        state.isCellVisible(toGlobalDefinition(state))) {
      return translation
          .getFigureVariationTranslation(object.asset.id, variation)
          .name;
    }
    return translation.getFigureTranslation(object.asset.id).name;
  }

  @override
  Future<Sprite?> loadIcon(ClientWorldState state) =>
      getAssetManager(state).loadFigureSprite(
          item.$3.asset,
          item.$3.hidden || !state.isCellVisible(state.toGlobal(item.$1))
              ? null
              : item.$3.variation);

  @override
  void moveItem(HandItemDropZone zone) {
    final current = toGlobalDefinition(bloc.state);
    switch (zone) {
      case GameCell():
        final global = zone.toDefinition();
        bloc.process(ObjectsMoved(
          current.table,
          [item.$2],
          current.position,
          global,
        ));
        if (bloc.state.switchCellOnMove) {
          bloc.process(CellSwitched(global));
        }
      case GameObjectHandItem():
        bloc.process(ObjectIndexChanged(
          current,
          item.$2,
          zone.item.$2,
        ));
      case GameHand():
        final cell = bloc.state.table.cells[item.$1];
        bloc.process(ObjectIndexChanged(
          current,
          item.$2,
          (cell?.objects.length ?? 1) - 1,
        ));
      default:
        return;
    }
  }

  @override
  get contextItemsBuilder {
    final location = item.$3.asset;
    final global = toGlobalDefinition(bloc.state);
    return (context, onClose) => [
          ContextMenuButtonItem(
            label: AppLocalizations.of(context).toggleHide,
            onPressed: () {
              bloc.process(CellHideChanged(global, object: item.$2));
              onClose();
            },
          ),
          ContextMenuButtonItem(
            label: AppLocalizations.of(context).remove,
            onPressed: () {
              bloc.process(ObjectsRemoved.single(global, object: item.$2));
              onClose();
            },
          ),
          if (getAssetManager(bloc.state).getFigure(location)?.rollable ?? true)
            ContextMenuButtonItem(
              label: AppLocalizations.of(context).roll,
              onPressed: () {
                bloc.process(CellRollRequest(global, object: item.$2));
                onClose();
              },
            ),
        ];
  }
}
