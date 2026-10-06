import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:setonix/board/cell.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:setonix/bloc/multiplayer.dart';
import 'package:setonix/bloc/settings.dart';
import 'package:setonix/bloc/world/bloc.dart';
import 'package:setonix/bloc/world/state.dart';
import 'package:setonix/board/game.dart';
import 'package:setonix/helpers/asset.dart';
import 'package:setonix/services/file_system.dart';
import 'package:setonix/services/network.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _World extends Bloc<PlayableWorldEvent, ClientWorldState>
    implements WorldBloc {
  _World(super.initialState);
  void project(WorldState world) => emit(state.copyWith(world: world));
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Assets extends GameAssetManager {
  final SetonixData pack;
  Completer<void>? delayFigures;
  @override
  Future<Sprite?> loadFigureSprite(
    ItemLocation location, [
    String? variation,
  ]) async {
    await delayFigures?.future;
    return super.loadFigureSprite(location, variation);
  }

  _Assets(this.pack) : super(fileSystem: SetonixFileSystem());
  @override
  Iterable<MapEntry<String, SetonixData>> get packs => [MapEntry('core', pack)];
  @override
  SetonixData? getPack(String key) => key == 'core' ? pack : null;
  @override
  bool hasPack(String key) => key == 'core';
  @override
  Uint8List? getTextureFromLocation(ItemLocation location) =>
      pack.getTexture(location.id);
}

void main() {
  testWidgets('merged hands keep one continuous background after hits', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1100, 600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    SharedPreferences.setMockInitialValues({});
    final settings = SettingsCubit(await SharedPreferences.getInstance());
    final multiplayer = MultiplayerCubit(NetworkService(settings));
    final assets = _Assets(
      SetonixData.fromData(File('assets/pack.stnx').readAsBytesSync()),
    );
    var world = WorldState(
      data: SetonixData.empty(),
      info: GameInfo(packs: ['core']),
    );
    WorldState apply(ServerWorldEvent event) =>
        processServerEvent(event, world, signature: const []).state!;
    world = apply(
      TableBoundsChanged(
        '',
        minCell: const VectorDefinition(0, 0),
        maxCell: const VectorDefinition(5, 1),
      ),
    );
    world = apply(
      CellMergeStrategyChanged(
        GlobalVectorDefinition('', 0, 1),
        const DistributeCellMergeStrategy(
          maxCards: 52,
          fillVariableSpace: true,
        ),
        span: 6,
      ),
    );
    List<GameObject> hand(int count) => [
      for (final rank in [
        'club-queen',
        'club-3',
        'heart-2',
        'diamond-9',
      ].take(count))
        GameObject(ItemLocation('core', 'cards'), variation: rank),
    ];
    world = apply(ObjectsChanged(GlobalVectorDefinition('', 0, 1), hand(2)));
    final bloc = _World(
      ClientWorldState(
        world: world,
        multiplayer: multiplayer,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        assetManager: assets,
      ),
    );
    final game = BoardGame(
      bloc: bloc,
      settingsCubit: settings,
      contextMenuController: ContextMenuController(),
      onEscape: () {},
      onChat: () {},
    );
    final key = GlobalKey();
    await tester.pumpWidget(
      MaterialApp(
        home: RepaintBoundary(
          key: key,
          child: GameWidget(game: game),
        ),
      ),
    );
    Future<void> frames() async {
      for (var i = 0; i < 12; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 10)),
        );
        await tester.pump(const Duration(milliseconds: 16));
      }
    }

    await frames();
    // Hold image loading while another hit arrives to reproduce overlapping
    // projections, which used to append obsolete cards to the latest hand.
    final delayed = assets.delayFigures = Completer<void>();
    world = apply(ObjectsChanged(GlobalVectorDefinition('', 0, 1), hand(3)));
    bloc.project(world);
    await tester.pump(const Duration(milliseconds: 16));
    await tester.pump(const Duration(milliseconds: 16));
    world = apply(ObjectsChanged(GlobalVectorDefinition('', 0, 1), hand(4)));
    bloc.project(world);
    await tester.pump(const Duration(milliseconds: 16));
    await tester.pump(const Duration(milliseconds: 16));
    assets.delayFigures = null;
    delayed.complete();
    await frames();
    final handCell = game.grid.children.whereType<GameCell>().singleWhere(
      (cell) => cell.position == Vector2(0, 128),
    );
    expect(handCell.children.whereType<SpriteComponent>(), hasLength(4));
    final boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = (await tester.runAsync(() => boundary.toImage()))!;
    final bytes = await tester.runAsync(
      () => image.toByteData(format: ui.ImageByteFormat.rawRgba),
    );
    final pixels = bytes!.buffer.asUint8List();
    List<int> pixel(Vector2 point) {
      final offset = (point.y.round() * image.width + point.x.round()) * 4;
      return pixels.sublist(offset, offset + 4);
    }

    // The hand's right margin must have the same texture as the row above.
    expect(
      pixel(game.camera.localToGlobal(Vector2(597, 192))),
      pixel(game.camera.localToGlobal(Vector2(597, 64))),
    );
    expect(
      pixel(game.camera.localToGlobal(Vector2(597, 192))),
      isNot([51, 60, 87, 255]),
    );
    image.dispose();
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
    await bloc.close();
    await multiplayer.close();
    await settings.close();
  });
}
