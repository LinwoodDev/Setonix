import 'package:flame/components.dart';
import 'package:quokka/game/board/hand/item.dart';
import 'package:quokka/models/table.dart';

class GameObjectHandItem extends HandItem<MapEntry<GridLocation, GameObject>> {
  GameObjectHandItem({required super.item});

  @override
  String get label => item.value.asset.id;

  @override
  Future<Sprite?> loadIcon() => game.assetManager
      .loadFigureSpriteFromLocation(item.value.asset, item.value.variation);
}
