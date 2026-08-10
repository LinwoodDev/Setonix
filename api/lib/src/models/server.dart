import 'package:dart_mappable/dart_mappable.dart';
import 'package:networker/networker.dart';

import '../event/event.dart';
import 'authorization.dart';
import 'meta.dart';

part 'server.mapper.dart';

const kSetonixProtocolVersion = 1;
const kSupportedSetonixProtocolVersions = <int>[kSetonixProtocolVersion];
const kSetonixServerProtocolVersions = <int>[kSetonixProtocolVersion];
const kSetonixProtocolQueryParameter = 'setonixProtocol';
const kSetonixProtocolCapabilities = <String>['handshake-v1'];

Uri addSetonixProtocolVersion(
  Uri uri, {
  int version = kSetonixProtocolVersion,
}) => uri.replace(
  queryParameters: {
    ...uri.queryParameters,
    kSetonixProtocolQueryParameter: version.toString(),
  },
);

int? readSetonixProtocolVersion(Uri uri) =>
    int.tryParse(uri.queryParameters[kSetonixProtocolQueryParameter] ?? '');

final class IncompatibleProtocolException implements Exception {
  final List<int> clientVersions;
  final List<int> serverVersions;

  const IncompatibleProtocolException({
    this.clientVersions = kSupportedSetonixProtocolVersions,
    required this.serverVersions,
  });

  @override
  String toString() => serverVersions.isEmpty
      ? 'The server does not advertise a Setonix protocol version.'
      : 'Setonix protocol mismatch: client supports $clientVersions, '
            'server supports $serverVersions.';
}

@MappableClass()
sealed class GameServer with GameServerMappable {
  final String address;
  final bool secure;

  GameServer({required this.address, this.secure = true});

  String get display => address;
}

@MappableClass()
final class LanGameServer extends GameServer with LanGameServerMappable {
  LanGameServer({required super.address, super.secure});
}

@MappableClass()
final class ListGameServer extends GameServer with ListGameServerMappable {
  final String name;
  final String thumbnail;
  final bool highlighted;

  ListGameServer({
    this.name = '',
    this.thumbnail = '',
    required super.address,
    super.secure = true,
    this.highlighted = false,
  });

  @override
  String get display => name.isEmpty ? address : name;

  Uri buildAddress({bool webSockets = true}) =>
      buildServerAddress(Uri.parse(address), secure, webSockets: webSockets);
}

@MappableClass()
final class BrowsedGameServer extends ListGameServer
    with BrowsedGameServerMappable {
  BrowsedGameServer({
    super.name = '',
    super.thumbnail = '',
    required super.address,
    super.secure = true,
    super.highlighted = false,
  });
}

Uri buildServerAddress(Uri uri, bool secure, {bool webSockets = true}) {
  // handle plain host without scheme: treat single-segment path as host
  if (uri.host.isEmpty && uri.pathSegments.length == 1) {
    uri = uri.replace(
      host: uri.pathSegments.first,
      pathSegments: uri.pathSegments.skip(1).toList(),
    );
  }
  uri = uri.replace(scheme: (webSockets ? 'ws' : 'http') + (secure ? 's' : ''));
  if (!uri.hasPort) {
    uri = uri.replace(port: kDefaultPort);
  }
  return uri;
}

@MappableClass()
class GameProperty with GamePropertyMappable {
  final String description;
  final bool hasThumbnail;
  final int? maxPlayers;
  final int currentPlayers;
  final Map<String, SignatureMetadata> packsSignature;
  final List<int> protocolVersions;
  final List<String> protocolCapabilities;

  const GameProperty({
    this.description = '',
    this.hasThumbnail = false,
    this.maxPlayers,
    this.currentPlayers = 0,
    this.packsSignature = const {},
    this.protocolVersions = const [],
    this.protocolCapabilities = const [],
  });

  int? negotiateProtocol([
    Iterable<int> supportedVersions = kSupportedSetonixProtocolVersions,
  ]) {
    int? selected;
    for (final version in protocolVersions) {
      if (supportedVersions.contains(version) &&
          (selected == null || version > selected)) {
        selected = version;
      }
    }
    return selected;
  }

  bool supportsProtocol([
    Iterable<int> supportedVersions = kSupportedSetonixProtocolVersions,
  ]) => negotiateProtocol(supportedVersions) != null;

  int requireProtocol([
    List<int> supportedVersions = kSupportedSetonixProtocolVersions,
  ]) {
    final selected = negotiateProtocol(supportedVersions);
    if (selected == null) {
      throw IncompatibleProtocolException(
        clientVersions: supportedVersions,
        serverVersions: protocolVersions,
      );
    }
    return selected;
  }

  static const defaultProperty = GameProperty(
    description: 'A server for Setonix.',
  );
}

@MappableClass()
class LanProperty extends GameProperty with LanPropertyMappable {
  final int port;

  const LanProperty({
    this.port = kDefaultPort,
    super.currentPlayers,
    super.maxPlayers,
    super.description,
    super.hasThumbnail,
    super.packsSignature,
    super.protocolVersions,
    super.protocolCapabilities,
  });
}

@MappableClass()
class ListProperty extends GameProperty with ListPropertyMappable {
  final int index;

  const ListProperty({
    required this.index,
    super.currentPlayers,
    super.maxPlayers,
    super.description,
    super.hasThumbnail,
    super.packsSignature,
    super.protocolVersions,
    super.protocolCapabilities,
  });
}

@MappableClass()
final class PlayerInfo with PlayerInfoMappable {
  final Channel id;
  final String? name;
  final Set<String> serverRoles;
  final Set<String> gameRoles;
  final bool registered;
  final bool manageable;

  const PlayerInfo({
    required this.id,
    this.name,
    this.serverRoles = const {kDefaultServerRole},
    this.gameRoles = const {},
    this.registered = false,
    this.manageable = false,
  });
}

@MappableClass()
final class ServerState with ServerStateMappable {
  final String? link;
  final List<PlayerInfo> players;
  final Map<String, ServerRoleDefinition> serverRoles;
  final Set<String> permissions;
  final Set<String> assignableServerRoles;

  const ServerState({
    this.link,
    this.players = const [],
    this.serverRoles = const {},
    this.permissions = const {},
    this.assignableServerRoles = const {},
  });
}

@MappableClass()
final class ServerList with ServerListMappable {
  final List<ListGameServer> servers;

  const ServerList({this.servers = const []});
}
