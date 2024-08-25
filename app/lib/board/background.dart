import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:quokka/bloc/world/bloc.dart';
import 'package:quokka/board/game.dart';
import 'package:quokka/bloc/world/state.dart';

class GameBoardBackground extends PositionComponent
    with
        HasGameReference<BoardGame>,
        FlameBlocListenable<WorldBloc, ClientWorldState> {
  SpriteComponent? _sprite;

  GameBoardBackground({super.size});

  @override
  void onInitialState(ClientWorldState state) => updateBackground(state);

  @override
  bool listenWhen(ClientWorldState previousState, ClientWorldState newState) =>
      previousState.table.background != newState.table.background;

  @override
  void onNewState(ClientWorldState state) => updateBackground(state);

  Future<void> updateBackground(ClientWorldState state) async {
    final backgroundLocation = state.table.background;
    final background = (backgroundLocation == null
            ? null
            : (await game.assetManager.loadPack(backgroundLocation.namespace))
                ?.getBackgroundItem(backgroundLocation.id)) ??
        game.assetManager.packs
            .map((pack) => pack.value.getBackgroundItems(pack.key).firstOrNull)
            .nonNulls
            .firstOrNull;
    if (background == null) return;
    final shouldAdd = _sprite == null;
    final sprite = _sprite ??= SpriteComponent(
      size: size,
      paint: Paint()..isAntiAlias = false,
    );
    sprite.sprite = await game.assetManager.loadSprite(background.item.texture);
    if (shouldAdd) add(sprite);
  }
}
