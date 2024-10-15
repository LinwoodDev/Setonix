import 'package:flame/widgets.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/board/cell.dart';
import 'package:setonix/board/hand/item.dart';
import 'package:setonix/helpers/string.dart';
import 'package:setonix_api/setonix_api.dart';

class BoardDefinitionHandItem extends HandItem<PackItem<BoardDefinition>> {
  BoardDefinitionHandItem({required super.item});

  @override
  String getLabel(ClientWorldState state) {
    final translation = getAssetManager(state).getTranslations(item.namespace);
    return translation.getBoardTranslation(item.id).name;
  }

  bool matches(ClientWorldState state, String term) =>
      item.location.toString().equalsIgnoreCase(term) ||
      getLabel(state).equalsIgnoreCase(term);

  @override
  Future<Sprite?> loadIcon(ClientWorldState state) =>
      getAssetManager(state).loadBoardSprite(item.location);
  @override
  void moveItem(HandItemDropZone zone) {
    if (zone is! GameCell) return;
    bloc.process(BoardsSpawnRequest.single(
        zone.toGlobalDefinition(bloc.state), item.location));
  }
}
