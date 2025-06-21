final migrations = <int, String>{
  1: '''
CREATE TABLE users (
  id            INTEGER PRIMARY KEY AUTOINCREMENT,
  role          VARCHAR(50)   NOT NULL DEFAULT '',
  created_at    INTEGER       NOT NULL DEFAULT (strftime('%s','now')),
  fingerprint   TEXT          NOT NULL UNIQUE,
  updated_at    INTEGER       NOT NULL DEFAULT (strftime('%s','now')),
  last_login    INTEGER,
  name          TEXT          NOT NULL UNIQUE,
  on_whitelist  INTEGER       NOT NULL DEFAULT 0
);
''',
};
