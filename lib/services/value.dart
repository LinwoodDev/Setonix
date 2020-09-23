import 'package:flutter_blue/flutter_blue.dart';

class BluetoothValue {
  final bool service;
  final BluetoothDevice device;
  final String data;

  BluetoothValue({this.service, this.data, this.device});
  Map<String, dynamic> toJson() => {"service": service, "data": data};

  BluetoothValue.fromJson(Map<String, dynamic> json, BluetoothDevice device)
      : service = json['service'],
        data = json['data'],
        device = device;
}
