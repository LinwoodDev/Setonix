import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:setonix_server/setonix_server.dart';

final class RemoteUserService extends UserService {
  static const requestTimeout = Duration(seconds: 10);

  final String apiEndpoint;
  final String? endpointSecret;

  RemoteUserService({required this.apiEndpoint, this.endpointSecret});

  Map<String, String> get headers =>
      endpointSecret != null && endpointSecret!.isNotEmpty
      ? {'Authorization': 'Bearer $endpointSecret'}
      : {};

  @override
  Future<SetonixUser?> getUser(String fingerprint) async {
    final response = await http
        .get(
          Uri.parse('$apiEndpoint/user/${Uri.encodeComponent(fingerprint)}'),
          headers: headers,
        )
        .timeout(requestTimeout);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null; // No user found
      return SetonixUserMapper.fromJson(response.body);
    }
    throw KickMessage.fromString(response.body);
  }

  @override
  Future<SetonixUser?> getUserFromName(String name) async {
    final response = await http
        .get(
          Uri.parse('$apiEndpoint/user?name=${Uri.encodeComponent(name)}'),
          headers: headers,
        )
        .timeout(requestTimeout);
    if (response.statusCode == 200) {
      return SetonixUserMapper.fromJson(response.body);
    }
    return null;
  }

  @override
  Future<bool> updateUser(
    String fingerprint, {
    String? name,
    bool? onWhitelist,
    String? role,
    bool? banned,
    DateTime? bannedUntil,
    String? banReason,
    DateTime? lastLogin,
    bool createIfNotExists = false,
  }) async {
    final body = jsonEncode({
      'name': name,
      'onWhitelist': onWhitelist,
      'role': role,
      'banned': banned,
      'bannedUntil': bannedUntil?.millisecondsSinceEpoch,
      'banReason': banReason,
      'lastLogin': lastLogin?.millisecondsSinceEpoch,
    });
    final response = await http
        .patch(
          Uri.parse('$apiEndpoint/user/${Uri.encodeComponent(fingerprint)}'),
          headers: {...headers, 'Content-Type': 'application/json'},
          body: body,
        )
        .timeout(requestTimeout);

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      if (createIfNotExists) {
        final createBody = jsonEncode({
          'fingerprint': fingerprint,
          'name': name,
          'onWhitelist': onWhitelist,
          'role': role,
          'banned': banned,
          'bannedUntil': bannedUntil?.millisecondsSinceEpoch,
          'banReason': banReason,
          'lastLogin': lastLogin?.millisecondsSinceEpoch,
        });
        final createResponse = await http
            .post(
              Uri.parse('$apiEndpoint/user'),
              headers: {...headers, 'Content-Type': 'application/json'},
              body: createBody,
            )
            .timeout(requestTimeout);
        return createResponse.statusCode >= 200 &&
            createResponse.statusCode < 300;
      }
      return false; // User not found
    }
    throw Exception('Failed to update user: ${response.body}');
  }
}
