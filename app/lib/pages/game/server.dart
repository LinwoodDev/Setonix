import 'dart:convert';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:town/models/server.dart';

import 'client.dart';
import 'logic.dart';

part 'server.freezed.dart';
part 'server.g.dart';

@freezed
class ServerConnectionMessage with _$ServerConnectionMessage {
  const factory ServerConnectionMessage.fetchPlayers() =
      FetchPlayersServerConnectionMessage;

  factory ServerConnectionMessage.fromJson(Map<String, dynamic> json) =>
      _$ServerConnectionMessageFromJson(json);
}

class WebSocketClient {
  final WebSocket socket;
  final HttpConnectionInfo info;

  WebSocketClient(this.socket, this.info);
}

class ServerGameConnection extends GameConnection {
  final HttpServer server;
  final List<WebSocketClient> clients = [];

  ServerGameConnection(this.server);

  static Future<ServerGameConnection> create() async {
    return ServerGameConnection(
      await HttpServer.bind(
        InternetAddress.anyIPv4,
        kDefaultPort,
      ),
    );
  }

  @override
  Future<void> close() async {
    await server.close();
  }

  Future<void> setup() async {
    await for (HttpRequest request in server) {
      if (request.uri.path == '/ws') {
        final info = request.connectionInfo;
        if (info == null) {
          request.response.statusCode = HttpStatus.forbidden;
          request.response.close();
          continue;
        }
        var socket = await WebSocketTransformer.upgrade(request);
        final client = WebSocketClient(socket, info);
        clients.add(client);

        // Listen for incoming messages from the client
        socket.listen((event) => _onMessage(client, event), onDone: () {
          clients.remove(client);
        });
      } else {
        request.response.statusCode = HttpStatus.forbidden;
        request.response.close();
      }
    }
  }

  @override
  List<GamePlayer> getPlayers() => clients
      .map((e) => GamePlayer(
          name: e.info.remoteAddress.address, id: e.info.remoteAddress.address))
      .toList();

  Future<void> _onMessage(WebSocketClient client, event) async {
    final message = ServerConnectionMessage.fromJson(jsonDecode(event));
    void sendBack(ClientConnectionMessage message) {
      client.socket.add(jsonEncode(message));
    }

    message.when(
      fetchPlayers: () => sendBack(
        ClientConnectionMessage.fetchedPlayers(getPlayers()),
      ),
    );
  }
}
