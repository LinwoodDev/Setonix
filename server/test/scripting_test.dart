import 'dart:io';

import 'package:setonix_server/setonix_server.dart';
import 'package:test/test.dart';

import 'support/script_game.dart';

class _Assets extends AssetManager {
  SetonixData pack;
  _Assets(this.pack);
  @override
  SetonixData? getPack(String key) => key == 'core' ? pack : null;
  @override
  bool hasPack(String key) => key == 'core';
  @override
  Iterable<MapEntry<String, SetonixData>> get packs => [MapEntry('core', pack)];
}

void main() {
  setUpAll(initPluginSystem);
  tearDownAll(disposePluginSystem);

  test(
    'the chess pack mode loads its Luau script onto the prepared board',
    () async {
      final mode = GameModeMapper.fromJson(
        File('../app/pack/modes/chess.json').readAsStringSync(),
      );
      final pack = SetonixData.empty()
          .setMode('chess', mode)
          .setScript(
            'chess.luau',
            File('../app/pack/scripts/chess.luau').readAsStringSync(),
          );
      final data = SetonixData.fromMode(pack.getModeItem('chess', 'core'));
      final game = ScriptGame(
        initial: WorldState(data: data, table: data.getTableOrDefault()),
      );
      final system = PluginSystem(server: game);
      addTearDown(() => system.dispose(false));
      expect(
        await system.loadGameMode(_Assets(pack), ItemLocation('core', 'chess')),
        isNotNull,
      );
      expect(game.state.table.cells, hasLength(100));
      expect(
        game.state.table
            .getCell(const VectorDefinition(5, 8))
            .objects
            .single
            .variation,
        'king',
      );
      expect(game.state.data.getNote('Chess'), contains('White to move'));
    },
  );

  test(
    'pack scripts migrate legacy storage independently, including clearing',
    () async {
      final game = ScriptGame();
      game.states['core'] = '{"round":{"version":2}}';
      final system = PluginSystem(server: game);
      addTearDown(() => system.dispose(false));
      final assets = _Assets(
        SetonixData.empty()
            .setScript('blackjack.luau', '''
        assert(Setonix.storage.get("round").version == 2)
        Setonix.storage.set("round", {version = 2})
      ''')
            .setScript('chess.luau', '''
        Setonix.storage.set("round", {version = 1})
      '''),
      );
      await system.loadLuaPluginFromLocation(
        assets,
        ItemLocation('core', 'blackjack.luau'),
      );
      await system.loadLuaPluginFromLocation(
        assets,
        ItemLocation('core', 'chess.luau'),
      );
      await system.loadLuaPluginFromLocation(
        assets,
        ItemLocation('core', 'blackjack.luau'),
      );
      assets.pack = assets.pack.setScript(
        'blackjack.luau',
        'Setonix.storage.clear()',
      );
      await system.loadLuaPluginFromLocation(
        assets,
        ItemLocation('core', 'blackjack.luau'),
      );
      assets.pack = assets.pack.setScript(
        'blackjack.luau',
        'assert(Setonix.storage.get("round") == nil)',
      );
      await system.loadLuaPluginFromLocation(
        assets,
        ItemLocation('core', 'blackjack.luau'),
      );
      expect(
        game.states.keys,
        containsAll(['core', 'core:blackjack.luau', 'core:chess.luau']),
      );
    },
  );

  test(
    'guard cancels before errors and releases its shared action lock',
    () async {
      final game = await ScriptGame.load(r'''
      local lock = {}
      Setonix.events.action("fail", Setonix.events.guard(function() error("expected test failure") end, lock))
      Setonix.events.action("ok", Setonix.events.guard(function()
        Setonix.storage.set("ran", true)
      end, lock))
      Setonix.events.block({"note_changed"}, function(event) return event.name == "Protected" end)
    ''');
      addTearDown(game.dispose);
      expect(await game.action(1, 'fail'), isTrue);
      expect(await game.action(1, 'ok'), isTrue);
      expect(game.stored['ran'], isTrue);
      expect(await game.event(NoteChanged('Protected', 'changed'), 1), isTrue);
      expect(await game.event(NoteChanged('Other', 'changed'), 1), isFalse);
    },
  );

  test('dedicated server routes actions to their own world scripts', () async {
    final directory = await Directory.systemTemp.createTemp(
      'setonix-script-world-',
    );
    final server = await SetonixServer.load(
      rootPath: directory.path,
      argsConfig: const SetonixConfig(autosave: false),
    );
    final world = WorldBloc(SetonixData.empty(), server, 'chess-world');
    var localCalls = 0;
    var defaultCalls = 0;
    await world.pluginSystem.registerPlugin('test', (interface) {
      final plugin = SetonixPlugin(interface);
      plugin.eventSystem.on<MessageRequest>((event) {
        localCalls++;
        event.cancel();
      });
      return plugin;
    });
    await server.defaultWorld.pluginSystem.registerPlugin('test', (interface) {
      final plugin = SetonixPlugin(interface);
      plugin.eventSystem.on<MessageRequest>((event) {
        defaultCalls++;
        event.cancel();
      });
      return plugin;
    });
    addTearDown(() async {
      await world.close();
      await server.close();
      await directory.delete(recursive: true);
    });
    await world.onClientEvent(
      NetworkerPacket(MessageRequest('/move e2e4'), kAuthorityChannel),
    );
    expect(localCalls, 1);
    expect(defaultCalls, 0);
  });
}
