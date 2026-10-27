import 'dart:convert';

import 'package:consoler/consoler.dart';

import '../server.dart';

void printServerStatus(SetonixServer server, CommandContext context) {
  final data = <String, Object?>{
    'state': server.isClosing ? 'stopping' : 'running',
    'address': server.address?.toString(),
    'uptimeSeconds': server.uptime.inSeconds,
    'players': server.userManager.getUsers().length,
    'maxPlayers': server.configManager.maxPlayers,
    'worlds': server.worldNames.length,
    'packs': server.assetManager.packs.length,
    'autosave': server.configManager.autosave,
    'whitelist': server.configManager.whitelistEnabled,
  };
  if (context.options!['json'] as bool) {
    context.write(jsonEncode(data));
    return;
  }
  final duration = server.uptime;
  final time = [
    duration.inHours.toString().padLeft(2, '0'),
    (duration.inMinutes % 60).toString().padLeft(2, '0'),
    (duration.inSeconds % 60).toString().padLeft(2, '0'),
  ].join(':');
  String toggle(bool value) => value ? 'enabled' : 'disabled';
  context.console.table(
    ['Server status', ''],
    [
      ['State', data['state']],
      ['Address', data['address']],
      ['Uptime', time],
      ['Players', '${data['players']} / ${data['maxPlayers']}'],
      ['Loaded worlds', data['worlds']],
      ['Content packs', data['packs']],
      ['Autosave', toggle(data['autosave'] as bool)],
      ['Whitelist', toggle(data['whitelist'] as bool)],
    ],
  );
}
