import 'package:dart_mappable/dart_mappable.dart';
import 'package:qeck/models/state.dart';

part 'message.mapper.dart';

@MappableClass()
sealed class NetworkMessage with NetworkMessageMappable {}

@MappableClass()
class NetworkPlayerJoinMessage extends NetworkMessage
    with NetworkPlayerJoinMessageMappable {
  final int id;
  final NetworkingUser user;

  NetworkPlayerJoinMessage({
    required this.id,
    required this.user,
  });
}

@MappableClass()
class NetworkPlayerLeaveMessage extends NetworkMessage
    with NetworkPlayerLeaveMessageMappable {
  final int id;

  NetworkPlayerLeaveMessage({
    required this.id,
  });
}

@MappableClass()
class NetworkUpdateMessage extends NetworkMessage
    with NetworkUpdateMessageMappable {
  final int id;
  final String? name;
  final PlayerState? state;
  final (double, double)? position;
  final (double, double)? velocity;

  NetworkUpdateMessage({
    required this.id,
    this.name,
    this.state,
    this.position,
    this.velocity,
  });
}

@MappableClass()
class NetworkInitMessage extends NetworkMessage
    with NetworkInitMessageMappable {
  final Map<String, NetworkingUser> users;

  NetworkInitMessage({
    required this.users,
  });
  NetworkInitMessage.build({
    required Map<int, NetworkingUser> users,
  }) : users = users.map((key, value) => MapEntry(key.toString(), value));

  Map<int, NetworkingUser> getUsers() =>
      users.map((key, value) => MapEntry(int.parse(key), value));
}
