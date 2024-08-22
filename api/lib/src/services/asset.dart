import 'package:quokka_api/quokka_api.dart';

abstract class AssetManager {
  QuokkaData? getPack(String key);
}
