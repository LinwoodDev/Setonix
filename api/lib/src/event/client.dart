part of 'event.dart';

/// Events that will be send by the client
/// Naming convention: present tense + Request
@MappableClass()
sealed class ClientWorldEvent extends WorldEvent
    with ClientWorldEventMappable {}

@MappableClass()
final class TeamJoinRequest extends ClientWorldEvent
    with TeamJoinRequestMappable {
  final String team;

  TeamJoinRequest(this.team);
}

@MappableClass()
final class TeamLeaveRequest extends ClientWorldEvent
    with TeamLeaveRequestMappable {
  final String team;

  TeamLeaveRequest(this.team);
}

@MappableClass()
final class CellRollRequest extends ClientWorldEvent
    with CellRollRequestMappable {
  final GlobalVectorDefinition cell;
  final int? object;

  CellRollRequest(this.cell, {this.object});
}

@MappableClass()
final class ShuffleCellRequest extends ClientWorldEvent
    with ShuffleCellRequestMappable {
  final GlobalVectorDefinition cell;

  ShuffleCellRequest(this.cell);
}

@MappableClass()
final class PacksChangeRequest extends ClientWorldEvent
    with PacksChangeRequestMappable {
  final List<String> packs;

  PacksChangeRequest(this.packs);
}

@MappableClass()
final class MessageRequest extends ClientWorldEvent
    with MessageRequestMappable {
  final String message;

  MessageRequest(this.message);
}

@MappableClass()
final class BoardsSpawnRequest extends ClientWorldEvent
    with BoardsSpawnRequestMappable {
  final String table;
  final List<
      ({
        VectorDefinition cell,
        ItemLocation asset,
      })> assets;

  BoardsSpawnRequest(this.table, this.assets);
  BoardsSpawnRequest.single(GlobalVectorDefinition cell, ItemLocation asset)
      : table = cell.table,
        assets = [(cell: cell.position, asset: asset)];
}
