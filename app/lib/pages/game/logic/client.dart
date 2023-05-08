import 'dart:async';
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qeck/pages/game/logic/state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'logic.dart';
import 'server.dart';

part 'client.freezed.dart';
part 'client.g.dart';

@freezed
class ClientConnectionMessage with _$ClientConnectionMessage {
  const factory ClientConnectionMessage.playersUpdated(
    List<GamePlayer> players,
    int playerId,
  ) = FetchedPlayersClientConnectionMessage;

  const factory ClientConnectionMessage.chatMessage(
    String message,
    String from,
  ) = ChatMessageClientConnectionMessage;

  const factory ClientConnectionMessage.stateChanged(GameState state) =
      GameStateChangedClientConnectionMessage;

  factory ClientConnectionMessage.fromJson(Map<String, dynamic> json) =>
      _$ClientConnectionMessageFromJson(json);
}

class ClientGameConnection with GameConnection {
  final WebSocketChannel channel;
  List<GamePlayer> _players = [];
  int _playerId = -2;

  ClientGameConnection(this.channel);

  factory ClientGameConnection.connect(Uri address) {
    final channel = WebSocketChannel.connect(address);
    return ClientGameConnection(channel);
  }

  void setup() {
    channel.stream
        .map((event) => ClientConnectionMessage.fromJson(jsonDecode(event)))
        .listen((event) {
      event.maybeWhen(
          stateChanged: (state) {
            stateSubject.add(state);
          },
          playersUpdated: (players, playerId) {
            _players = players;
            _playerId = playerId;
          },
          orElse: () {});
    });
  }

  void _send(ServerConnectionMessage message) {
    channel.sink.add(jsonEncode(message.toJson()));
  }

  Future<T> _waitForResponse<T extends ClientConnectionMessage>() async {
    return await channel.stream
        .map((event) => jsonDecode(event))
        .map((event) => ClientConnectionMessage.fromJson(event))
        .where((event) => event is T)
        .first as T;
  }

  @override
  Future<void> close() async {
    await channel.sink.close();
  }

  @override
  int get playerId => _playerId;

  @override
  List<GamePlayer> get players => _players;
}
