import 'dart:io';

import 'package:networker/networker.dart';
import 'package:networker_socket/server.dart';

InternetAddress? _parseAddress(String value) {
  // Forwarded addresses must be bare IP literals, without ports or scope IDs.
  if (value.contains('%') || value.contains('[') || value.contains(']')) {
    return null;
  }
  final address = InternetAddress.tryParse(value.trim());
  if (address == null) return null;
  final bytes = address.rawAddress;
  if (bytes.length == 16 &&
      bytes.take(10).every((byte) => byte == 0) &&
      bytes[10] == 255 &&
      bytes[11] == 255) {
    return InternetAddress.fromRawAddress(bytes.sublist(12));
  }
  // Canonical spelling prevents IPv6 aliases from splitting rate-limit buckets.
  return InternetAddress.fromRawAddress(bytes);
}

final class _ProxyNetwork {
  final List<int> bytes;
  final int prefix;

  _ProxyNetwork(this.bytes, this.prefix);

  factory _ProxyNetwork.parse(String value) {
    final parts = value.trim().split('/');
    final address = _parseAddress(parts.first);
    final original = InternetAddress.tryParse(parts.first);
    var prefix = parts.length == 1
        ? address?.rawAddress.length == 4
              ? 32
              : 128
        : int.tryParse(parts[1]);
    if (parts.length == 2 &&
        original?.type == InternetAddressType.IPv6 &&
        address?.type == InternetAddressType.IPv4 &&
        prefix != null) {
      prefix -= 96;
    }
    if (parts.length > 2 ||
        address == null ||
        prefix == null ||
        prefix < 0 ||
        prefix > address.rawAddress.length * 8) {
      throw FormatException(
        'Invalid trusted proxy "$value": expected an IP address or CIDR network.',
      );
    }
    return _ProxyNetwork(address.rawAddress, prefix);
  }

  bool contains(InternetAddress address) {
    final candidate = address.rawAddress;
    if (candidate.length != bytes.length) return false;
    for (var bit = 0; bit < prefix; bit += 8) {
      final remaining = prefix - bit;
      final mask = remaining >= 8 ? 255 : (255 << (8 - remaining)) & 255;
      final index = bit ~/ 8;
      if (bytes[index] & mask != candidate[index] & mask) return false;
    }
    return true;
  }
}

/// Resolves client IPs only across an explicitly trusted proxy chain.
final class TrustedProxies {
  final List<_ProxyNetwork> _networks;

  TrustedProxies(Iterable<String> networks)
    : _networks = networks.map(_ProxyNetwork.parse).toList();

  bool _contains(InternetAddress address) =>
      _networks.any((network) => network.contains(address));

  InternetAddress resolveClientAddress(
    InternetAddress peer, {
    Iterable<String> forwardedFor = const [],
  }) {
    final normalizedPeer = _parseAddress(peer.address) ?? peer;
    if (!_contains(normalizedPeer)) return normalizedPeer;
    final values = forwardedFor.expand((value) => value.split(',')).toList();
    if (values.isEmpty) return normalizedPeer;
    final chain = values.map(_parseAddress).toList();
    if (chain.any((address) => address == null)) return normalizedPeer;

    // Walk toward the client, stopping at the first address outside our trust.
    // Entries further left may have been supplied by that untrusted client.
    var client = normalizedPeer;
    for (final address in chain.reversed) {
      if (!_contains(client)) break;
      client = address!;
    }
    return client;
  }
}

/// Keeps the resolved client address in the normal connection metadata, so
/// logs, commands, plugins and authentication limits all use the same identity.
final class TrustedProxySocketServer extends NetworkerSocketServer {
  final TrustedProxies trustedProxies;

  TrustedProxySocketServer(
    super.serverAddress,
    super.port, {
    required this.trustedProxies,
    super.securityContext,
    super.filterConnections,
    super.overrideStatusCode,
  });

  @override
  Future<void> handleWebSocketUpgrade(HttpRequest request) async {
    final peer = request.connectionInfo;
    if (peer == null) return super.handleWebSocketUpgrade(request);
    final client = trustedProxies.resolveClientAddress(
      peer.remoteAddress,
      forwardedFor: request.headers['x-forwarded-for'] ?? const [],
    );
    final peerAddress =
        _parseAddress(peer.remoteAddress.address) ?? peer.remoteAddress;
    request.response.statusCode = HttpStatus.switchingProtocols;
    final socket = await WebSocketTransformer.upgrade(request);
    final info = NetworkerSocketInfo(
      Uri(
        host: client.address,
        port: client.address == peerAddress.address ? peer.remotePort : null,
      ),
      socket,
    );
    final channel = addClientConnection(info);
    if (channel == kAnyChannel) {
      await socket.close();
      return;
    }
    handleWebSocketConnection(channel, info, socket);
  }
}
