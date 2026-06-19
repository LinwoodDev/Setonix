import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/local.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/board/grid.dart';
import 'package:setonix/board/hand/view.dart';
import 'package:setonix/helpers/scroll.dart';
import 'package:setonix/helpers/vector.dart';
import 'package:setonix_api/setonix_api.dart';

class BoardGame extends FlameGame
    with ScrollDetector, KeyboardEvents, HasCollisionDetection, ScaleDetector {
  final VoidCallback onEscape;
  final ContextMenuController contextMenuController;
  late final Sprite selectionSprite, blankSprite;
  late final GameHand _hand;
  late final BoardGrid grid;
  final WorldBloc bloc;
  final SettingsCubit settingsCubit;

  bool _isShifting = false;
  bool get isShifting => _isShifting;

  BoardGame({
    required this.bloc,
    required this.contextMenuController,
    required this.onEscape,
    required this.settingsCubit,
  });

  @override
  FutureOr<void> onLoad() async {
    add(ScreenHitbox());
    FlameBlocProvider provider =
        FlameBlocProvider<WorldBloc, ClientWorldState>.value(value: bloc);
    provider = provider;
    await add(
      FlameBlocProvider<SettingsCubit, SetonixSettings>.value(
        value: settingsCubit,
        children: [
          provider,
          FlameBlocListener<SettingsCubit, SetonixSettings>(
            listenWhen: (previousState, newState) =>
                previousState.zoom != newState.zoom,
            onNewState: (state) {
              camera.viewfinder.zoom = state.zoom.clamp(0.4, 2.0);
            },
          ),
        ],
      ),
    );
    provider.addAll([camera, world]);
    camera.viewfinder.zoom = settingsCubit.state.zoom;
    selectionSprite = await Sprite.load('selection.png');
    blankSprite = await Sprite.load('blank.png');
    _hand = GameHand();
    camera.viewport.add(_hand);
    camera.moveTo(camera.viewport.virtualSize * 0.5);
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
    bloc.state.assetManager.currentLocale = Localizations.localeOf(
      context,
    ).languageCode;
  }

  static const zoomPerScrollUnit = 0.02;

  double _startZoom = 1.0;
  Vector2 _startPosition = Vector2.zero();
  bool _scaleStartedOnHand = false;

  @override
  void onScaleStart(ScaleStartInfo info) {
    _startZoom = camera.viewfinder.zoom;
    _startPosition = info.eventPosition.global;
    _scaleStartedOnHand =
        _hand.isShowing && _hand.containsPoint(info.eventPosition.widget);
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    if (_scaleStartedOnHand) {
      if (info.pointerCount == 1) {
        _hand.dragScroll(info.delta.global.x);
      }
      return;
    }
    final zoom = camera.viewfinder.zoom;
    final delta = (info.delta.global..negate()) / zoom;

    if (info.scale.global.x == 0 || info.scale.global.x == 1.0) {
      camera.moveBy(delta);
      return;
    }

    final newZoom = (_startZoom * info.scale.global.x).clamp(0.4, 2.0);
    final oldZoom = camera.viewfinder.zoom.clamp(0.4, 2.0);
    camera.viewfinder.zoom = newZoom;
    // Zoom inside towards the focal point
    final screenCenter = camera.viewport.size / 2;
    final zoomDelta = newZoom - oldZoom;
    if (((4.0 - newZoom) < precisionErrorTolerance &&
            (4.0 - oldZoom) < precisionErrorTolerance) ||
        ((0.4 - newZoom) < precisionErrorTolerance &&
            (0.4 - oldZoom) < precisionErrorTolerance)) {
      return;
    }
    final focalPoint = info.eventPosition.global - screenCenter;
    final focalDelta = (focalPoint - _startPosition) / newZoom;
    camera.moveBy(focalDelta * (zoomDelta / newZoom) + delta);
  }

  @override
  void onScaleEnd(ScaleEndInfo info) {
    _scaleStartedOnHand = false;
    settingsCubit.resetZoom(camera.viewfinder.zoom);
  }

  @override
  void onScroll(PointerScrollInfo info) {
    final handled = componentsAtPoint(
      info.eventPosition.widget,
    ).whereType<ScrollCallbacks>().any((element) => element.onScroll(info));
    if (handled) return;
    camera.viewfinder.zoom +=
        info.scrollDelta.global.y.sign * zoomPerScrollUnit;
  }

  Vector2 _currentCameraVelocity = Vector2.zero();

  @override
  void update(double dt) {
    super.update(dt);

    if (!_currentCameraVelocity.isZero()) {
      final zoom = camera.viewfinder.zoom;
      camera.moveBy(_currentCameraVelocity * dt * 500 / zoom);
    }
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    var handled = false;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.escape:
        if (event is KeyDownEvent) {
          if (bloc.state.showHand) {
            bloc.add(HandChanged(show: false));
          } else {
            onEscape();
          }
        }
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
      case LogicalKeyboardKey.arrowLeft:
        if (bloc.state.showHand) {
          if (event is KeyDownEvent) _hand.moveLeft();
          handled = true;
        }
      case LogicalKeyboardKey.arrowRight:
        if (bloc.state.showHand) {
          if (event is KeyDownEvent) _hand.moveRight();
          handled = true;
        }
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

  void showContextMenu({
    required Widget Function(BuildContext, VoidCallback onClose)
    contextMenuBuilder,
  }) {
    final context = buildContext;
    if (context == null) return;
    contextMenuController.show(
      context: context,
      contextMenuBuilder: (context) =>
          contextMenuBuilder(context, contextMenuController.remove),
    );
  }

  void teleport(GlobalVectorDefinition position) {
    final table = position.table;
    if (table != bloc.state.world.tableName) {
      bloc.add(TableSwitched(table));
    }
    final cellSize = grid.cellSize;
    camera.moveTo(
      (position.position.toVector()..multiply(cellSize)) + cellSize / 2,
    );
  }
}
