import 'dart:async';
import 'dart:convert';

import 'package:path/path.dart' as p;
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/services/user/migrations.dart';
import 'package:sqlite3/sqlite3.dart';

final class FileUserService extends UserService {
  Database? _database;

  Set<String> _decodeRoles(Object? value) {
    if (value is! String || value.isEmpty) return const {kDefaultServerRole};
    try {
      final decoded = jsonDecode(value);
      if (decoded is List) {
        final roles = decoded.whereType<String>().where((e) => e.isNotEmpty);
        if (roles.isNotEmpty) return {...roles, kDefaultServerRole};
      }
    } catch (_) {
      return {kDefaultServerRole, value};
    }
    return const {kDefaultServerRole};
  }

  Future<void> setup({String rootPath = '.'}) async {
    final database = sqlite3.open(p.join(rootPath, 'setonix.db'));
    // Basic migration system

    final result = database.select('PRAGMA user_version');
    final currentVersion = result.isNotEmpty
        ? result.first['user_version'] as int
        : 0;

    for (
      var version = currentVersion + 1;
      version <= migrations.length;
      version++
    ) {
      database.execute(migrations[version]!);
      database.execute('PRAGMA user_version = $version;');
    }
    _database = database;
  }

  SetonixUser _fromRow(Row row) {
    return SetonixUser(
      fingerprint: row['fingerprint'] as String?,
      name: row['name'] as String,
      onWhitelist: row['on_whitelist'] == 1,
      roles: _decodeRoles(row['roles']),
      banned: row['banned'] == 1,
      bannedUntil: row['banned_until'] != null
          ? DateTime.fromMillisecondsSinceEpoch(row['banned_until'] as int)
          : null,
      banReason: row['ban_reason'] as String?,
      createdAt: row['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(row['created_at'] as int)
          : null,
      updatedAt: row['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(row['updated_at'] as int)
          : null,
      lastLogin: row['last_login'] != null
          ? DateTime.fromMillisecondsSinceEpoch(row['last_login'] as int)
          : null,
    );
  }

  @override
  SetonixUser? getUser(String fingerprint) => _database
      ?.select('SELECT * FROM users WHERE fingerprint = ?', [fingerprint])
      .map(_fromRow)
      .firstOrNull;

  @override
  SetonixUser? getUserFromName(String name) => _database
      ?.select('SELECT * FROM users WHERE name = ?', [name])
      .map(_fromRow)
      .firstOrNull;

  @override
  List<SetonixUser> getBannedUsers() =>
      _database
          ?.select('SELECT * FROM users WHERE banned = 1 ORDER BY name')
          .map(_fromRow)
          .where((user) => user.isBanned)
          .toList(growable: false) ??
      const [];

  @override
  bool updateUser(
    String fingerprint, {
    String? name,
    bool? onWhitelist,
    Set<String>? roles,
    bool? banned,
    DateTime? bannedUntil,
    String? banReason,
    DateTime? lastLogin,
    bool createIfNotExists = false,
  }) {
    final updates = <String>[];
    final values = <dynamic>[];

    if (name != null) {
      updates.add('name = ?');
      values.add(name);
    }
    if (onWhitelist != null) {
      updates.add('on_whitelist = ?');
      values.add(onWhitelist ? 1 : 0);
    }
    if (roles != null) {
      updates.add('roles = ?');
      values.add(jsonEncode(roles.toList(growable: false)));
    }
    if (banned != null) {
      updates.addAll(['banned = ?', 'banned_until = ?', 'ban_reason = ?']);
      values.addAll([
        banned ? 1 : 0,
        bannedUntil?.millisecondsSinceEpoch,
        banReason,
      ]);
    }
    if (lastLogin != null) {
      updates.add('last_login = ?');
      values.add(lastLogin.millisecondsSinceEpoch);
    }

    if (updates.isEmpty && !createIfNotExists) return false;

    if (!createIfNotExists) {
      values.add(fingerprint);
      _database?.execute(
        'UPDATE users SET ${updates.join(', ')} WHERE fingerprint = ?',
        values,
      );
      return _database?.updatedRows == 1;
    }

    final insertCols = ['fingerprint'];
    final insertVals = <dynamic>[fingerprint];

    if (name != null) {
      insertCols.add('name');
      insertVals.add(name);
    }
    if (onWhitelist != null) {
      insertCols.add('on_whitelist');
      insertVals.add(onWhitelist ? 1 : 0);
    }
    if (roles != null) {
      insertCols.add('roles');
      insertVals.add(jsonEncode(roles.toList(growable: false)));
    }
    if (banned != null) {
      insertCols.addAll(['banned', 'banned_until', 'ban_reason']);
      insertVals.addAll([
        banned ? 1 : 0,
        bannedUntil?.millisecondsSinceEpoch,
        banReason,
      ]);
    }
    if (lastLogin != null) {
      insertCols.add('last_login');
      insertVals.add(lastLogin.millisecondsSinceEpoch);
    }

    final placeholders = List.filled(insertCols.length, '?').join(', ');

    if (updates.isEmpty) {
      _database?.execute(
        'INSERT OR IGNORE INTO users (${insertCols.join(', ')}) VALUES ($placeholders)',
        insertVals,
      );
    } else {
      _database?.execute(
        '''
        INSERT INTO users (${insertCols.join(', ')})
        VALUES ($placeholders)
        ON CONFLICT(fingerprint) DO UPDATE SET ${updates.join(', ')}
        ''',
        [...insertVals, ...values],
      );
    }
    return true;
  }

  @override
  bool replaceRole(String role, String replacement) {
    final database = _database;
    if (database == null) return false;
    final users = database.select('SELECT fingerprint, roles FROM users');
    for (final user in users) {
      final roles = _decodeRoles(user['roles']);
      if (!roles.remove(role)) continue;
      roles.add(replacement);
      database.execute('UPDATE users SET roles = ? WHERE fingerprint = ?', [
        jsonEncode(roles.toList(growable: false)),
        user['fingerprint'],
      ]);
    }
    return true;
  }

  @override
  void close() {
    _database?.close();
    _database = null;
  }
}
