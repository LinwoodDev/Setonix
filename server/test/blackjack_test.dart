import 'dart:convert';
import 'dart:io';

import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_plugin/setonix_plugin.dart';
import 'package:test/test.dart';

final script = File('../app/pack/scripts/blackjack.luau').readAsStringSync();

void main() {
  setUpAll(initPluginSystem);
  tearDownAll(disposePluginSystem);

  test('native scripting preserves empty arrays and missing values', () async {
    final game = await _Game.load(
      code: r'''
      local board = Setonix.tables.current()
      local minimum, maximum = board:bounds()
      assert(minimum == nil and maximum == nil)
      assert(Setonix.storage.get("missing", 42) == 42)
      Setonix.storage.set("empty", Setonix.collections.copy({}))
      board:cell(0, 0):setObjects({})
    ''',
    );
    addTearDown(game.dispose);
    expect((jsonDecode(game.storage) as Map)['empty'], isA<List>());
  });

  test('publishes live notes without leaking the dealer hole card', () async {
    final game = await _Game.load(
      saved: _round(
        rules: 'dealer',
        hands: [
          ['heart-10', 'club-7'],
          ['diamond-10', 'club-6'],
        ],
        dealer: ['heart-6', 'club-5'],
        deck: ['spade-6', 'spade-10'],
      ),
    );
    addTearDown(game.dispose);
    var note = game.state.data.getNote('Blackjack')!;
    expect(note, contains('Player 1'));
    expect(note, contains('[Hit](action:blackjack_hit)'));
    expect(note, contains('[Stand](action:blackjack_stand)'));
    expect(note, contains('[Switch rules](action:blackjack_rules)'));
    final toolbar = game.toolbars[1]!;
    expect(toolbar.editable, isFalse);
    expect(toolbar.actions.where((a) => a.showInToolbar).map((a) => a.id), [
      'blackjack_start',
      'blackjack_hit',
      'blackjack_stand',
    ]);
    expect(
      toolbar.actions.firstWhere((a) => a.id == 'blackjack_rules').enabled,
      isFalse,
    );
    expect(note, contains('**Dealer:** 6 + hidden card'));
    expect(note, isNot(contains('**Dealer:** 11')));
    await game.command(1, '/stand');
    expect(game.state.data.getNote('Blackjack'), contains("Player 2's turn"));
    await game.command(2, '/stand');
    note = game.state.data.getNote('Blackjack')!;
    expect(note, contains('Round complete'));
    expect(note, contains('[Next round](action:blackjack_start)'));
    expect(note, contains('**Dealer:** 17'));
    expect(note, isNot(contains('hidden card')));
    expect(await game.event(NoteChanged('Blackjack', 'changed'), 1), isTrue);
    expect(await game.event(NoteRemoved('Blackjack'), 1), isTrue);
  });

  test('deals two cards, enforces turns and leaves results visible', () async {
    final game = await _Game.load();
    addTearDown(game.dispose);
    await game.command(1, '/deal');
    expect(game.round['phase'], 'playing');
    expect(game.seats.length, 2);
    expect(
      game.seats.every((seat) => (seat['hand'] as List).length == 2),
      isTrue,
    );
    expect(game.state.table.minCell, const VectorDefinition(0, 0));
    expect(game.state.table.maxCell, const VectorDefinition(5, 2));
    final before = jsonEncode(game.round);
    await game.command(2, '/hit');
    expect(jsonEncode(game.round), before);
    await game.command(1, '/stand');
    expect(game.round['turn'], 2);
    final hand = List.of(game.seats.first['hand'] as List);
    await game.command(1, '/hit');
    expect(game.seats.first['hand'], hand);
    await game.command(2, '/stand');
    expect(game.round['phase'], 'finished');
    expect(game.seats.every((seat) => seat['result'] != null), isTrue);
    expect(
      game.state.table.getCell(const VectorDefinition(0, 1)).objects,
      hasLength(2),
    );
    expect(
      game.toolbars[1]!.actions
          .firstWhere((a) => a.id == 'blackjack_start')
          .enabled,
      isTrue,
    );
    await game.command(1, '/deal');
    expect(game.round['number'], 2);
  });

  test(
    'scores several aces, includes the busting card and prevents replay',
    () async {
      final game = await _Game.load(
        saved: _round(
          hands: [
            ['heart-ace', 'diamond-ace'],
            ['heart-10', 'club-7'],
          ],
          deck: ['spade-9', 'club-king', 'heart-king', 'spade-3'],
        ),
      );
      addTearDown(game.dispose);
      await game.command(1, '/hit');
      expect(game.seats.first['hand'], hasLength(3));
      // A + A + 9 = 21, automatically advances.
      expect(game.seats.first['status'], 'stood');
      expect(game.round['turn'], 2);
      await game.command(2, '/hit');
      expect(game.round['phase'], 'finished');
      expect(game.seats.last['status'], 'bust');
      expect(
        game.state.table.getCell(const VectorDefinition(0, 2)).objects,
        hasLength(3),
      );
      final before = jsonEncode(game.round);
      await game.command(2, '/hit');
      expect(jsonEncode(game.round), before);
    },
  );

  test(
    'dealer reveals hole card, draws to 17 and pushes equal totals',
    () async {
      final game = await _Game.load(
        saved: _round(
          rules: 'dealer',
          hands: [
            ['heart-10', 'club-7'],
            ['diamond-10', 'diamond-9'],
          ],
          dealer: ['heart-6', 'club-5'],
          deck: ['spade-6', 'spade-10'],
        ),
      );
      addTearDown(game.dispose);
      expect(
        game.state.table
            .getCell(const VectorDefinition(1, 0))
            .objects[1]
            .hidden,
        isTrue,
      );
      await game.command(1, '/stand');
      await game.command(2, '/stand');
      expect(game.round['dealer'], ['heart-6', 'club-5', 'spade-6']);
      expect(game.seats.first['result'], 'push');
      expect(game.seats.last['result'], 'win');
      expect(
        game.state.table
            .getCell(const VectorDefinition(1, 0))
            .objects
            .every((card) => !card.hidden),
        isTrue,
      );
    },
  );

  test('dealer stands on soft 17', () async {
    final game = await _Game.load(
      saved: _round(
        rules: 'dealer',
        hands: [
          ['heart-10', 'club-7'],
          ['diamond-ace', 'diamond-king'],
        ],
        statuses: ['playing', 'blackjack'],
        dealer: ['heart-ace', 'club-6'],
        deck: ['spade-6', 'spade-10'],
      ),
    );
    addTearDown(game.dispose);
    await game.command(1, '/stand');
    expect(game.round['dealer'], ['heart-ace', 'club-6']);
    expect(game.seats.first['result'], 'push');
    expect(game.seats.last['result'], 'win');
  });

  test('natural blackjack beats a dealer 21 made with three cards', () async {
    final saved = _round(
      rules: 'dealer',
      hands: [
        ['diamond-ace', 'diamond-king'],
        ['heart-7', 'club-7', 'diamond-7'],
      ],
      statuses: ['blackjack', 'playing'],
      dealer: ['heart-10', 'club-6'],
      deck: ['spade-5', 'spade-10'],
    )..['turn'] = 2;
    final game = await _Game.load(saved: saved);
    addTearDown(game.dispose);
    await game.command(2, '/stand');
    expect(game.round['dealer'], ['heart-10', 'club-6', 'spade-5']);
    expect(game.seats.first['result'], 'win');
    expect(game.seats.last['result'], 'push');
  });

  test('dealer blackjack pushes naturals and beats other 21s', () async {
    final game = await _Game.load(
      saved: _round(
        rules: 'dealer',
        hands: [
          ['heart-7', 'club-7', 'diamond-7'],
          ['diamond-ace', 'diamond-king'],
        ],
        statuses: ['playing', 'blackjack'],
        dealer: ['heart-ace', 'club-king'],
        deck: ['spade-6'],
      ),
    );
    addTearDown(game.dispose);
    await game.command(1, '/stand');
    expect(game.seats.first['result'], 'loss');
    expect(game.seats.last['result'], 'push');
  });

  test('rules are configurable only by the host between rounds', () async {
    final game = await _Game.load();
    addTearDown(game.dispose);
    await game.command(2, '/rules dealer');
    expect(game.round['rules'], 'competitive');
    await game.command(1, '/rules dealer');
    expect(game.round['rules'], 'dealer');
    await game.command(1, '/deal');
    await game.command(1, '/rules competitive');
    expect(game.round['rules'], 'dealer');
  });

  test(
    'late join spectates and leaving the active seat advances the round',
    () async {
      final game = await _Game.load(
        saved: _round(
          hands: [
            ['heart-10', 'club-7'],
            ['diamond-10', 'diamond-9'],
          ],
          deck: ['spade-6'],
        ),
      );
      addTearDown(game.dispose);
      game.players.add(3);
      await game.event(
        UserJoined(channel: 3, info: const ConnectionInfoMapper().decode({})),
        3,
      );
      expect(game.seats, hasLength(2));
      expect(
        game.toolbars[3]!.actions
            .firstWhere((a) => a.id == 'blackjack_hit')
            .enabled,
        isFalse,
      );
      game.players.remove(1);
      game.plugin.eventSystem.runLeaveCallback(
        1,
        const ConnectionInfoMapper().decode({}),
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(game.seats.first['status'], 'left');
      expect(game.round['turn'], 2);
      await game.command(2, '/stand');
      expect(game.round['phase'], 'finished');
      await game.command(2, '/deal');
      expect(game.seats.map((seat) => seat['id']), [2, 3]);
    },
  );

  test('reload retains deck order, hands, rules and current turn', () async {
    final game = await _Game.load(
      saved: _round(
        rules: 'dealer',
        hands: [
          ['heart-10', 'club-7'],
          ['diamond-10', 'diamond-9'],
        ],
        deck: ['spade-2', 'spade-3'],
        dealer: ['club-8', 'club-6'],
      ),
    );
    await game.command(1, '/stand');
    final saved = Map<String, dynamic>.from(game.round);
    game.dispose();
    final restored = await _Game.load(saved: saved);
    addTearDown(restored.dispose);
    expect(restored.round['turn'], 2);
    expect(restored.round['deck'], ['spade-2', 'spade-3']);
    expect(restored.round['rules'], 'dealer');
    await restored.command(2, '/hit');
    expect(restored.seats.last['hand'], ['diamond-10', 'diamond-9', 'spade-2']);
    expect(restored.round['phase'], 'finished');
  });

  test('empty deck stands instead of locking the turn', () async {
    final game = await _Game.load(
      saved: _round(
        hands: [
          ['heart-10', 'club-7'],
          ['diamond-10', 'diamond-9'],
        ],
        deck: [],
      ),
    );
    addTearDown(game.dispose);
    await game.command(1, '/hit');
    expect(game.round['turn'], 2);
    await game.command(2, '/stand');
    expect(game.round['phase'], 'finished');
  });

  test(
    'queued board updates cannot reuse a card or lose the busting card',
    () async {
      final game = await _Game.load(
        queued: true,
        saved: _round(
          hands: [
            ['heart-10', 'club-5'],
            ['diamond-10', 'diamond-9'],
          ],
          deck: ['spade-2', 'spade-king', 'spade-3'],
        ),
      );
      addTearDown(game.dispose);
      await game.command(1, '/hit');
      await game.command(1, '/hit');
      expect(game.seats.first['hand'], [
        'heart-10',
        'club-5',
        'spade-2',
        'spade-king',
      ]);
      expect(game.seats.first['status'], 'bust');
      expect(game.round['deck'], ['spade-3']);
      game.flush();
      final hand = game.state.table
          .getCell(const VectorDefinition(0, 1))
          .objects;
      expect(hand.map((card) => card.variation), [
        'heart-10',
        'club-5',
        'spade-2',
        'spade-king',
      ]);
    },
  );

  test('dragging the deck uses the same turn rules as the toolbar', () async {
    final game = await _Game.load(
      saved: _round(
        hands: [
          ['heart-10', 'club-5'],
          ['diamond-10', 'diamond-9'],
        ],
        deck: ['spade-6', 'spade-3'],
      ),
    );
    addTearDown(game.dispose);
    expect(
      await game.event(
        ObjectsMoved(
          '',
          [0],
          const VectorDefinition(0, 0),
          const VectorDefinition(0, 1),
        ),
        2,
      ),
      isTrue,
    );
    expect(game.round['deck'], ['spade-6', 'spade-3']);
    expect(
      await game.event(
        ObjectsMoved(
          '',
          [0],
          const VectorDefinition(0, 0),
          const VectorDefinition(0, 1),
        ),
        1,
      ),
      isTrue,
    );
    expect(game.seats.first['status'], 'stood');
    expect(game.round['turn'], 2);
    expect(game.seats.first['hand'], hasLength(3));
  });

  test(
    'blocks sandbox edits and restores table bounds when the mode closes',
    () async {
      final game = await _Game.load();
      addTearDown(game.dispose);
      expect(
        await game.event(
          TableBoundsChanged(
            '',
            minCell: const VectorDefinition(-9, -9),
            maxCell: const VectorDefinition(9, 9),
          ),
          1,
        ),
        isTrue,
      );
      expect(
        await game.event(CellHideChanged(GlobalVectorDefinition('', 0, 0)), 1),
        isTrue,
      );
      expect(
        await game.event(
          ShuffleCellRequest(GlobalVectorDefinition('', 0, 0)),
          1,
        ),
        isTrue,
      );
      await game.plugin.close();
      expect(game.state.table.isRestricted, isFalse);
      expect(game.toolbars[0]!.editable, isTrue);
    },
  );
}

Map<String, dynamic> _round({
  String rules = 'competitive',
  required List<List<String>> hands,
  required List<String> deck,
  List<String> dealer = const [],
  List<String> statuses = const ['playing', 'waiting'],
}) => {
  'version': 2,
  'tableName': '',
  'rules': rules,
  'host': 1,
  'number': 1,
  'phase': 'playing',
  'turn': 1,
  'rows': hands.length,
  'deck': deck,
  'dealer': dealer,
  'players': [
    for (var i = 0; i < hands.length; i++)
      {'id': i + 1, 'hand': hands[i], 'status': statuses[i]},
  ],
};

class _Game implements PluginServerInterface {
  @override
  WorldState state = WorldState(data: SetonixData.empty());
  @override
  final List<int> players;
  final bool queued;
  final pending = <PlayableWorldEvent>[];

  _Game({List<int>? ids, this.queued = false}) : players = ids ?? [1, 2];
  String storage = '{}';
  late RustSetonixPlugin plugin;
  final toolbars = <int, GameToolbar>{};
  final sent = <PlayableWorldEvent>[];

  Map<String, dynamic> get round =>
      (jsonDecode(storage) as Map)['round'] as Map<String, dynamic>;
  List<Map<String, dynamic>> get seats =>
      (round['players'] as List).cast<Map<String, dynamic>>();

  static Future<_Game> load({
    Map<String, dynamic>? saved,
    String? code,
    List<int>? ids,
    bool queued = false,
  }) async {
    final game = _Game(ids: ids, queued: queued);
    if (saved != null) game.storage = jsonEncode({'round': saved});
    game.plugin = await RustSetonixPlugin.build(
      (callback) => LuauPlugin(
        code: code ?? 'math.randomseed(42)\n$script',
        callback: callback,
      ),
      game,
      location: ItemLocation('core', 'blackjack'),
    );
    return game;
  }

  Future<void> command(int id, String text) async {
    expect(await event(MessageRequest(text), id), isTrue);
  }

  Future<bool> event(WorldEvent input, int source) async {
    final event = Event(
      clientEvent: input,
      source: source,
      target: 0,
      serverEvent: null,
    );
    await plugin.eventSystem.fire(event);
    return event.cancelled;
  }

  @override
  Future<void> process(WorldEvent event, {bool force = false}) async =>
      throw StateError('Unexpected client request: $event');

  @override
  Future<void> sendEvent(PlayableWorldEvent event, {int target = 0}) async {
    sent.add(event);
    if (queued &&
        event is ServerWorldEvent &&
        event is! ToolbarUpdated &&
        event is! MessageSent) {
      pending.add(event);
      return;
    }
    apply(event, target);
  }

  void flush() {
    for (final event in pending) {
      apply(event, 0);
    }
    pending.clear();
  }

  void apply(PlayableWorldEvent event, int target) {
    if (event is ToolbarUpdated) {
      toolbars[target] = event.toolbar;
    } else if (event is ServerWorldEvent && event is! MessageSent) {
      final result = processServerEvent(event, state, signature: const []);
      if (result.state != null) state = result.state!;
    }
  }

  @override
  String getScriptState(String plugin) => storage;
  @override
  void setScriptState(String plugin, String state) => storage = state;
  void dispose() => plugin.dispose();
}
