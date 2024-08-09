import 'package:flame/widgets.dart';
import 'package:quokka/bloc/board_event.dart';
import 'package:quokka/board/cell.dart';
import 'package:quokka/board/hand/item.dart';
import 'package:quokka/models/object.dart';
import 'package:quokka/models/data.dart';
import 'package:quokka/models/table.dart';

class FigureDefinitionHandItem
    extends HandItem<(PackItem<FigureDefinition>, String?)> {
  FigureDefinitionHandItem({required super.item});

  @override
  String get label {
    final translation = game.assetManager.getTranslations(item.$1.namespace);
    final variation = item.$2;
    if (variation != null) {
      return translation
          .getFigureVariationTranslation(item.$1.id, variation)
          .name;
    }
    return translation.getFigureTranslation(item.$1.id).name;
  }

  @override
  Future<Sprite?> loadIcon() =>
      assetManager.loadFigureSpriteFromLocation(item.$1.location, item.$2);
  @override
  void moveItem(GameCell cell) {
    bloc.add(ObjectsSpawned(cell.toDefinition(), [
      GameObject(
          asset: ItemLocation(item.$1.namespace, item.$1.id),
          variation: item.$2)
    ]));
  }
}
