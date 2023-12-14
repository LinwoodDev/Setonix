import 'dart:convert';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qeck/logic/state.dart';
import 'package:qeck/services/network.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'client.dart';
import 'logic.dart';

part 'server.freezed.dart';
part 'server.g.dart';

@freezed
class ServerConnectionMessage with _$ServerConnectionMessage {
  const factory ServerConnectionMessage.fetchPlayers() =
      FetchPlayersServerConnectionMessage;

  const factory ServerConnectionMessage.chatMessage(String message) =
      ChatMessageServerConnectionMessage;

  const factory ServerConnectionMessage.addDeck(GameDeck deck, int? seatIndex) =
      AddDeckServerConnectionMessage;

  const factory ServerConnectionMessage.removeDeck(int index, int? seatIndex) =
      RemoveDeckServerConnectionMessage;

  const factory ServerConnectionMessage.addSeat(String name) =
      AddSeatServerConnectionMessage;

  const factory ServerConnectionMessage.addCards(
          List<CardIndex> cards, int deckIndex, int? seatIndex) =
      AddCardsServerConnectionMessage;

  const factory ServerConnectionMessage.putCards(
    int deckIndex,
    int? seatIndex,
    PickLocation location,
    int count,
    int movedDeckIndex,
    int? movedSeatIndex,
  ) = PutCardsServerConnectionMessage;

  const factory ServerConnectionMessage.removeCards(List<CardIndex> cards) =
      RemoveCardsServerConnectionMessage;

  const factory ServerConnectionMessage.removeSeat(int index) =
      RemoveSeatServerConnectionMessage;

  const factory ServerConnectionMessage.joinSeat(int index) =
      JoinSeatServerConnectionMessage;

  const factory ServerConnectionMessage.leaveSeat(int index) =
      LeaveSeatServerConnectionMessage;

  const factory ServerConnectionMessage.shuffle(int deckIndex, int? seatIndex) =
      ShuffleServerConnectionMessage;

  const factory ServerConnectionMessage.changeVisibility(
          int deckIndex, int? seatIndex, DeckVisibility visibility,
          [DeckVisibility? ownVisibility]) =
      ChangeVisibilityServerConnectionMessage;

  factory ServerConnectionMessage.fromJson(Map<String, dynamic> json) =>
      _$ServerConnectionMessageFromJson(json);
}

class WebSocketClient {
  final WebSocket socket;
  final HttpConnectionInfo info;

  WebSocketClient(this.socket, this.info);

  int get id => socket.hashCode;
}

class ServerGameConnection with GameConnection {
  final HttpServer server;
  final List<WebSocketClient> clients = [];

  ServerGameConnection._(this.server) {
    _setup();
  }

  static Future<ServerGameConnection> create() async {
    final connection = ServerGameConnection._(
      await HttpServer.bind(
        InternetAddress.anyIPv4,
        kDefaultPort,
      ),
    );
    return connection;
  }

  @override
  Future<void> close() async {
    await server.close();
  }

  Future<void> _setup() async {
    await for (HttpRequest request in server) {
      final info = request.connectionInfo;
      if (info == null) {
        request.response.statusCode = HttpStatus.forbidden;
        request.response.close();
        continue;
      }
      var socket = await WebSocketTransformer.upgrade(request);
      final client = WebSocketClient(socket, info);
      clients.add(client);
      _sendPlayersUpdated();
      _sendState(client);

      // Listen for incoming messages from the client
      socket.listen((event) => _onMessage(client, event), onDone: () {
        clients.remove(client);
        _sendPlayersUpdated();
      });
    }
  }

  @override
  List<GamePlayer> get players => clients
      .map((e) => GamePlayer(name: e.info.remoteAddress.address, id: e.id))
      .toList();

  @override
  int get playerId => -1;

  void _send(WebSocketClient client, ClientConnectionMessage message) {
    client.socket.add(jsonEncode(message));
  }

  void _sendPlayersUpdated() {
    for (final client in clients) {
      _send(
        client,
        ClientConnectionMessage.playersUpdated(players, client.id),
      );
    }
  }

  void _sendToAll(ClientConnectionMessage message) {
    for (final client in clients) {
      _send(client, message);
    }
  }

  void _changeState(GameState state) {
    stateSubject.add(state);
    clients.forEach(_sendState);
  }

  void _sendState(WebSocketClient client) {
    _send(
      client,
      ClientConnectionMessage.stateChanged(
        state.onPlayer(
          client.id,
        ),
      ),
    );
  }

  List<GameCard> _removeCards(List<CardIndex> cards) {
    final deckIndexes = cards.whereType<DeckCardIndex>().toList();
    final seatIndexes = cards.whereType<SeatCardIndex>().toList();

    final addingCards =
        cards.whereType<AvailableCardIndex>().map((e) => e.card).toList();
    _changeState(state.copyWith(
        decks: state.decks.asMap().entries.map(
          (de) {
            final deck = de.value;
            return deck.copyWith(
                cards: deck.cards
                    .asMap()
                    .entries
                    .where((e) {
                      final found = deckIndexes.any((element) =>
                          element.deckIndex == de.key &&
                          element.cardIndex == e.key);
                      if (found) {
                        addingCards.add(e.value);
                      }
                      return !found;
                    })
                    .map((e) => e.value)
                    .toList());
          },
        ).toList(),
        seats: state.seats.asMap().entries.map((se) {
          final seat = se.value;
          return seat.copyWith(
              decks: seat.decks.asMap().entries.map((de) {
            final deck = de.value;
            return deck.copyWith(
                cards: deck.cards
                    .asMap()
                    .entries
                    .where((e) {
                      final found = seatIndexes.any((element) =>
                          element.deckIndex == de.key &&
                          element.seatIndex == se.key &&
                          element.cardIndex == e.key);
                      if (found) {
                        addingCards.add(e.value);
                      }
                      return !found;
                    })
                    .map((e) => e.value)
                    .toList());
          }).toList());
        }).toList()));
    return addingCards;
  }

  Future<void> _onMessage(WebSocketClient client, event) async {
    final message = ServerConnectionMessage.fromJson(jsonDecode(event));
    void sendBack(ClientConnectionMessage message) {
      _send(client, message);
    }

    message.when(
      fetchPlayers: () => sendBack(
        ClientConnectionMessage.playersUpdated(players, client.id),
      ),
      chatMessage: (message) => _sendToAll(
        ClientConnectionMessage.chatMessage(
          message,
          client.info.remoteAddress.address,
        ),
      ),
      addDeck: (deck, seatIndex) {
        if (seatIndex != null) {
          _changeState(state.copyWith(
              seats: List<GameSeat>.from(state.seats)
                ..[seatIndex] = state.seats[seatIndex].copyWith(
                  decks: [...state.seats[seatIndex].decks, deck],
                )));
          return;
        }
        _changeState(state.copyWith(decks: [...state.decks, deck]));
      },
      removeDeck: (index, seatIndex) {
        if (seatIndex != null) {
          _changeState(state.copyWith(
              seats: List<GameSeat>.from(state.seats)
                ..[seatIndex] = state.seats[seatIndex].copyWith(
                  decks: List<GameDeck>.from(state.seats[seatIndex].decks)
                    ..removeAt(index),
                )));
          return;
        }
        _changeState(state.copyWith(
            decks: List<GameDeck>.from(state.decks)..removeAt(index)));
      },
      addSeat: (name) {
        _changeState(state.copyWith(seats: [
          ...state.seats,
          GameSeat(
            name: name,
          ),
        ]));
      },
      removeSeat: (index) {
        _changeState(state.copyWith(
            seats: List<GameSeat>.from(state.seats)..removeAt(index)));
      },
      joinSeat: (index) {
        _changeState(state.copyWith(
            seats: List<GameSeat>.from(state.seats)
              ..[index] = state.seats[index].copyWith(
                players: [...state.seats[index].players, client.id],
              )));
      },
      leaveSeat: (index) {
        _changeState(state.copyWith(
            seats: List<GameSeat>.from(state.seats)
              ..[index] = state.seats[index].copyWith(
                players: List<int>.from(state.seats[index].players)
                  ..remove(client.id),
              )));
      },
      addCards: (cards, deckIndex, seatIndex) {
        final addingCards = _removeCards(cards);
        var newState = state;
        if (seatIndex != null) {
          newState = newState.copyWith(
              seats: List<GameSeat>.from(newState.seats)
                ..[seatIndex] = newState.seats[seatIndex].copyWith(
                    decks: List<GameDeck>.from(newState.seats[seatIndex].decks)
                      ..[deckIndex] =
                          newState.seats[seatIndex].decks[deckIndex].copyWith(
                        cards: [
                          ...newState.seats[seatIndex].decks[deckIndex].cards,
                          ...addingCards
                        ],
                      )));
        } else {
          newState = newState.copyWith(
              decks: List<GameDeck>.from(newState.decks)
                ..[deckIndex] = newState.decks[deckIndex].copyWith(
                  cards: [...newState.decks[deckIndex].cards, ...addingCards],
                ));
        }
        _changeState(newState);
      },
      removeCards: (cards) {
        _removeCards(cards);
        _changeState(state);
      },
      putCards: (deckIndex, seatIndex, location, count, movedDeckIndex,
          movedSeatIndex) {
        var cards = [];
        var newState = state;
        if (seatIndex != null) {
          final removeState = state.seats[seatIndex].decks[deckIndex]
              .removeCards(count, location);
          newState = state.copyWith(
              seats: List<GameSeat>.from(state.seats)
                ..[seatIndex] = state.seats[seatIndex].copyWith(
                    decks: List<GameDeck>.from(state.seats[seatIndex].decks)
                      ..[deckIndex] = removeState.deck));
          cards.addAll(removeState.removedCards);
        } else {
          final removeState =
              state.decks[deckIndex].removeCards(count, location);
          newState = state.copyWith(
              decks: List<GameDeck>.from(state.decks)
                ..[deckIndex] = removeState.deck);
          cards.addAll(removeState.removedCards);
        }
        if (movedSeatIndex != null) {
          newState = newState.copyWith(
              seats: List<GameSeat>.from(newState.seats)
                ..[movedSeatIndex] = newState.seats[movedSeatIndex].copyWith(
                    decks: List<GameDeck>.from(
                        newState.seats[movedSeatIndex].decks)
                      ..[movedDeckIndex] = newState
                          .seats[movedSeatIndex].decks[movedDeckIndex]
                          .copyWith(
                        cards: [
                          ...newState.seats[movedSeatIndex]
                              .decks[movedDeckIndex].cards,
                          ...cards
                        ],
                      )));
        } else {
          newState = newState.copyWith(
              decks: List<GameDeck>.from(newState.decks)
                ..[movedDeckIndex] = newState.decks[movedDeckIndex].copyWith(
                  cards: [...newState.decks[movedDeckIndex].cards, ...cards],
                ));
        }
        _changeState(newState);
      },
      changeVisibility: (deckIndex, seatIndex, visibility, ownVisibility) {
        if (seatIndex != null) {
          _changeState(state.copyWith(
              seats: List<GameSeat>.from(state.seats)
                ..[seatIndex] = state.seats[seatIndex].copyWith(
                    decks: List<GameDeck>.from(state.seats[seatIndex].decks)
                      ..[deckIndex] = state.seats[seatIndex].decks[deckIndex]
                          .copyWith(
                              visibility: visibility,
                              ownVisibility: ownVisibility))));
        } else {
          _changeState(state.copyWith(
              decks: List<GameDeck>.from(state.decks)
                ..[deckIndex] = state.decks[deckIndex].copyWith(
                    visibility: visibility, ownVisibility: ownVisibility)));
        }
      },
      shuffle: (deckIndex, seatIndex) {
        if (seatIndex != null) {
          _changeState(state.copyWith(
              seats: List<GameSeat>.from(state.seats)
                ..[seatIndex] = state.seats[seatIndex].copyWith(
                    decks: List<GameDeck>.from(state.seats[seatIndex].decks)
                      ..[deckIndex] =
                          state.seats[seatIndex].decks[deckIndex].shuffle())));
        } else {
          _changeState(state.copyWith(
              decks: List<GameDeck>.from(state.decks)
                ..[deckIndex] = state.decks[deckIndex].shuffle()));
        }
      },
    );
  }
}

class ClientServerGameConnection extends ClientGameConnection {
  final ServerGameConnection server;

  ClientServerGameConnection(this.server, super.channel);

  static Future<ClientServerGameConnection> create() async {
    final server = await ServerGameConnection.create();
    return ClientServerGameConnection(
        server,
        WebSocketChannel.connect(Uri(
          scheme: 'ws',
          host: 'localhost',
          port: server.server.port,
        )));
  }

  @override
  Future<void> close() async {
    await super.close();
    await server.close();
  }
}
