import 'package:dart_mappable/dart_mappable.dart';

part 'info.mapper.dart';

@MappableClass()
class ServersInfo with ServersInfoMappable {
  final List<ServerInfo> official, community;

  const ServersInfo({
    this.official = const [],
    this.community = const [],
  });
}

@MappableClass()
class ServerInfo with ServerInfoMappable {
  final String name, description, address;

  const ServerInfo({
    required this.name,
    required this.description,
    required this.address,
  });
}
