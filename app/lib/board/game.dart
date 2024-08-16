import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:quokka/bloc/world.dart';
import 'package:quokka/bloc/world_event.dart';
import 'package:quokka/bloc/world_state.dart';
import 'package:quokka/board/grid.dart';
import 'package:quokka/board/hand/view.dart';
import 'package:quokka/helpers/asset.dart';
import 'package:quokka/helpers/scroll.dart';
import 'package:quokka/helpers/secondary.dart';

class BoardGame extends FlameGame
    with ScrollDetector, KeyboardEvents, SecondaryTapDetector {
  final VoidCallback onEscape;
  final ContextMenuController contextMenuController;
  final AssetManager assetManager;
  late final Sprite selectionSprite;
  late final GameHand _hand;
  late final BoardGrid grid;
  final WorldBloc bloc;

  bool _isShifting = false;

  bool get isShifting => _isShifting;

  BoardGame({
    required this.bloc,
    required this.assetManager,
    required this.contextMenuController,
    required this.onEscape,
  });

  @override
  FutureOr<void> onLoad() async {
    final provider =
        FlameBlocProvider<WorldBloc, WorldState>.value(value: bloc);
    await add(provider);
    provider.addAll([camera, world]);
    const packName = '';
    await assetManager.loadPack(packName);
    selectionSprite = await Sprite.load('selection.png');
    _hand = GameHand();
    camera.viewport.add(_hand);
    grid = BoardGrid(cellSize: Vector2.all(128));
    world.add(grid);
    _updateLocale();
  }

  @override
  void onAttach() {
    _updateLocale();
  }

  void _updateLocale() {
    final context = buildContext;
    if (context == null) return;
    assetManager.currentLocale = Localizations.localeOf(context).languageCode;
  }

  void clampZoom(double zoom) {
    camera.viewfinder.zoom = zoom.clamp(0.3, 3.0);
  }

  static const zoomPerScrollUnit = 0.02;

  @override
  void onScroll(PointerScrollInfo info) {
    componentsAtPoint(info.eventPosition.widget)
        .whereType<ScrollCallbacks>()
        .any((element) => element.onScroll(info));
  }

  @override
  void onSecondaryTapUp(TapUpInfo info) {
    componentsAtPoint(info.eventPosition.widget)
        .whereType<SecondaryTapCallbacks>()
        .any((element) => element.onSecondaryTapUp(info));
  }

  Vector2 _currentCameraVelocity = Vector2.zero();

  @override
  void update(double dt) {
    super.update(dt);

    if (!_currentCameraVelocity.isZero()) {
      camera.moveBy(_currentCameraVelocity * dt * 60);
    }
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    var handled = false;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.escape:
        if (event is KeyDownEvent) onEscape();
        handled = true;
      case LogicalKeyboardKey.tab:
        if (event is KeyDownEvent) bloc.add(HandChanged.toggle());
        handled = true;
      case LogicalKeyboardKey.shiftLeft:
        if (event is KeyDownEvent) _isShifting = true;
        if (event is KeyUpEvent) _isShifting = false;
        handled = true;
      case LogicalKeyboardKey.keyW:
      case LogicalKeyboardKey.keyS:
      case LogicalKeyboardKey.keyA:
      case LogicalKeyboardKey.keyD:
        handled = true;
    }
    Vector2 nextCameraVelocity = Vector2.zero();
    if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
      nextCameraVelocity += Vector2(0, -1);
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
      nextCameraVelocity += Vector2(0, 1);
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
      nextCameraVelocity += Vector2(-1, 0);
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
      nextCameraVelocity += Vector2(1, 0);
    }
    if (nextCameraVelocity != _currentCameraVelocity) {
      _currentCameraVelocity = nextCameraVelocity;
    }
    return handled ? KeyEventResult.handled : KeyEventResult.ignored;
  }

  void showContextMenu(
      {required Widget Function(BuildContext, VoidCallback onClose)
          contextMenuBuilder}) {
    final context = buildContext;
    if (context == null) return;
    contextMenuController.show(
      context: context,
      contextMenuBuilder: (context) =>
          contextMenuBuilder(context, contextMenuController.remove),
    );
  }
}
