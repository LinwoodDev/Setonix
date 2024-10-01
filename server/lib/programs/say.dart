import 'package:consoler/consoler.dart';
import 'package:quokka_api/quokka_api.dart';
import 'package:quokka_server/server.dart';

class SayProgram extends ConsoleProgram {
  final QuokkaServer server;

  SayProgram(this.server);
  @override
  String getDescription() => "Send a message in the message";

  @override
  Future<void> run(String label, List<String> args) async {
    final message = args.join(' ');
    server.consoler.print("Sent $message", level: LogLevel.info);
    server.process(MessageRequest(message));
  }
}
