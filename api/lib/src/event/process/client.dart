import 'dart:math';

import 'package:dart_leap/dart_leap.dart';
import 'package:networker/networker.dart';
import 'package:quokka_api/quokka_api.dart';

bool isValidClientEvent(
  WorldEvent event,
  Channel channel,
  WorldState state, {
  required AssetManager assetManager,
}) =>
    switch (event) {
      TeamJoinRequest() => state.info.teams.containsKey(event.team),
      TeamLeaveRequest() => state.info.teams.containsKey(event.team),
      CellRollRequest() => event.object?.inRange(
              0,
              state
                      .getTableOrDefault(event.cell.table)
                      .getCell(event.cell.position)
                      .objects
                      .length -
                  1) ??
          true,
      ShuffleCellRequest() => state
          .getTableOrDefault(event.cell.table)
          .cells
          .containsKey(event.cell.position),
      ObjectsSpawned() => event.objects.values.expand((e) => e).every((e) {
          final figure =
              assetManager.getPack(e.asset.namespace)?.getFigure(e.asset.id);
          return figure != null &&
              (e.variation == null ||
                  figure.variations.containsKey(e.variation));
        }),
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
      TeamRemoved() => state.info.teams.containsKey(event.team),
      PacksChangeRequest() => channel == kAuthorityChannel,
      _ => true,
    };

(ServerWorldEvent, Channel)? processClientEvent(
    WorldEvent? event, Channel channel, WorldState state,
    {required AssetManager assetManager, bool allowServerEvents = false}) {
  (ServerWorldEvent, Channel) sendInit(Channel? channel, WorldState state) {
    return (
      WorldInitialized(
        table: state.table,
        info: state.info,
        id: channel,
        packsSignature: assetManager.createSignature(state.info.packs.toSet()),
        teamMembers: state.teamMembers,
      ),
      channel ?? kAnyChannel,
    );
  }

  if (event == null) {
    return sendInit(channel, state);
  }
  if (!isValidClientEvent(event, channel, state, assetManager: assetManager)) {
    return null;
  }
  switch (event) {
    case HybridWorldEvent():
      return (event, kAnyChannel);
    case LocalWorldEvent():
      return null;
    case ServerWorldEvent():
      return allowServerEvents ? (event, kAnyChannel) : null;
    case TeamJoinRequest(team: final team):
      return (TeamJoined(channel, team), kAnyChannel);
    case TeamLeaveRequest(team: final team):
      return (TeamLeft(channel, team), kAnyChannel);
    case CellRollRequest():
      final table = state.getTableOrDefault(event.cell.table);
      var cell = table.getCell(event.cell.position);
      final random = Random();
      GameObject roll(GameObject object) {
        final figure = assetManager
            .getPack(object.asset.namespace)
            ?.getFigure(object.asset.id);
        if (figure == null || !figure.rollable) return object;
        final variations = figure.variations.keys.toList();
        if (variations.isEmpty) return object;
        final picked = variations[random.nextInt(variations.length)];
        return object.copyWith(variation: picked);
      }
      final objectIndex = event.object;
      List<GameObject> objects;
      if (objectIndex != null) {
        final object = cell.objects[objectIndex];
        objects = List<GameObject>.from(cell.objects)
          ..[objectIndex] = roll(object);
      } else {
        objects = cell.objects.map(roll).toList();
      }
      return (ObjectsChanged(event.cell, objects), kAnyChannel);
    case ShuffleCellRequest():
      final table = state.getTableOrDefault(event.cell.table);
      final cell = table.cells[event.cell.position];
      if (cell == null) return null;
      final positions = List<int>.generate(cell.objects.length, (i) => i)
        ..shuffle();
      return (CellShuffled(event.cell, positions), kAnyChannel);
    case PacksChangeRequest():
      return sendInit(
          null,
          state.copyWith.info(
            packs: event.packs.where((e) => assetManager.hasPack(e)).toList(),
          ));
    case MessageRequest():
      return (MessageSent(channel, event.message), kAnyChannel);
    case BoardsSpawnRequest():
      final tiles = <VectorDefinition, List<BoardTile>>{};
      for (final (asset: asset, cell: cell) in event.assets) {
        final definition =
            assetManager.getPack(asset.namespace)?.getBoard(asset.id);
        if (definition == null) return null;
        final size = definition.size ?? VectorDefinition.one;
        for (var x = 0; x < size.x; x++) {
          for (var y = 0; y < size.y; y++) {
            final tile = VectorDefinition(x, y);
            final position = cell + tile;
            tiles.putIfAbsent(position, () => []).add(BoardTile(
                  asset: asset,
                  tile: tile,
                ));
          }
        }
      }
      return (BoardTilesSpawned(event.table, tiles), kAnyChannel);
  }
}
