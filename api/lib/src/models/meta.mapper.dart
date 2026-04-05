// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'meta.dart';

/// @nodoc

class FileTypeMapper extends EnumMapper<SetonixFileType> {
  FileTypeMapper._();

  static FileTypeMapper? _instance;
  static FileTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FileTypeMapper._());
    }
    return _instance!;
  }

  static SetonixFileType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SetonixFileType decode(dynamic value) {
    switch (value) {
      case r'pack':
        return SetonixFileType.pack;
      case r'game':
        return SetonixFileType.game;
      case r'template':
        return SetonixFileType.template;
      case r'accounts':
        return SetonixFileType.accounts;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SetonixFileType self) {
    switch (self) {
      case SetonixFileType.pack:
        return r'pack';
      case SetonixFileType.game:
        return r'game';
      case SetonixFileType.template:
        return r'template';
      case SetonixFileType.accounts:
        return r'accounts';
    }
  }
}

/// @nodoc

extension FileTypeMapperExtension on SetonixFileType {
  String toValue() {
    FileTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SetonixFileType>(this) as String;
  }
}

/// @nodoc
class FileMetadataMapper extends ClassMapperBase<FileMetadata> {
  FileMetadataMapper._();

  static FileMetadataMapper? _instance;
  static FileMetadataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FileMetadataMapper._());
      FileTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FileMetadata';

  static SetonixFileType _$type(FileMetadata v) => v.type;
  static const Field<FileMetadata, SetonixFileType> _f$type = Field(
    'type',
    _$type,
    opt: true,
    def: SetonixFileType.pack,
  );
  static String _$name(FileMetadata v) => v.name;
  static const Field<FileMetadata, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );
  static String _$description(FileMetadata v) => v.description;
  static const Field<FileMetadata, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static String _$author(FileMetadata v) => v.author;
  static const Field<FileMetadata, String> _f$author = Field(
    'author',
    _$author,
    opt: true,
    def: '',
  );
  static String _$version(FileMetadata v) => v.version;
  static const Field<FileMetadata, String> _f$version = Field(
    'version',
    _$version,
    opt: true,
    def: '',
  );
  static Set<String> _$dependencies(FileMetadata v) => v.dependencies;
  static const Field<FileMetadata, Set<String>> _f$dependencies = Field(
    'dependencies',
    _$dependencies,
    opt: true,
    def: const {},
  );
  static int _$fileVersion(FileMetadata v) => v.fileVersion;
  static const Field<FileMetadata, int> _f$fileVersion = Field(
    'fileVersion',
    _$fileVersion,
    opt: true,
    def: kFileVersion,
  );

  @override
  final MappableFields<FileMetadata> fields = const {
    #type: _f$type,
    #name: _f$name,
    #description: _f$description,
    #author: _f$author,
    #version: _f$version,
    #dependencies: _f$dependencies,
    #fileVersion: _f$fileVersion,
  };

  static FileMetadata _instantiate(DecodingData data) {
    return FileMetadata(
      type: data.dec(_f$type),
      name: data.dec(_f$name),
      description: data.dec(_f$description),
      author: data.dec(_f$author),
      version: data.dec(_f$version),
      dependencies: data.dec(_f$dependencies),
      fileVersion: data.dec(_f$fileVersion),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static FileMetadata fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FileMetadata>(map);
  }

  static FileMetadata fromJson(String json) {
    return ensureInitialized().decodeJson<FileMetadata>(json);
  }
}

/// @nodoc
mixin FileMetadataMappable {
  String toJson() {
    return FileMetadataMapper.ensureInitialized().encodeJson<FileMetadata>(
      this as FileMetadata,
    );
  }

  Map<String, dynamic> toMap() {
    return FileMetadataMapper.ensureInitialized().encodeMap<FileMetadata>(
      this as FileMetadata,
    );
  }

  FileMetadataCopyWith<FileMetadata, FileMetadata, FileMetadata> get copyWith =>
      _FileMetadataCopyWithImpl<FileMetadata, FileMetadata>(
        this as FileMetadata,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return FileMetadataMapper.ensureInitialized().stringifyValue(
      this as FileMetadata,
    );
  }

  @override
  bool operator ==(Object other) {
    return FileMetadataMapper.ensureInitialized().equalsValue(
      this as FileMetadata,
      other,
    );
  }

  @override
  int get hashCode {
    return FileMetadataMapper.ensureInitialized().hashValue(
      this as FileMetadata,
    );
  }
}

/// @nodoc
extension FileMetadataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FileMetadata, $Out> {
  FileMetadataCopyWith<$R, FileMetadata, $Out> get $asFileMetadata =>
      $base.as((v, t, t2) => _FileMetadataCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class FileMetadataCopyWith<$R, $In extends FileMetadata, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    SetonixFileType? type,
    String? name,
    String? description,
    String? author,
    String? version,
    Set<String>? dependencies,
    int? fileVersion,
  });
  FileMetadataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _FileMetadataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FileMetadata, $Out>
    implements FileMetadataCopyWith<$R, FileMetadata, $Out> {
  _FileMetadataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FileMetadata> $mapper =
      FileMetadataMapper.ensureInitialized();
  @override
  $R call({
    SetonixFileType? type,
    String? name,
    String? description,
    String? author,
    String? version,
    Set<String>? dependencies,
    int? fileVersion,
  }) => $apply(
    FieldCopyWithData({
      if (type != null) #type: type,
      if (name != null) #name: name,
      if (description != null) #description: description,
      if (author != null) #author: author,
      if (version != null) #version: version,
      if (dependencies != null) #dependencies: dependencies,
      if (fileVersion != null) #fileVersion: fileVersion,
    }),
  );
  @override
  FileMetadata $make(CopyWithData data) => FileMetadata(
    type: data.get(#type, or: $value.type),
    name: data.get(#name, or: $value.name),
    description: data.get(#description, or: $value.description),
    author: data.get(#author, or: $value.author),
    version: data.get(#version, or: $value.version),
    dependencies: data.get(#dependencies, or: $value.dependencies),
    fileVersion: data.get(#fileVersion, or: $value.fileVersion),
  );

  @override
  FileMetadataCopyWith<$R2, FileMetadata, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _FileMetadataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class SignatureMetadataMapper extends ClassMapperBase<SignatureMetadata> {
  SignatureMetadataMapper._();

  static SignatureMetadataMapper? _instance;
  static SignatureMetadataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SignatureMetadataMapper._());
      FileMetadataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SignatureMetadata';

  static String _$id(SignatureMetadata v) => v.id;
  static const Field<SignatureMetadata, String> _f$id = Field('id', _$id);
  static FileMetadata _$metadata(SignatureMetadata v) => v.metadata;
  static const Field<SignatureMetadata, FileMetadata> _f$metadata = Field(
    'metadata',
    _$metadata,
  );
  static List<String> _$downloadUrls(SignatureMetadata v) => v.downloadUrls;
  static const Field<SignatureMetadata, List<String>> _f$downloadUrls = Field(
    'downloadUrls',
    _$downloadUrls,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<SignatureMetadata> fields = const {
    #id: _f$id,
    #metadata: _f$metadata,
    #downloadUrls: _f$downloadUrls,
  };

  static SignatureMetadata _instantiate(DecodingData data) {
    return SignatureMetadata(
      id: data.dec(_f$id),
      metadata: data.dec(_f$metadata),
      downloadUrls: data.dec(_f$downloadUrls),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SignatureMetadata fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SignatureMetadata>(map);
  }

  static SignatureMetadata fromJson(String json) {
    return ensureInitialized().decodeJson<SignatureMetadata>(json);
  }
}

/// @nodoc
mixin SignatureMetadataMappable {
  String toJson() {
    return SignatureMetadataMapper.ensureInitialized()
        .encodeJson<SignatureMetadata>(this as SignatureMetadata);
  }

  Map<String, dynamic> toMap() {
    return SignatureMetadataMapper.ensureInitialized()
        .encodeMap<SignatureMetadata>(this as SignatureMetadata);
  }

  SignatureMetadataCopyWith<
    SignatureMetadata,
    SignatureMetadata,
    SignatureMetadata
  >
  get copyWith =>
      _SignatureMetadataCopyWithImpl<SignatureMetadata, SignatureMetadata>(
        this as SignatureMetadata,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SignatureMetadataMapper.ensureInitialized().stringifyValue(
      this as SignatureMetadata,
    );
  }

  @override
  bool operator ==(Object other) {
    return SignatureMetadataMapper.ensureInitialized().equalsValue(
      this as SignatureMetadata,
      other,
    );
  }

  @override
  int get hashCode {
    return SignatureMetadataMapper.ensureInitialized().hashValue(
      this as SignatureMetadata,
    );
  }
}

/// @nodoc
extension SignatureMetadataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SignatureMetadata, $Out> {
  SignatureMetadataCopyWith<$R, SignatureMetadata, $Out>
  get $asSignatureMetadata => $base.as(
    (v, t, t2) => _SignatureMetadataCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class SignatureMetadataCopyWith<
  $R,
  $In extends SignatureMetadata,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  FileMetadataCopyWith<$R, FileMetadata, FileMetadata> get metadata;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get downloadUrls;
  $R call({String? id, FileMetadata? metadata, List<String>? downloadUrls});
  SignatureMetadataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _SignatureMetadataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SignatureMetadata, $Out>
    implements SignatureMetadataCopyWith<$R, SignatureMetadata, $Out> {
  _SignatureMetadataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SignatureMetadata> $mapper =
      SignatureMetadataMapper.ensureInitialized();
  @override
  FileMetadataCopyWith<$R, FileMetadata, FileMetadata> get metadata =>
      $value.metadata.copyWith.$chain((v) => call(metadata: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get downloadUrls => ListCopyWith(
    $value.downloadUrls,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(downloadUrls: v),
  );
  @override
  $R call({String? id, FileMetadata? metadata, List<String>? downloadUrls}) =>
      $apply(
        FieldCopyWithData({
          if (id != null) #id: id,
          if (metadata != null) #metadata: metadata,
          if (downloadUrls != null) #downloadUrls: downloadUrls,
        }),
      );
  @override
  SignatureMetadata $make(CopyWithData data) => SignatureMetadata(
    id: data.get(#id, or: $value.id),
    metadata: data.get(#metadata, or: $value.metadata),
    downloadUrls: data.get(#downloadUrls, or: $value.downloadUrls),
  );

  @override
  SignatureMetadataCopyWith<$R2, SignatureMetadata, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SignatureMetadataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class DataMetadataMapper extends ClassMapperBase<DataMetadata> {
  DataMetadataMapper._();

  static DataMetadataMapper? _instance;
  static DataMetadataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DataMetadataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DataMetadata';

  static bool _$manuallyAdded(DataMetadata v) => v.manuallyAdded;
  static const Field<DataMetadata, bool> _f$manuallyAdded = Field(
    'manuallyAdded',
    _$manuallyAdded,
    opt: true,
    def: true,
  );
  static DateTime _$addedAt(DataMetadata v) => v.addedAt;
  static const Field<DataMetadata, DateTime> _f$addedAt = Field(
    'addedAt',
    _$addedAt,
  );
  static Map<String, DateTime> _$serversLastUsed(DataMetadata v) =>
      v.serversLastUsed;
  static const Field<DataMetadata, Map<String, DateTime>> _f$serversLastUsed =
      Field('serversLastUsed', _$serversLastUsed, opt: true, def: const {});

  @override
  final MappableFields<DataMetadata> fields = const {
    #manuallyAdded: _f$manuallyAdded,
    #addedAt: _f$addedAt,
    #serversLastUsed: _f$serversLastUsed,
  };

  static DataMetadata _instantiate(DecodingData data) {
    return DataMetadata(
      manuallyAdded: data.dec(_f$manuallyAdded),
      addedAt: data.dec(_f$addedAt),
      serversLastUsed: data.dec(_f$serversLastUsed),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DataMetadata fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DataMetadata>(map);
  }

  static DataMetadata fromJson(String json) {
    return ensureInitialized().decodeJson<DataMetadata>(json);
  }
}

/// @nodoc
mixin DataMetadataMappable {
  String toJson() {
    return DataMetadataMapper.ensureInitialized().encodeJson<DataMetadata>(
      this as DataMetadata,
    );
  }

  Map<String, dynamic> toMap() {
    return DataMetadataMapper.ensureInitialized().encodeMap<DataMetadata>(
      this as DataMetadata,
    );
  }

  DataMetadataCopyWith<DataMetadata, DataMetadata, DataMetadata> get copyWith =>
      _DataMetadataCopyWithImpl<DataMetadata, DataMetadata>(
        this as DataMetadata,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DataMetadataMapper.ensureInitialized().stringifyValue(
      this as DataMetadata,
    );
  }

  @override
  bool operator ==(Object other) {
    return DataMetadataMapper.ensureInitialized().equalsValue(
      this as DataMetadata,
      other,
    );
  }

  @override
  int get hashCode {
    return DataMetadataMapper.ensureInitialized().hashValue(
      this as DataMetadata,
    );
  }
}

/// @nodoc
extension DataMetadataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DataMetadata, $Out> {
  DataMetadataCopyWith<$R, DataMetadata, $Out> get $asDataMetadata =>
      $base.as((v, t, t2) => _DataMetadataCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class DataMetadataCopyWith<$R, $In extends DataMetadata, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, DateTime, ObjectCopyWith<$R, DateTime, DateTime>>
  get serversLastUsed;
  $R call({
    bool? manuallyAdded,
    DateTime? addedAt,
    Map<String, DateTime>? serversLastUsed,
  });
  DataMetadataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _DataMetadataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DataMetadata, $Out>
    implements DataMetadataCopyWith<$R, DataMetadata, $Out> {
  _DataMetadataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DataMetadata> $mapper =
      DataMetadataMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, DateTime, ObjectCopyWith<$R, DateTime, DateTime>>
  get serversLastUsed => MapCopyWith(
    $value.serversLastUsed,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(serversLastUsed: v),
  );
  @override
  $R call({
    bool? manuallyAdded,
    DateTime? addedAt,
    Map<String, DateTime>? serversLastUsed,
  }) => $apply(
    FieldCopyWithData({
      if (manuallyAdded != null) #manuallyAdded: manuallyAdded,
      if (addedAt != null) #addedAt: addedAt,
      if (serversLastUsed != null) #serversLastUsed: serversLastUsed,
    }),
  );
  @override
  DataMetadata $make(CopyWithData data) => DataMetadata(
    manuallyAdded: data.get(#manuallyAdded, or: $value.manuallyAdded),
    addedAt: data.get(#addedAt, or: $value.addedAt),
    serversLastUsed: data.get(#serversLastUsed, or: $value.serversLastUsed),
  );

  @override
  DataMetadataCopyWith<$R2, DataMetadata, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DataMetadataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

