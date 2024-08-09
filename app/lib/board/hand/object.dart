import 'package:flame/components.dart';
import 'package:quokka/bloc/board_event.dart';
import 'package:quokka/board/cell.dart';
import 'package:quokka/board/hand/item.dart';
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
    if (variation != null) {
      return translation
          .getFigureVariationTranslation(object.asset.id, variation)
          .name;
    }
    return translation.getFigureTranslation(object.asset.id).name;
  }

  @override
  Future<Sprite?> loadIcon() => game.assetManager
      .loadFigureSpriteFromLocation(item.$3.asset, item.$3.variation);

  @override
  void moveItem(GameCell cell) {
    game.bloc.add(ObjectsMoved(
      [item.$2],
      item.$1,
      cell.toDefinition(),
    ));
  }
}
