part of '../event.dart';

(ServerWorldEvent, Channel)? processEvent(
        WorldBloc bloc, WorldEvent event, Channel channel,
        {bool allowServerEvents = false}) =>
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
      RollObjectRequest r => _processRollObjectRequest(bloc, r),
    };

(ServerWorldEvent, Channel)? _processRollObjectRequest(
    WorldBloc bloc, RollObjectRequest r) {
  final cell = bloc.state.table.cells[r.cell];
  if (cell == null || !r.object.inRange(0, cell.objects.length - 1))
    return null;
  final object = cell.objects[r.object];
  final figure = bloc.assetManager
      .getPack(object.asset.namespace)
      ?.getFigure(object.asset.id);
  if (figure == null || !figure.rollable) return null;
  final variations = figure.variations.keys.toList();
  if (variations.isEmpty) return null;
  final picked = variations[Random().nextInt(variations.length)];
  return (VariationChanged(r.cell, r.object, picked), kAnyChannel);
}
