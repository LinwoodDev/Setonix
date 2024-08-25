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

  bool _firstPrefix = true;

  ConsoleManager({this.prefix = '\n> '});

  void dispose() {
    _subscription?.cancel();
    _firstPrefix = true;
  }

  void run() {
    _subscription?.cancel();
    _subscription = _readLine().listen(_onInput);
    if (_firstPrefix) sendPrefix();
  }

  Iterable<MapEntry<String?, T>> get programs => _programs.entries;

  void sendPrefix() {
    _firstPrefix = false;
    stdout.write(' \r$prefix');
  }

  void print(Object? message) {
    stdout.write('\r');
    stdout.write(message);
    sendPrefix();
  }

  void registerProgram(String? name, T program) {
    _programs[name] = program;
  }

  bool unregisterProgram(String? name) {
    return _programs.remove(name) != null;
  }

  void _onInput(String input) {
    final splitted = _splitBySpaces(input);
    (_programs[splitted.firstOrNull] ?? _programs[null])
        ?.run(splitted.isEmpty ? const [] : splitted.sublist(1));
  }
}
