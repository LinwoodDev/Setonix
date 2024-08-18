import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quokka/bloc/world_event.dart';
import 'package:quokka/board/cell.dart';
import 'package:quokka/board/hand/item.dart';
import 'package:quokka/board/hand/view.dart';
import 'package:quokka/models/table.dart';
import 'package:quokka/models/vector.dart';

class GameObjectHandItem extends HandItem<(VectorDefinition, int, GameObject)> {
  GameObjectHandItem({required super.item});

  @override
  String get label {
    final object = item.$3;
    final translation =
        game.assetManager.getTranslations(object.asset.namespace);
    final variation = object.variation;
    if (variation != null && !item.$3.hidden) {
      return translation
          .getFigureVariationTranslation(object.asset.id, variation)
          .name;
    }
    return translation.getFigureTranslation(object.asset.id).name;
  }

  @override
  Future<Sprite?> loadIcon() => game.assetManager.loadFigureSpriteFromLocation(
      item.$3.asset, item.$3.hidden ? null : item.$3.variation);

  @override
  void moveItem(HandItemDropZone zone) {
    switch (zone) {
      case GameCell e:
        game.bloc.send(ObjectsMoved(
          [item.$2],
          item.$1,
          e.toDefinition(),
        ));
      case GameObjectHandItem e:
        game.bloc.send(ObjectIndexChanged(
          item.$1,
          item.$2,
          e.item.$2,
        ));
      case GameHand _:
        final cell = game.bloc.state.table.cells[item.$1];
        game.bloc.send(ObjectIndexChanged(
          item.$1,
          item.$2,
          (cell?.objects.length ?? 1) - 1,
        ));
      default:
        return;
    }
  }

  @override
  get contextItemsBuilder => (context, onClose) => [
        ContextMenuButtonItem(
          label: AppLocalizations.of(game.buildContext!).toggleHide,
          onPressed: () {
            game.bloc.send(CellHideChanged(item.$1, object: item.$2));
            onClose();
          },
        ),
      ];
}
