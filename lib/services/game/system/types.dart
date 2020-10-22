enum ConnectionType { bluetooth, socket, online }

extension ConnectTypeExtension on ConnectionType {
  String getName() {
    switch (this) {
      case ConnectionType.bluetooth:
        return "Bluetooth";
      case ConnectionType.socket:
        return "LAN";
      case ConnectionType.online:
        return "Online";
    }
    return null;
  }

  String getDescription() {
    switch (this) {
      case ConnectionType.bluetooth:
        return "Play without internet together using bluetooth.";
      case ConnectionType.socket:
        return "Play on your current network. All players need to be on the same!";
      case ConnectionType.online:
        return "Play on the official servers.";
    }
    return null;
  }
}
