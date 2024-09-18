import 'package:flame/sprite.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka/board/hand/item.dart';
import 'package:quokka_api/quokka_api.dart';

class BoardTileHandItem extends HandItem<(VectorDefinition, int, BoardTile)> {
  BoardTileHandItem({required super.item});

  @override
  String getLabel(ClientWorldState state) {
    final object = item.$3;
    final translation =
        getAssetManager(state).getTranslations(object.asset.namespace);
    return translation.getBoardTranslation(object.asset.id).name;
  }

  @override
  Future<Sprite?> loadIcon(ClientWorldState state) {
    return getAssetManager(state).loadBoardSprite(item.$3.asset, item.$3.tile);
  }
}
