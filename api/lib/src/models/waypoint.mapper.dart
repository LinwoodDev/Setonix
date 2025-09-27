// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'waypoint.dart';

class WaypointMapper extends ClassMapperBase<Waypoint> {
  WaypointMapper._();

  static WaypointMapper? _instance;
  static WaypointMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WaypointMapper._());
      GlobalVectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Waypoint';

  static String _$name(Waypoint v) => v.name;
  static const Field<Waypoint, String> _f$name = Field('name', _$name);
  static GlobalVectorDefinition _$position(Waypoint v) => v.position;
  static const Field<Waypoint, GlobalVectorDefinition> _f$position = Field(
    'position',
    _$position,
  );

  @override
  final MappableFields<Waypoint> fields = const {
    #name: _f$name,
    #position: _f$position,
  };

  static Waypoint _instantiate(DecodingData data) {
    return Waypoint(name: data.dec(_f$name), position: data.dec(_f$position));
  }

  @override
  final Function instantiate = _instantiate;

  static Waypoint fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Waypoint>(map);
  }

  static Waypoint fromJson(String json) {
    return ensureInitialized().decodeJson<Waypoint>(json);
  }
}

mixin WaypointMappable {
  String toJson() {
    return WaypointMapper.ensureInitialized().encodeJson<Waypoint>(
      this as Waypoint,
    );
  }

  Map<String, dynamic> toMap() {
    return WaypointMapper.ensureInitialized().encodeMap<Waypoint>(
      this as Waypoint,
    );
  }

  WaypointCopyWith<Waypoint, Waypoint, Waypoint> get copyWith =>
      _WaypointCopyWithImpl<Waypoint, Waypoint>(
        this as Waypoint,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WaypointMapper.ensureInitialized().stringifyValue(this as Waypoint);
  }

  @override
  bool operator ==(Object other) {
    return WaypointMapper.ensureInitialized().equalsValue(
      this as Waypoint,
      other,
    );
  }

  @override
  int get hashCode {
    return WaypointMapper.ensureInitialized().hashValue(this as Waypoint);
  }
}

extension WaypointValueCopy<$R, $Out> on ObjectCopyWith<$R, Waypoint, $Out> {
  WaypointCopyWith<$R, Waypoint, $Out> get $asWaypoint =>
      $base.as((v, t, t2) => _WaypointCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WaypointCopyWith<$R, $In extends Waypoint, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get position;
  $R call({String? name, GlobalVectorDefinition? position});
  WaypointCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WaypointCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Waypoint, $Out>
    implements WaypointCopyWith<$R, Waypoint, $Out> {
  _WaypointCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Waypoint> $mapper =
      WaypointMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get position => $value.position.copyWith.$chain((v) => call(position: v));
  @override
  $R call({String? name, GlobalVectorDefinition? position}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (position != null) #position: position,
    }),
  );
  @override
  Waypoint $make(CopyWithData data) => Waypoint(
    name: data.get(#name, or: $value.name),
    position: data.get(#position, or: $value.position),
  );

  @override
  WaypointCopyWith<$R2, Waypoint, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WaypointCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

