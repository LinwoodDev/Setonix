part of 'event.dart';

@MappableClass()
sealed class HybridWorldEvent extends WorldEvent
    with HybridWorldEventMappable
    implements ClientWorldEvent, ServerWorldEvent {}

@MappableClass()
final class BackgroundChanged extends HybridWorldEvent
    with BackgroundChangedMappable {
  final ItemLocation background;

  BackgroundChanged(this.background);
}

@MappableClass()
final class ObjectsSpawned extends HybridWorldEvent
    with ObjectsSpawnedMappable {
  final VectorDefinition cell;
  final List<GameObject> objects;

  ObjectsSpawned(this.cell, this.objects);
}

@MappableClass()
final class ObjectsMoved extends HybridWorldEvent with ObjectsMovedMappable {
  final List<int> objects;
  final VectorDefinition from, to;

  ObjectsMoved(this.objects, this.from, this.to);
}

@MappableClass()
final class CellHideChanged extends HybridWorldEvent
    with CellHideChangedMappable {
  final VectorDefinition cell;
  final int? object;
  final bool? hide;

  CellHideChanged(this.cell, {this.object, this.hide});
  CellHideChanged.show(this.cell, {this.object}) : hide = false;
  CellHideChanged.hide(this.cell, {this.object}) : hide = true;
}

@MappableClass()
final class ObjectIndexChanged extends HybridWorldEvent
    with ObjectIndexChangedMappable {
  final VectorDefinition cell;
  final int object;
  final int index;

  ObjectIndexChanged(this.cell, this.object, this.index);
}

@MappableClass()
final class TeamChanged extends HybridWorldEvent with TeamChangedMappable {
  final String name;
  final GameTeam team;

  TeamChanged(this.name, this.team);
}

@MappableClass()
final class TeamRemoved extends HybridWorldEvent with TeamRemovedMappable {
  final String team;

  TeamRemoved(this.team);
}

@MappableClass()
final class MetadataChanged extends HybridWorldEvent
    with MetadataChangedMappable {
  final FileMetadata metadata;

  MetadataChanged(this.metadata);
}

@MappableClass()
final class CellItemsCleared extends HybridWorldEvent
    with CellItemsClearedMappable {
  final VectorDefinition cell;
  final int? object;

  CellItemsCleared(this.cell, {this.object});
}
