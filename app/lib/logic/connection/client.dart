import 'dart:async';
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qeck/logic/state.dart';
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

mixin ConnectedGameConnection on GameConnection {}

class ClientGameConnection with GameConnection, ConnectedGameConnection {
  final WebSocketChannel channel;
  List<GamePlayer> _players = [];
  int _playerId = -2;

  ClientGameConnection(this.channel) {
    _setup();
  }

  factory ClientGameConnection.connect(Uri address) {
    final channel = WebSocketChannel.connect(address);
    return ClientGameConnection(channel);
  }

  void onMessage(ClientConnectionMessage message) {
    message.maybeWhen(
        stateChanged: (state) {
          stateSubject.add(state);
        },
        playersUpdated: (players, playerId) {
          _players = players;
          _playerId = playerId;
        },
        orElse: () {});
  }

  @override
  int get playerId => _playerId;

  @override
  List<GamePlayer> get players => _players;

  void _setup() {
    channel.stream
        .map((event) => ClientConnectionMessage.fromJson(jsonDecode(event)))
        .listen(onMessage);
  }

  void send(ServerConnectionMessage message) {
    channel.sink.add(jsonEncode(message.toJson()));
  }

  Future<T> waitForResponse<T extends ClientConnectionMessage>() async {
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

  List<GameSeat> getMySeats() => state.seats
      .where((element) => element.players.any((e) => e == playerId))
      .toList();

  void addSeat(String name) {
    send(ServerConnectionMessage.addSeat(name));
  }

  void leaveSeat(int key) {
    send(ServerConnectionMessage.leaveSeat(key));
  }

  void joinSeat(int key) {
    send(ServerConnectionMessage.joinSeat(key));
  }

  void removeSeat(int key) {
    send(ServerConnectionMessage.removeSeat(key));
  }

  void addDeck(GameDeck deck, int? seatIndex) {
    send(ServerConnectionMessage.addDeck(deck, seatIndex));
  }

  void addCards(List<CardIndex> cards, int deckIndex, [int? seatIndex]) {
    send(ServerConnectionMessage.addCards(cards, deckIndex, seatIndex));
  }

  void removeCards(List<CardIndex> cards) {
    send(ServerConnectionMessage.removeCards(cards));
  }

  void putCards(int deckIndex, int? seatIndex, PickLocation location, int count,
      int movedDeckIndex, int? movedSeatIndex) {
    send(ServerConnectionMessage.putCards(
      deckIndex,
      seatIndex,
      location,
      count,
      movedDeckIndex,
      movedSeatIndex,
    ));
  }

  void removeDeck(int deckIndex, int? seatIndex) {
    send(ServerConnectionMessage.removeDeck(deckIndex, seatIndex));
  }

  void changeVisibility(int index, int? seatIndex, DeckVisibility visibility) {
    send(
        ServerConnectionMessage.changeVisibility(index, seatIndex, visibility));
  }

  void shuffle(int index, int? seatIndex) {
    send(ServerConnectionMessage.shuffle(index, seatIndex));
  }
}
