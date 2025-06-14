import 'dart:typed_data';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:networker/networker.dart';

import '../models/config.dart';

part 'user.mapper.dart';

@MappableClass()
final class SetonixUser with SetonixUserMappable {
  final Uint8List? publicKey;
  final String name;

  const SetonixUser({
    this.publicKey,
    required this.name,
  });
}

final class UserManager {
  final Map<Channel, SetonixUser> _users = {};
  final String guestPrefix;
  int _nextGuestId = 1;

  UserManager([this.guestPrefix = SetonixConfig.defaultGuestPrefix]);

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

  bool addUser(Channel channel, [Uint8List? publicKey, String? name]) {
    name ??= _generateGuestName();
    if (containsUserName(name)) {
      return false;
    }
    _users[channel] = SetonixUser(publicKey: publicKey, name: name);
    return true;
  }
}
