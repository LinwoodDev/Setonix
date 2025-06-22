import 'dart:async';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:networker/networker.dart';
import 'package:setonix_api/event.dart';

part 'user.mapper.dart';

@MappableClass(includeCustomMappers: [Base64Uint8ListHook()])
final class SetonixUser with SetonixUserMappable {
  final String? fingerprint;
  final String name;
  final bool onWhitelist;
  final DateTime? createdAt, updatedAt, lastLogin;

  const SetonixUser({
    this.fingerprint,
    required this.name,
    this.onWhitelist = false,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
  });
}

abstract class UserService {
  FutureOr<SetonixUser?> getUser(String fingerprint);
  FutureOr<SetonixUser?> getUserFromName(String name);
  FutureOr<bool> updateUser(
    String fingerprint, {
    String? name,
    bool? onWhitelist,
    DateTime? lastLogin,
  });
}

final class UserManager {
  final Map<Channel, SetonixUser> _users = {};
  final String guestPrefix;
  final UserService? service;
  final bool whitelistEnabled;
  int _nextGuestId = 1;

  UserManager({
    this.service,
    this.whitelistEnabled = SetonixConfig.defaultWhitelistEnabled,
    this.guestPrefix = SetonixConfig.defaultGuestPrefix,
  });

  bool containsUserName(String name) =>
      _users.values.any((u) => u.name == name);

  void removeUser(Channel channel) {
    _users.remove(channel);
  }

  /// Retrieves the user associated with the channel.
  SetonixUser? getUser(Channel channel) => _users[channel];

  /// Retrieves a user by name.
  SetonixUser? getUserByName(String name) {
    for (var user in _users.values) {
      if (user.name == name) {
        return user;
      }
    }
    return null;
  }

  String _generateGuestName() {
    String name;
    do {
      name = '$guestPrefix$_nextGuestId';
      _nextGuestId++;
    } while (containsUserName(name));
    return name;
  }

  Future<bool> addUser(
    Channel channel, [
    String? fingerprint,
    String? name,
  ]) async {
    SetonixUser? user;
    if (fingerprint != null) {
      user = await service?.getUser(fingerprint);
      if (user != null) name = user.name;
      if (whitelistEnabled && user?.onWhitelist != true) {
        return false; // User is not on the whitelist
      }
    }
    name ??= _generateGuestName();
    if (containsUserName(name)) {
      return false;
    }
    if (user == null) {
      user = SetonixUser(fingerprint: fingerprint, name: name);
      if (fingerprint != null) {
        await service?.updateUser(fingerprint, name: name, onWhitelist: false);
      }
    }
    _users[channel] = user;
    return true;
  }

  Future<bool> changeName(Channel channel, String newName) async {
    if (containsUserName(newName)) {
      return false;
    }
    final user = _users[channel];
    if (user == null) {
      return false;
    }
    final fingerprint = user.fingerprint;
    final result = fingerprint == null
        ? null
        : await service?.updateUser(fingerprint, name: newName);
    if (result == false) return false;
    final updatedUser = user.copyWith(name: newName);
    _users[channel] = updatedUser;
    return true;
  }
}
