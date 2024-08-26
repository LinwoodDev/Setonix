import 'dart:math';

import 'package:dart_leap/dart_leap.dart';
import 'package:networker/networker.dart';
import 'package:quokka_api/quokka_api.dart';

bool isValidClientEvent(
  WorldEvent event,
  WorldState state, {
  required AssetManager assetManager,
}) =>
    switch (event) {
      TeamJoinRequest() => state.info.teams.containsKey(event.team),
      TeamLeaveRequest() => state.info.teams.containsKey(event.team),
      RollObjectRequest() => event.object
          .inRange(0, state.table.getCell(event.cell).objects.length - 1),
      ShuffleCellRequest() => state.table.cells.containsKey(event.cell),
      ObjectsSpawned() => event.objects.every((e) {
          final figure =
              assetManager.getPack(e.asset.namespace)?.getFigure(e.asset.id);
          return figure != null &&
              (e.variation == null ||
                  figure.variations.containsKey(e.variation));
        }),
      ObjectsMoved() => event.from != event.to &&
          event.objects.every((e) =>
              e.inRange(0, state.table.getCell(event.from).objects.length - 1)),
      CellHideChanged() => event.object?.inRange(
              0, state.table.getCell(event.cell).objects.length - 1) ??
          true,
      ObjectIndexChanged() => event.index
          .inRange(0, state.table.getCell(event.cell).objects.length - 1),
      TeamRemoved() => state.info.teams.containsKey(event.team),
      _ => true,
    };

(ServerWorldEvent, Channel)? processClientEvent(
    WorldEvent event, Channel channel, WorldState state,
    {required AssetManager assetManager, bool allowServerEvents = false}) {
  if (!isValidClientEvent(event, state, assetManager: assetManager)) {
    return null;
  }
  switch (event) {
    case HybridWorldEvent():
      return (event, kAnyChannel);
    case LocalWorldEvent():
      return null;
    case ServerWorldEvent e:
      return allowServerEvents ? (e, kAnyChannel) : null;
    case TeamJoinRequest(team: final team):
      return (TeamJoined(channel, team), kAnyChannel);
    case TeamLeaveRequest(team: final team):
      return (TeamLeft(channel, team), kAnyChannel);
    case RollObjectRequest r:
      final cell = state.table.cells[r.cell];
      if (cell == null || !r.object.inRange(0, cell.objects.length - 1)) {
        return null;
      }
      final object = cell.objects[r.object];
      final figure = assetManager
          .getPack(object.asset.namespace)
          ?.getFigure(object.asset.id);
      if (figure == null || !figure.rollable) return null;
      final variations = figure.variations.keys.toList();
      if (variations.isEmpty) return null;
      final picked = variations[Random().nextInt(variations.length)];
      return (VariationChanged(r.cell, r.object, picked), kAnyChannel);
    case ShuffleCellRequest r:
      final cell = state.table.cells[r.cell];
      if (cell == null) return null;
      final positions = List<int>.generate(cell.objects.length, (i) => i)
        ..shuffle();
      return (CellShuffled(r.cell, positions), kAnyChannel);
  }
}
