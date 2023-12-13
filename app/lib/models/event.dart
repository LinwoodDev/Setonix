import 'package:dart_mappable/dart_mappable.dart';

part 'event.mapper.dart';

@MappableClass(discriminatorKey: 'type')
class NetworkingEvent with NetworkingEventMappable {}

@MappableClass(discriminatorValue: 'move')
class NetworkingMoveEvent extends NetworkingEvent
    with NetworkingMoveEventMappable {
  final (double, double) position, velocity;

  NetworkingMoveEvent({
    required this.position,
    required this.velocity,
  });
}
