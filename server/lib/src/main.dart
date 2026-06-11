import 'dart:async';

import 'package:args/args.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/server.dart';

const String version = '0.0.1';

ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show additional command output.',
    )
    ..addFlag(
      'version',
      abbr: 'V',
      negatable: false,
      help: 'Print the tool version.',
    )
    ..addOption(
      'host',
      abbr: 'H',
      help:
          'The host to run the server on. Defaults to ${SetonixConfig.defaultHost}.',
    )
    ..addOption(
      'port',
      abbr: 'p',
      help: 'The port to run the server on. Defaults to $kDefaultPort.',
    )
    ..addOption(
      'description',
      abbr: 'd',
      help:
          'A description of the server. Will be displayed in the server list.',
    )
    ..addOption(
      'thumbnail',
      abbr: 't',
      help:
          'Path to an image file for the server thumbnail. Will be displayed in the server list.',
    )
    ..addOption(
      'autosave',
      abbr: 'a',
      help: "Disable saving of the world automatically",
    )
    ..addOption(
      'max-players',
      abbr: 'm',
      help: "Maximum number of players",
      defaultsTo: '10',
    )
    ..addFlag(
      'multi-world',
      abbr: 'w',
      negatable: false,
      help: "Enable multi-world support",
      defaultsTo: false,
    )
    ..addOption(
      'game-mode',
      abbr: 'g',
      help: 'The game mode to load. Otherwise it is a sandbox.',
    );
}

void printUsage(ArgParser argParser) {
  print('Usage: server <flags> [arguments]');
  print(argParser.usage);
}

typedef ServerLoader = FutureOr<void> Function(SetonixServer server);

const welcomeText = """
   ____    __            _     
  / __/__ / /____  ___  (_)_ __
 _\\ \\/ -_) __/ _ \\/ _ \\/ /\\ \\ /
/___/\\__/\\__/\\___/_//_/_//_\\_\\                         
""";
Future<void> runServer(List<String> arguments, [ServerLoader? onLoad]) async {
  final ArgParser argParser = buildParser();
  try {
    print(welcomeText);
    final ArgResults results = argParser.parse(arguments);
    bool verbose = false, autosave = false, multiWorld = false;
    String? gameMode;
    int maxPlayers = 10;

    // Process the parsed arguments.
    if (results.wasParsed('help')) {
      printUsage(argParser);
      return;
    }
    if (results.wasParsed('version')) {
      print('server version: $version');
      return;
    }
    if (results.wasParsed('verbose')) {
      verbose = true;
    }
    if (results.wasParsed('autosave')) {
      autosave = true;
    }
    if (results.wasParsed('multi-world')) {
      multiWorld = true;
    }
    if (results.wasParsed('max-players')) {
      maxPlayers = int.tryParse(results['max-players'] ?? '') ?? maxPlayers;
    }
    String? description;
    if (results.wasParsed('description')) {
      description = results['description'];
    }
    String? thumbnail;
    if (results.wasParsed('thumbnail')) {
      thumbnail = results['thumbnail'];
    }
    String? host;
    if (results.wasParsed('host')) {
      host = results['host'];
    }
    if (results.wasParsed('game-mode')) {
      gameMode = results['game-mode'];
    }
    final server = await SetonixServer.load(
      argsConfig: SetonixConfig(
        host: host,
        port: int.tryParse(results['port'] ?? ''),
        autosave: autosave,
        description: description,
        thumbnail: thumbnail,
        maxPlayers: maxPlayers,
        multiWorld: multiWorld,
        gameMode: gameMode,
      ),
    );
    await server.init(verbose: verbose);
    await onLoad?.call(server);
    await server.run();
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
