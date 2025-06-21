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

  static String? _$host(SetonixConfig v) => v.host;
  static const Field<SetonixConfig, String> _f$host =
      Field('host', _$host, opt: true);
  static int? _$port(SetonixConfig v) => v.port;
  static const Field<SetonixConfig, int> _f$port =
      Field('port', _$port, opt: true);
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
  static String? _$guestPrefix(SetonixConfig v) => v.guestPrefix;
  static const Field<SetonixConfig, String> _f$guestPrefix =
      Field('guestPrefix', _$guestPrefix, opt: true);
  static bool? _$whitelistEnabled(SetonixConfig v) => v.whitelistEnabled;
  static const Field<SetonixConfig, bool> _f$whitelistEnabled =
      Field('whitelistEnabled', _$whitelistEnabled, opt: true);
  static bool? _$accountRequired(SetonixConfig v) => v.accountRequired;
  static const Field<SetonixConfig, bool> _f$accountRequired =
      Field('accountRequired', _$accountRequired, opt: true);
  static String? _$apiEndpoint(SetonixConfig v) => v.apiEndpoint;
  static const Field<SetonixConfig, String> _f$apiEndpoint =
      Field('apiEndpoint', _$apiEndpoint, opt: true);
  static String? _$endpointSecret(SetonixConfig v) => v.endpointSecret;
  static const Field<SetonixConfig, String> _f$endpointSecret =
      Field('endpointSecret', _$endpointSecret, opt: true);

  @override
  final MappableFields<SetonixConfig> fields = const {
    #host: _f$host,
    #port: _f$port,
    #worldFile: _f$worldFile,
    #autosave: _f$autosave,
    #multiWorld: _f$multiWorld,
    #maxPlayers: _f$maxPlayers,
    #description: _f$description,
    #guestPrefix: _f$guestPrefix,
    #whitelistEnabled: _f$whitelistEnabled,
    #accountRequired: _f$accountRequired,
    #apiEndpoint: _f$apiEndpoint,
    #endpointSecret: _f$endpointSecret,
  };

  static SetonixConfig _instantiate(DecodingData data) {
    return SetonixConfig(
        host: data.dec(_f$host),
        port: data.dec(_f$port),
        worldFile: data.dec(_f$worldFile),
        autosave: data.dec(_f$autosave),
        multiWorld: data.dec(_f$multiWorld),
        maxPlayers: data.dec(_f$maxPlayers),
        description: data.dec(_f$description),
        guestPrefix: data.dec(_f$guestPrefix),
        whitelistEnabled: data.dec(_f$whitelistEnabled),
        accountRequired: data.dec(_f$accountRequired),
        apiEndpoint: data.dec(_f$apiEndpoint),
        endpointSecret: data.dec(_f$endpointSecret));
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
      {String? host,
      int? port,
      String? worldFile,
      bool? autosave,
      bool? multiWorld,
      int? maxPlayers,
      String? description,
      String? guestPrefix,
      bool? whitelistEnabled,
      bool? accountRequired,
      String? apiEndpoint,
      String? endpointSecret});
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
          {Object? host = $none,
          Object? port = $none,
          Object? worldFile = $none,
          Object? autosave = $none,
          Object? multiWorld = $none,
          Object? maxPlayers = $none,
          Object? description = $none,
          Object? guestPrefix = $none,
          Object? whitelistEnabled = $none,
          Object? accountRequired = $none,
          Object? apiEndpoint = $none,
          Object? endpointSecret = $none}) =>
      $apply(FieldCopyWithData({
        if (host != $none) #host: host,
        if (port != $none) #port: port,
        if (worldFile != $none) #worldFile: worldFile,
        if (autosave != $none) #autosave: autosave,
        if (multiWorld != $none) #multiWorld: multiWorld,
        if (maxPlayers != $none) #maxPlayers: maxPlayers,
        if (description != $none) #description: description,
        if (guestPrefix != $none) #guestPrefix: guestPrefix,
        if (whitelistEnabled != $none) #whitelistEnabled: whitelistEnabled,
        if (accountRequired != $none) #accountRequired: accountRequired,
        if (apiEndpoint != $none) #apiEndpoint: apiEndpoint,
        if (endpointSecret != $none) #endpointSecret: endpointSecret
      }));
  @override
  SetonixConfig $make(CopyWithData data) => SetonixConfig(
      host: data.get(#host, or: $value.host),
      port: data.get(#port, or: $value.port),
      worldFile: data.get(#worldFile, or: $value.worldFile),
      autosave: data.get(#autosave, or: $value.autosave),
      multiWorld: data.get(#multiWorld, or: $value.multiWorld),
      maxPlayers: data.get(#maxPlayers, or: $value.maxPlayers),
      description: data.get(#description, or: $value.description),
      guestPrefix: data.get(#guestPrefix, or: $value.guestPrefix),
      whitelistEnabled:
          data.get(#whitelistEnabled, or: $value.whitelistEnabled),
      accountRequired: data.get(#accountRequired, or: $value.accountRequired),
      apiEndpoint: data.get(#apiEndpoint, or: $value.apiEndpoint),
      endpointSecret: data.get(#endpointSecret, or: $value.endpointSecret));

  @override
  SetonixConfigCopyWith<$R2, SetonixConfig, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SetonixConfigCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
