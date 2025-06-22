import 'dart:convert';
import 'dart:io';

import 'package:setonix_server/setonix_server.dart';

class ConfigManager {
  SetonixConfig _config = SetonixConfig();
  final SetonixConfig _envConfig;
  late SetonixConfig _mergedConfig = _mergeConfig();
  SetonixConfig _argsConfig = SetonixConfig();

  ConfigManager({SetonixConfig? argsConfig, SetonixConfig? envConfig})
    : _envConfig = envConfig ?? SetonixConfig.fromEnvironment();

  SetonixConfig _mergeConfig() {
    return _config.merge(_envConfig).merge(_argsConfig);
  }

  void setArgsConfig(SetonixConfig argsConfig) {
    _argsConfig = argsConfig;
    _mergedConfig = _mergeConfig();
  }

  Future<void> loadConfig() async {
    final file = File('config.json');
    if (await file.exists()) {
      final content = await file.readAsString();
      _config = SetonixConfigMapper.fromJson(content);
      _mergedConfig = _mergeConfig();
    } else {
      _config = SetonixConfig.defaultConfig;
      await file.writeAsString(
        JsonEncoder.withIndent('  ').convert(_config.toMap()),
      );
    }
  }

  String get host => _mergedConfig.host ?? SetonixConfig.defaultHost;

  int get port => _mergedConfig.port ?? SetonixConfig.defaultPort;

  bool get autosave => _mergeConfig().autosave ?? SetonixConfig.defaultAutosave;

  String get description =>
      _mergedConfig.description ?? SetonixConfig.defaultDescription;

  int get maxPlayers =>
      _mergedConfig.maxPlayers ?? SetonixConfig.defaultMaxPlayers;

  bool get multiWorld =>
      _mergedConfig.multiWorld ?? SetonixConfig.defaultMultiWorld;

  String get worldFile =>
      _mergedConfig.worldFile ?? SetonixConfig.defaultWorldName;

  String get guestPrefix =>
      _mergedConfig.guestPrefix ?? SetonixConfig.defaultGuestPrefix;

  bool get whitelistEnabled =>
      _mergedConfig.whitelistEnabled ?? SetonixConfig.defaultWhitelistEnabled;

  bool get accountRequired =>
      _mergedConfig.accountRequired ?? SetonixConfig.defaultAccountRequired;

  String get apiEndpoint =>
      _mergedConfig.apiEndpoint ?? SetonixConfig.defaultApiEndpoint;

  String get endpointSecret =>
      _mergedConfig.endpointSecret ?? SetonixConfig.defaultEndpointSecret;
}
