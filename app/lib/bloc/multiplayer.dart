import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/client.dart';
import 'package:networker_socket/server.dart';
import 'package:setonix/services/network.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:swamp_api/swamp_api.dart';

part 'multiplayer.mapper.dart';

enum ConnectionTechnology {
  webSocket,
  swamp;

  static ConnectionTechnology fromScheme(String scheme) {
    if (NetworkerSocketClient.supportedSchemes.contains(scheme)) {
      return webSocket;
    }
    return swamp;
  }
}

Future<String> _swampAuthenticationOrigin(SwampConnection connection) async {
  final e2ee = connection.e2eePipe;
  if (e2ee == null) {
    throw const FormatException(
      'Authenticated Swamp connections require end-to-end encryption.',
    );
  }
  final key = await e2ee.secretKey.extractBytes();
  return generateFingerprint(Uint8List.fromList(key));
}

@MappableClass()
sealed class MultiplayerState with MultiplayerStateMappable {
  const MultiplayerState();

  bool get isConnected => this is MultiplayerConnectedState;
  bool get isClient => false;
  bool get isServer => false;

  UserManager? get userManager => null;
}

@MappableClass()
final class MultiplayerDisabledState extends MultiplayerState
    with MultiplayerDisabledStateMappable {}

@MappableClass()
final class MultiplayerConnectingState extends MultiplayerState
    with MultiplayerConnectingStateMappable {}

@MappableClass()
final class MultiplayerDisconnectedState extends MultiplayerState
    with MultiplayerDisconnectedStateMappable {
  final MultiplayerConnectedState? oldState;
  final Object? error;

  MultiplayerDisconnectedState({this.error, this.oldState});

  bool get canReconnect => oldState != null;
}

@MappableClass()
final class MultiplayerConnectedState extends MultiplayerState
    with MultiplayerConnectedStateMappable {
  final NetworkerBase networker;
  final SimpleNetworkerPipe<WorldEvent> pipe;
  @override
  final UserManager userManager = UserManager();
  final ChallengeManager? challengeManager;
  final String? serverIdentity;

  MultiplayerConnectedState(
    this.networker,
    this.pipe, {
    bool authenticatePeers = false,
    this.serverIdentity,
  }) : challengeManager = authenticatePeers
           ? ChallengeManager(
               serverId:
                   serverIdentity ??
                   (throw ArgumentError(
                     'Authenticated hosting requires a secure origin.',
                   )),
             )
           : null;

  bool get hasSecureAuthenticationTransport => serverIdentity != null;

  @override
  bool get isClient => networker is NetworkerClient;
  @override
  bool get isServer => networker is NetworkerServer;

  Stream<Set<int>>? get clientChange => networker is NetworkerServer
      ? (networker as NetworkerServer).clientChange
      : null;

  Future<Uri> getShareAddress() async {
    if (networker is SwampConnection) {
      return (networker as SwampConnection).getSecureAddress();
    }
    if (networker is NetworkerSocketServer) {
      final ip = await NetworkInfo().getWifiIP();
      return Uri(
        scheme: 'ws',
        host: ip ?? InternetAddress.loopbackIPv4.address,
        port: (networker as NetworkerSocketServer).port,
      );
    }
    return networker.address;
  }
}

class MultiplayerCubit extends Cubit<MultiplayerState> {
  final NetworkService networkService;
  final StreamController<PlayableWorldEvent> _eventController =
      StreamController.broadcast();

  Stream<PlayableWorldEvent> get events => _eventController.stream;

  final StreamController<NetworkerPacket<ClientWorldEvent>>
  _serverEventController = StreamController.broadcast();

  Stream<NetworkerPacket<ClientWorldEvent>> get serverEvents =>
      _serverEventController.stream;

  final StreamController<(Channel, ConnectionInfo)> _initController =
      StreamController.broadcast();

  Stream<(Channel, ConnectionInfo)> get inits => _initController.stream;

  FatalServerEventError? _fatalError;
  final Map<Channel, Timer> _authenticationTimers = {};
  final AuthenticationRateLimiter _authenticationRateLimiter =
      AuthenticationRateLimiter();

  MultiplayerCubit(this.networkService) : super(MultiplayerDisabledState());

  bool get isConnected => state.isConnected;
  bool get isClient => state.isClient;
  bool get isServer => state.isServer;

  Set<Channel> get clients {
    final state = this.state;
    if (state is! MultiplayerConnectedState) return {};
    final networker = state.networker;
    if (networker is! NetworkerServer) return {};
    return networker.clientConnections;
  }

  Future<MultiplayerConnectedState> _addNetworker(
    NetworkerBase base, {
    bool authenticatePeers = false,
    String? serverIdentity,
  }) async {
    final transformer = NetworkerPipeTransformer<String, WorldEvent>(
      WorldEventMapper.fromJson,
      (e) => (e is ServerWorldEvent ? protectServerEvent(e) : e).toJson(),
    );
    final pipe = SimpleNetworkerPipe<WorldEvent>();
    final connectedState = MultiplayerConnectedState(
      base,
      pipe,
      authenticatePeers: authenticatePeers,
      serverIdentity: serverIdentity,
    );
    final stringPlugin = StringNetworkerPlugin();
    transformer.read.listen(_onServerEvent);
    base.connect(
      FilteredNetworkerPipe<Uint8List>(
        filterDecoded: (data, _) => data.length <= kMaxNetworkEventBytes,
      )..connect(stringPlugin..connect(transformer)),
    );
    if (base is NetworkerClient) {
      transformer.connect(pipe);
    } else if (base is NetworkerServer) {
      base.clientConnect.listen((event) => _onJoin(event, connectedState));
      base.clientDisconnect.listen((event) => _onLeft(event, connectedState));
      transformer.connect(
        SimpleNetworkerPipe()
          ..read.listen(_onClientEvent)
          ..write.listen((e) => _onClientEvent(e, true))
          ..connect(pipe),
      );
    }
    return connectedState;
  }

  void _onClientEvent(NetworkerPacket<WorldEvent> event, [bool local = false]) {
    final data = event.data;
    if (data is ServerWorldEvent && local) {
      if (event.channel == kAuthorityChannel || event.channel == kAnyChannel) {
        _eventController.add(data);
      }
    } else if (data is ClientWorldEvent) {
      _serverEventController.add(
        NetworkerPacket(data, local ? kAuthorityChannel : event.channel),
      );
    }
  }

  void _onServerEvent(NetworkerPacket<WorldEvent> event) {
    final data = event.data;
    if (data is ServerWorldEvent) {
      _eventController.add(data);
    }
  }

  @override
  Future<void> close() async {
    await disconnect(false);
    return super.close();
  }

  Future<void> disconnect([bool emit = true]) async {
    final state = this.state;
    if (state is! MultiplayerConnectedState) return;
    for (final timer in _authenticationTimers.values) {
      timer.cancel();
    }
    _authenticationTimers.clear();
    _authenticationRateLimiter.clear();
    await state.networker.close();
    networkService.cancelServerInfo();
    if (emit && state.isServer) {
      this.emit(MultiplayerDisabledState());
    }
  }

  Cipher _buildCipher() => AesGcm.with256bits();

  Future<SwampConnection> _createSwamp(Uri uri) {
    if (uri.scheme.isEmpty) {
      uri = uri.replace(scheme: 'wss');
    }
    final cipher = _buildCipher();
    return SwampConnection.buildSecure(uri, cipher);
  }

  Future<void> connect(Uri uri, [ConnectionTechnology? technology]) =>
      switch (technology ?? ConnectionTechnology.fromScheme(uri.scheme)) {
        ConnectionTechnology.webSocket => connectSocket(uri),
        ConnectionTechnology.swamp => connectSwamp(uri),
      };

  Future<void> connectSwamp(Uri address) async {
    try {
      emit(MultiplayerConnectingState());
      final connection = await _createSwamp(address);
      final serverIdentity = await _swampAuthenticationOrigin(connection);
      final state = await _addNetworker(
        connection,
        serverIdentity: serverIdentity,
      );
      connection.onClosed.listen((_) {
        if (isClosed) return;
        emit(MultiplayerDisconnectedState(oldState: state, error: _fatalError));
        _fatalError = null;
      }, onError: (e) => emit(MultiplayerDisconnectedState(error: e)));
      await connection.init();
      emit(state);
    } catch (e) {
      emit(MultiplayerDisconnectedState(error: e));
    }
  }

  Future<void> connectSocket(Uri address) async {
    try {
      emit(MultiplayerConnectingState());
      final property = await networkService.fetchRequiredInfo(address);
      final protocolVersion = property.requireProtocol();
      final versionedAddress = addSetonixProtocolVersion(
        address,
        version: protocolVersion,
      );
      final client = NetworkerSocketClient(versionedAddress);
      final serverIdentity = trustedAuthenticationOrigin(versionedAddress);
      final state = await _addNetworker(client, serverIdentity: serverIdentity);
      client.onClosed.listen((_) {
        if (isClosed) return;
        final closeReason = client.closeReason;
        emit(
          MultiplayerDisconnectedState(
            oldState: state,
            error:
                _fatalError ??
                (closeReason == null
                    ? null
                    : KickMessage.fromString(closeReason)),
          ),
        );
        _fatalError = null;
      }, onError: (e) => emit(MultiplayerDisconnectedState(error: e)));
      await client.init();
      emit(state);
    } catch (e) {
      emit(MultiplayerDisconnectedState(error: e));
    }
  }

  Future<void> createSwamp(Uri uri) async {
    try {
      final server = await _createSwamp(uri);
      final serverIdentity = await _swampAuthenticationOrigin(server);
      final state = await _addNetworker(
        server,
        authenticatePeers: true,
        serverIdentity: serverIdentity,
      );
      await server.init();
      emit(state);
    } catch (e) {
      emit(MultiplayerDisconnectedState(error: e));
    }
  }

  Future<void> createSocket({GameProperty? property, int? port}) async {
    try {
      port ??= kDefaultPort;
      final prop = (property ?? GameProperty.defaultProperty).copyWith(
        protocolVersions: kSetonixServerProtocolVersions,
        protocolCapabilities: kSetonixProtocolCapabilities,
      );
      final server = NetworkerSocketServer(
        InternetAddress.loopbackIPv4,
        port,
        filterConnections: buildFilterConnections(
          loadProperty: (_) {
            final state = this.state;
            if (state is! MultiplayerConnectedState) return prop;
            final networker = state.networker;
            if (networker is! NetworkerServer) return prop;
            return prop.copyWith(
              currentPlayers: networker.clientConnections.length,
            );
          },
        ),
      );
      final state = await _addNetworker(server);
      await server.init();
      networkService.sendServerInfo(
        LanProperty(
          description: prop.description,
          hasThumbnail: prop.hasThumbnail,
          port: port,
          protocolVersions: prop.protocolVersions,
          protocolCapabilities: prop.protocolCapabilities,
        ),
      );
      emit(state);
    } catch (e) {
      emit(MultiplayerDisconnectedState(error: e));
    }
  }

  void send(WorldEvent event) {
    final state = this.state;
    if (state is! MultiplayerConnectedState) return;
    if (event is LocalWorldEvent) return;
    if (event is! ClientWorldEvent) return;
    state.pipe.sendMessage(event);
  }

  void sendServer(ServerWorldEvent event, [Channel channel = kAnyChannel]) =>
      sendServerPacket(NetworkerPacket(event, channel));

  void sendServerPacket(NetworkerPacket<ServerWorldEvent> packet) =>
      sendServerPackets([packet]);

  void sendServerPackets(List<NetworkerPacket<ServerWorldEvent>> packets) {
    final state = this.state;
    if (state is! MultiplayerConnectedState) return;
    for (final packet in packets) {
      state.pipe.sendMessage(packet.data, packet.channel);
    }
  }

  Future<void> reconnect() async {
    try {
      final state = this.state;
      if (state is! MultiplayerDisconnectedState) return;
      final oldState = state.oldState;
      if (oldState == null) return;
      emit(MultiplayerConnectingState());
      await oldState.networker.init();
      emit(oldState);
    } catch (e) {
      emit(MultiplayerDisconnectedState(error: e));
    }
  }

  Future<void> raiseError(FatalServerEventError e) async {
    _fatalError = e;
    disconnect();
  }

  void _onLeft(
    (Channel, ConnectionInfo) event,
    MultiplayerConnectedState connectedState,
  ) {
    _authenticationTimers.remove(event.$1)?.cancel();
    connectedState.challengeManager?.removeChallenge(event.$1);
    connectedState.userManager.removeUser(event.$1);
  }

  void _onJoin(
    (Channel, ConnectionInfo) event,
    MultiplayerConnectedState connectedState,
  ) {
    _initController.add(event);
    final challengeManager = connectedState.challengeManager;
    if (challengeManager == null) {
      connectedState.userManager.addUser(event.$1);
      return;
    }
    _authenticationTimers[event.$1] = Timer(challengeManager.ttl, () {
      if (connectedState.userManager.getUser(event.$1) != null) {
        return;
      }
      challengeManager.removeChallenge(event.$1);
      final networker = connectedState.networker;
      if (networker is NetworkerServer) {
        networker.closeConnection(event.$1);
      }
    });
  }

  void completeAuthentication(Channel channel) {
    _authenticationTimers.remove(channel)?.cancel();
  }

  bool allowAuthenticationAttempt(Channel channel) {
    final current = state;
    final networker = current is MultiplayerConnectedState
        ? current.networker
        : null;
    if (networker is! NetworkerServer) return false;
    final source = networker.getConnectionInfo(channel)?.address.host;
    return source != null && _authenticationRateLimiter.allow(source);
  }

  void kick(Channel channel) {
    final current = state;
    final networker = current is MultiplayerConnectedState
        ? current.networker
        : null;
    if (networker is NetworkerServer) networker.closeConnection(channel);
  }
}
