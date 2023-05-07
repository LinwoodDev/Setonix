import 'package:freezed_annotation/freezed_annotation.dart';

part 'server.freezed.dart';

const kDefaultPort = 10357;

@freezed
class GameServer with _$GameServer {
  const factory GameServer.lan({
    required String address,
    required GameProperty property,
  }) = LanGameServer;
}

@freezed
class GameProperty with _$GameProperty {
  const factory GameProperty({
    @Default('') String name,
    @Default('') String description,
  }) = _GameProperty;
}
