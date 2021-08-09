import 'package:hive/hive.dart';

part 'server.g.dart';

@HiveType(typeId: 0)
class Server {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? address;
  @HiveField(3)
  String? password;

  Server({this.name, this.address, this.password});
}
