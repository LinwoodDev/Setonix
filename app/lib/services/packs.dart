import 'package:collection/collection.dart';
import 'package:quokka/models/pack.dart';

class PacksService {
  final PackData? _corePack;

  PacksService({
    PackData? corePack,
  }) : _corePack = corePack;

  Future<PackData?> fetchCorePack() async =>
      _corePack ?? await PackData.getCorePack();

  Future<List<PackData>> getPacks() async => [
        await fetchCorePack(),
      ].whereNotNull().toList();
}
