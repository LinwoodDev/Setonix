// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'config.dart';

class SetonixConfigMapper extends ClassMapperBase<SetonixConfig> {
  SetonixConfigMapper._();

  static SetonixConfigMapper? _instance;
  static SetonixConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SetonixConfigMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SetonixConfig';

  static String? _$worldFile(SetonixConfig v) => v.worldFile;
  static const Field<SetonixConfig, String> _f$worldFile =
      Field('worldFile', _$worldFile, opt: true);
  static bool? _$autosave(SetonixConfig v) => v.autosave;
  static const Field<SetonixConfig, bool> _f$autosave =
      Field('autosave', _$autosave, opt: true);
  static bool? _$multiWorld(SetonixConfig v) => v.multiWorld;
  static const Field<SetonixConfig, bool> _f$multiWorld =
      Field('multiWorld', _$multiWorld, opt: true);
  static int? _$maxPlayers(SetonixConfig v) => v.maxPlayers;
  static const Field<SetonixConfig, int> _f$maxPlayers =
      Field('maxPlayers', _$maxPlayers, opt: true);
  static String? _$description(SetonixConfig v) => v.description;
  static const Field<SetonixConfig, String> _f$description =
      Field('description', _$description, opt: true);

  @override
  final MappableFields<SetonixConfig> fields = const {
    #worldFile: _f$worldFile,
    #autosave: _f$autosave,
    #multiWorld: _f$multiWorld,
    #maxPlayers: _f$maxPlayers,
    #description: _f$description,
  };

  static SetonixConfig _instantiate(DecodingData data) {
    return SetonixConfig(
        worldFile: data.dec(_f$worldFile),
        autosave: data.dec(_f$autosave),
        multiWorld: data.dec(_f$multiWorld),
        maxPlayers: data.dec(_f$maxPlayers),
        description: data.dec(_f$description));
  }

  @override
  final Function instantiate = _instantiate;

  static SetonixConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SetonixConfig>(map);
  }

  static SetonixConfig fromJson(String json) {
    return ensureInitialized().decodeJson<SetonixConfig>(json);
  }
}

mixin SetonixConfigMappable {
  String toJson() {
    return SetonixConfigMapper.ensureInitialized()
        .encodeJson<SetonixConfig>(this as SetonixConfig);
  }

  Map<String, dynamic> toMap() {
    return SetonixConfigMapper.ensureInitialized()
        .encodeMap<SetonixConfig>(this as SetonixConfig);
  }

  SetonixConfigCopyWith<SetonixConfig, SetonixConfig, SetonixConfig>
      get copyWith => _SetonixConfigCopyWithImpl<SetonixConfig, SetonixConfig>(
          this as SetonixConfig, $identity, $identity);
  @override
  String toString() {
    return SetonixConfigMapper.ensureInitialized()
        .stringifyValue(this as SetonixConfig);
  }

  @override
  bool operator ==(Object other) {
    return SetonixConfigMapper.ensureInitialized()
        .equalsValue(this as SetonixConfig, other);
  }

  @override
  int get hashCode {
    return SetonixConfigMapper.ensureInitialized()
        .hashValue(this as SetonixConfig);
  }
}

extension SetonixConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SetonixConfig, $Out> {
  SetonixConfigCopyWith<$R, SetonixConfig, $Out> get $asSetonixConfig =>
      $base.as((v, t, t2) => _SetonixConfigCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SetonixConfigCopyWith<$R, $In extends SetonixConfig, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? worldFile,
      bool? autosave,
      bool? multiWorld,
      int? maxPlayers,
      String? description});
  SetonixConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SetonixConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SetonixConfig, $Out>
    implements SetonixConfigCopyWith<$R, SetonixConfig, $Out> {
  _SetonixConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SetonixConfig> $mapper =
      SetonixConfigMapper.ensureInitialized();
  @override
  $R call(
          {Object? worldFile = $none,
          Object? autosave = $none,
          Object? multiWorld = $none,
          Object? maxPlayers = $none,
          Object? description = $none}) =>
      $apply(FieldCopyWithData({
        if (worldFile != $none) #worldFile: worldFile,
        if (autosave != $none) #autosave: autosave,
        if (multiWorld != $none) #multiWorld: multiWorld,
        if (maxPlayers != $none) #maxPlayers: maxPlayers,
        if (description != $none) #description: description
      }));
  @override
  SetonixConfig $make(CopyWithData data) => SetonixConfig(
      worldFile: data.get(#worldFile, or: $value.worldFile),
      autosave: data.get(#autosave, or: $value.autosave),
      multiWorld: data.get(#multiWorld, or: $value.multiWorld),
      maxPlayers: data.get(#maxPlayers, or: $value.maxPlayers),
      description: data.get(#description, or: $value.description));

  @override
  SetonixConfigCopyWith<$R2, SetonixConfig, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SetonixConfigCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
