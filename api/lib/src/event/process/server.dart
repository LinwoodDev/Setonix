import 'package:dart_leap/dart_leap.dart';
import 'package:networker/networker.dart';
import 'package:quokka_api/quokka_api.dart';

bool isValidServerEvent(ServerWorldEvent event, WorldState state) =>
    switch (event) {
      TeamJoined() => state.info.teams.containsKey(event.team),
      TeamLeft() => state.info.teams.containsKey(event.team),
      VariationChanged() => event.object
          .inRange(0, state.table.getCell(event.cell).objects.length - 1),
      CellShuffled() => event.positions.every((e) =>
          e.inRange(0, state.table.getCell(event.cell).objects.length - 1)),
      ObjectsMoved() => event.from != event.to &&
          event.objects.every((e) =>
              e.inRange(0, state.table.getCell(event.from).objects.length - 1)),
      CellHideChanged() => event.object?.inRange(
              0, state.table.getCell(event.cell).objects.length - 1) ??
          true,
      ObjectIndexChanged() => event.index
          .inRange(0, state.table.getCell(event.cell).objects.length - 1),
      _ => true,
    };

sealed class FatalServerEventError {}

final class InvalidPacksError extends FatalServerEventError {
  final Map<String, String> signature;

  InvalidPacksError({required this.signature});

  @override
  String toString() =>
      'Server requested packs, that are not available on the client: $signature';
}

WorldState? processServerEvent(
  ServerWorldEvent event,
  WorldState state, {
  required AssetManager assetManager,
}) {
  if (!isValidServerEvent(event, state)) return null;
  switch (event) {
    case WorldInitialized event:
      final supported = assetManager.isServerSupported(event.packsSignature);
      if (!supported) {
        throw InvalidPacksError(signature: event.packsSignature);
      }
      return state.copyWith(
        table: event.table,
        id: event.id,
        teamMembers: event.teamMembers,
      );
    case TeamJoined event:
      return state.copyWith(
        teamMembers: {
          ...state.teamMembers,
          event.team: {
            ...?state.teamMembers[event.team],
            event.user,
          },
        },
      );
    case TeamLeft event:
      final members = Set<Channel>.from(state.teamMembers[event.team] ?? {});
      members.remove(event.user);
      final allMembers = Map<String, Set<int>>.from(state.teamMembers);
      if (members.isEmpty) {
        allMembers.remove(event.team);
      } else {
        allMembers[event.team] = members;
      }
      return state.copyWith(teamMembers: allMembers);
    case VariationChanged event:
      final cell = state.table.cells[event.cell] ?? TableCell();
      final object = cell.objects[event.object];
      return state.copyWith.table.cells.replace(
          event.cell,
          cell.copyWith.objects.replace(
              event.object, object.copyWith(variation: event.variation)));
    case CellShuffled(positions: final positions):
      final cell = state.table.cells[event.cell] ?? TableCell();
      final objects = cell.objects;
      final newObjects = List<GameObject>.from(objects);
      for (var i = 0; i < positions.length; i++) {
        newObjects[positions[i]] = objects[i];
      }
      return state.copyWith.table.cells.replace(
          event.cell,
          cell.copyWith(
            objects: newObjects,
          ));
    case BackgroundChanged():
      return state.copyWith.table(background: event.background);
    case ObjectsSpawned():
      final cell = (state.table.cells[event.cell] ?? TableCell());
      return state.copyWith.table.cells.replace(event.cell,
          cell.copyWith(objects: [...cell.objects, ...event.objects]));
    case ObjectsMoved():
      var from = state.table.cells[event.from] ?? TableCell();
      var to = state.table.cells[event.to] ?? TableCell();
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
      return state.copyWith.table(cells: {
        ...state.table.cells,
        event.from: from,
        event.to: to,
      });
    case CellHideChanged():
      final cell = state.table.cells[event.cell] ?? TableCell();
      final objectIndex = event.object;
      if (objectIndex != null) {
        final object = cell.objects[objectIndex];
        return state.copyWith.table.cells.replace(
            event.cell,
            cell.copyWith.objects.replace(objectIndex,
                object.copyWith(hidden: event.hide ?? !object.hidden)));
      } else {
        final hidden =
            !(event.hide ?? cell.objects.firstOrNull?.hidden ?? false);
        return state.copyWith.table.cells.replace(
            event.cell,
            cell.copyWith(
              objects:
                  cell.objects.map((e) => e.copyWith(hidden: hidden)).toList(),
            ));
      }
    case ObjectIndexChanged():
      final cell = state.table.cells[event.cell] ?? TableCell();
      final object = cell.objects[event.object];
      final newObjects = List<GameObject>.from(cell.objects);
      newObjects.removeAt(event.object);
      newObjects.insert(event.index, object);
      return state.copyWith.table.cells
          .replace(event.cell, cell.copyWith(objects: newObjects));
    case TeamChanged():
      return state.copyWith.info.teams.put(event.name, event.team);
    case TeamRemoved():
      return state.copyWith(
        info: state.info.copyWith.teams.remove(event.team),
        teamMembers: Map.from(state.teamMembers)..remove(event.team),
      );
    case MetadataChanged():
      return state.copyWith(metadata: event.metadata);
  }
}
