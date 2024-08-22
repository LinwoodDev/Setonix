part of 'event.dart';

(ServerWorldEvent, Channel)? processEvent(WorldEvent event, Channel channel,
        {required AssetManager assetManager,
        required GameTable table,
        bool allowServerEvents = false}) =>
    switch (event) {
      HybridWorldEvent e => (e, kAnyChannel),
      LocalWorldEvent _ => null,
      ServerWorldEvent e => allowServerEvents ? (e, kAnyChannel) : null,
      TeamJoinRequest(team: final team) => (
          TeamJoined(channel, team),
          kAnyChannel
        ),
      TeamLeaveRequest(team: final team) => (
          TeamLeft(channel, team),
          kAnyChannel
        ),
      RollObjectRequest r => _processRollObjectRequest(r, assetManager, table),
      ShuffleCellRequest r => _processShuffleCellRequest(r, table),
    };

(ServerWorldEvent, Channel)? _processRollObjectRequest(
    RollObjectRequest r, AssetManager assetManager, GameTable table) {
  final cell = table.cells[r.cell];
  if (cell == null || !r.object.inRange(0, cell.objects.length - 1)) {
    return null;
  }
  final object = cell.objects[r.object];
  final figure =
      assetManager.getPack(object.asset.namespace)?.getFigure(object.asset.id);
  if (figure == null || !figure.rollable) return null;
  final variations = figure.variations.keys.toList();
  if (variations.isEmpty) return null;
  final picked = variations[Random().nextInt(variations.length)];
  return (VariationChanged(r.cell, r.object, picked), kAnyChannel);
}

(ServerWorldEvent, Channel)? _processShuffleCellRequest(
    ShuffleCellRequest r, GameTable table) {
  final cell = table.cells[r.cell];
  if (cell == null) return null;
  final positions = List<int>.generate(cell.objects.length, (i) => i)
    ..shuffle();
  return (CellShuffled(r.cell, positions), kAnyChannel);
}
