class BluetoothValue {
  final bool? service;

  // final BluetoothDevice device;
  final String? data;

  BluetoothValue({this.service, this.data});

  Map<String, dynamic> toJson() => {"service": service, "data": data};

  BluetoothValue.fromJson(Map<String, dynamic> json)
      : service = json['service'],
        data = json['data'];
}
