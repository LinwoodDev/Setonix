import 'dart:async';
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'logic.dart';
import 'server.dart';

part 'client.freezed.dart';
part 'client.g.dart';

@freezed
class ClientConnectionMessage with _$ClientConnectionMessage {
  const factory ClientConnectionMessage.fetchedPlayers(
    List<GamePlayer> players,
  ) = FetchedPlayersClientConnectionMessage;

  const factory ClientConnectionMessage.chatMessage(
    String message,
    String from,
  ) = ChatMessageClientConnectionMessage;

  factory ClientConnectionMessage.fromJson(Map<String, dynamic> json) =>
      _$ClientConnectionMessageFromJson(json);
}

class ClientGameConnection extends GameConnection {
  final WebSocketChannel channel;

  ClientGameConnection(this.channel);

  factory ClientGameConnection.connect(Uri address) {
    final channel = WebSocketChannel.connect(address);
    return ClientGameConnection(channel);
  }

  void setup() {
    channel.stream.listen((event) {});
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
