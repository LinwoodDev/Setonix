import 'dart:async';
import 'dart:convert';
import 'dart:io';

Stream<String> _readLine() =>
    stdin.transform(utf8.decoder).transform(const LineSplitter());
List<String> _splitBySpaces(String input) {
  final List<String> words = [];
  bool inQuotes = false;
  String currentWord = "";

  for (int i = 0; i < input.length; i++) {
    final char = input[i];

    if (char == '"') {
      inQuotes = !inQuotes;
    } else if (char == ' ' && !inQuotes) {
      if (currentWord.isNotEmpty) {
        words.add(currentWord);
        currentWord = "";
      }
    } else {
      currentWord += char;
    }
  }

  if (currentWord.isNotEmpty) {
    words.add(currentWord);
  }

  return words;
}

abstract class ConsoleProgram {
  String? getUsage() => null;
  String? getDescription();
  void run(List<String> args);

  bool get isHidden => getDescription() == null;
}

class ConsoleManager<T extends ConsoleProgram> {
  StreamSubscription? _subscription;
  final Map<String?, T> _programs = {};
  final String prefix;

  ConsoleManager({this.prefix = '\n> '});

  void dispose() {
    _subscription?.cancel();
  }

  void run() {
    _subscription?.cancel();
    _subscription = _readLine().listen(_onInput);
    sendPrefix();
  }

  Iterable<MapEntry<String?, T>> get programs => _programs.entries;

  void sendPrefix() {
    //TODO:Fix print writes over prefix
    //stdout.write(prefix);
  }

  void registerProgram(String? name, T program) {
    _programs[name] = program;
  }

  bool unregisterProgram(String? name) {
    return _programs.remove(name) != null;
  }

  void _onInput(String input) {
    sendPrefix();
    final splitted = _splitBySpaces(input);
    (_programs[splitted.first] ?? _programs[null])?.run(splitted.sublist(1));
  }
}
