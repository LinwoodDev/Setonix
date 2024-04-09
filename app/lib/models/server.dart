import 'package:dart_mappable/dart_mappable.dart';

part 'server.mapper.dart';

@MappableClass()
sealed class GameServer with GameServerMappable {
  final GameProperty property;

  GameServer({required this.property});

  String get address;
}

@MappableClass()
class LanGameServer extends GameServer with LanGameServerMappable {
  @override
  final String address;

  LanGameServer({
    required this.address,
    required super.property,
  });
}

@MappableClass()
class GameProperty with GamePropertyMappable {
  final String name;
  final String description;

  const GameProperty({
    this.name = '',
    this.description = '',
  });
}
