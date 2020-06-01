import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:minigamesparty/game/lobby.dart';

abstract class GameMode extends StatefulWidget {
  final GameModeManager manager;

  GameMode({this.manager, Key key}) : super(key: key);

  
}

class GameModeManager {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  GameMode currentGameMode;
  List<BluetoothDevice> players = List();

  GameModeManager(){
    currentGameMode = LobbyPage(manager: this);
  }

  void changeGameMode(GameMode gameMode) {
    currentGameMode = gameMode;
  }

  void changeToLobby() {
    currentGameMode = LobbyPage();
  }

  void startScan() {
    // Start scanninga
    flutterBlue.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
    flutterBlue.scanResults.listen((scanResult) {
      // do something with scan result
      var device = scanResult.last.device;
      print('${device.name} found! rssi: ${device.id}');
      if (join(device))
        players.add(device);
    });
  }

  void stopScan() {
    flutterBlue.stopScan();
  }

  bool join(BluetoothDevice device) {
    return true;
  }
}
