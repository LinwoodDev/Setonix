import 'dart:math';

import 'package:dart_leap/dart_leap.dart';
import 'package:networker/networker.dart';
import 'package:quokka_api/quokka_api.dart';

(ServerWorldEvent, Channel)? processClientEvent(
    WorldEvent event, Channel channel,
    {required AssetManager assetManager,
    required GameTable table,
    bool allowServerEvents = false}) {
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
      final cell = table.cells[r.cell];
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
      final cell = table.cells[r.cell];
      if (cell == null) return null;
      final positions = List<int>.generate(cell.objects.length, (i) => i)
        ..shuffle();
      return (CellShuffled(r.cell, positions), kAnyChannel);
  }
}
