import 'package:consoler/consoler.dart';
import 'package:quokka_api/quokka_api.dart';
import 'package:quokka_server/main.dart';

class SayProgram extends ConsoleProgram {
  final QuokkaServer server;

  SayProgram(this.server);
  @override
  String getDescription() => "Send a message in the message";

  @override
  Future<void> run(String label, List<String> args) async {
    final message = args.join(' ');
    server.process(MessageRequest(message));
  }
}
