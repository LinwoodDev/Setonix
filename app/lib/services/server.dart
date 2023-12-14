import 'package:networker/networker.dart';
import 'package:qeck/models/message.dart';
import 'package:qeck/models/state.dart';
import 'package:qeck/services/client.dart';
import 'package:qeck/services/messenger.dart';

class ServerMessenger extends NetworkMessenger {
  @override
  final NetworkerServer networker;
  @override
  final RpcNetworkerServerPlugin rpc = RpcNetworkerServerPlugin();

  ServerMessenger(this.networker) {
    networker.addPlugin(rpc);
    networker.connect.listen((event) {
      rpc.sendMessage(
        RpcRequest(
          kNetworkerConnectionIdAny,
          'join',
          NetworkPlayerJoinMessage(id: event, user: getInitialUser(event))
              .toMap(),
        ),
      );
      rpc.sendMessage(RpcRequest(
          event, 'init', NetworkInitMessage.build(users: users).toMap()));
    });
    networker.disconnect.listen((event) => rpc.sendMessage(
          RpcRequest(
            kNetworkerConnectionIdAny,
            'leave',
            NetworkPlayerLeaveMessage(id: event).toMap(),
          ),
        ));
  }

  NetworkingUser getInitialUser(int id) => NetworkingUser(
        name: id.toString(),
      );
}

class ClientServerMessenger extends ServerMessenger
    with GenericClientMessenger {
  ClientServerMessenger(super.networker) {
    usersSubject.add({
      ...users,
      kNetworkerConnectionIdAuthority:
          getInitialUser(kNetworkerConnectionIdAuthority),
    });
  }
}
