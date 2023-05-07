import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'logic.freezed.dart';
part 'logic.g.dart';

@freezed
class GamePlayer with _$GamePlayer {
  const factory GamePlayer({
    required String name,
    required String id,
  }) = _GamePlayer;

  factory GamePlayer.fromJson(Map<String, dynamic> json) =>
      _$GamePlayerFromJson(json);
}

abstract class GameConnection {
  FutureOr<List<GamePlayer>> getPlayers();

  Future<void> close();
}
