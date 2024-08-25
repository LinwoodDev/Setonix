// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'state.dart';

class WorldOperationModeMapper extends EnumMapper<WorldOperationMode> {
  WorldOperationModeMapper._();

  static WorldOperationModeMapper? _instance;
  static WorldOperationModeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WorldOperationModeMapper._());
    }
    return _instance!;
  }

  static WorldOperationMode fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  WorldOperationMode decode(dynamic value) {
    switch (value) {
      case 'figures':
        return WorldOperationMode.figures;
      case 'boards':
        return WorldOperationMode.boards;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(WorldOperationMode self) {
    switch (self) {
      case WorldOperationMode.figures:
        return 'figures';
      case WorldOperationMode.boards:
        return 'boards';
    }
  }
}

extension WorldOperationModeMapperExtension on WorldOperationMode {
  String toValue() {
    WorldOperationModeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<WorldOperationMode>(this) as String;
  }
}

class WorldStateMapper extends ClassMapperBase<WorldState> {
  WorldStateMapper._();

  static WorldStateMapper? _instance;
  static WorldStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WorldStateMapper._());
      GameTableMapper.ensureInitialized();
      GameInfoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WorldState';

  static String? _$name(WorldState v) => v.name;
  static const Field<WorldState, String> _f$name =
      Field('name', _$name, opt: true);
  static GameTable _$table(WorldState v) => v.table;
  static const Field<WorldState, GameTable> _f$table =
      Field('table', _$table, opt: true, def: const GameTable());
  static String _$tableName(WorldState v) => v.tableName;
  static const Field<WorldState, String> _f$tableName =
      Field('tableName', _$tableName, opt: true, def: '');
  static GameInfo _$info(WorldState v) => v.info;
  static const Field<WorldState, GameInfo> _f$info =
      Field('info', _$info, opt: true, def: const GameInfo());
  static Map<String, Set<int>> _$teamMembers(WorldState v) => v.teamMembers;
  static const Field<WorldState, Map<String, Set<int>>> _f$teamMembers =
      Field('teamMembers', _$teamMembers, opt: true, def: const {});
  static int _$id(WorldState v) => v.id;
  static const Field<WorldState, int> _f$id =
      Field('id', _$id, opt: true, def: kAuthorityChannel);
  static QuokkaData _$data(WorldState v) => v.data;
  static const Field<WorldState, QuokkaData> _f$data = Field('data', _$data);

  @override
  final MappableFields<WorldState> fields = const {
    #name: _f$name,
    #table: _f$table,
    #tableName: _f$tableName,
    #info: _f$info,
    #teamMembers: _f$teamMembers,
    #id: _f$id,
    #data: _f$data,
  };

  static WorldState _instantiate(DecodingData data) {
    return WorldState(
        name: data.dec(_f$name),
        table: data.dec(_f$table),
        tableName: data.dec(_f$tableName),
        info: data.dec(_f$info),
        teamMembers: data.dec(_f$teamMembers),
        id: data.dec(_f$id),
        data: data.dec(_f$data));
  }

  @override
  final Function instantiate = _instantiate;

  static WorldState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WorldState>(map);
  }

  static WorldState fromJson(String json) {
    return ensureInitialized().decodeJson<WorldState>(json);
  }
}

mixin WorldStateMappable {
  String toJson() {
    return WorldStateMapper.ensureInitialized()
        .encodeJson<WorldState>(this as WorldState);
  }

  Map<String, dynamic> toMap() {
    return WorldStateMapper.ensureInitialized()
        .encodeMap<WorldState>(this as WorldState);
  }

  WorldStateCopyWith<WorldState, WorldState, WorldState> get copyWith =>
      _WorldStateCopyWithImpl(this as WorldState, $identity, $identity);
  @override
  String toString() {
    return WorldStateMapper.ensureInitialized()
        .stringifyValue(this as WorldState);
  }

  @override
  bool operator ==(Object other) {
    return WorldStateMapper.ensureInitialized()
        .equalsValue(this as WorldState, other);
  }

  @override
  int get hashCode {
    return WorldStateMapper.ensureInitialized().hashValue(this as WorldState);
  }
}

extension WorldStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WorldState, $Out> {
  WorldStateCopyWith<$R, WorldState, $Out> get $asWorldState =>
      $base.as((v, t, t2) => _WorldStateCopyWithImpl(v, t, t2));
}

abstract class WorldStateCopyWith<$R, $In extends WorldState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  GameTableCopyWith<$R, GameTable, GameTable> get table;
  GameInfoCopyWith<$R, GameInfo, GameInfo> get info;
  MapCopyWith<$R, String, Set<int>, ObjectCopyWith<$R, Set<int>, Set<int>>>
      get teamMembers;
  $R call(
      {String? name,
      GameTable? table,
      String? tableName,
      GameInfo? info,
      Map<String, Set<int>>? teamMembers,
      int? id,
      QuokkaData? data});
  WorldStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WorldStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WorldState, $Out>
    implements WorldStateCopyWith<$R, WorldState, $Out> {
  _WorldStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WorldState> $mapper =
      WorldStateMapper.ensureInitialized();
  @override
  GameTableCopyWith<$R, GameTable, GameTable> get table =>
      $value.table.copyWith.$chain((v) => call(table: v));
  @override
  GameInfoCopyWith<$R, GameInfo, GameInfo> get info =>
      $value.info.copyWith.$chain((v) => call(info: v));
  @override
  MapCopyWith<$R, String, Set<int>, ObjectCopyWith<$R, Set<int>, Set<int>>>
      get teamMembers => MapCopyWith(
          $value.teamMembers,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(teamMembers: v));
  @override
  $R call(
          {Object? name = $none,
          GameTable? table,
          String? tableName,
          GameInfo? info,
          Map<String, Set<int>>? teamMembers,
          int? id,
          QuokkaData? data}) =>
      $apply(FieldCopyWithData({
        if (name != $none) #name: name,
        if (table != null) #table: table,
        if (tableName != null) #tableName: tableName,
        if (info != null) #info: info,
        if (teamMembers != null) #teamMembers: teamMembers,
        if (id != null) #id: id,
        if (data != null) #data: data
      }));
  @override
  WorldState $make(CopyWithData data) => WorldState(
      name: data.get(#name, or: $value.name),
      table: data.get(#table, or: $value.table),
      tableName: data.get(#tableName, or: $value.tableName),
      info: data.get(#info, or: $value.info),
      teamMembers: data.get(#teamMembers, or: $value.teamMembers),
      id: data.get(#id, or: $value.id),
      data: data.get(#data, or: $value.data));

  @override
  WorldStateCopyWith<$R2, WorldState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WorldStateCopyWithImpl($value, $cast, t);
}
