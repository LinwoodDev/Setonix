import 'package:dart_mappable/dart_mappable.dart';

part 'server.mapper.dart';

@MappableClass()
final class GameServer with GameServerMappable {
  final String name, address;
  final bool secure;

  GameServer({
    this.name = '',
    required this.address,
    this.secure = true,
  });

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
