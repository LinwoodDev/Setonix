part of 'event.dart';

/// Events that will be send by the client
/// Naming convention: present tense + Event
@MappableClass(discriminatorKey: 'type')
sealed class ServerWorldEvent extends PlayableWorldEvent
    with ServerWorldEventMappable {}

@MappableClass()
final class WorldInitialized extends ServerWorldEvent
    with WorldInitializedMappable {
  final GameTable table;
  final Map<String, Set<Channel>> teamMembers;
  final Channel id;
  final Map<String, String> packsSignature;

  WorldInitialized({
    required this.table,
    this.teamMembers = const {},
    this.id = kAuthorityChannel,
    this.packsSignature = const {},
  });
}

@MappableClass()
final class TeamJoined extends ServerWorldEvent with TeamJoinedMappable {
  final Channel user;
  final String team;

  TeamJoined(this.user, this.team);
}

@MappableClass()
final class TeamLeft extends ServerWorldEvent with TeamLeftMappable {
  final Channel user;
  final String team;

  TeamLeft(this.user, this.team);
}

@MappableClass()
final class VariationChanged extends ServerWorldEvent
    with VariationChangedMappable {
  final VectorDefinition cell;
  final int object;
  final String? variation;

  VariationChanged(this.cell, this.object, this.variation);
}

@MappableClass()
final class CellShuffled extends ServerWorldEvent with CellShuffledMappable {
  final VectorDefinition cell;
  final List<int> positions;

  CellShuffled(this.cell, this.positions);
}
