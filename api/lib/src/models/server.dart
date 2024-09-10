import 'package:dart_mappable/dart_mappable.dart';

import '../event/event.dart';

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
  final String description;

  LanGameServer({
    required super.address,
    super.secure,
    this.description = '',
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

  Uri toHttps() => secure ? Uri.https(address, '') : Uri.http(address, '');
}

@MappableClass()
class GameProperty with GamePropertyMappable {
  final String description;

  const GameProperty({
    this.description = '',
  });

  static const defaultProperty = GameProperty(
    description: 'A server for Quokka.',
  );
}

@MappableClass()
class LanProperty extends GameProperty with LanPropertyMappable {
  final int port;

  const LanProperty({
    this.port = kDefaultPort,
    super.description,
  });
}

@MappableClass()
class ListProperty extends GameProperty with ListPropertyMappable {
  final int index;

  const ListProperty({
    required this.index,
    super.description,
  });
}
