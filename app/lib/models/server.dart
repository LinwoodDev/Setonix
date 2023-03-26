import 'package:freezed_annotation/freezed_annotation.dart';

part 'server.g.dart';
part 'server.freezed.dart';

@freezed
class GameServer with _$GameServer {
  const GameServer._();

  const factory GameServer({
    @Default('') String name,
    @Default('') String address,
    @Default(0) int port,
  }) = _GameServer;

  factory GameServer.fromJson(Map<String, dynamic> json) =>
      _$GameServerFromJson(json);
}
