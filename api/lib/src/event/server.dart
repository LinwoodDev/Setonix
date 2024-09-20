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
  final GameInfo info;
  final Map<String, Set<Channel>> teamMembers;
  final Channel? id;
  final Map<String, FileMetadata> packsSignature;

  WorldInitialized({
    required this.table,
    required this.info,
    this.teamMembers = const {},
    this.id,
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
final class ObjectsChanged extends ServerWorldEvent
    with ObjectsChangedMappable {
  final GlobalVectorDefinition cell;
  final List<GameObject> objects;

  ObjectsChanged(this.cell, this.objects);
}

@MappableClass()
final class CellShuffled extends ServerWorldEvent with CellShuffledMappable {
  final GlobalVectorDefinition cell;
  final List<int> positions;

  CellShuffled(this.cell, this.positions);
}

@MappableClass()
final class MessageSent extends ServerWorldEvent with MessageSentMappable {
  final Channel user;
  final String message;

  MessageSent(this.user, this.message);
}

@MappableClass()
final class BoardTilesSpawned extends ServerWorldEvent
    with BoardTilesSpawnedMappable {
  final String table;
  final Map<VectorDefinition, List<BoardTile>> tiles;

  BoardTilesSpawned(this.table, this.tiles);
}

@MappableClass()
final class BoardTilesChanged extends ServerWorldEvent
    with BoardTilesChangedMappable {
  final String table;
  final Map<VectorDefinition, List<BoardTile>> tiles;

  BoardTilesChanged(this.table, this.tiles);
}
