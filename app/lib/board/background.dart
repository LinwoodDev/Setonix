import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/board/grid.dart';
import 'package:setonix_api/setonix_api.dart';

class GameBoardBackground extends PositionComponent
    with FlameBlocListenable<WorldBloc, ClientWorldState> {
  Sprite? _sprite;
  bool _isDirty = true;
  late final BoardGrid grid;

  GameBoardBackground({super.size});

  @override
  void onLoad() {
    super.onLoad();
    grid = findParent<BoardGrid>()!;
  }

  @override
  void onInitialState(ClientWorldState state) => _isDirty = true;

  @override
  bool listenWhen(ClientWorldState previousState, ClientWorldState newState) =>
      previousState.table.background != newState.table.background ||
      previousState.info.packs != newState.info.packs;

  @override
  void onNewState(ClientWorldState state) => _isDirty = true;

  @override
  void update(double dt) {
    super.update(dt);
    if (_isDirty) {
      _isDirty = false;
      updateBackground(bloc.state);
    }
  }

  @override
  void render(Canvas canvas) {
    final sprite = _sprite;
    if (sprite != null) {
      paintImage(
        canvas: canvas,
        rect: size.toRect(),
        image: sprite.image,
        repeat: ImageRepeat.repeat,
        scale: sprite.image.width / grid.cellSize.x,
        alignment: Alignment.topLeft,
        filterQuality: FilterQuality.none,
      );
    }
  }

  Future<Sprite?> _loadSprite(
    ClientWorldState state,
    PackItem<BackgroundDefinition>? item,
  ) {
    if (item == null) return Future.value(null);
    return state.assetManager.loadSprite(item.item.texture, item.namespace);
  }

  Future<void> updateBackground(ClientWorldState state) async {
    final backgroundLocation = state.table.background;
    final background =
        await _loadSprite(
          state,
          backgroundLocation == null
              ? null
              : state.assetManager.getBackgroundItem(backgroundLocation),
        ) ??
        await _loadSprite(
          state,
          state.packs
              .map(
                (pack) => pack.value.getBackgroundItems(pack.key).firstOrNull,
              )
              .nonNulls
              .firstOrNull,
        );
    _sprite = background;
  }
}
