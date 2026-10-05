import 'dart:async';
import 'dart:convert';

import 'package:setonix_plugin/setonix_plugin.dart';

import 'runtime_smoke_report.dart'
    if (dart.library.js_interop) 'runtime_smoke_report_web.dart';

void check(bool condition, String message) {
  if (!condition) throw StateError(message);
}

Future<void> main() async {
  try {
    await verifyRuntime().timeout(const Duration(seconds: 30));
    report(
      'PASS: real Dart callbacks, asynchronous Process/Send, live state, '
      'storage, subscriptions/disconnect, cancellation, server event changes, '
      'scheduled events, errors, isolation, disposal and reinitialization',
    );
  } catch (error, stack) {
    report('FAIL: $error\n$stack');
    rethrow;
  }
}

Future<void> verifyRuntime() async {
  await initPluginSystem();
  await verifyEventDispatch();
  String storage = '{}';
  bool updated = false;
  final printed = <String>[];
  final processed = <String>[];
  final sent = <(String, int?)>[];
  final callback = PluginCallback(
    onPrint: (message) async {
      await Future<void>.delayed(const Duration(milliseconds: 1));
      printed.add(message);
    },
    processEvent: (event, force) async {
      await Future<void>.delayed(const Duration(milliseconds: 1));
      if ((jsonDecode(event) as Map)['type'] == 'Fail')
        throw StateError('expected callback failure');
      processed.add(event);
      updated = true;
    },
    sendEvent: (event, target) async {
      await Future<void>.delayed(const Duration(milliseconds: 1));
      sent.add((event, target));
    },
    stateFieldAccess: (field) async {
      await Future<void>.delayed(const Duration(milliseconds: 1));
      return jsonEncode(switch (field) {
        StateFieldAccess.tableName => 'main',
        StateFieldAccess.tables => ['main', 'other'],
        StateFieldAccess.namespace => 'tests',
        StateFieldAccess.game => 'smoke',
        StateFieldAccess.info => {'updated': updated},
        StateFieldAccess.players => [7],
        StateFieldAccess.teamMembers || StateFieldAccess.gameRoles => {},
      });
    },
    tableAccess: (name) async =>
        jsonEncode({'name': name ?? 'main', 'cells': {}}),
    storageRead: () async => storage,
    storageWrite: (value) async {
      await Future<void>.delayed(const Duration(milliseconds: 1));
      storage = value;
    },
  );
  final plugin = LuauPlugin(
    code: r'''
    assert(Setonix.namespace() == "tests")
    assert(Setonix.game() == "smoke")
    assert(Setonix.pluginId() == "tests:smoke")
    assert(Setonix.state.tableName() == "main")
    assert(SetonixRaw.State:GetTable("other").name == "other")
    Setonix.storage.set("count", 0)
    print("loaded")
    local connection
    connection = SetonixRaw.Events.Demo:Connect(function(event, details)
      assert(event.answer == 42 and details.source == 7)
      details.cancelled = true
      details.server_event = {type = "Demo", changed = true}
      details:ScheduleEvent(Setonix.event("MessageRequest", {message = "scheduled"}), 2)
      Setonix.storage.set("count", Setonix.storage.get("count") + 1)
      Setonix.process(Setonix.event("MessageRequest", {message = "processed"}), true)
      assert(Setonix.state.info().updated == true)
      Setonix.send(Setonix.event("MessageRequest", {message = "sent"}), 3)
      connection:Disconnect()
    end)
  ''',
    callback: callback,
  );
  await plugin.run();
  check(printed.single == 'loaded', 'Print callback was not awaited');
  check(
    (jsonDecode(storage) as Map)['count'] == 0,
    'Storage write was not awaited',
  );
  Future<EventResult> event() => plugin.runEvent(
    eventType: 'Demo',
    event: '{"answer":42}',
    serverEvent: '{"type":"Demo"}',
    source: 7,
    cancelled: false,
    target: 0,
  );
  final result = await event();
  check(result.cancelled, 'Event cancellation failed');
  check(
    (jsonDecode(result.serverEvent!) as Map)['changed'] == true,
    'Server event was not changed',
  );
  check(result.scheduledEvents.single.$2 == 2, 'Scheduled target was lost');
  check(
    (jsonDecode(result.scheduledEvents.single.$1) as Map)['message'] ==
        'scheduled',
    'Scheduled payload was lost',
  );
  check(
    (jsonDecode(storage) as Map)['count'] == 1,
    'Storage was not persisted',
  );
  check(
    processed.length == 1 && sent.single.$2 == 3,
    'Server callbacks did not complete',
  );
  check(
    !(await event()).cancelled,
    'Disconnect did not remove the subscription',
  );

  final errorPlugin = LuauPlugin(
    code: r'''
    local ok, message = pcall(function() Setonix.process(Setonix.event("Fail")) end)
    assert(not ok and string.find(tostring(message), "expected callback failure"))
    assert(io == nil and package == nil)
    assert(not pcall(function() math.changed = true end))
  ''',
    callback: callback,
  );
  await errorPlugin.run();
  errorPlugin.dispose();
  final invalid = LuauPlugin(code: 'this is invalid !!!', callback: callback);
  bool failed = false;
  try {
    await invalid.run();
  } catch (_) {
    failed = true;
  }
  check(failed, 'Invalid script was accepted');
  invalid.dispose();

  final isolated = LuauPlugin(
    code: 'assert(connection == nil)',
    callback: callback,
  );
  await isolated.run();
  isolated.dispose();
  plugin.dispose();
  plugin.dispose();
  failed = false;
  try {
    await plugin.run();
  } catch (_) {
    failed = true;
  }
  check(failed, 'Disposed plugin was still usable');
  callback.dispose();
  disposePluginSystem();
  await initPluginSystem();
  check(isPluginSystemInitialized, 'Plugin system could not be reinitialized');
  disposePluginSystem();
}

// Run this through the application adapter too: release web builds minify
// runtimeType names, whereas Lua subscriptions use serialized event types.
Future<void> verifyEventDispatch() async {
  final recorder = _EventRecorder();
  final plugin = await RustSetonixPlugin.build(
    (_) => recorder,
    _UnusedServer(),
  );
  final event = Event(
    clientEvent: UserJoined(
      channel: 7,
      info: const ConnectionInfoMapper().decode({}),
    ),
    serverEvent: null,
    source: 7,
    target: 0,
  );
  await plugin.eventSystem.fire(event);
  check(recorder.eventType == 'UserJoined', 'Lua event type was minified');
  check(event.cancelled, 'Application adapter lost event cancellation');
  plugin.dispose();
}

class _UnusedServer implements PluginServerInterface {
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('Unexpected server access: ${invocation.memberName}');
}

class _EventRecorder implements RustPlugin {
  String? eventType;

  @override
  Future<void> run() async {}

  @override
  Future<EventResult> runEvent({
    required String eventType,
    required String event,
    String? serverEvent,
    required int source,
    required bool cancelled,
    required int target,
  }) async {
    this.eventType = eventType;
    return EventResult(
      target: target,
      serverEvent: null,
      cancelled: true,
      scheduledEvents: [],
    );
  }
}
