import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/services/user/migrations.dart';
import 'package:sqlite3/sqlite3.dart';

final class FileUserService extends UserService {
  Database? _database;

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
  bool updateUser(
    String fingerprint, {
    String? name,
    bool? onWhitelist,
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
}
