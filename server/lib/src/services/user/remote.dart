import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:setonix_server/setonix_server.dart';

final class RemoteUserService extends UserService {
  final String apiEndpoint;
  final String? endpointSecret;

  RemoteUserService({
    required this.apiEndpoint,
    this.endpointSecret,
  });

  Map<String, String> get headers =>
      endpointSecret != null ? {'Authorization': 'Bearer $endpointSecret'} : {};

  @override
  Future<SetonixUser?> getUser(String fingerprint) async {
    final response = await http.get(
      Uri.parse('$apiEndpoint/user/${Uri.encodeComponent(fingerprint)}'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return SetonixUserMapper.fromJson(response.body);
    }
    return null;
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
  FutureOr<bool> updateUser(String fingerprint,
      {String? name, bool? onWhitelist, DateTime? lastLogin}) {
    final body = jsonEncode({
      'name': name,
      'onWhitelist': onWhitelist,
      'lastLogin': lastLogin?.millisecondsSinceEpoch,
    });
    final response = http.patch(
      Uri.parse('$apiEndpoint/user/${Uri.encodeComponent(fingerprint)}'),
      headers: {
        ...headers,
        'Content-Type': 'application/json',
      },
      body: body,
    );
    return response.then((res) {
      if (res.statusCode == 200) {
        return true;
      } else if (res.statusCode == 404) {
        return false; // User not found
      }
      throw Exception('Failed to update user: ${res.body}');
    });
  }
}
