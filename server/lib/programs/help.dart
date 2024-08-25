import 'package:quokka_server/console.dart';

class HelpProgram extends ConsoleProgram {
  final ConsoleManager consoleManager;

  HelpProgram(this.consoleManager);

  @override
  String getDescription() => "Show an overview about all commands";

  @override
  void run(List<String> args) {
    print("Quokka server");
    for (final program in consoleManager.programs) {
      final usage = program.value.getUsage();
      final description = program.value.getDescription();
      if (description == null) continue;
      print("> ${program.key}${usage != null ? ' $usage' : ''} - $description");
    }
  }
}
