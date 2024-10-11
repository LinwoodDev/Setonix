import 'package:dart_mappable/dart_mappable.dart';

import '../event/event.dart';
import 'meta.dart';

part 'server.mapper.dart';

@MappableClass()
sealed class GameServer with GameServerMappable {
  final String address;
  final bool secure;

  GameServer({
    required this.address,
    this.secure = true,
  });

  String get display => address;
}

@MappableClass()
final class LanGameServer extends GameServer with LanGameServerMappable {
  LanGameServer({
    required super.address,
    super.secure,
  });
}

@MappableClass()
final class ListGameServer extends GameServer with ListGameServerMappable {
  final String name;

  ListGameServer({
    this.name = '',
    required super.address,
    super.secure = true,
  });

  @override
  String get display => name.isEmpty ? address : name;

  Uri buildAddress({bool webSockets = true}) =>
      buildServerAddress(address, secure, webSockets: webSockets);
}

Uri buildServerAddress(String input, bool secure, {bool webSockets = true}) {
  final splitted = input.split(':');
  return Uri(
    scheme: (webSockets ? 'ws' : 'http') + (secure ? 's' : ''),
    host: splitted[0],
    port: splitted.length <= 1 ? kDefaultPort : int.parse(splitted[1]),
  );
}

@MappableClass()
class GameProperty with GamePropertyMappable {
  final String description;
  final int? maxPlayers;
  final int currentPlayers;
  final Map<String, FileMetadata> packsSignature;

  const GameProperty({
    this.description = '',
    this.maxPlayers,
    this.currentPlayers = 0,
    this.packsSignature = const {},
  });

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
    super.packsSignature,
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
    super.packsSignature,
  });
}
