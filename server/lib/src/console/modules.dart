import 'package:consoler/consoler.dart';

import '../server.dart';
import '../programs/ban.dart';
import '../programs/bans.dart';
import '../programs/kick.dart';
import '../programs/modes.dart';
import '../programs/name.dart';
import '../programs/packs.dart';
import '../programs/players.dart';
import '../programs/reset.dart';
import '../programs/role.dart';
import '../programs/roles.dart';
import '../programs/save.dart';
import '../programs/say.dart';
import '../programs/scripts.dart';
import '../programs/stop.dart';
import '../programs/whitelist.dart';
import '../programs/worlds.dart';
import 'status.dart';

abstract class ServerConsoleModule extends ConsoleModule {
  final SetonixServer server;
  final Map<String, ConsoleProgram> programs;
  ServerConsoleModule(this.server, this.programs);

  @override
  Iterable<ConsoleCommand> get commands => programs.entries.map((entry) {
    final name = entry.key;
    final program = entry.value;
    final worldOption = {'players', 'save', 'scripts'}.contains(name);
    final parser = worldOption
        ? (ArgParser()..addOption(
            'world',
            abbr: 'w',
            help: "Limit the command to this world.",
          ))
        : null;

    Future<void> invoke(CommandContext context, List<String> prefix) async {
      var args = context.args;
      final world = context.options?['world'] as String?;
      if (world != null) {
        if (args.isNotEmpty) context.usage();
        args = [world];
      }
      await program.run(name, [...prefix, ...args]);
    }

    ConsoleCommand child(
      String action,
      String usage, {
      List<String> prefix = const [],
      List<ConsoleCommand> children = const [],
    }) => ConsoleCommand(
      name: action,
      usage: usage,
      subcommands: children,
      description: program.getDescription() ?? '',
      run: (context) => invoke(context, [...prefix, action]),
    );

    final children = switch (name) {
      'role' => [
        child('list', '<User>'),
        child('add', '<User> <Role...>'),
        child('remove', '<User> <Role...>'),
        child('set', '<User> <Role...>'),
      ],
      'roles' => [
        child('list', ''),
        child('show', '<Role>'),
        child('create', '<Role> <Priority> <Display name...>'),
        child('delete', '<Role> [Replacement]'),
        child('rename', '<Role> <Display name...>'),
        child('priority', '<Role> <Priority>'),
        ConsoleCommand(
          name: 'permission',
          subcommands: [
            child('add', '<Role> <Permission>', prefix: ['permission']),
            child('remove', '<Role> <Permission>', prefix: ['permission']),
          ],
        ),
      ],
      'whitelist' => [child('add', '<User>'), child('remove', '<User>')],
      _ => <ConsoleCommand>[],
    };
    return ConsoleCommand(
      name: name,
      category: switch (id) {
        'worlds' => 'Worlds',
        'moderation' => 'Moderation',
        'roles' => 'Roles',
        'content' => 'Content',
        _ => 'Server',
      },
      parser: parser,
      usage: name == 'say' ? '<Message...>' : program.getUsage() ?? '',
      description: program.getDescription() ?? '',
      examples: _examples[name] ?? const [],
      subcommands: children,
      run: (context) => invoke(context, const []),
    );
  });
}

final class ServerModule extends ServerConsoleModule {
  ServerModule(SetonixServer server)
    : super(server, {'say': SayProgram(server), 'stop': StopProgram(server)});
  @override
  String get id => 'server';
  @override
  Iterable<ConsoleCommand> get commands => [
    ...super.commands,
    ConsoleCommand(
      name: 'status',
      category: 'Server',
      maxArgs: 0,
      description: 'Show server status and uptime.',
      parser: ArgParser()
        ..addFlag(
          'json',
          negatable: false,
          help: "Print machine-readable JSON.",
        ),
      examples: ['status', 'status --json'],
      run: (context) => printServerStatus(server, context),
    ),
  ];
}

final class WorldModule extends ServerConsoleModule {
  WorldModule(SetonixServer server)
    : super(server, {
        'worlds': WorldsProgram(server),
        'save': SaveProgram(server),
        'reset': ResetProgram(server),
      });
  @override
  String get id => 'worlds';
}

final class ModerationModule extends ServerConsoleModule {
  ModerationModule(SetonixServer server)
    : super(server, {
        'players': PlayersProgram(server),
        'name': NameProgram(server),
        'kick': KickProgram(server),
        'ban': BanProgram(server, banned: true),
        'unban': BanProgram(server, banned: false),
        'bans': BansProgram(server),
        'whitelist': WhitelistProgram(server),
      });
  @override
  String get id => 'moderation';
}

final class RolesModule extends ServerConsoleModule {
  RolesModule(SetonixServer server)
    : super(server, {
        'role': RoleProgram(server),
        'roles': RolesProgram(server),
      });
  @override
  String get id => 'roles';
}

final class ContentModule extends ServerConsoleModule {
  ContentModule(SetonixServer server)
    : super(server, {
        'packs': PacksProgram(server),
        'modes': ModesProgram(server),
        'scripts': ScriptsProgram(server),
      });
  @override
  String get id => 'content';
}

const _examples = <String, List<String>>{
  'say': ['say "Hello everyone!"'],
  'players': ['players', 'players --world default'],
  'save': ['save', 'save --world default'],
  'reset': ['reset default sandbox'],
  'ban': ['ban @Player 60 "Repeated disruption"'],
  'role': ['role add @Player moderator', 'role list @Player'],
  'roles': [
    'roles create helper 10 "Server helper"',
    'roles permission add helper kickPlayers',
  ],
};
