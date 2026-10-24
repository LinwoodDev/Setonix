import 'dart:convert';

import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_plugin/setonix_plugin.dart';

/// Exercises the real Luau VM while optionally delaying its board projection.
class ScriptGame implements PluginServerInterface, ServerInterface {
  @override
  WorldState state;
  @override
  final List<int> players;
  final bool queued;
  final pending = <(PlayableWorldEvent, int)>[];
  final states = <String, String>{};
  final toolbars = <int, GameToolbar>{};
  final sent = <PlayableWorldEvent>[];
  late RustSetonixPlugin plugin;

  ScriptGame({List<int>? ids, this.queued = false, WorldState? initial})
    : players = ids ?? [1, 2],
      state = initial ?? WorldState(data: SetonixData.empty());

  static Future<ScriptGame> load(
    String code, {
    Map<String, dynamic>? saved,
    List<int>? ids,
    bool queued = false,
  }) async {
    final game = ScriptGame(ids: ids, queued: queued);
    if (saved != null) game.states['test'] = jsonEncode(saved);
    game.plugin = await RustSetonixPlugin.build(
      (callback) => LuauPlugin(code: code, callback: callback),
      game,
      location: ItemLocation('core', 'chess.luau'),
      storageKey: 'test',
    );
    return game;
  }

  Map<String, dynamic> get stored =>
      jsonDecode(states['test'] ?? '{}') as Map<String, dynamic>;
  Map<String, dynamic> get match =>
      stored['chess.match'] as Map<String, dynamic>;
  Map<String, dynamic> get position =>
      match['position'] as Map<String, dynamic>;
  Map<String, dynamic> get board => position['board'] as Map<String, dynamic>;

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

  Future<bool> command(int source, String command) =>
      event(MessageRequest(command), source);
  Future<bool> action(int source, String action) =>
      event(ToolbarActionRequest(action), source);

  Future<void> leave(int source) async {
    players.remove(source);
    await plugin.plugin.runEvent(
      eventType: 'UserLeft',
      event: jsonEncode({'type': 'UserLeft', 'channel': source}),
      source: source,
      target: 0,
      cancelled: false,
    );
  }

  Future<void> join(int source) async {
    players.add(source);
    await plugin.plugin.runEvent(
      eventType: 'UserJoined',
      event: jsonEncode({'type': 'UserJoined', 'channel': source}),
      source: source,
      target: 0,
      cancelled: false,
    );
  }

  @override
  Future<void> process(
    WorldEvent event, {
    bool force = false,
    String? plugin,
  }) async => throw StateError('Unexpected request: $event');

  @override
  Future<void> sendEvent(
    PlayableWorldEvent event, {
    int target = 0,
    String? plugin,
  }) async {
    sent.add(event);
    if (queued &&
        event is ServerWorldEvent &&
        event is! ToolbarUpdated &&
        event is! MessageSent) {
      pending.add((event, target));
    } else {
      apply(event, target);
    }
  }

  void apply(PlayableWorldEvent event, int target) {
    if (event is ToolbarUpdated) {
      toolbars[target] = event.toolbar;
    } else if (event is ServerWorldEvent && event is! MessageSent) {
      final result = processServerEvent(event, state, signature: const []);
      if (result.state != null) state = result.state!;
    }
  }

  void flush() {
    for (final (event, target) in pending) {
      apply(event, target);
    }
    pending.clear();
  }

  @override
  String getScriptState(String plugin) => states[plugin] ?? '{}';
  @override
  void setScriptState(String plugin, String state) => states[plugin] = state;
  @override
  void print(String message, [String? plugin]) {}
  void dispose() => plugin.dispose();
}
