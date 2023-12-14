import 'package:dart_mappable/dart_mappable.dart';

part 'state.mapper.dart';

@MappableEnum()
enum PlayerState { idle, walking, sitting }

@MappableClass()
class NetworkingUser with NetworkingUserMappable {
  final String name;
  final PlayerState state;
  final (double, double) position;
  final (double, double) velocity;

  const NetworkingUser({
    required this.name,
    this.position = const (0, 0),
    this.state = PlayerState.idle,
    this.velocity = const (0, 0),
  });
}
