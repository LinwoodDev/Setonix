import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart'
    show ExternalLibrary;
import 'package:web/web.dart' as web;

import '../rust/api/plugin.dart' show EventResult, StateFieldAccess;
import 'luau.dart';

@JS('setonixLuau')
external _BrowserRuntime get _browserRuntime;

extension type _BrowserRuntime(JSObject _) implements JSObject {
  external JSPromise<JSAny?> init();
  external JSNumber create(JSString code, JSFunction sync, JSFunction async);
  external JSPromise<JSString> run(JSNumber plugin, JSString event);
  external void destroy(JSNumber plugin);
  external void dispose();
}

Future<void>? _initializing;
bool _ready = false;

Future<void> initialize({ExternalLibrary? externalLibrary}) =>
    _initializing ??= _initialize();

Future<void> _initialize() async {
  try {
    final script =
        web.document.createElement('script') as web.HTMLScriptElement;
    final loaded = Completer<void>();
    script.src = Uri.parse(web.document.baseURI)
        .resolve('pkg/setonix_luau_runtime.js')
        .toString();
    script.onload = ((web.Event _) {
      loaded.complete();
    }).toJS;
    script.onerror = ((web.Event _) {
      loaded.completeError(
        StateError('Could not load the Luau web runtime at ${script.src}'),
      );
    }).toJS;
    web.document.head!.appendChild(script);
    await loaded.future;
    await _browserRuntime.init().toDart;
    _ready = true;
  } catch (_) {
    _initializing = null;
    rethrow;
  }
}

void disposeSystem() {
  if (_ready) _browserRuntime.dispose();
  // The compiled module can be reused; individual plugins have been destroyed.
}

LuauPlugin createPlugin(String code, PluginCallback callback) {
  if (!_ready)
    throw StateError(
      'Initialize the plugin system before creating a Luau plugin',
    );
  return _WebLuauPlugin(code, callback);
}

class _WebLuauPlugin extends LuauPlugin {
  late final JSNumber _id;
  final Map<String, String> _state = {};
  final Map<String?, String> _tables = {};
  String _storage = '{}';
  Future<void> _effects = Future.value();

  _WebLuauPlugin(String code, PluginCallback callback)
    : super.internal(callback) {
    _id = _browserRuntime.create(code.toJS, _sync.toJS, _async.toJS);
  }

  Future<void> _refresh() async {
    checkActive();
    final fields = await Future.wait(
      StateFieldAccess.values.map((field) async {
        final value = await callbacks.stateFieldAccess(field);
        jsonDecode(value);
        final name = field.name[0].toUpperCase() + field.name.substring(1);
        return MapEntry(name, value);
      }),
    );
    _state
      ..clear()
      ..addEntries(fields);
    final names = (jsonDecode(_state['Tables']!) as List).cast<String>();
    final current = jsonDecode(_state['TableName']!) as String?;
    final tables = await Future.wait(
      <String?>{null, current, ...names}.map((name) async {
        final value = await callbacks.tableAccess(name);
        jsonDecode(value);
        return MapEntry(name, value);
      }),
    );
    _tables
      ..clear()
      ..addEntries(tables);
    _storage = await callbacks.storageRead();
    jsonDecode(_storage);
    checkActive();
  }

  void _enqueue(FutureOr<void> Function() effect) {
    // Preserve callback order without blocking the browser's event loop.
    _effects = _effects.then((_) {
      checkActive();
      return effect();
    });
    // Keep a rejected callback observable at the next flush, without an unhandled Future.
    unawaited(_effects.catchError((Object _) {}));
  }

  JSString _sync(JSString method, JSString serializedArgs) {
    checkActive();
    final args = jsonDecode(serializedArgs.toDart) as List;
    final Object? value = switch (method.toDart) {
      'stateFieldAccess' => _state[args[0]]!,
      'tableAccess' => _tables[args[0]] ?? '{}',
      'storageRead' => _storage,
      'storageWrite' => _writeStorage(args[0] as String),
      'onPrint' => _print(args[0] as String),
      _ => throw StateError('Unknown Luau callback: ${method.toDart}'),
    };
    return jsonEncode(value).toJS;
  }

  Object? _writeStorage(String value) {
    jsonDecode(value);
    _storage = value;
    _enqueue(() => callbacks.storageWrite(value));
    return null;
  }

  Object? _print(String message) {
    _enqueue(() => callbacks.onPrint(message));
    return null;
  }

  JSPromise<JSString> _async(JSString method, JSString serializedArgs) =>
      _callAsync(method.toDart, serializedArgs.toDart)
          .then(
            (value) => value.toJS,
            onError: (Object error) =>
                jsonEncode({'error': error.toString()}).toJS,
          )
          .toJS;

  Future<String> _callAsync(String method, String serializedArgs) async {
    checkActive();
    await _effects;
    final args = jsonDecode(serializedArgs) as List;
    switch (method) {
      case 'processEvent':
        await callbacks.processEvent(args[0] as String, args[1] as bool?);
      case 'sendEvent':
        await callbacks.sendEvent(args[0] as String, args[1] as int?);
      default:
        throw StateError('Unknown asynchronous Luau callback: $method');
    }
    await _refresh();
    return '{}';
  }

  Future<Object?> _run(String event) async {
    await _effects;
    await _refresh();
    try {
      final result = await _browserRuntime.run(_id, event.toJS).toDart;
      return jsonDecode(result.toDart);
    } finally {
      await _effects;
    }
  }

  @override
  Future<void> executeScript() async {
    await _run('');
  }

  @override
  Future<EventResult> executeEvent(LuauEvent event) async {
    final result = await _run(
      jsonEncode({
        'eventType': event.eventType,
        'event': event.event,
        'serverEvent': event.serverEvent,
        'source': event.source,
        'cancelled': event.cancelled,
        'target': event.target,
      }),
    ) as Map<String, dynamic>;
    return EventResult(
      target: result['target'] as int,
      serverEvent: result['server_event'] as String?,
      needsUpdate: (result['needs_update'] as List?)?.cast<int>().toSet(),
      cancelled: result['cancelled'] as bool,
      scheduledEvents: (result['scheduled_events'] as List)
          .map((entry) => ((entry as List)[0] as String, entry[1] as int))
          .toList(),
    );
  }

  @override
  void release() {
    _browserRuntime.destroy(_id);
  }
}
