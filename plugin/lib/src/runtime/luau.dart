import 'dart:async';
import 'dart:convert';

import '../rust/api/luau.dart' as rust;
import '../rust/api/plugin.dart' as rust;
import 'callback.dart';

export 'callback.dart';

// Both native and web use the generated bridge. Lua's synchronous getters read
// a snapshot; only Process/Send await Dart, allowing the browser loop to run.
class LuauPlugin implements rust.RustPlugin {
  final PluginCallback _callbacks;
  bool _disposed = false;
  late final rust.PluginCallback _callback;
  late final rust.LuauPlugin _plugin;
  Future<void> _effects = Future.value();

  LuauPlugin({required String code, required PluginCallback callback})
    : _callbacks = callback {
    _checkActive();
    _callback = rust.PluginCallback(
      processEvent: (event, force) async {
        await _flushEffects();
        await _callbacks.processEvent(event, force);
        await _refresh();
      },
      sendEvent: (event, target) async {
        await _flushEffects();
        await _callbacks.sendEvent(event, target);
        await _refresh();
      },
    );
    _plugin = rust.LuauPlugin(code: code, callback: _callback);
  }

  Future<void> _refresh() async {
    _checkActive();
    final fields = Map.fromEntries(
      await Future.wait(
        rust.StateFieldAccess.values.map((field) async {
          final value = await _callbacks.stateFieldAccess(field);
          jsonDecode(value);
          return MapEntry(field, value);
        }),
      ),
    );
    final names = (jsonDecode(fields[rust.StateFieldAccess.tables]!) as List)
        .cast<String>();
    final current =
        jsonDecode(fields[rust.StateFieldAccess.tableName]!) as String?;
    final tables = Map.fromEntries(
      await Future.wait(
        <String?>{null, current, ...names}.map((name) async {
          final value = await _callbacks.tableAccess(name);
          jsonDecode(value);
          return MapEntry(name, value);
        }),
      ),
    );
    final storage = await _callbacks.storageRead();
    jsonDecode(storage);
    _checkActive();
    _callback.setSnapshot(
      fields: fields,
      tables: {
        for (final entry in tables.entries)
          if (entry.key != null) entry.key!: entry.value,
      },
      currentTable: tables[null]!,
      storage: storage,
    );
  }

  Future<void> _flushEffects() {
    _checkActive();
    final effects = _callback.takeEffects();
    _effects = _effects.then((_) async {
      for (final effect in effects) {
        _checkActive();
        switch (effect.method) {
          case 'onPrint':
            await _callbacks.onPrint(effect.value);
          case 'storageWrite':
            await _callbacks.storageWrite(effect.value);
          default:
            throw StateError('Unknown Luau callback: ${effect.method}');
        }
      }
    });
    unawaited(_effects.catchError((Object _) {}));
    return _effects;
  }

  Future<T> _run<T>(Future<T> Function() action) async {
    await _flushEffects();
    await _refresh();
    try {
      return await action();
    } finally {
      await _flushEffects();
    }
  }

  void _checkActive() {
    if (_disposed) throw StateError('Luau plugin has been disposed');
    _callbacks.checkActive();
  }

  @override
  Future<void> run() {
    _checkActive();
    return _run(_plugin.run);
  }

  @override
  Future<rust.EventResult> runEvent({
    required String eventType,
    required String event,
    String? serverEvent,
    required int source,
    required bool cancelled,
    required int target,
  }) {
    _checkActive();
    return _run(
      () => _plugin.runEvent(
        eventType: eventType,
        event: event,
        serverEvent: serverEvent,
        source: source,
        cancelled: cancelled,
        target: target,
      ),
    );
  }

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _plugin.dispose();
    _callback.dispose();
  }
}
