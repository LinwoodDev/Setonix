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
  final Set<String> roles;
  final bool banned;
  final DateTime? bannedUntil;
  final String? banReason;
  final DateTime? createdAt, updatedAt, lastLogin;

  const SetonixUser({
    this.fingerprint,
    required this.name,
    this.onWhitelist = false,
    this.roles = const {kDefaultServerRole},
    this.banned = false,
    this.bannedUntil,
    this.banReason,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
  });

  bool get isBanned =>
      banned && (bannedUntil == null || bannedUntil!.isAfter(DateTime.now()));
}

abstract class UserService {
  FutureOr<SetonixUser?> getUser(String fingerprint);
  FutureOr<SetonixUser?> getUserFromName(String name);
  FutureOr<List<SetonixUser>> getBannedUsers() => const [];
  FutureOr<bool> updateUser(
    String fingerprint, {
    String? name,
    bool? onWhitelist,
    Set<String>? roles,
    bool? banned,
    DateTime? bannedUntil,
    String? banReason,
    DateTime? lastLogin,
    bool createIfNotExists = false,
  });

  FutureOr<bool> replaceRole(String role, String replacement) => false;

  FutureOr<void> close() {}
}

const kUserReferenceID = '#';
const kUserReferenceName = '@';
const kUserReferenceFingerprint = '*';

final class UserManager {
  final Map<Channel, SetonixUser> _users = {};
  final StreamController<void> _changeController = StreamController.broadcast();
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

  Stream<void> get changes => _changeController.stream;

  void _notifyChanged() => _changeController.add(null);

  void removeUser(Channel channel) {
    if (_users.remove(channel) != null) _notifyChanged();
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
        if (!user.roles.contains(kDefaultServerRole)) {
          user = user.copyWith(roles: {kDefaultServerRole, ...user.roles});
        }
        name = user.name;
        if (user.isBanned) {
          throw KickMessage(reason: KickReason.ban, message: user.banReason);
        }
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
    _notifyChanged();
    return user;
  }

  Future<bool> changeName(Channel channel, String newName) async {
    final user = _users[channel];
    if (user == null) {
      return false;
    }
    if (user.name == newName) return true;
    if (containsUserName(newName)) return false;
    final fingerprint = user.fingerprint;
    final result = fingerprint == null
        ? null
        : await service?.updateUser(fingerprint, name: newName);
    if (result == false) return false;
    final updatedUser = user.copyWith(name: newName);
    _users[channel] = updatedUser;
    _notifyChanged();
    return true;
  }

  Future<bool> changeRoles(String reference, Set<String> roles) async {
    roles = {...roles, kDefaultServerRole};
    final user = await getUserByReference(reference);
    if (user == null) return false;
    final fingerprint = user.fingerprint;
    if (fingerprint != null) {
      final result = await service?.updateUser(fingerprint, roles: roles);
      if (result == false) return false;
    }
    final entry = _users.entries.firstWhereOrNull(
      (entry) =>
          entry.value == user ||
          (fingerprint != null && entry.value.fingerprint == fingerprint),
    );
    if (entry == null) return fingerprint != null;
    _users[entry.key] = entry.value.copyWith(roles: roles);
    _notifyChanged();
    return true;
  }

  Future<bool> addRole(String reference, String role) async {
    final user = await getUserByReference(reference);
    if (user == null) return false;
    return changeRoles(reference, {...user.roles, role});
  }

  Future<bool> removeRole(String reference, String role) async {
    if (role == kDefaultServerRole) return false;
    final user = await getUserByReference(reference);
    if (user == null || !user.roles.contains(role)) return false;
    return changeRoles(reference, {...user.roles}..remove(role));
  }

  Future<int> replaceRole(String role, String replacement) async {
    final replacedPersistently = await service?.replaceRole(role, replacement);
    final entries = _users.entries
        .where((entry) => entry.value.roles.contains(role))
        .toList(growable: false);
    for (final entry in entries) {
      final fingerprint = entry.value.fingerprint;
      if (replacedPersistently != true && fingerprint != null) {
        final updatedRoles = {...entry.value.roles, replacement}..remove(role);
        await service?.updateUser(fingerprint, roles: updatedRoles);
      }
      _users[entry.key] = entry.value.copyWith(
        roles: {...entry.value.roles, replacement}..remove(role),
      );
    }
    return entries.length;
  }

  Future<bool> changeBan(
    String reference, {
    required bool banned,
    DateTime? until,
    String? reason,
  }) async {
    final user = await getUserByReference(reference);
    final fingerprint = user?.fingerprint;
    if (user == null || fingerprint == null) return false;
    final result = await service?.updateUser(
      fingerprint,
      banned: banned,
      bannedUntil: banned ? until : null,
      banReason: banned ? reason : null,
    );
    if (result == false) return false;
    final entry = _users.entries
        .where((entry) => entry.value.fingerprint == fingerprint)
        .firstOrNull;
    if (entry != null) {
      _users[entry.key] = entry.value.copyWith(
        banned: banned,
        bannedUntil: banned ? until : null,
        banReason: banned ? reason : null,
      );
    }
    return true;
  }

  Future<List<SetonixUser>> getBannedUsers() async {
    final users = (await service?.getBannedUsers() ?? const [])
        .where((user) => user.fingerprint != null && user.isBanned)
        .toList();
    users.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return users;
  }

  Future<bool> unban(String fingerprint) async {
    final user = await service?.getUser(fingerprint);
    if (user == null || !user.isBanned) return false;
    return await service?.updateUser(
          fingerprint,
          banned: false,
          bannedUntil: null,
          banReason: null,
        ) ??
        false;
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
