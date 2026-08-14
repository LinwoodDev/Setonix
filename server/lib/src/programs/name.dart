import 'package:consoler/consoler.dart';
import 'package:setonix_server/src/programs/async.dart';

class NameProgram extends AsyncServerProgram {
  NameProgram(super.server);

  @override
  String getUsage() => '<User> <Name>';

  @override
  String getDescription() => 'Change a connected user\'s display name.';

  @override
  Future<void> runAsync(String label, List<String> args) async {
    if (args.length < 2) {
      server.log('Wrong usage, use ${getUsage()}', level: LogLevel.error);
      return;
    }
    final reference = args.first;
    final name = args.skip(1).join(' ').trim();
    final channel = await server.userManager.getUserIdByReference(reference);
    if (channel == null || name.isEmpty || name.length > 256) {
      server.log('User not found or invalid name.', level: LogLevel.error);
      return;
    }
    if (!await server.userManager.changeName(channel, name)) {
      server.log('The name is already in use.', level: LogLevel.error);
      return;
    }
    await server.broadcastAllServerStates();
    server.log('Changed $reference name to $name', level: LogLevel.info);
  }
}
