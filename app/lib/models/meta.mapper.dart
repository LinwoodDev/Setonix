// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'meta.dart';

class PackMetadataMapper extends ClassMapperBase<PackMetadata> {
  PackMetadataMapper._();

  static PackMetadataMapper? _instance;
  static PackMetadataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PackMetadataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PackMetadata';

  static String? _$name(PackMetadata v) => v.name;
  static const Field<PackMetadata, String> _f$name =
      Field('name', _$name, opt: true);
  static String? _$description(PackMetadata v) => v.description;
  static const Field<PackMetadata, String> _f$description =
      Field('description', _$description, opt: true);
  static String? _$author(PackMetadata v) => v.author;
  static const Field<PackMetadata, String> _f$author =
      Field('author', _$author, opt: true);
  static String? _$version(PackMetadata v) => v.version;
  static const Field<PackMetadata, String> _f$version =
      Field('version', _$version, opt: true);

  @override
  final MappableFields<PackMetadata> fields = const {
    #name: _f$name,
    #description: _f$description,
    #author: _f$author,
    #version: _f$version,
  };

  static PackMetadata _instantiate(DecodingData data) {
    return PackMetadata(
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        author: data.dec(_f$author),
        version: data.dec(_f$version));
  }

  @override
  final Function instantiate = _instantiate;

  static PackMetadata fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PackMetadata>(map);
  }

  static PackMetadata fromJson(String json) {
    return ensureInitialized().decodeJson<PackMetadata>(json);
  }
}

mixin PackMetadataMappable {
  String toJson() {
    return PackMetadataMapper.ensureInitialized()
        .encodeJson<PackMetadata>(this as PackMetadata);
  }

  Map<String, dynamic> toMap() {
    return PackMetadataMapper.ensureInitialized()
        .encodeMap<PackMetadata>(this as PackMetadata);
  }

  PackMetadataCopyWith<PackMetadata, PackMetadata, PackMetadata> get copyWith =>
      _PackMetadataCopyWithImpl(this as PackMetadata, $identity, $identity);
  @override
  String toString() {
    return PackMetadataMapper.ensureInitialized()
        .stringifyValue(this as PackMetadata);
  }

  @override
  bool operator ==(Object other) {
    return PackMetadataMapper.ensureInitialized()
        .equalsValue(this as PackMetadata, other);
  }

  @override
  int get hashCode {
    return PackMetadataMapper.ensureInitialized()
        .hashValue(this as PackMetadata);
  }
}

extension PackMetadataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PackMetadata, $Out> {
  PackMetadataCopyWith<$R, PackMetadata, $Out> get $asPackMetadata =>
      $base.as((v, t, t2) => _PackMetadataCopyWithImpl(v, t, t2));
}

abstract class PackMetadataCopyWith<$R, $In extends PackMetadata, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? description, String? author, String? version});
  PackMetadataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PackMetadataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PackMetadata, $Out>
    implements PackMetadataCopyWith<$R, PackMetadata, $Out> {
  _PackMetadataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PackMetadata> $mapper =
      PackMetadataMapper.ensureInitialized();
  @override
  $R call(
          {Object? name = $none,
          Object? description = $none,
          Object? author = $none,
          Object? version = $none}) =>
      $apply(FieldCopyWithData({
        if (name != $none) #name: name,
        if (description != $none) #description: description,
        if (author != $none) #author: author,
        if (version != $none) #version: version
      }));
  @override
  PackMetadata $make(CopyWithData data) => PackMetadata(
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      author: data.get(#author, or: $value.author),
      version: data.get(#version, or: $value.version));

  @override
  PackMetadataCopyWith<$R2, PackMetadata, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PackMetadataCopyWithImpl($value, $cast, t);
}
