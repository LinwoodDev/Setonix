import 'dart:ui' as ui;

import 'package:flame/game.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
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

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('a world without packs has a visible board', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final settings = SettingsCubit(await SharedPreferences.getInstance());
    final multiplayer = MultiplayerCubit(NetworkService(settings));
    final colors = ColorScheme.fromSeed(seedColor: Colors.teal);
    final bloc = _World(
      ClientWorldState(
        world: WorldState(data: SetonixData.empty()),
        multiplayer: multiplayer,
        colorScheme: colors,
        assetManager: GameAssetManager(fileSystem: SetonixFileSystem()),
      ),
    );
    final game = BoardGame(
      bloc: bloc,
      settingsCubit: settings,
      contextMenuController: ContextMenuController(),
      onEscape: () {},
      onChat: () {},
    );
    final boundaryKey = GlobalKey();
    await tester.pumpWidget(
      MaterialApp(
        home: RepaintBoundary(
          key: boundaryKey,
          child: GameWidget(game: game),
        ),
      ),
    );
    for (var i = 0; i < 12; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 10)),
      );
      await tester.pump(const Duration(milliseconds: 16));
    }

    final boundary =
        boundaryKey.currentContext!.findRenderObject()!
            as RenderRepaintBoundary;
    final image = (await tester.runAsync(() => boundary.toImage()))!;
    final bytes = await tester.runAsync(
      () => image.toByteData(format: ui.ImageByteFormat.rawRgba),
    );
    final data = bytes!.buffer.asUint8List();
    var visiblePixels = 0;
    for (var offset = 0; offset < data.length; offset += 4) {
      if ((data[offset] | data[offset + 1] | data[offset + 2]) != 0 &&
          data[offset + 3] == 255) {
        visiblePixels++;
      }
    }
    image.dispose();
    expect(visiblePixels, greaterThan(data.length ~/ 8));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
    await bloc.close();
    await multiplayer.close();
    await settings.close();
  });
}
