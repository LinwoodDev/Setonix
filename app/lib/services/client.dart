import 'package:networker/networker.dart';
import 'package:quokka/models/message.dart';
import 'package:quokka/services/messenger.dart';

mixin GenericClientMessenger on NetworkMessenger {
  void sendUpdate(NetworkUpdateMessage event) {
    final request =
        RpcRequest(kNetworkerConnectionIdAny, 'update', event.toMap());
    onUpdate(RpcMessage({...request.data, 'you': currentId}));
    rpc.sendMessage(request);
  }
}

class ClientMessenger extends NetworkMessenger with GenericClientMessenger {
  @override
  final NetworkerClient networker;

  @override
  final RpcNetworkerPlugin rpc = RpcNetworkerPlugin();

  ClientMessenger(this.networker) {
    networker.addPlugin(RawJsonNetworkerPlugin()..addPlugin(rpc));
  }
}
