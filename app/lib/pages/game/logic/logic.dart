import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qeck/pages/game/logic/state.dart';
import 'package:rxdart/rxdart.dart';

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

mixin GameConnection {
  @protected
  final BehaviorSubject<GameState> stateSubject = BehaviorSubject()
    ..add(const GameState());

  GameState get state => stateSubject.value;

  ValueStream<GameState> get stateStream => stateSubject.stream;

  List<GamePlayer> get players;

  int get playerId;

  Future<void> close();
}
