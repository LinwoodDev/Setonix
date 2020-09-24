import 'package:flutter/widgets.dart';
import 'package:minigamesparty/game/lobby.dart';

abstract class GameMode {
  const GameMode({this.manager});
  final GameModeManager manager;

  /* bool join(BluetoothDevice device) {
    return true;
  } */

  Widget build();

  /* void read(BluetoothDevice device, String data) {}
 */
  void initGame() {}
}

class GameModeManager {
/*   FlutterBlue flutterBlue = FlutterBlue.instance;
 */
  GameMode currentGameMode;
  /* List<BluetoothDevice> _players = List<BluetoothDevice>();
  BluetoothDevice owner;
  List<BluetoothDevice> get players => _players;


  void changeGameMode(GameMode gameMode) {
    currentGameMode = gameMode;
  }

  void changeToLobby() {
    currentGameMode = LobbyGame();
  } */
  GameModeManager();

  Future<void> initCommunication() async {}
  /* Future<void> reloadPlayers() async {
    _players = await flutterBlue.connectedDevices;
    _players.forEach((_player) async {
      var services = await _player.discoverServices();
    });
  } */

  /* void startScan() {
    // Start scanninga
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    // Listen to scan results
    flutterBlue.scanResults.listen((scanResult) {
      // do something with scan result
      var device = scanResult.last.device;
      print('${device.name} found! rssi: ${device.id}');
      if (join(device))
        device.disconnect().then((value) =>
            print("Successfully disconnected the device ${device.name}, rssi: ${device.id}"));
      reloadPlayers();
    });
  } */

  void stopScan() {
    // flutterBlue.stopScan();
  }

  /* void onRead(BluetoothDevice device, String data) {
    currentGameMode?.read(device, data);
  } */

  void communicate(String data) {}

  /* bool join(BluetoothDevice device) {
    return currentGameMode?.join(device);
  } */

  bool isOwner() {
    return true;
  }
}
