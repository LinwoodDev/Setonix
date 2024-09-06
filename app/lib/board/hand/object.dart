import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quokka/bloc/world/local.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka/board/cell.dart';
import 'package:quokka/board/hand/item.dart';
import 'package:quokka/board/hand/view.dart';
import 'package:quokka_api/quokka_api.dart';

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
      getAssetManager(state).loadFigureSpriteFromLocation(
          item.$3.asset,
          item.$3.hidden || !state.isCellVisible(state.toGlobal(item.$1))
              ? null
              : item.$3.variation);

  @override
  void moveItem(HandItemDropZone zone) {
    final current = toGlobalDefinition(bloc.state);
    switch (zone) {
      case GameCell e:
        final global = e.toDefinition();
        bloc.process(ObjectsMoved(
          [item.$2],
          current.table,
          current.location,
          global,
        ));
        if (bloc.state.switchCellOnMove) {
          bloc.process(CellSwitched(global));
        }
      case GameObjectHandItem e:
        bloc.process(ObjectIndexChanged(
          current,
          item.$2,
          e.item.$2,
        ));
      case GameHand _:
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
              bloc.process(CellItemsCleared(global, object: item.$2));
              onClose();
            },
          ),
          if (getAssetManager(bloc.state)
                  .getPack(location.namespace)
                  ?.getFigure(location.id)
                  ?.rollable ??
              true)
            ContextMenuButtonItem(
              label: AppLocalizations.of(context).roll,
              onPressed: () {
                bloc.process(RollObjectRequest(global, item.$2));
                onClose();
              },
            ),
        ];
  }
}
