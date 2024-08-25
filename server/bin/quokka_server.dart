import 'package:args/args.dart';
import 'package:quokka_api/quokka_api.dart';
import 'package:quokka_server/main.dart';

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
      'port',
      abbr: 'p',
      help: 'The port to run the server on. Defaults to $kDefaultPort.',
    )
    ..addOption('autosave',
        abbr: 'a', help: "Disable saving of the world automatically");
}

void printUsage(ArgParser argParser) {
  print('Usage: server <flags> [arguments]');
  print(argParser.usage);
}

Future<void> main(List<String> arguments) async {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);
    bool verbose = false, autosave = false;

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
    final server = await QuokkaServer.load();
    await server.init(
      port: int.tryParse(results['port'] ?? '') ?? kDefaultPort,
      verbose: verbose,
      autosave: autosave,
    );
    await server.run();
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
