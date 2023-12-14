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
  final NetworkingUser user;

  NetworkUpdateMessage({
    required this.user,
  });
}
