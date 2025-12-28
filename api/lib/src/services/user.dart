import 'dart:async';

import 'package:collection/collection.dart';
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
    bool createIfNotExists = false,
  });
}

const kUserReferenceID = '#';
const kUserReferenceName = '@';
const kUserReferenceFingerprint = '*';

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

  Future<SetonixUser?> addUser(
    Channel channel, [
    String? fingerprint,
    String? name,
  ]) async {
    SetonixUser? user;
    if (fingerprint != null) {
      user = await service?.getUser(fingerprint);
      if (user == null) {
        if (whitelistEnabled) {
          throw KickMessage(reason: KickReason.notWhitelisted);
        }
      } else {
        name = user.name;
        if (whitelistEnabled && !user.onWhitelist) {
          throw KickMessage(reason: KickReason.notWhitelisted);
        }
      }
    }
    name ??= _generateGuestName();
    if (containsUserName(name)) {
      return null;
    }
    if (user == null) {
      user = SetonixUser(fingerprint: fingerprint, name: name);
      if (fingerprint != null) {
        await service?.updateUser(
          fingerprint,
          name: name,
          onWhitelist: false,
          createIfNotExists: true,
        );
      }
    }
    _users[channel] = user;
    return user;
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

  Future<SetonixUser?> getUserByReference(String reference) async {
    if (reference.isEmpty) return null;
    switch (reference[0]) {
      case kUserReferenceID:
        final id = reference.substring(1);
        if (id.isEmpty) return null;
        final idInt = int.tryParse(id);
        if (idInt == null) return null;
        return getUser(idInt);
      case kUserReferenceName:
        final name = reference.substring(1);
        return getUserByName(name);
      case kUserReferenceFingerprint:
        final fingerprint = reference.substring(1);
        return service?.getUser(fingerprint);
      default:
        final id = int.tryParse(reference);
        if (id != null) {
          return getUser(id);
        }
        final user = getUserByName(reference);
        if (user != null) {
          return user;
        }
        return service?.getUserFromName(reference);
    }
  }

  Future<Channel?> getUserIdByReference(String reference) async {
    final user = await getUserByReference(reference);
    if (user == null) return null;
    return _users.entries.firstWhereOrNull((e) => e.value == user)?.key;
  }

  Iterable<MapEntry<Channel, SetonixUser>> getUsers() => _users.entries;
}
