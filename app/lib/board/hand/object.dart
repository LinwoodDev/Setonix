import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quokka/bloc/world/event.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka/board/cell.dart';
import 'package:quokka/board/hand/item.dart';
import 'package:quokka/board/hand/view.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/models/vector.dart';

class GameObjectHandItem extends HandItem<(VectorDefinition, int, GameObject)> {
  GameObjectHandItem({required super.item});

  @override
  String getLabel(WorldState state) {
    final object = item.$3;
    final translation =
        game.assetManager.getTranslations(object.asset.namespace);
    final variation = object.variation;
    if (variation != null && !item.$3.hidden && state.isCellVisible(item.$1)) {
      return translation
          .getFigureVariationTranslation(object.asset.id, variation)
          .name;
    }
    return translation.getFigureTranslation(object.asset.id).name;
  }

  @override
  Future<Sprite?> loadIcon(WorldState state) =>
      game.assetManager.loadFigureSpriteFromLocation(
          item.$3.asset,
          item.$3.hidden || !state.isCellVisible(item.$1)
              ? null
              : item.$3.variation);

  @override
  void moveItem(HandItemDropZone zone) {
    switch (zone) {
      case GameCell e:
        game.bloc.process(ObjectsMoved(
          [item.$2],
          item.$1,
          e.toDefinition(),
        ));
      case GameObjectHandItem e:
        game.bloc.process(ObjectIndexChanged(
          item.$1,
          item.$2,
          e.item.$2,
        ));
      case GameHand _:
        final cell = game.bloc.state.table.cells[item.$1];
        game.bloc.process(ObjectIndexChanged(
          item.$1,
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
    return (context, onClose) => [
          ContextMenuButtonItem(
            label: AppLocalizations.of(game.buildContext!).toggleHide,
            onPressed: () {
              game.bloc.process(CellHideChanged(item.$1, object: item.$2));
              onClose();
            },
          ),
          if (game.assetManager
                  .getPack(location.namespace)
                  ?.getFigure(location.id)
                  ?.rollable ??
              true)
            ContextMenuButtonItem(
              label: AppLocalizations.of(game.buildContext!).roll,
              onPressed: () {
                game.bloc.process(RollObjectRequest(item.$1, item.$2));
                onClose();
              },
            ),
        ];
  }
}
