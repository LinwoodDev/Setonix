import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

Future<void> main() {
  final destination = InternetAddress('255.255.255.255');
  print('Sending to $destination');
  return RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889)
      .then((RawDatagramSocket udpSocket) {
    udpSocket.broadcastEnabled = true;
    List<String> words = ['apple', 'banana', 'cherry', 'date', 'elderberry'];
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      String word = words[Random().nextInt(words.length)];
      List<int> data = utf8.encode(word);
      udpSocket.send(data, destination, 8889);
      print('sent $word');
    });
  });
}
