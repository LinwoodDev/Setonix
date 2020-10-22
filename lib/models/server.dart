import 'package:hive/hive.dart';

part 'server.g.dart';

@HiveType(typeId: 0)
class Server {
  @HiveField(0)
  String name;
  @HiveField(1)
  String address;
  @HiveField(2)
  String password;
}
