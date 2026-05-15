import 'dart:math';

import 'package:dart_leap/dart_leap.dart';
import 'package:networker/networker.dart';
import 'package:setonix_api/setonix_api.dart';

const _maxTextLength = 2000;
const _maxIdentifierLength = 256;
const _maxImagesPerRequest = 100;
const _maxPacksPerRequest = 128;
const _maxBoardsPerRequest = 256;

bool _isReasonableIdentifier(String value) =>
    value.isNotEmpty && value.length <= _maxIdentifierLength;

bool isValidClientEvent(
  WorldEvent event,
  Channel channel,
  WorldState state, {
  required AssetManager assetManager,
  ChallengeManager? challengeManager,
}) => switch (event) {
  TeamJoinRequest() =>
    _isReasonableIdentifier(event.team) &&
        state.info.teams.containsKey(event.team),
  TeamLeaveRequest() =>
    _isReasonableIdentifier(event.team) &&
        state.info.teams.containsKey(event.team),
  CellRollRequest() =>
    event.object?.inRange(
          0,
          state
                  .getTableOrDefault(event.cell.table)
                  .getCell(event.cell.position)
                  .objects
                  .length -
              1,
        ) ??
        true,
  ShuffleCellRequest() =>
    state
        .getTableOrDefault(event.cell.table)
        .cells
        .containsKey(event.cell.position),
  ObjectsSpawned() => event.objects.values.expand((e) => e).every((e) {
    final figure = assetManager.getFigure(e.asset);
    return figure != null &&
        (e.variation == null || figure.variations.containsKey(e.variation));
  }),
  ObjectsMoved() =>
    event.from != event.to &&
        event.objects.every(
          (e) => e.inRange(
            0,
            state
                    .getTableOrDefault(event.table)
                    .getCell(event.from)
                    .objects
                    .length -
                1,
          ),
        ),
  CellHideChanged() =>
    event.object?.inRange(
          0,
          state
                  .getTableOrDefault(event.cell.table)
                  .getCell(event.cell.position)
                  .objects
                  .length -
              1,
        ) ??
        true,
  ObjectIndexChanged() => event.index.inRange(
    0,
    state
            .getTableOrDefault(event.cell.table)
            .getCell(event.cell.position)
            .objects
            .length -
        1,
  ),
  TeamRemoved() => state.info.teams.containsKey(event.team),
  PacksChangeRequest() =>
    channel == kAuthorityChannel &&
        event.packs.length <= _maxPacksPerRequest &&
        event.packs.every(_isReasonableIdentifier),
  MessageRequest() =>
    event.message.isNotEmpty && event.message.length <= _maxTextLength,
  BoardsSpawnRequest() =>
    _isReasonableIdentifier(event.table) &&
        event.assets.length <= _maxBoardsPerRequest &&
        event.assets.values.expand((e) => e).length <= _maxBoardsPerRequest,
  BoardMoveRequest() =>
    _isReasonableIdentifier(event.table) &&
        event.from != event.to &&
        event.index.inRange(
          0,
          state
                  .getTableOrDefault(event.table)
                  .getCell(event.from)
                  .tiles
                  .length -
              1,
        ),
  ModeChangeRequest() => channel == kAuthorityChannel,
  DialogCloseRequest() => _isReasonableIdentifier(event.id),
  ImagesRequest() =>
    event.ids.length <= _maxImagesPerRequest &&
        event.ids.every(_isReasonableIdentifier),
  ToolbarActionRequest() => _isReasonableIdentifier(event.actionId),
  _ => true,
};

sealed class ServerResponse {
  const ServerResponse();
}

class KickServerResponse extends ServerResponse {
  final KickMessage message;
  final Set<Channel> kicked;

  const KickServerResponse(this.message, {this.kicked = const {}});
}

HybridWorldEvent _hybridProtectPacket(HybridWorldEvent event) =>
    switch (event) {
      ObjectsSpawned() => event.copyWith(
        objects: event.objects.map((cell, objects) {
          final protectedObjects = objects
              .map((e) => e.hidden ? e.copyWith(variation: null) : e)
              .toList();
          return MapEntry(cell, protectedObjects);
        }),
      ),
      _ => event,
    };

ServerWorldEvent protectServerEvent(ServerWorldEvent event) =>
    event is HybridWorldEvent ? _hybridProtectPacket(event) : event;

class UpdateServerResponse extends ServerResponse {
  final NetworkerPacket<ServerWorldEvent>? main;
  final Set<Channel> needsUpdate;

  UpdateServerResponse(this.main, [this.needsUpdate = const {}]);
  UpdateServerResponse.builder(
    ServerWorldEvent? event, [
    Channel channel = kAnyChannel,
    this.needsUpdate = const {},
  ]) : main = event == null ? null : NetworkerPacket(event, channel);

  List<NetworkerPacket<ServerWorldEvent>> buildPackets(
    WorldState state,
    Iterable<Channel> connected,
  ) {
    return [?main, ...buildUpdatePackets(state, connected)];
  }

  List<NetworkerPacket<WorldInitialized>> buildUpdatePackets(
    WorldState state,
    Iterable<Channel> connected,
  ) => buildUpdatePacketsFor(state, connected, needsUpdate);

  List<NetworkerPacket<WorldInitialized>> buildUpdatePacketsFor(
    WorldState state,
    Iterable<Channel> connected,
    Set<Channel>? needsUpdate,
  ) {
    needsUpdate ??= this.needsUpdate;
    if (needsUpdate.isEmpty) return [];
    final packets = <NetworkerPacket<WorldInitialized>>[];
    for (final channel in connected) {
      if (needsUpdate.contains(channel) || needsUpdate.contains(kAnyChannel)) {
        packets.add(
          NetworkerPacket(
            WorldInitialized(table: state.protectTable(channel)),
            channel,
          ),
        );
      }
    }
    return packets;
  }
}

Set<Channel> _hybridNeedsUpdate(
  HybridWorldEvent event,
  WorldState state,
  Channel channel,
) => switch (event) {
  TeamRemoved() => {kAnyChannel},
  CellHideChanged() => {kAnyChannel},
  _ => {},
};

Future<ServerResponse?> processClientEvent(
  WorldEvent? event,
  Channel channel,
  WorldState state, {
  required AssetManager assetManager,
  bool allowServerEvents = false,
  ChallengeManager? challengeManager,
  UserManager? userManager,
}) async {
  buildInitialize() => WorldInitialized(
    table: state.protectTable(channel),
    info: state.info,
    id: channel,
    packsSignature: assetManager
        .createSignature(state.info.packs.toSet())
        .values
        .toList(),
    teamMembers: state.teamMembers,
  );

  if (event == null) {
    if (challengeManager != null) {
      final challenge = challengeManager.generateNewChallenge(channel);
      return UpdateServerResponse.builder(
        AuthenticatedRequested(challenge, isRequired: true),
        channel,
      );
    }
    await userManager?.addUser(channel);
    return UpdateServerResponse.builder(buildInitialize(), channel);
  }
  if (!isValidClientEvent(event, channel, state, assetManager: assetManager)) {
    return null;
  }
  switch (event) {
    case HybridWorldEvent():
      return UpdateServerResponse.builder(
        event,
        kAnyChannel,
        _hybridNeedsUpdate(event, state, channel),
      );
    case LocalWorldEvent():
      return null;
    case ServerWorldEvent():
      return allowServerEvents
          ? UpdateServerResponse.builder(event, kAnyChannel)
          : null;
    case TeamJoinRequest(team: final team):
      return UpdateServerResponse.builder(
        TeamJoined(channel, team),
        kAnyChannel,
        {channel},
      );
    case TeamLeaveRequest(team: final team):
      return UpdateServerResponse.builder(
        TeamLeft(channel, team),
        kAnyChannel,
        {channel},
      );
    case CellRollRequest():
      final table = state.getTableOrDefault(event.cell.table);
      var cell = table.getCell(event.cell.position);
      final random = Random.secure();
      GameObject roll(GameObject object) {
        final figure = assetManager.getFigure(object.asset);
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
      return UpdateServerResponse.builder(
        ObjectsChanged(event.cell, objects),
        kAnyChannel,
      );
    case ShuffleCellRequest():
      final table = state.getTableOrDefault(event.cell.table);
      final cell = table.cells[event.cell.position];
      if (cell == null) return null;
      final positions = List<int>.generate(cell.objects.length, (i) => i)
        ..shuffle(Random.secure());
      return UpdateServerResponse.builder(
        CellShuffled(event.cell, positions),
        kAnyChannel,
      );
    case PacksChangeRequest():
      return UpdateServerResponse.builder(
        WorldInitialized(
          info: state.info.copyWith(
            packs: event.packs.where((e) => assetManager.hasPack(e)).toList(),
          ),
        ),
      );
    case MessageRequest():
      return UpdateServerResponse.builder(
        MessageSent(channel, event.message),
        kAnyChannel,
      );
    case BoardsSpawnRequest():
      final tiles = <VectorDefinition, List<BoardTile>>{};
      for (final (cell, asset) in event.assets.entries.expand(
        (e) => e.value.map((l) => (e.key, l)),
      )) {
        final definition = assetManager.getBoard(asset);
        if (definition == null) return null;
        final size = definition.tiles;
        for (var x = 0; x < size.x; x++) {
          for (var y = 0; y < size.y; y++) {
            final tile = VectorDefinition(x, y);
            final position = cell + tile;
            tiles.putIfAbsent(position, () => []).add(BoardTile(asset, tile));
          }
        }
      }
      return UpdateServerResponse.builder(
        BoardTilesSpawned(event.table, tiles),
        kAnyChannel,
      );
    case BoardRemoveRequest():
      final table = state.getTableOrDefault(event.position.table);
      final cell = table.getCell(event.position.position);
      final currentObject = cell.tiles[event.index];
      final definition = assetManager.getBoard(currentObject.asset);
      final size = definition?.tiles ?? VectorDefinition.one;
      final newTiles = <VectorDefinition, List<BoardTile>>{};
      for (var x = 0; x < size.x; x++) {
        for (var y = 0; y < size.y; y++) {
          final position = VectorDefinition(
            x + event.position.x - currentObject.tile.x,
            y + event.position.y - currentObject.tile.y,
          );
          final cell = table.getCell(position);
          final index = cell.tiles.indexWhere(
            (e) =>
                e.asset == currentObject.asset &&
                e.tile.x == x &&
                e.tile.y == y,
          );
          if (index != -1) {
            final newTilesList = List<BoardTile>.from(cell.tiles)
              ..removeAt(index);
            newTiles[position] = newTilesList;
          }
        }
      }
      return UpdateServerResponse.builder(
        BoardTilesChanged(event.position.table, newTiles),
        kAnyChannel,
      );
    case BoardMoveRequest():
      final table = state.getTableOrDefault(event.table);
      final from = table.getCell(event.from);
      final currentObject = from.tiles[event.index];
      final definition = assetManager.getBoard(currentObject.asset);
      final size = definition?.tiles ?? VectorDefinition.one;
      final newTiles = <VectorDefinition, List<BoardTile>>{};
      for (var x = 0; x < size.x; x++) {
        for (var y = 0; y < size.y; y++) {
          final fromPosition = VectorDefinition(
            x + event.from.x - currentObject.tile.x,
            y + event.from.y - currentObject.tile.y,
          );
          final toPosition = fromPosition + event.to - event.from;
          final tiles =
              newTiles[fromPosition] ?? table.getCell(fromPosition).tiles;
          final index = tiles.indexWhere(
            (e) =>
                e.asset == currentObject.asset &&
                e.tile.x == x &&
                e.tile.y == y,
          );
          if (index != -1) {
            final newTilesList = List<BoardTile>.from(tiles)..removeAt(index);
            newTiles[fromPosition] = newTilesList;
            newTiles
                .putIfAbsent(
                  toPosition,
                  () => List<BoardTile>.from(table.getCell(toPosition).tiles),
                )
                .add(BoardTile(currentObject.asset, VectorDefinition(x, y)));
          }
        }
      }
      return UpdateServerResponse.builder(
        BoardTilesChanged(event.table, newTiles),
        kAnyChannel,
      );
    case DialogCloseRequest():
      return UpdateServerResponse.builder(
        DialogsClosed.single(event.id),
        channel,
      );
    case ImagesRequest():
      return UpdateServerResponse.builder(
        ImagesUpdated(
          Map.fromEntries(
            event.ids.map((e) {
              final image = state.images[e];
              if (image == null) return null;
              return MapEntry(e, image);
            }).nonNulls,
          ),
        ),
        channel,
      );
    case ModeChangeRequest():
      final location = event.location;
      final mode = location == null ? null : assetManager.getModeItem(location);
      return UpdateServerResponse.builder(
        WorldInitialized.fromMode(mode, state),
        channel,
      );
    case AuthenticateRequest():
      final challenge = challengeManager?.getChallenge(channel);
      if (challenge == null) return null;
      if (challengeManager == null) return null;
      final verified = await event.verify(challenge);
      if (!verified) {
        final newChallenge = challengeManager.generateNewChallenge(channel);
        return UpdateServerResponse.builder(
          AuthenticatedRequested(newChallenge, isRequired: true),
          channel,
        );
      }
      challengeManager.removeChallenge(channel);
      SetonixUser? user;
      try {
        user = await userManager?.addUser(
          channel,
          generateFingerprint(event.publicKey),
        );
      } catch (e) {
        if (e is KickMessage) {
          return KickServerResponse(e, kicked: {channel});
        } else {
          return KickServerResponse(
            KickMessage(reason: KickReason.notRegistered),
          );
        }
      }
      if (user == null) {
        final newChallenge = challengeManager.generateNewChallenge(channel);
        return UpdateServerResponse.builder(
          AuthenticatedRequested(newChallenge, isRequired: true),
          channel,
        );
      }
      return UpdateServerResponse.builder(buildInitialize(), channel);
    case ToolbarActionRequest():
      return UpdateServerResponse.builder(null);
  }
}
