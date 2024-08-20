part of '../event.dart';

/// Events that will be send by the client
/// Naming convention: present tense + Request
@MappableClass()
sealed class ClientWorldEvent extends WorldEvent
    with ClientWorldEventMappable {}

@MappableClass()
final class TeamJoinRequest extends ClientWorldEvent
    with TeamJoinRequestMappable {
  final String team;

  TeamJoinRequest(this.team);
}

@MappableClass()
final class TeamLeaveRequest extends ClientWorldEvent
    with TeamLeaveRequestMappable {
  final String team;

  TeamLeaveRequest(this.team);
}

@MappableClass()
final class RollObjectRequest extends ClientWorldEvent
    with RollObjectRequestMappable {
  final VectorDefinition cell;
  final int object;

  RollObjectRequest(this.cell, this.object);
}

@MappableClass()
final class ShuffleCellRequest extends ClientWorldEvent
    with ShuffleCellRequestMappable {
  final VectorDefinition cell;

  ShuffleCellRequest(this.cell);
}
