import 'package:dart_mappable/dart_mappable.dart';

part 'meta.mapper.dart';

@MappableClass()
class PackMetadata with PackMetadataMappable {
  final String? name;
  final String? description;
  final String? author;
  final String? version;

  PackMetadata({
    this.name,
    this.description,
    this.author,
    this.version,
  });
}
