import 'dart:convert';
import 'dart:io';

import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_plugin/setonix_plugin.dart';
import 'package:test/test.dart';

import 'support/script_game.dart';

final script = File('../app/pack/scripts/chess.luau').readAsStringSync();
final rules = script.split('-- Mode integration.').first;
const fixtures = r'''
local function fen(text)
  local fields = string.split(text, " ")
  local position = {board = {}, turn = fields[2], rights = fields[3] == "-" and "" or fields[3], ep = fields[4] ~= "-" and fields[4] or nil, halfmove = tonumber(fields[5]) or 0, fullmove = tonumber(fields[6]) or 1}
  for y, rank in ipairs(string.split(fields[1], "/")) do
    local x = 1
    for index = 1, #rank do
      local char = string.sub(rank, index, index)
      if tonumber(char) then x += tonumber(char)
      else
        position.board[square(x, y)] = (char == string.upper(char) and "w" or "b") .. string.lower(char)
        x += 1
      end
    end
  end
  return position
end
local function perft(position, depth)
  if depth == 0 then return 1 end
  local count = 0
  for _, move in ipairs(Chess.moves(position)) do count += perft(Chess.apply(position, move), depth - 1) end
  return count
end
''';

Future<void> checkRules(String assertions) async {
  final game = await ScriptGame.load('$rules\n$fixtures\n$assertions');
  game.dispose();
}

Map<String, dynamic> matchPosition(
  Map<String, String> board, {
  String turn = 'w',
  String rights = '',
  String? ep,
  int halfmove = 0,
}) => {
  'chess.match': <String, dynamic>{
    'version': 1,
    'position': {
      'board': board,
      'turn': turn,
      'rights': rights,
      'ep': ep,
      'halfmove': halfmove,
      'fullmove': 1,
    },
    'tableName': '',
    'phase': 'playing',
    'seats': {'w': 1, 'b': 2},
    'hotseat': false,
    'repetitions': <String, int>{},
    'history': <String>[],
    'votes': <String, bool>{},
  },
};

void main() {
  setUpAll(initPluginSystem);
  tearDownAll(disposePluginSystem);

  test(
    'initial and castling-rich positions have known legal move counts',
    () async {
      await checkRules(r'''
      assert(perft(Chess.new(), 1) == 20)
      assert(perft(Chess.new(), 2) == 400)
      assert(perft(Chess.new(), 3) == 8902)
      local kiwi = fen("r3k2r/p1ppqpb1/bn2pnp1/3PN3/1p2P3/2N2Q1p/PPPBBPPP/R3K2R w KQkq - 0 1")
      assert(perft(kiwi, 1) == 48)
      assert(perft(kiwi, 2) == 2039)
    ''');
    },
  );

  test(
    'pins, king adjacency and en passant discovered checks are illegal',
    () async {
      await checkRules(r'''
      local p = fen("k3r3/8/8/3pP3/8/8/8/4K3 w - d6 0 1")
      assert(not Chess.find(p, "e5", "d6"))
      assert(Chess.find(p, "e5", "e6"))
      assert(Chess.key(p) == Chess.key(fen("k3r3/8/8/3pP3/8/8/8/4K3 w - - 0 1")))
      p = fen("k7/8/8/3pP3/8/8/8/4K3 w - d6 0 1")
      local capture = Chess.find(p, "e5", "d6")
      assert(capture and capture.enPassant)
      local next = Chess.apply(p, capture)
      assert(next.board.d6 == "wp" and next.board.d5 == nil and next.board.e5 == nil)
      assert(Chess.key(p) ~= Chess.key(fen("k7/8/8/3pP3/8/8/8/4K3 w - - 0 1")))
      assert(not Chess.find(fen("8/8/8/8/8/4k3/8/4K3 w - - 0 1"), "e1", "e2"))
      assert(not Chess.find(fen("k3r3/8/8/8/8/8/4R3/4K3 w - - 0 1"), "e2", "d2"))
    ''');
    },
  );

  test(
    'castling moves the rook, checks transit and consumes historical rights',
    () async {
      await checkRules(r'''
      local p = fen("r3k2r/8/8/8/8/8/8/R3K2R w KQkq - 0 1")
      local next = Chess.apply(p, Chess.find(p, "e1", "g1"))
      assert(next.board.g1 == "wk" and next.board.f1 == "wr" and not next.board.h1)
      assert(next.rights == "kq")
      next = Chess.apply(p, Chess.find(p, "a1", "a8"))
      assert(next.rights == "Kk")
      p = fen("4kr2/8/8/8/8/8/8/R3K2R w KQ - 0 1")
      assert(not Chess.find(p, "e1", "g1") and Chess.find(p, "e1", "c1"))
      p = fen("r3k2r/8/8/8/8/8/8/R3K2R b KQkq - 0 1")
      next = Chess.apply(p, Chess.find(p, "e8", "c8"))
      assert(next.board.c8 == "bk" and next.board.d8 == "br" and next.rights == "KQ")
    ''');
    },
  );

  test(
    'all four promotions and insufficient-material cases are distinguished',
    () async {
      await checkRules(r'''
      local p = fen("4k3/P7/8/8/8/8/8/4K3 w - - 0 1")
      for _, kind in ipairs({"q", "r", "b", "n"}) do
        local next = Chess.apply(p, Chess.find(p, "a7", "a8", kind))
        assert(next.board.a8 == "w" .. kind and next.halfmove == 0)
      end
      assert(Chess.insufficient(fen("4k3/8/8/8/8/8/8/4K3 w - - 0 1")))
      assert(Chess.insufficient(fen("4k3/8/8/8/8/8/8/2B1K3 w - - 0 1")))
      assert(not Chess.insufficient(fen("4k3/8/8/8/8/8/8/1NN1K3 w - - 0 1")))
      assert(not Chess.insufficient(fen("4k3/8/8/8/8/8/8/2BNK3 w - - 0 1")))
      assert(not Chess.valid({}))
      assert(not Chess.valid(fen("8/8/8/8/8/8/8/4K3 w - - 0 1")))
    ''');
    },
  );

  test(
    'dragging validates turn, ownership, piece indices and captures',
    () async {
      final game = await ScriptGame.load(script, ids: [1, 2, 3]);
      addTearDown(game.dispose);
      final before = jsonEncode(game.position);
      await game.command(2, '/move e2e4');
      await game.command(3, '/move e2e4');
      await game.event(
        ObjectsMoved(
          '',
          [0, 1],
          const VectorDefinition(5, 7),
          const VectorDefinition(5, 5),
        ),
        1,
      );
      await game.event(
        ObjectsMoved(
          'other',
          [0],
          const VectorDefinition(5, 7),
          const VectorDefinition(5, 5),
        ),
        1,
      );
      expect(jsonEncode(game.position), before);
      expect(
        await game.event(
          ObjectsMoved(
            '',
            [0],
            const VectorDefinition(5, 7),
            const VectorDefinition(5, 5),
          ),
          1,
        ),
        isTrue,
      );
      await game.command(2, '/move d7d5');
      await game.command(1, '/move e4d5');
      expect(game.board['d5'], 'wp');
      expect(game.board['e4'], isNull);
      expect(
        game.state.table.getCell(const VectorDefinition(4, 4)).objects,
        hasLength(1),
      );
      expect(
        game.state.table
            .getCell(const VectorDefinition(4, 4))
            .objects
            .single
            .asset
            .id,
        'chess_white',
      );
      expect(game.state.data.getNote('Chess'), contains('Black to move'));
      expect(game.toolbars[3]!.editable, isFalse);
    },
  );

  test('queued board updates never become the source of chess state', () async {
    final game = await ScriptGame.load(script, queued: true);
    addTearDown(game.dispose);
    await game.command(1, '/move e2e4');
    await game.command(2, '/move d7d5');
    await game.command(1, '/move e4d5');
    expect(game.board['d5'], 'wp');
    game.flush();
    expect(
      game.state.table
          .getCell(const VectorDefinition(4, 4))
          .objects
          .single
          .variation,
      'pawn',
    );
    expect(
      game.state.table.getCell(const VectorDefinition(5, 5)).objects,
      isEmpty,
    );
  });

  test('promotion waits for the moving player and survives reload', () async {
    final game = await ScriptGame.load(
      script,
      saved: matchPosition({'e1': 'wk', 'e8': 'bk', 'a7': 'wp'}),
    );
    addTearDown(game.dispose);
    await game.command(1, '/move a7a8');
    expect(game.match['pending'], isNotNull);
    expect(game.board['a7'], 'wp');
    await game.action(2, 'chess_promote_q');
    expect(game.board['a7'], 'wp');
    final restored = await ScriptGame.load(script, saved: game.stored);
    addTearDown(restored.dispose);
    await restored.action(1, 'chess_promote_n');
    expect(restored.board['a8'], 'wn');
    expect(restored.match['pending'], isNull);
    expect(restored.match['phase'], 'finished');
  });

  test('checkmate blocks play and rematch needs both players', () async {
    final game = await ScriptGame.load(script, ids: [1, 2, 3]);
    addTearDown(game.dispose);
    for (final (id, move) in [
      (1, 'f2f3'),
      (2, 'e7e5'),
      (1, 'g2g4'),
      (2, 'd8h4'),
    ]) {
      await game.command(id, '/move $move');
    }
    expect(game.match['result'], 'Black wins by checkmate.');
    final before = jsonEncode(game.position);
    await game.command(1, '/move e2e4');
    await game.action(3, 'chess_rematch');
    await game.action(1, 'chess_rematch');
    expect(jsonEncode(game.position), before);
    await game.action(2, 'chess_rematch');
    expect(game.match['phase'], 'playing');
    expect(game.board, hasLength(32));
    expect(game.position['rights'], 'KQkq');
  });

  test('stalemate and seventy-five moves end automatically; fifty moves require a claim', () async {
    final stale = await ScriptGame.load(
      script,
      saved: matchPosition({'a8': 'bk', 'c6': 'wk', 'b6': 'wq'}, turn: 'b'),
    );
    addTearDown(stale.dispose);
    expect(stale.match['result'], 'Draw by stalemate.');
    final fifty = await ScriptGame.load(
      script,
      saved: matchPosition({'a8': 'bk', 'e1': 'wk', 'h1': 'wr'}, halfmove: 100),
    );
    addTearDown(fifty.dispose);
    expect(fifty.match['phase'], 'playing');
    await fifty.command(2, '/claim');
    expect(fifty.match['phase'], 'playing');
    await fifty.command(1, '/claim');
    expect(fifty.match['result'], contains('fifty-move'));
    final automatic = await ScriptGame.load(
      script,
      saved: matchPosition({'a8': 'bk', 'e1': 'wk', 'h1': 'wr'}, halfmove: 150),
    );
    addTearDown(automatic.dispose);
    expect(automatic.match['result'], contains('seventy-five'));
  });

  test('repetition can be claimed for an intended move and is automatic on five occurrences', () async {
    final game = await ScriptGame.load(script);
    addTearDown(game.dispose);
    Future<void> cycle() async {
      for (final (id, move) in [
        (1, 'g1f3'),
        (2, 'g8f6'),
        (1, 'f3g1'),
        (2, 'f6g8'),
      ]) {
        await game.command(id, '/move $move');
      }
    }

    await cycle();
    await game.command(1, '/move g1f3');
    await game.command(2, '/move g8f6');
    await game.command(1, '/move f3g1');
    final claiming = await ScriptGame.load(script, saved: game.stored);
    addTearDown(claiming.dispose);
    await claiming.command(2, '/claim f6g8');
    expect(claiming.match['result'], contains('threefold'));
    expect(claiming.board['f6'], 'bn');
    await game.command(2, '/move f6g8');
    expect(game.match['phase'], 'playing');
    await cycle();
    await cycle();
    expect(game.match['result'], contains('fivefold'));
  });

  test(
    'hot-seat, departures, replacement seats and draw offers work',
    () async {
      final solo = await ScriptGame.load(script, ids: [0]);
      addTearDown(solo.dispose);
      await solo.command(0, '/move e2e4');
      await solo.command(0, '/move e7e5');
      expect(solo.position['turn'], 'w');
      final game = await ScriptGame.load(script, ids: [1, 2, 3]);
      addTearDown(game.dispose);
      await game.leave(2);
      await game.command(1, '/move e2e4');
      expect(game.board['e2'], 'wp');
      await game.command(3, '/black');
      await game.command(1, '/move e2e4');
      await game.command(1, '/draw');
      expect(game.match['phase'], 'playing');
      await game.command(3, '/draw');
      expect(game.match['result'], 'Draw by agreement.');
    },
  );

  test(
    'restores rights and en passant on reload and rejects corrupt storage',
    () async {
      final game = await ScriptGame.load(script);
      addTearDown(game.dispose);
      await game.command(1, '/move e2e4');
      final restored = await ScriptGame.load(script, saved: game.stored);
      addTearDown(restored.dispose);
      expect(restored.position, game.position);
      final corrupt = game.stored;
      (corrupt['chess.match'] as Map)['position'] = {};
      final reset = await ScriptGame.load(script, saved: corrupt);
      addTearDown(reset.dispose);
      expect(reset.board, hasLength(32));
      expect(reset.position['turn'], 'w');
    },
  );

  test(
    'protects the board and note and restores previous bounds on close',
    () async {
      final saved = matchPosition({'a8': 'bk', 'e1': 'wk', 'h1': 'wr'});
      (saved['chess.match'] as Map).addAll(<String, dynamic>{
        'previousMin': {'x': -2, 'y': -3},
        'previousMax': {'x': 12, 'y': 13},
      });
      final game = await ScriptGame.load(script, saved: saved);
      addTearDown(game.dispose);
      expect(
        await game.event(ObjectsRemoved(GlobalVectorDefinition('', 5, 8)), 1),
        isTrue,
      );
      expect(await game.event(NoteChanged('Chess', 'changed'), 1), isTrue);
      expect(await game.event(NoteRemoved('Other'), 1), isFalse);
      await game.plugin.close();
      expect(game.state.table.minCell, const VectorDefinition(-2, -3));
      expect(game.state.table.maxCell, const VectorDefinition(12, 13));
      expect(game.toolbars[0]!.editable, isTrue);
    },
  );

  test(
    'joining a hot-seat game opens Black without resetting the position',
    () async {
      final game = await ScriptGame.load(script, ids: [0]);
      addTearDown(game.dispose);
      await game.command(0, '/move e2e4');
      await game.join(2);
      expect(game.match['hotseat'], isFalse);
      expect((game.match['seats'] as Map)['b'], isNull);
      await game.action(2, 'chess_black');
      await game.command(2, '/move e7e5');
      expect(game.board['e4'], 'wp');
      expect(game.board['e5'], 'bp');
    },
  );

  test(
    'checkmate takes precedence at the automatic move-count threshold',
    () async {
      final game = await ScriptGame.load(
        script,
        saved: matchPosition({
          'h8': 'bk',
          'f6': 'wk',
          'g6': 'wq',
        }, halfmove: 149),
      );
      addTearDown(game.dispose);
      await game.command(1, '/move g6g7');
      expect(game.position['halfmove'], 150);
      expect(game.match['result'], 'White wins by checkmate.');
    },
  );

  test('intended-move fifty-move claims do not move the piece', () async {
    final game = await ScriptGame.load(
      script,
      saved: matchPosition({'a8': 'bk', 'e1': 'wk', 'h1': 'wr'}, halfmove: 99),
    );
    addTearDown(game.dispose);
    await game.command(1, '/claim h1h2');
    expect(game.match['result'], contains('fifty-move'));
    expect(game.board['h1'], 'wr');
    expect(game.board['h2'], isNull);
  });

  test('resignation is permitted during promotion and cannot award a bare king a win', () async {
    final game = await ScriptGame.load(
      script,
      saved: matchPosition({'e1': 'wk', 'e8': 'bk', 'a7': 'wp', 'h8': 'br'}),
    );
    addTearDown(game.dispose);
    await game.command(1, '/move a7a8');
    await game.action(1, 'chess_resign');
    expect(game.match['result'], 'Black wins by resignation.');
    final bare = await ScriptGame.load(
      script,
      saved: matchPosition({'e1': 'wk', 'e8': 'bk', 'a7': 'wp'}),
    );
    addTearDown(bare.dispose);
    await bare.command(1, '/resign');
    expect(bare.match['result'], contains('Draw by resignation'));
  });
}
