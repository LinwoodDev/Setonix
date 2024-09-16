import 'package:dart_leap/dart_leap.dart';
import 'package:networker/networker.dart';
import 'package:quokka_api/quokka_api.dart';

bool isValidServerEvent(ServerWorldEvent event, WorldState state) =>
    switch (event) {
      WorldInitialized() =>
        event.info.packs.length == event.packsSignature.length &&
            event.info.packs.every((e) => event.packsSignature.containsKey(e)),
      TeamJoined() => state.info.teams.containsKey(event.team),
      TeamLeft() => state.info.teams.containsKey(event.team),
      CellShuffled() => event.positions.every((e) => e.inRange(
          0,
          state
                  .getTableOrDefault(event.cell.table)
                  .getCell(event.cell.position)
                  .objects
                  .length -
              1)),
      ObjectsMoved() => event.from != event.to &&
          event.objects.every((e) => e.inRange(
              0,
              state
                      .getTableOrDefault(event.table)
                      .getCell(event.from)
                      .objects
                      .length -
                  1)),
      CellHideChanged() => event.object?.inRange(
              0,
              state
                      .getTableOrDefault(event.cell.table)
                      .getCell(event.cell.position)
                      .objects
                      .length -
                  1) ??
          true,
      ObjectIndexChanged() => event.index.inRange(
          0,
          state
                  .getTableOrDefault(event.cell.table)
                  .getCell(event.cell.position)
                  .objects
                  .length -
              1),
      _ => true,
    };

sealed class FatalServerEventError {}

final class InvalidPacksError extends FatalServerEventError {
  final Map<String, FileMetadata> signature;

  InvalidPacksError({required this.signature});

  @override
  String toString() =>
      'Server requested packs, that are not available on the client (or is empty): $signature';
}

WorldState? processServerEvent(
  ServerWorldEvent event,
  WorldState state, {
  required AssetManager assetManager,
}) {
  if (!isValidServerEvent(event, state)) return null;
  switch (event) {
    case WorldInitialized():
      final supported = assetManager.isServerSupported(event.packsSignature);
      if (!supported) {
        throw InvalidPacksError(signature: event.packsSignature);
      }
      return state.copyWith(
        table: event.table,
        id: event.id ?? state.id,
        teamMembers: event.teamMembers,
        info: event.info,
      );
    case TeamJoined():
      return state.copyWith(
        teamMembers: {
          ...state.teamMembers,
          event.team: {
            ...?state.teamMembers[event.team],
            event.user,
          },
        },
      );
    case TeamLeft():
      final members = Set<Channel>.from(state.teamMembers[event.team] ?? {});
      members.remove(event.user);
      final allMembers = Map<String, Set<int>>.from(state.teamMembers);
      if (members.isEmpty) {
        allMembers.remove(event.team);
      } else {
        allMembers[event.team] = members;
      }
      return state.copyWith(teamMembers: allMembers);
    case ObjectsChanged():
      return state.mapTableOrDefault(event.cell.table, (table) {
        final cell = table.cells[event.cell.position] ?? TableCell();
        return table.copyWith.cells.replace(
            event.cell.position, cell.copyWith(objects: event.objects));
      });
    case CellShuffled(positions: final positions):
      return state.mapTableOrDefault(event.cell.table, (table) {
        final cell = table.cells[event.cell.position] ?? TableCell();
        final objects = cell.objects;
        final newObjects = List<GameObject>.from(objects);
        for (var i = 0; i < positions.length; i++) {
          newObjects[positions[i]] = objects[i];
        }
        return table.copyWith.cells.replace(
            event.cell.position,
            cell.copyWith(
              objects: newObjects,
            ));
      });
    case BackgroundChanged():
      return state.copyWith.table(background: event.background);
    case ObjectsSpawned():
      return state.mapTableOrDefault(event.table, (table) {
        var newTable = table;
        for (final entry in event.objects.entries) {
          final cell = newTable.cells[entry.key] ?? TableCell();
          newTable = newTable.copyWith.cells
              .replace(entry.key, cell.copyWith(objects: entry.value));
        }
        return newTable;
      });
    case ObjectsMoved():
      return state.mapTableOrDefault(event.table, (table) {
        var from = table.cells[event.from] ?? TableCell();
        var to = table.cells[event.to] ?? TableCell();
        final toRemove = List<int>.from(event.objects)
          ..sort((a, b) => b.compareTo(a));
        final toAdd = toRemove.map((e) => from.objects[e]).toList();
        final newObjects = List<GameObject>.from(from.objects);
        for (final i in toRemove) {
          newObjects.removeAt(i);
        }
        from = from.copyWith(objects: newObjects);
        to = to.copyWith(objects: [
          ...to.objects,
          ...toAdd,
        ]);
        return table.copyWith(cells: {
          ...table.cells,
          event.from: from,
          event.to: to,
        });
      });
    case CellHideChanged():
      return state.mapTableOrDefault(event.cell.table, (table) {
        final cell = table.cells[event.cell.position] ?? TableCell();
        final objectIndex = event.object;
        if (objectIndex != null) {
          final object = cell.objects[objectIndex];
          return table.copyWith.cells.replace(
              event.cell.position,
              cell.copyWith.objects.replace(objectIndex,
                  object.copyWith(hidden: event.hide ?? !object.hidden)));
        } else {
          final hidden =
              !(event.hide ?? cell.objects.firstOrNull?.hidden ?? false);
          return table.copyWith.cells.replace(
              event.cell.position,
              cell.copyWith(
                objects: cell.objects
                    .map((e) => e.copyWith(hidden: hidden))
                    .toList(),
              ));
        }
      });
    case CellItemsCleared():
      return state.mapTableOrDefault(event.cell.table, (table) {
        final cell = table.cells[event.cell.position] ?? TableCell();
        final objectIndex = event.object;
        if (objectIndex != null) {
          return table.copyWith.cells.replace(
              event.cell.position, cell.copyWith.objects.removeAt(objectIndex));
        } else {
          return table.copyWith.cells.replace(
              event.cell.position,
              cell.copyWith(
                objects: [],
              ));
        }
      });
    case ObjectIndexChanged():
      return state.mapTableOrDefault(event.cell.table, (table) {
        final cell = table.cells[event.cell.position] ?? TableCell();
        final object = cell.objects[event.object];
        final newObjects = List<GameObject>.from(cell.objects);
        newObjects.removeAt(event.object);
        newObjects.insert(event.index, object);
        return table.copyWith.cells
            .replace(event.cell.position, cell.copyWith(objects: newObjects));
      });
    case TeamChanged():
      return state.copyWith.info.teams.put(event.name, event.team);
    case TeamRemoved():
      return state.copyWith(
        info: state.info.copyWith.teams.remove(event.team),
        teamMembers: Map.from(state.teamMembers)..remove(event.team),
      );
    case MetadataChanged():
      return state.copyWith(metadata: event.metadata);
    case MessageSent():
      return state.copyWith.messages.add(ChatMessage(
        author: event.user,
        content: event.message,
        timestamp: DateTime.now(),
      ));
    case TableRenamed():
      final data = state.data.getTable(event.name);
      return state.copyWith(
          tableName:
              event.name == state.tableName ? event.newName : state.tableName,
          data: data == null
              ? state.data
              : state.data
                  .removeTable(event.name)
                  .setTable(data, event.newName));
    case TableRemoved():
      return state.copyWith(
          tableName: state.tableName == event.name ? '' : state.tableName,
          data: state.data.removeTable(event.name));
    case NoteChanged():
      return state.copyWith(
          data: state.data.setNote(event.name, event.content));
    case NoteRemoved():
      return state.copyWith(data: state.data.removeNote(event.name));
  }
}
