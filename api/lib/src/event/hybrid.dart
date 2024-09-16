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
  final String table;
  final Map<VectorDefinition, List<GameObject>> objects;

  ObjectsSpawned(this.table, this.objects);
  ObjectsSpawned.single(GlobalVectorDefinition cell, List<GameObject> objects)
      : objects = {cell.position: objects},
        table = cell.table;
}

@MappableClass()
final class ObjectsMoved extends HybridWorldEvent with ObjectsMovedMappable {
  final List<int> objects;
  final String table;
  final VectorDefinition from, to;

  ObjectsMoved(this.objects, this.table, this.from, this.to);
}

@MappableClass()
final class CellHideChanged extends HybridWorldEvent
    with CellHideChangedMappable {
  final GlobalVectorDefinition cell;
  final int? object;
  final bool? hide;

  CellHideChanged(this.cell, {this.object, this.hide});
  CellHideChanged.show(this.cell, {this.object}) : hide = false;
  CellHideChanged.hide(this.cell, {this.object}) : hide = true;
}

@MappableClass()
final class ObjectIndexChanged extends HybridWorldEvent
    with ObjectIndexChangedMappable {
  final GlobalVectorDefinition cell;
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
  final GlobalVectorDefinition cell;
  final int? object;

  CellItemsCleared(this.cell, {this.object});
}

@MappableClass()
final class TableRenamed extends HybridWorldEvent with TableRenamedMappable {
  final String name, newName;

  TableRenamed(this.name, this.newName);
}

@MappableClass()
final class TableRemoved extends HybridWorldEvent with TableRemovedMappable {
  final String name;

  TableRemoved(this.name);
}

@MappableClass()
final class NoteChanged extends HybridWorldEvent with NoteChangedMappable {
  final String name, content;

  NoteChanged(this.name, this.content);
}

@MappableClass()
final class NoteRemoved extends HybridWorldEvent with NoteRemovedMappable {
  final String name;

  NoteRemoved(this.name);
}
