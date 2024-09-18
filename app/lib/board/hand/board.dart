import 'package:flame/widgets.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka/board/cell.dart';
import 'package:quokka/board/hand/item.dart';
import 'package:quokka_api/quokka_api.dart';

class BoardDefinitionHandItem extends HandItem<PackItem<BoardDefinition>> {
  BoardDefinitionHandItem({required super.item});

  @override
  String getLabel(ClientWorldState state) {
    final translation = getAssetManager(state).getTranslations(item.namespace);
    return translation.getBoardTranslation(item.id).name;
  }

  @override
  Future<Sprite?> loadIcon(ClientWorldState state) =>
      getAssetManager(state).loadBoardSprite(item.location);
  @override
  void moveItem(HandItemDropZone zone) {
    if (zone is! GameCell) return;
  }
}
