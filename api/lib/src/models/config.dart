import 'package:dart_mappable/dart_mappable.dart';
import 'package:setonix_api/event.dart';

part 'config.mapper.dart';

@MappableClass()
final class SetonixConfig with SetonixConfigMappable {
  final String? host;
  static const String defaultHost = '0.0.0.0';
  static const String envHost = 'SETONIX_HOST';
  final int? port;
  static const int defaultPort = kDefaultPort;
  static const String envPort = 'SETONIX_PORT';
  final String? worldFile;
  static const String defaultWorldName = 'world.stnx';
  static const String envWorldFile = 'SETONIX_WORLD_FILE';
  final bool? autosave;
  static const bool defaultAutosave = true;
  static const String envAutosave = 'SETONIX_AUTOSAVE';
  final bool? multiWorld;
  static const bool defaultMultiWorld = false;
  static const String envMultiWorld = 'SETONIX_MULTI_WORLD';
  final int? maxPlayers;
  static const int defaultMaxPlayers = -1;
  static const String envMaxPlayers = 'SETONIX_MAX_PLAYERS';
  final String? description;
  static const String defaultDescription = 'A server for Setonix.';
  static const String envDescription = 'SETONIX_DESCRIPTION';
  final String? guestPrefix;
  static const String defaultGuestPrefix = 'Guest ';
  static const String envGuestPrefix = 'SETONIX_GUEST_PREFIX';
  final bool? whitelistEnabled;
  static const bool defaultWhitelistEnabled = false;
  static const String envWhitelistEnabled = 'SETONIX_WHITELIST_ENABLED';
  final bool? accountRequired;
  static const bool defaultAccountRequired = true;
  static const String envAccountRequired = 'SETONIX_ACCOUNT_REQUIRED';
  final String? apiEndpoint;
  static const String defaultApiEndpoint = "";
  static const String envApiEndpoint = 'SETONIX_API_ENDPOINT';
  final String? endpointSecret;
  static const String defaultEndpointSecret = '';
  static const String envEndpointSecret = 'SETONIX_ENDPOINT_SECRET';

  const SetonixConfig({
    this.host,
    this.port,
    this.worldFile,
    this.autosave,
    this.multiWorld,
    this.maxPlayers,
    this.description,
    this.guestPrefix,
    this.whitelistEnabled,
    this.accountRequired,
    this.apiEndpoint,
    this.endpointSecret,
  });

  static const defaultConfig = SetonixConfig(
    host: defaultHost,
    port: defaultPort,
    worldFile: defaultWorldName,
    autosave: defaultAutosave,
    multiWorld: defaultMultiWorld,
    maxPlayers: defaultMaxPlayers,
    description: defaultDescription,
    guestPrefix: defaultGuestPrefix,
    whitelistEnabled: defaultWhitelistEnabled,
    accountRequired: defaultAccountRequired,
    apiEndpoint: defaultApiEndpoint,
    endpointSecret: defaultEndpointSecret,
  );

  static SetonixConfig fromEnvironment() {
    return SetonixConfig(
      host: bool.hasEnvironment(envHost)
          ? String.fromEnvironment(envHost, defaultValue: defaultHost)
          : null,
      port: bool.hasEnvironment(envPort)
          ? int.fromEnvironment(envPort, defaultValue: defaultPort)
          : null,
      worldFile: bool.hasEnvironment(envWorldFile)
          ? String.fromEnvironment(envWorldFile, defaultValue: defaultWorldName)
          : null,
      autosave: bool.hasEnvironment(envAutosave)
          ? bool.fromEnvironment(envAutosave, defaultValue: defaultAutosave)
          : null,
      multiWorld: bool.hasEnvironment(envMultiWorld)
          ? bool.fromEnvironment(envMultiWorld, defaultValue: defaultMultiWorld)
          : null,
      maxPlayers: bool.hasEnvironment(envMaxPlayers)
          ? int.fromEnvironment(envMaxPlayers, defaultValue: defaultMaxPlayers)
          : null,
      description: bool.hasEnvironment(envDescription)
          ? String.fromEnvironment(
              envDescription,
              defaultValue: defaultDescription,
            )
          : null,
      guestPrefix: bool.hasEnvironment(envGuestPrefix)
          ? String.fromEnvironment(
              envGuestPrefix,
              defaultValue: defaultGuestPrefix,
            )
          : null,
      whitelistEnabled: bool.hasEnvironment(envWhitelistEnabled)
          ? bool.fromEnvironment(
              envWhitelistEnabled,
              defaultValue: defaultWhitelistEnabled,
            )
          : null,
      accountRequired: bool.hasEnvironment(envAccountRequired)
          ? bool.fromEnvironment(
              envAccountRequired,
              defaultValue: defaultAccountRequired,
            )
          : null,
      apiEndpoint: bool.hasEnvironment(envApiEndpoint)
          ? String.fromEnvironment(
              envApiEndpoint,
              defaultValue: defaultApiEndpoint,
            )
          : null,
      endpointSecret: bool.hasEnvironment(envEndpointSecret)
          ? String.fromEnvironment(
              envEndpointSecret,
              defaultValue: defaultEndpointSecret,
            )
          : null,
    );
  }

  SetonixConfig merge(SetonixConfig other) => SetonixConfig(
    host: other.host ?? host,
    port: other.port ?? port,
    worldFile: other.worldFile ?? worldFile,
    autosave: other.autosave ?? autosave,
    multiWorld: other.multiWorld ?? multiWorld,
    maxPlayers: other.maxPlayers ?? maxPlayers,
    description: other.description ?? description,
    guestPrefix: other.guestPrefix ?? guestPrefix,
    accountRequired: other.accountRequired ?? accountRequired,
    whitelistEnabled: other.whitelistEnabled ?? whitelistEnabled,
    apiEndpoint: other.apiEndpoint ?? apiEndpoint,
    endpointSecret: other.endpointSecret ?? endpointSecret,
  );
}
