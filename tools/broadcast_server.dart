import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<void> main() {
  final destination = InternetAddress('255.255.255.255');
  print('Sending to $destination');
  return RawDatagramSocket.bind(InternetAddress.anyIPv4, 28007)
      .then((RawDatagramSocket udpSocket) {
    udpSocket.broadcastEnabled = true;
    //List<String> words = ['apple', 'banana', 'cherry', 'date', 'elderberry'];
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      //String word = words[Random().nextInt(words.length)];
      var word =
          '{"port":28006,"description":"A server for Setonix. ${DateTime.now()}"}';
      List<int> data = utf8.encode(word);
      udpSocket.send(data, destination, 28007);
      print('sent $word');
    });
  });
}
