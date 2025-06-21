import 'dart:async';

import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/services/user/migrations.dart';
import 'package:sqlite3/sqlite3.dart';

final class FileUserService extends UserService {
  Database? _database;

  Future<void> setup() async {
    final database = sqlite3.open('setonix.db');
    // Basic migration system

    final result = database.select('PRAGMA user_version');
    final currentVersion =
        result.isNotEmpty ? result.first['user_version'] as int : 0;

    for (var version = currentVersion + 1;
        version <= migrations.length;
        version++) {
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
      createdAt: row['created_at'] != null
          ? DateTime.parse(row['created_at'] as String)
          : null,
      updatedAt: row['updated_at'] != null
          ? DateTime.parse(row['updated_at'] as String)
          : null,
      lastLogin: row['last_login'] != null
          ? DateTime.parse(row['last_login'] as String)
          : null,
    );
  }

  @override
  SetonixUser? getUser(String fingerprint) => _database
      ?.select(
        'SELECT * FROM users WHERE fingerprint = ?',
        [fingerprint],
      )
      .map(_fromRow)
      .firstOrNull;

  @override
  SetonixUser? getUserFromName(String name) => _database
      ?.select(
        'SELECT * FROM users WHERE name = ?',
        [name],
      )
      .map(_fromRow)
      .firstOrNull;

  @override
  bool updateUser(String fingerprint,
      {String? name, bool? onWhitelist, DateTime? lastLogin}) {
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
    if (lastLogin != null) {
      updates.add('last_login = ?');
      values.add(lastLogin.toIso8601String());
    }

    if (updates.isEmpty) return false;

    values.add(fingerprint);
    _database?.execute(
      'UPDATE users SET ${updates.join(', ')} WHERE fingerprint = ?',
      values,
    );
    return _database?.updatedRows == 1;
  }
}
