import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:quokka/bloc/world/bloc.dart';
import 'package:quokka/bloc/world/state.dart';
import 'package:quokka_api/quokka_api.dart';

class GameBoardBackground extends PositionComponent
    with FlameBlocListenable<WorldBloc, ClientWorldState> {
  SpriteComponent? _sprite;

  GameBoardBackground({super.size});

  @override
  void onInitialState(ClientWorldState state) => updateBackground(state);

  @override
  bool listenWhen(ClientWorldState previousState, ClientWorldState newState) =>
      previousState.table.background != newState.table.background ||
      previousState.info.packs != newState.info.packs;

  @override
  void onNewState(ClientWorldState state) => updateBackground(state);

  Future<Sprite?> _loadSprite(
      ClientWorldState state, PackItem<BackgroundDefinition>? item) {
    if (item == null) return Future.value(null);
    return state.assetManager.loadSprite(item.item.texture, item.namespace);
  }

  Future<void> updateBackground(ClientWorldState state) async {
    final backgroundLocation = state.table.background;
    final background = await _loadSprite(
            state,
            backgroundLocation == null
                ? null
                : state.assetManager
                    .getPack(backgroundLocation.namespace)
                    ?.getBackgroundItem(
                        backgroundLocation.id, backgroundLocation.namespace)) ??
        await _loadSprite(
            state,
            state.packs
                .map((pack) =>
                    pack.value.getBackgroundItems(pack.key).firstOrNull)
                .nonNulls
                .firstOrNull);
    if (background == null) return;
    final shouldAdd = _sprite == null;
    final sprite = _sprite ??= SpriteComponent(
      size: size,
      paint: Paint()..isAntiAlias = false,
    );
    sprite.sprite = background;
    if (shouldAdd) add(sprite);
  }
}
