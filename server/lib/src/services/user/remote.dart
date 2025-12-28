import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:setonix_server/setonix_server.dart';

final class RemoteUserService extends UserService {
  final String apiEndpoint;
  final String? endpointSecret;

  RemoteUserService({required this.apiEndpoint, this.endpointSecret});

  Map<String, String> get headers =>
      endpointSecret != null ? {'Authorization': 'Bearer $endpointSecret'} : {};

  @override
  Future<SetonixUser?> getUser(String fingerprint) async {
    final response = await http.get(
      Uri.parse('$apiEndpoint/user/${Uri.encodeComponent(fingerprint)}'),
      headers: headers,
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null; // No user found
      return SetonixUserMapper.fromJson(response.body);
    }
    throw KickMessage.fromString(response.body);
  }

  @override
  Future<SetonixUser?> getUserFromName(String name) async {
    final response = await http.get(
      Uri.parse('$apiEndpoint/user?name=${Uri.encodeComponent(name)}'),
      headers: headers,
    );
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
    DateTime? lastLogin,
    bool createIfNotExists = false,
  }) async {
    final body = jsonEncode({
      'name': name,
      'onWhitelist': onWhitelist,
      'lastLogin': lastLogin?.millisecondsSinceEpoch,
    });
    final response = await http.patch(
      Uri.parse('$apiEndpoint/user/${Uri.encodeComponent(fingerprint)}'),
      headers: {...headers, 'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      if (createIfNotExists) {
        final createBody = jsonEncode({
          'fingerprint': fingerprint,
          'name': name,
          'onWhitelist': onWhitelist,
          'lastLogin': lastLogin?.millisecondsSinceEpoch,
        });
        final createResponse = await http.post(
          Uri.parse('$apiEndpoint/user'),
          headers: {...headers, 'Content-Type': 'application/json'},
          body: createBody,
        );
        return createResponse.statusCode >= 200 &&
            createResponse.statusCode < 300;
      }
      return false; // User not found
    }
    throw Exception('Failed to update user: ${response.body}');
  }
}
