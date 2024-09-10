import 'package:dart_mappable/dart_mappable.dart';

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
sealed class LanGameServer extends GameServer with LanGameServerMappable {
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
