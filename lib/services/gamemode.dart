import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:minigamesparty/game/lobby.dart';

abstract class GameMode {
  final GameModeManager manager;

  GameMode({this.manager});

  bool join(BluetoothDevice device);
  
  Widget build();
}

class GameModeManager {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  GameMode currentGameMode;
  List<BluetoothDevice> players;
  BluetoothDevice owner;

  GameModeManager();

  void changeGameMode(GameMode gameMode) {
    currentGameMode = gameMode;
  }

  void changeToLobby() {
    currentGameMode = LobbyGame();  
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
    return currentGameMode?.join(device);
  }

  bool isOwner(){
    return owner == null;
  }
}
