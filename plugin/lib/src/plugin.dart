import 'dart:convert';
import 'dart:io';

import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:networker/networker.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_plugin/setonix_plugin.dart';
import 'package:setonix_plugin/src/rust/frb_generated.dart';

typedef PluginProcessCallback = void Function(String, WorldEvent, [bool force]);
typedef PluginSendEventCallback =
    void Function(
      NetworkerPacket<PlayableWorldEvent> packet,
      String? worldName,
    );

mixin ServerInterface {
  void process(WorldEvent event, {bool force = false, required String plugin});
  void sendEvent(
    PlayableWorldEvent event, {
    Channel target = kAnyChannel,
    required String plugin,
  });

  void print(String message, [String? plugin]);

  WorldState get state;
  List<int> get players;
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

  Future<SetonixPlugin> registerLuauPlugin(String name, String code) {
    if (!_nativeEnabled) throw Exception('Native not enabled');
    return registerPlugin(
      name,
      (pluginServer) => RustSetonixPlugin.build(
        (c) => LuauPlugin(code: code, callback: c),
        pluginServer,
        onPrint: (e) => server.print(e, name),
        pluginId: () => name,
      ),
    );
  }

  void unregisterPlugin(String name) {
    _plugins.remove(name);
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
    return registerLuauPlugin(name, data);
  }

  bool get _nativeEnabled => RustLib.instance.initialized;

  Iterable<String> get plugins => _plugins.keys;

  void dispose([bool disposeNative = true]) {
    unregisterAll();
    if (disposeNative) disposePluginSystem();
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
  void process(WorldEvent event, {bool force = false});
  void sendEvent(PlayableWorldEvent event, {Channel target = kAnyChannel});
  WorldState get state;
  List<int> get players;
}

class _PluginServerInterfaceImpl implements PluginServerInterface {
  final ServerInterface server;
  final String pluginName;

  _PluginServerInterfaceImpl(this.server, this.pluginName);

  @override
  void process(WorldEvent event, {bool force = false}) {
    server.process(event, force: force, plugin: pluginName);
  }

  @override
  void sendEvent(PlayableWorldEvent event, {Channel target = kAnyChannel}) {
    server.sendEvent(event, target: target, plugin: pluginName);
  }

  @override
  WorldState get state => server.state;

  @override
  List<int> get players => server.players;
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
    String Function()? pluginId,
  }) async {
    final callback = PluginCallback.default_();
    if (onPrint != null) {
      callback.changeOnPrint(onPrint: onPrint);
    }
    callback.changeProcessEvent(
      processEvent: (eventSerizalized, force) {
        final event = WorldEventMapper.fromJson(eventSerizalized);
        server.process(event, force: force ?? false);
      },
    );
    callback.changeSendEvent(
      sendEvent: (eventSerizalized, target) {
        final event = PlayableWorldEventMapper.fromJson(eventSerizalized);
        server.sendEvent(event, target: target ?? kAnyChannel);
      },
    );
    callback.changeStateFieldAccess(
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
          StateFieldAccess.pluginId => jsonEncode(
            pluginId?.call() ?? 'unknown',
          ),
        };
      },
    );
    callback.changeTableAccess(
      tableAccess: (tableName) {
        final table = server.state.data.getTable(tableName ?? '');
        return table?.toJson() ?? "{}";
      },
    );
    final plugin = builder(callback);
    final instance = RustSetonixPlugin._(server, plugin);
    instance.eventSystem.on<WorldEvent>((e) async {
      final result = await instance.plugin.runEvent(
        eventType: e.clientEvent.runtimeType.toString(),
        event: e.clientEvent.toJson(),
        serverEvent: e.serverEvent.toJson(),
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
    });
    await instance.plugin.run();
    return instance;
  }

  @override
  void dispose() {
    super.dispose();
    if (plugin is RustOpaqueInterface) {
      (plugin as RustOpaqueInterface).dispose();
    }
  }
}
