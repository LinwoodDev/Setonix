import 'dart:io';

Future<void> main() {
  // Receive broadcast messages from the udp server
  // and print them to the console.
  final server = RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889);
  return server.then((RawDatagramSocket socket) {
    socket.broadcastEnabled = true;
    socket.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        final datagram = socket.receive();
        if (datagram != null) {
          final message = String.fromCharCodes(datagram.data);
          print(message);
        }
      }
    });
  });
}
