import 'dart:async';
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:town/pages/game/server.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'logic.dart';

part 'client.freezed.dart';
part 'client.g.dart';

@freezed
class ClientConnectionMessage with _$ClientConnectionMessage {
  const factory ClientConnectionMessage.fetchedPlayers(
    List<GamePlayer> players,
  ) = FetchedPlayersClientConnectionMessage;

  factory ClientConnectionMessage.fromJson(Map<String, dynamic> json) =>
      _$ClientConnectionMessageFromJson(json);
}

class ClientGameConnection extends GameConnection {
  final WebSocketChannel channel;

  ClientGameConnection(this.channel);

  factory ClientGameConnection.connect(String address) {
    final channel = WebSocketChannel.connect(Uri.parse(address));
    return ClientGameConnection(channel);
  }

  void setup() {
    channel.stream.listen((event) {});
  }

  void _send(ServerConnectionMessage message) {
    channel.sink.add(message.toJson());
  }

  Future<T> _waitForResponse<T extends ClientConnectionMessage>() async {
    return channel.stream
        .map((event) => jsonDecode(event))
        .map((event) => ClientConnectionMessage.fromJson(event))
        .where((event) => event is T)
        .first as T;
  }

  @override
  Future<List<GamePlayer>> getPlayers() async {
    const message = ServerConnectionMessage.fetchPlayers();
    _send(message);
    return (await _waitForResponse<FetchedPlayersClientConnectionMessage>())
        .players;
  }

  @override
  Future<void> close() async {
    await channel.sink.close();
  }
}
