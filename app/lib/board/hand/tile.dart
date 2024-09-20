import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka/board/cell.dart';
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

  @override
  get contextItemsBuilder {
    return (context, onClose) => [
          ContextMenuButtonItem(
            label: AppLocalizations.of(context).remove,
            onPressed: () {
              bloc.process(BoardRemoveRequest(
                GlobalVectorDefinition.fromLocal(bloc.state.tableName, item.$1),
                item.$2,
              ));
              onClose();
            },
          ),
        ];
  }

  @override
  void moveItem(HandItemDropZone zone) {
    if (zone is! GameCell) return;
    final to = zone.toDefinition();
    bloc.process(BoardMoveRequest(bloc.state.tableName, item.$1, to, item.$2));
  }
}
