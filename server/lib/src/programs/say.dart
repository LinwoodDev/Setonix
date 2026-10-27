import 'package:consoler/consoler.dart';
import 'package:setonix_api/setonix_api.dart';
import 'package:setonix_server/src/programs/async.dart';

class SayProgram extends AsyncServerProgram {
  SayProgram(super.server);

  @override
  String getDescription() => "Send a chat message.";

  @override
  Future<void> runAsync(String label, List<String> args) async {
    if (args.isEmpty) {
      throw const CommandUsageException();
    }
    final message = args.join(' ');
    server.consoler.print("Sent: $message", level: LogLevel.info);
    server.process(MessageRequest(message));
  }
}
