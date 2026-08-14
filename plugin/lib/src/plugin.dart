import 'dart:convert';
import 'dart:io';

import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:networker/networker.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_plugin/setonix_plugin.dart';
import 'package:setonix_plugin/src/rust/frb_generated.dart';

typedef PluginProcessCallback = void Function(String, WorldEvent, [bool force]);
typedef PluginSendEventCallback = void Function(
  NetworkerPacket<PlayableWorldEvent> packet,
  String? worldName,
);

mixin ServerInterface {
  Future<void> process(
    WorldEvent event, {
    bool force = false,
    required String plugin,
  });
  Future<void> sendEvent(
    PlayableWorldEvent event, {
    Channel target = kAnyChannel,
    required String plugin,
  });

  void print(String message, [String? plugin]);

  WorldState get state;
  List<int> get players;
  String getScriptState(String plugin);
  void setScriptState(String plugin, String state);
}

final class PluginSystem {
  final ServerInterface server;
  final Map<String, SetonixPlugin> _plugins = {};

  PluginSystem({required this.server});

  Future<SetonixPlugin> registerPlugin(
    String name,
    FutureOr<SetonixPlugin> Function(PluginServerInterface) pluginBuilder,
  ) async {
    unregisterPlugin(name);
    final pluginServer = _PluginServerInterfaceImpl(server, name);
    final plugin = await pluginBuilder(pluginServer);
    return _plugins[name] = plugin;
  }

  Future<SetonixPlugin> registerLuauPlugin(
    String name,
    String code, {
    ItemLocation? location,
    String? storageKey,
  }) {
    if (!_nativeEnabled) throw Exception('Native not enabled');
    return registerPlugin(
      name,
      (pluginServer) => RustSetonixPlugin.build(
        (c) => LuauPlugin(code: code, callback: c),
        pluginServer,
        onPrint: (e) => server.print(e, name),
        location: location ?? ItemLocation.fromString(name),
        storageKey: storageKey ?? name,
      ),
    );
  }

  void unregisterPlugin(String name) {
    _plugins.remove(name)?.dispose();
  }

  Future<SetonixPlugin?> loadLuaPluginFromLocation(
    AssetManager assetManager,
    ItemLocation location, [
    String name = 'game',
  ]) async {
    final data = assetManager
        .getPack(location.namespace)
        ?.getScript(location.id);
    if (data == null) return null;
    try {
      return await registerLuauPlugin(
        name,
        data,
        location: location,
        storageKey: location.namespace,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        Exception('Error loading Luau script "$location": $error'),
        stackTrace,
      );
    }
  }

  Future<SetonixPlugin?> loadGameMode(
    AssetManager assetManager,
    ItemLocation? location,
  ) async {
    if (location == null) return null;
    final gameMode = assetManager
        .getPack(location.namespace)
        ?.getMode(location.id);
    if (gameMode == null) return null;
    final script = gameMode.script;
    if (script == null || script.isEmpty) return null;
    final scriptLocation = ItemLocation.fromString(script, location.namespace);
    try {
      return await loadLuaPluginFromLocation(assetManager, scriptLocation);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        Exception(
          'Error loading game mode "$location" from script "$scriptLocation": $error',
        ),
        stackTrace,
      );
    }
  }

  bool get _nativeEnabled => RustLib.instance.initialized;

  Iterable<String> get plugins => _plugins.keys;

  void dispose([bool disposeNative = true]) {
    unregisterAll();
    if (disposeNative) disposePluginSystem();
  }

  Future<void> closeAll() async {
    for (final plugin in _plugins.values.toList()) {
      await plugin.close();
    }
    unregisterAll();
  }

  Future<void> collectState() async {
    for (final plugin in _plugins.values.toList()) {
      await plugin.collectState();
    }
  }

  void unregisterAll() {
    List<String>.from(_plugins.keys).forEach(unregisterPlugin);
  }

  Future<void> fire(Event event) async {
    for (final plugin in _plugins.values) {
      await plugin.eventSystem.fire(event);
    }
  }

  GameProperty runPing(HttpRequest request, GameProperty property) {
    var result = property;
    for (final plugin in _plugins.values) {
      result = plugin.eventSystem.runPing(request, result);
    }
    return result;
  }

  void runLeaveCallback(Channel channel, ConnectionInfo info) {
    for (final plugin in _plugins.values) {
      plugin.eventSystem.runLeaveCallback(channel, info);
    }
  }
}

abstract class PluginServerInterface {
  Future<void> process(WorldEvent event, {bool force = false});
  Future<void> sendEvent(
    PlayableWorldEvent event, {
    Channel target = kAnyChannel,
  });
  WorldState get state;
  List<int> get players;
  String getScriptState(String plugin);
  void setScriptState(String plugin, String state);
}

class _PluginServerInterfaceImpl implements PluginServerInterface {
  final ServerInterface server;
  final String pluginName;

  _PluginServerInterfaceImpl(this.server, this.pluginName);

  @override
  Future<void> process(WorldEvent event, {bool force = false}) =>
      server.process(event, force: force, plugin: pluginName);

  @override
  Future<void> sendEvent(
    PlayableWorldEvent event, {
    Channel target = kAnyChannel,
  }) => server.sendEvent(event, target: target, plugin: pluginName);

  @override
  WorldState get state => server.state;

  @override
  List<int> get players => server.players;

  @override
  String getScriptState(String plugin) => server.getScriptState(plugin);

  @override
  void setScriptState(String plugin, String state) {
    server.setScriptState(plugin, state);
  }
}

final class ProcessMessage {
  final WorldEvent event;
  final bool force;

  ProcessMessage(this.event, this.force);
}

class SetonixPlugin {
  final PluginServerInterface server;
  final EventSystem eventSystem = EventSystem();

  SetonixPlugin(this.server);

  Future<void> collectState() async {}

  Future<void> close() async {}

  void dispose() {
    eventSystem.dispose();
  }
}

final class RustSetonixPlugin extends SetonixPlugin {
  final RustPlugin plugin;

  RustSetonixPlugin._(super.server, this.plugin);

  static Future<RustSetonixPlugin> build(
    RustPlugin Function(PluginCallback) builder,
    PluginServerInterface server, {
    void Function(String)? onPrint,
    ItemLocation? location,
    String storageKey = '',
  }) async {
    final callback = PluginCallback(
      onPrint: onPrint ?? (s) {},
      processEvent: (eventSerizalized, force) async {
        try {
          final event = WorldEventMapper.fromJson(eventSerizalized);
          await server.process(event, force: force ?? false);
        } catch (e) {
          print("Error processing event from plugin: $e");
        }
      },
      sendEvent: (eventSerizalized, target) async {
        try {
          final event = WorldEventMapper.fromJson(eventSerizalized);
          if (event is! PlayableWorldEvent) {
            throw Exception("Event is not PlayableWorldEvent");
          }
          await server.sendEvent(event, target: target ?? kAnyChannel);
        } catch (e) {
          print("Error sending event from plugin: $e");
        }
      },
      stateFieldAccess: (field) {
        final state = server.state;
        return switch (field) {
          StateFieldAccess.info => state.info.toJson(),
          StateFieldAccess.tables => jsonEncode(
            state.data.getTables().toList(),
          ),
          StateFieldAccess.tableName => jsonEncode(state.tableName),
          StateFieldAccess.players => jsonEncode(server.players),
          StateFieldAccess.teamMembers => jsonEncode(state.teamMembers),
          StateFieldAccess.gameRoles => jsonEncode(state.gameRoleMembers),
          StateFieldAccess.game => jsonEncode(location?.id ?? 'unknown'),
          StateFieldAccess.namespace => jsonEncode(
            location?.namespace ?? 'unknown',
          ),
        };
      },
      tableAccess: (tableName) {
        if (server.state.tableName == tableName)
          return server.state.table.toJson();
        final table = server.state.data.getTable(tableName ?? '');
        return table?.toJson() ?? "{}";
      },
      storageRead: () => server.getScriptState(storageKey),
      storageWrite: (state) => server.setScriptState(storageKey, state),
    );
    final plugin = builder(callback);
    final instance = RustSetonixPlugin._(server, plugin);
    instance.eventSystem.on<WorldEvent>((e) async {
      final result = await instance.plugin.runEvent(
        eventType: e.clientEvent.runtimeType.toString(),
        event: e.clientEvent.toJson(),
        serverEvent: e.serverEvent?.toJson(),
        target: e.target,
        source: e.source,
        cancelled: e.cancelled,
      );
      e.cancelled = result.cancelled;
      e.needsUpdate = result.needsUpdate;
      final serverEvent = result.serverEvent;
      if (serverEvent != null) {
        e.serverEvent = ServerWorldEventMapper.fromJson(serverEvent);
      }
      e.scheduleEvents(
        result.scheduledEvents.map((e) {
          final event = WorldEventMapper.fromJson(e.$1);
          if (event is! PlayableWorldEvent) {
            return null;
          }
          return NetworkerPacket(event, e.$2);
        }).nonNulls,
      );
    });
    await instance.plugin.run();
    return instance;
  }

  @override
  Future<void> collectState() async {
    await plugin.runEvent(
      eventType: 'WorldSaving',
      event: '{"type":"WorldSaving"}',
      source: kAuthorityChannel,
      target: kAnyChannel,
      cancelled: false,
    );
  }

  @override
  Future<void> close() async {
    try {
      await plugin.runEvent(
        eventType: 'WorldClosing',
        event: '{"type":"WorldClosing"}',
        source: kAuthorityChannel,
        target: kAnyChannel,
        cancelled: false,
      );
    } finally {
      await super.close();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (plugin is RustOpaqueInterface) {
      (plugin as RustOpaqueInterface).dispose();
    }
  }
}
