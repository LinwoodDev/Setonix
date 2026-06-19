// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'event.dart';

/// @nodoc
class WorldEventMapper extends ClassMapperBase<WorldEvent> {
  WorldEventMapper._();

  static WorldEventMapper? _instance;
  static WorldEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WorldEventMapper._());
      PlayableWorldEventMapper.ensureInitialized();
      ClientWorldEventMapper.ensureInitialized();
      HybridWorldEventMapper.ensureInitialized();
      LocalWorldEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WorldEvent';

  @override
  final MappableFields<WorldEvent> fields = const {};

  static WorldEvent _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
      'WorldEvent',
      'type',
      '${data.value['type']}',
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WorldEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WorldEvent>(map);
  }

  static WorldEvent fromJson(String json) {
    return ensureInitialized().decodeJson<WorldEvent>(json);
  }
}

/// @nodoc
mixin WorldEventMappable {
  String toJson();
  Map<String, dynamic> toMap();
  WorldEventCopyWith<WorldEvent, WorldEvent, WorldEvent> get copyWith;
}

/// @nodoc
abstract class WorldEventCopyWith<$R, $In extends WorldEvent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  WorldEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class PlayableWorldEventMapper extends SubClassMapperBase<PlayableWorldEvent> {
  PlayableWorldEventMapper._();

  static PlayableWorldEventMapper? _instance;
  static PlayableWorldEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlayableWorldEventMapper._());
      WorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      ServerWorldEventMapper.ensureInitialized();
      LocalWorldEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PlayableWorldEvent';

  @override
  final MappableFields<PlayableWorldEvent> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'PlayableWorldEvent';
  @override
  late final ClassMapperBase superMapper = WorldEventMapper.ensureInitialized();

  static PlayableWorldEvent _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
      'PlayableWorldEvent',
      'type',
      '${data.value['type']}',
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PlayableWorldEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PlayableWorldEvent>(map);
  }

  static PlayableWorldEvent fromJson(String json) {
    return ensureInitialized().decodeJson<PlayableWorldEvent>(json);
  }
}

/// @nodoc
mixin PlayableWorldEventMappable {
  String toJson();
  Map<String, dynamic> toMap();
  PlayableWorldEventCopyWith<
    PlayableWorldEvent,
    PlayableWorldEvent,
    PlayableWorldEvent
  >
  get copyWith;
}

/// @nodoc
abstract class PlayableWorldEventCopyWith<
  $R,
  $In extends PlayableWorldEvent,
  $Out
>
    implements WorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  PlayableWorldEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class ServerWorldEventMapper extends SubClassMapperBase<ServerWorldEvent> {
  ServerWorldEventMapper._();

  static ServerWorldEventMapper? _instance;
  static ServerWorldEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServerWorldEventMapper._());
      PlayableWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      WorldInitializedMapper.ensureInitialized();
      TeamJoinedMapper.ensureInitialized();
      TeamLeftMapper.ensureInitialized();
      ObjectsChangedMapper.ensureInitialized();
      CellShuffledMapper.ensureInitialized();
      MessageSentMapper.ensureInitialized();
      BoardTilesSpawnedMapper.ensureInitialized();
      BoardTilesChangedMapper.ensureInitialized();
      DialogOpenedMapper.ensureInitialized();
      DialogsClosedMapper.ensureInitialized();
      ImagesUpdatedMapper.ensureInitialized();
      ServerStateUpdatedMapper.ensureInitialized();
      AuthenticatedRequestedMapper.ensureInitialized();
      ToolbarUpdatedMapper.ensureInitialized();
      HybridWorldEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ServerWorldEvent';

  @override
  final MappableFields<ServerWorldEvent> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ServerWorldEvent';
  @override
  late final ClassMapperBase superMapper =
      PlayableWorldEventMapper.ensureInitialized();

  static ServerWorldEvent _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
      'ServerWorldEvent',
      'type',
      '${data.value['type']}',
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ServerWorldEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServerWorldEvent>(map);
  }

  static ServerWorldEvent fromJson(String json) {
    return ensureInitialized().decodeJson<ServerWorldEvent>(json);
  }
}

/// @nodoc
mixin ServerWorldEventMappable {
  String toJson();
  Map<String, dynamic> toMap();
  ServerWorldEventCopyWith<ServerWorldEvent, ServerWorldEvent, ServerWorldEvent>
  get copyWith;
}

/// @nodoc
abstract class ServerWorldEventCopyWith<$R, $In extends ServerWorldEvent, $Out>
    implements PlayableWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  ServerWorldEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class WorldInitializedMapper extends SubClassMapperBase<WorldInitialized> {
  WorldInitializedMapper._();

  static WorldInitializedMapper? _instance;
  static WorldInitializedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WorldInitializedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GameTableMapper.ensureInitialized();
      GameInfoMapper.ensureInitialized();
      SignatureMetadataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WorldInitialized';

  static GameTable? _$table(WorldInitialized v) => v.table;
  static const Field<WorldInitialized, GameTable> _f$table = Field(
    'table',
    _$table,
    opt: true,
  );
  static GameInfo? _$info(WorldInitialized v) => v.info;
  static const Field<WorldInitialized, GameInfo> _f$info = Field(
    'info',
    _$info,
    opt: true,
  );
  static Map<String, Set<int>>? _$teamMembers(WorldInitialized v) =>
      v.teamMembers;
  static const Field<WorldInitialized, Map<String, Set<int>>> _f$teamMembers =
      Field('teamMembers', _$teamMembers, opt: true);
  static int? _$id(WorldInitialized v) => v.id;
  static const Field<WorldInitialized, int> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static List<SignatureMetadata>? _$packsSignature(WorldInitialized v) =>
      v.packsSignature;
  static const Field<WorldInitialized, List<SignatureMetadata>>
  _f$packsSignature = Field('packsSignature', _$packsSignature, opt: true);
  static bool _$clearUserInterface(WorldInitialized v) => v.clearUserInterface;
  static const Field<WorldInitialized, bool> _f$clearUserInterface = Field(
    'clearUserInterface',
    _$clearUserInterface,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<WorldInitialized> fields = const {
    #table: _f$table,
    #info: _f$info,
    #teamMembers: _f$teamMembers,
    #id: _f$id,
    #packsSignature: _f$packsSignature,
    #clearUserInterface: _f$clearUserInterface,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'WorldInitialized';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static WorldInitialized _instantiate(DecodingData data) {
    return WorldInitialized(
      table: data.dec(_f$table),
      info: data.dec(_f$info),
      teamMembers: data.dec(_f$teamMembers),
      id: data.dec(_f$id),
      packsSignature: data.dec(_f$packsSignature),
      clearUserInterface: data.dec(_f$clearUserInterface),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WorldInitialized fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WorldInitialized>(map);
  }

  static WorldInitialized fromJson(String json) {
    return ensureInitialized().decodeJson<WorldInitialized>(json);
  }
}

/// @nodoc
mixin WorldInitializedMappable {
  String toJson() {
    return WorldInitializedMapper.ensureInitialized()
        .encodeJson<WorldInitialized>(this as WorldInitialized);
  }

  Map<String, dynamic> toMap() {
    return WorldInitializedMapper.ensureInitialized()
        .encodeMap<WorldInitialized>(this as WorldInitialized);
  }

  WorldInitializedCopyWith<WorldInitialized, WorldInitialized, WorldInitialized>
  get copyWith =>
      _WorldInitializedCopyWithImpl<WorldInitialized, WorldInitialized>(
        this as WorldInitialized,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WorldInitializedMapper.ensureInitialized().stringifyValue(
      this as WorldInitialized,
    );
  }

  @override
  bool operator ==(Object other) {
    return WorldInitializedMapper.ensureInitialized().equalsValue(
      this as WorldInitialized,
      other,
    );
  }

  @override
  int get hashCode {
    return WorldInitializedMapper.ensureInitialized().hashValue(
      this as WorldInitialized,
    );
  }
}

/// @nodoc
extension WorldInitializedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WorldInitialized, $Out> {
  WorldInitializedCopyWith<$R, WorldInitialized, $Out>
  get $asWorldInitialized =>
      $base.as((v, t, t2) => _WorldInitializedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class WorldInitializedCopyWith<$R, $In extends WorldInitialized, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  GameTableCopyWith<$R, GameTable, GameTable>? get table;
  GameInfoCopyWith<$R, GameInfo, GameInfo>? get info;
  MapCopyWith<$R, String, Set<int>, ObjectCopyWith<$R, Set<int>, Set<int>>>?
  get teamMembers;
  ListCopyWith<
    $R,
    SignatureMetadata,
    SignatureMetadataCopyWith<$R, SignatureMetadata, SignatureMetadata>
  >?
  get packsSignature;
  @override
  $R call({
    GameTable? table,
    GameInfo? info,
    Map<String, Set<int>>? teamMembers,
    int? id,
    List<SignatureMetadata>? packsSignature,
    bool? clearUserInterface,
  });
  WorldInitializedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _WorldInitializedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WorldInitialized, $Out>
    implements WorldInitializedCopyWith<$R, WorldInitialized, $Out> {
  _WorldInitializedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WorldInitialized> $mapper =
      WorldInitializedMapper.ensureInitialized();
  @override
  GameTableCopyWith<$R, GameTable, GameTable>? get table =>
      $value.table?.copyWith.$chain((v) => call(table: v));
  @override
  GameInfoCopyWith<$R, GameInfo, GameInfo>? get info =>
      $value.info?.copyWith.$chain((v) => call(info: v));
  @override
  MapCopyWith<$R, String, Set<int>, ObjectCopyWith<$R, Set<int>, Set<int>>>?
  get teamMembers => $value.teamMembers != null
      ? MapCopyWith(
          $value.teamMembers!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(teamMembers: v),
        )
      : null;
  @override
  ListCopyWith<
    $R,
    SignatureMetadata,
    SignatureMetadataCopyWith<$R, SignatureMetadata, SignatureMetadata>
  >?
  get packsSignature => $value.packsSignature != null
      ? ListCopyWith(
          $value.packsSignature!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(packsSignature: v),
        )
      : null;
  @override
  $R call({
    Object? table = $none,
    Object? info = $none,
    Object? teamMembers = $none,
    Object? id = $none,
    Object? packsSignature = $none,
    bool? clearUserInterface,
  }) => $apply(
    FieldCopyWithData({
      if (table != $none) #table: table,
      if (info != $none) #info: info,
      if (teamMembers != $none) #teamMembers: teamMembers,
      if (id != $none) #id: id,
      if (packsSignature != $none) #packsSignature: packsSignature,
      if (clearUserInterface != null) #clearUserInterface: clearUserInterface,
    }),
  );
  @override
  WorldInitialized $make(CopyWithData data) => WorldInitialized(
    table: data.get(#table, or: $value.table),
    info: data.get(#info, or: $value.info),
    teamMembers: data.get(#teamMembers, or: $value.teamMembers),
    id: data.get(#id, or: $value.id),
    packsSignature: data.get(#packsSignature, or: $value.packsSignature),
    clearUserInterface: data.get(
      #clearUserInterface,
      or: $value.clearUserInterface,
    ),
  );

  @override
  WorldInitializedCopyWith<$R2, WorldInitialized, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WorldInitializedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class TeamJoinedMapper extends SubClassMapperBase<TeamJoined> {
  TeamJoinedMapper._();

  static TeamJoinedMapper? _instance;
  static TeamJoinedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TeamJoinedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'TeamJoined';

  static int _$user(TeamJoined v) => v.user;
  static const Field<TeamJoined, int> _f$user = Field('user', _$user);
  static String _$team(TeamJoined v) => v.team;
  static const Field<TeamJoined, String> _f$team = Field('team', _$team);

  @override
  final MappableFields<TeamJoined> fields = const {
    #user: _f$user,
    #team: _f$team,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TeamJoined';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static TeamJoined _instantiate(DecodingData data) {
    return TeamJoined(data.dec(_f$user), data.dec(_f$team));
  }

  @override
  final Function instantiate = _instantiate;

  static TeamJoined fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TeamJoined>(map);
  }

  static TeamJoined fromJson(String json) {
    return ensureInitialized().decodeJson<TeamJoined>(json);
  }
}

/// @nodoc
mixin TeamJoinedMappable {
  String toJson() {
    return TeamJoinedMapper.ensureInitialized().encodeJson<TeamJoined>(
      this as TeamJoined,
    );
  }

  Map<String, dynamic> toMap() {
    return TeamJoinedMapper.ensureInitialized().encodeMap<TeamJoined>(
      this as TeamJoined,
    );
  }

  TeamJoinedCopyWith<TeamJoined, TeamJoined, TeamJoined> get copyWith =>
      _TeamJoinedCopyWithImpl<TeamJoined, TeamJoined>(
        this as TeamJoined,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TeamJoinedMapper.ensureInitialized().stringifyValue(
      this as TeamJoined,
    );
  }

  @override
  bool operator ==(Object other) {
    return TeamJoinedMapper.ensureInitialized().equalsValue(
      this as TeamJoined,
      other,
    );
  }

  @override
  int get hashCode {
    return TeamJoinedMapper.ensureInitialized().hashValue(this as TeamJoined);
  }
}

/// @nodoc
extension TeamJoinedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TeamJoined, $Out> {
  TeamJoinedCopyWith<$R, TeamJoined, $Out> get $asTeamJoined =>
      $base.as((v, t, t2) => _TeamJoinedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class TeamJoinedCopyWith<$R, $In extends TeamJoined, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({int? user, String? team});
  TeamJoinedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _TeamJoinedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TeamJoined, $Out>
    implements TeamJoinedCopyWith<$R, TeamJoined, $Out> {
  _TeamJoinedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TeamJoined> $mapper =
      TeamJoinedMapper.ensureInitialized();
  @override
  $R call({int? user, String? team}) => $apply(
    FieldCopyWithData({
      if (user != null) #user: user,
      if (team != null) #team: team,
    }),
  );
  @override
  TeamJoined $make(CopyWithData data) => TeamJoined(
    data.get(#user, or: $value.user),
    data.get(#team, or: $value.team),
  );

  @override
  TeamJoinedCopyWith<$R2, TeamJoined, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TeamJoinedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class TeamLeftMapper extends SubClassMapperBase<TeamLeft> {
  TeamLeftMapper._();

  static TeamLeftMapper? _instance;
  static TeamLeftMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TeamLeftMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'TeamLeft';

  static int _$user(TeamLeft v) => v.user;
  static const Field<TeamLeft, int> _f$user = Field('user', _$user);
  static String _$team(TeamLeft v) => v.team;
  static const Field<TeamLeft, String> _f$team = Field('team', _$team);

  @override
  final MappableFields<TeamLeft> fields = const {
    #user: _f$user,
    #team: _f$team,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TeamLeft';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static TeamLeft _instantiate(DecodingData data) {
    return TeamLeft(data.dec(_f$user), data.dec(_f$team));
  }

  @override
  final Function instantiate = _instantiate;

  static TeamLeft fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TeamLeft>(map);
  }

  static TeamLeft fromJson(String json) {
    return ensureInitialized().decodeJson<TeamLeft>(json);
  }
}

/// @nodoc
mixin TeamLeftMappable {
  String toJson() {
    return TeamLeftMapper.ensureInitialized().encodeJson<TeamLeft>(
      this as TeamLeft,
    );
  }

  Map<String, dynamic> toMap() {
    return TeamLeftMapper.ensureInitialized().encodeMap<TeamLeft>(
      this as TeamLeft,
    );
  }

  TeamLeftCopyWith<TeamLeft, TeamLeft, TeamLeft> get copyWith =>
      _TeamLeftCopyWithImpl<TeamLeft, TeamLeft>(
        this as TeamLeft,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TeamLeftMapper.ensureInitialized().stringifyValue(this as TeamLeft);
  }

  @override
  bool operator ==(Object other) {
    return TeamLeftMapper.ensureInitialized().equalsValue(
      this as TeamLeft,
      other,
    );
  }

  @override
  int get hashCode {
    return TeamLeftMapper.ensureInitialized().hashValue(this as TeamLeft);
  }
}

/// @nodoc
extension TeamLeftValueCopy<$R, $Out> on ObjectCopyWith<$R, TeamLeft, $Out> {
  TeamLeftCopyWith<$R, TeamLeft, $Out> get $asTeamLeft =>
      $base.as((v, t, t2) => _TeamLeftCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class TeamLeftCopyWith<$R, $In extends TeamLeft, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({int? user, String? team});
  TeamLeftCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _TeamLeftCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TeamLeft, $Out>
    implements TeamLeftCopyWith<$R, TeamLeft, $Out> {
  _TeamLeftCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TeamLeft> $mapper =
      TeamLeftMapper.ensureInitialized();
  @override
  $R call({int? user, String? team}) => $apply(
    FieldCopyWithData({
      if (user != null) #user: user,
      if (team != null) #team: team,
    }),
  );
  @override
  TeamLeft $make(CopyWithData data) => TeamLeft(
    data.get(#user, or: $value.user),
    data.get(#team, or: $value.team),
  );

  @override
  TeamLeftCopyWith<$R2, TeamLeft, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TeamLeftCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class ObjectsChangedMapper extends SubClassMapperBase<ObjectsChanged> {
  ObjectsChangedMapper._();

  static ObjectsChangedMapper? _instance;
  static ObjectsChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectsChangedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GlobalVectorDefinitionMapper.ensureInitialized();
      GameObjectMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectsChanged';

  static GlobalVectorDefinition _$cell(ObjectsChanged v) => v.cell;
  static const Field<ObjectsChanged, GlobalVectorDefinition> _f$cell = Field(
    'cell',
    _$cell,
  );
  static List<GameObject> _$objects(ObjectsChanged v) => v.objects;
  static const Field<ObjectsChanged, List<GameObject>> _f$objects = Field(
    'objects',
    _$objects,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<ObjectsChanged> fields = const {
    #cell: _f$cell,
    #objects: _f$objects,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ObjectsChanged';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static ObjectsChanged _instantiate(DecodingData data) {
    return ObjectsChanged(data.dec(_f$cell), data.dec(_f$objects));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectsChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectsChanged>(map);
  }

  static ObjectsChanged fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectsChanged>(json);
  }
}

/// @nodoc
mixin ObjectsChangedMappable {
  String toJson() {
    return ObjectsChangedMapper.ensureInitialized().encodeJson<ObjectsChanged>(
      this as ObjectsChanged,
    );
  }

  Map<String, dynamic> toMap() {
    return ObjectsChangedMapper.ensureInitialized().encodeMap<ObjectsChanged>(
      this as ObjectsChanged,
    );
  }

  ObjectsChangedCopyWith<ObjectsChanged, ObjectsChanged, ObjectsChanged>
  get copyWith => _ObjectsChangedCopyWithImpl<ObjectsChanged, ObjectsChanged>(
    this as ObjectsChanged,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ObjectsChangedMapper.ensureInitialized().stringifyValue(
      this as ObjectsChanged,
    );
  }

  @override
  bool operator ==(Object other) {
    return ObjectsChangedMapper.ensureInitialized().equalsValue(
      this as ObjectsChanged,
      other,
    );
  }

  @override
  int get hashCode {
    return ObjectsChangedMapper.ensureInitialized().hashValue(
      this as ObjectsChanged,
    );
  }
}

/// @nodoc
extension ObjectsChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectsChanged, $Out> {
  ObjectsChangedCopyWith<$R, ObjectsChanged, $Out> get $asObjectsChanged =>
      $base.as((v, t, t2) => _ObjectsChangedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class ObjectsChangedCopyWith<$R, $In extends ObjectsChanged, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get cell;
  ListCopyWith<$R, GameObject, GameObjectCopyWith<$R, GameObject, GameObject>>
  get objects;
  @override
  $R call({GlobalVectorDefinition? cell, List<GameObject>? objects});
  ObjectsChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _ObjectsChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectsChanged, $Out>
    implements ObjectsChangedCopyWith<$R, ObjectsChanged, $Out> {
  _ObjectsChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectsChanged> $mapper =
      ObjectsChangedMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get cell => $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  ListCopyWith<$R, GameObject, GameObjectCopyWith<$R, GameObject, GameObject>>
  get objects => ListCopyWith(
    $value.objects,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(objects: v),
  );
  @override
  $R call({GlobalVectorDefinition? cell, List<GameObject>? objects}) => $apply(
    FieldCopyWithData({
      if (cell != null) #cell: cell,
      if (objects != null) #objects: objects,
    }),
  );
  @override
  ObjectsChanged $make(CopyWithData data) => ObjectsChanged(
    data.get(#cell, or: $value.cell),
    data.get(#objects, or: $value.objects),
  );

  @override
  ObjectsChangedCopyWith<$R2, ObjectsChanged, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ObjectsChangedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class CellShuffledMapper extends SubClassMapperBase<CellShuffled> {
  CellShuffledMapper._();

  static CellShuffledMapper? _instance;
  static CellShuffledMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CellShuffledMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GlobalVectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CellShuffled';

  static GlobalVectorDefinition _$cell(CellShuffled v) => v.cell;
  static const Field<CellShuffled, GlobalVectorDefinition> _f$cell = Field(
    'cell',
    _$cell,
  );
  static List<int> _$positions(CellShuffled v) => v.positions;
  static const Field<CellShuffled, List<int>> _f$positions = Field(
    'positions',
    _$positions,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<CellShuffled> fields = const {
    #cell: _f$cell,
    #positions: _f$positions,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'CellShuffled';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static CellShuffled _instantiate(DecodingData data) {
    return CellShuffled(data.dec(_f$cell), data.dec(_f$positions));
  }

  @override
  final Function instantiate = _instantiate;

  static CellShuffled fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CellShuffled>(map);
  }

  static CellShuffled fromJson(String json) {
    return ensureInitialized().decodeJson<CellShuffled>(json);
  }
}

/// @nodoc
mixin CellShuffledMappable {
  String toJson() {
    return CellShuffledMapper.ensureInitialized().encodeJson<CellShuffled>(
      this as CellShuffled,
    );
  }

  Map<String, dynamic> toMap() {
    return CellShuffledMapper.ensureInitialized().encodeMap<CellShuffled>(
      this as CellShuffled,
    );
  }

  CellShuffledCopyWith<CellShuffled, CellShuffled, CellShuffled> get copyWith =>
      _CellShuffledCopyWithImpl<CellShuffled, CellShuffled>(
        this as CellShuffled,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CellShuffledMapper.ensureInitialized().stringifyValue(
      this as CellShuffled,
    );
  }

  @override
  bool operator ==(Object other) {
    return CellShuffledMapper.ensureInitialized().equalsValue(
      this as CellShuffled,
      other,
    );
  }

  @override
  int get hashCode {
    return CellShuffledMapper.ensureInitialized().hashValue(
      this as CellShuffled,
    );
  }
}

/// @nodoc
extension CellShuffledValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CellShuffled, $Out> {
  CellShuffledCopyWith<$R, CellShuffled, $Out> get $asCellShuffled =>
      $base.as((v, t, t2) => _CellShuffledCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class CellShuffledCopyWith<$R, $In extends CellShuffled, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get cell;
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get positions;
  @override
  $R call({GlobalVectorDefinition? cell, List<int>? positions});
  CellShuffledCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _CellShuffledCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CellShuffled, $Out>
    implements CellShuffledCopyWith<$R, CellShuffled, $Out> {
  _CellShuffledCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CellShuffled> $mapper =
      CellShuffledMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get cell => $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get positions =>
      ListCopyWith(
        $value.positions,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(positions: v),
      );
  @override
  $R call({GlobalVectorDefinition? cell, List<int>? positions}) => $apply(
    FieldCopyWithData({
      if (cell != null) #cell: cell,
      if (positions != null) #positions: positions,
    }),
  );
  @override
  CellShuffled $make(CopyWithData data) => CellShuffled(
    data.get(#cell, or: $value.cell),
    data.get(#positions, or: $value.positions),
  );

  @override
  CellShuffledCopyWith<$R2, CellShuffled, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CellShuffledCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class MessageSentMapper extends SubClassMapperBase<MessageSent> {
  MessageSentMapper._();

  static MessageSentMapper? _instance;
  static MessageSentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MessageSentMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'MessageSent';

  static int _$user(MessageSent v) => v.user;
  static const Field<MessageSent, int> _f$user = Field('user', _$user);
  static String _$message(MessageSent v) => v.message;
  static const Field<MessageSent, String> _f$message = Field(
    'message',
    _$message,
  );

  @override
  final MappableFields<MessageSent> fields = const {
    #user: _f$user,
    #message: _f$message,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'MessageSent';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static MessageSent _instantiate(DecodingData data) {
    return MessageSent(data.dec(_f$user), data.dec(_f$message));
  }

  @override
  final Function instantiate = _instantiate;

  static MessageSent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MessageSent>(map);
  }

  static MessageSent fromJson(String json) {
    return ensureInitialized().decodeJson<MessageSent>(json);
  }
}

/// @nodoc
mixin MessageSentMappable {
  String toJson() {
    return MessageSentMapper.ensureInitialized().encodeJson<MessageSent>(
      this as MessageSent,
    );
  }

  Map<String, dynamic> toMap() {
    return MessageSentMapper.ensureInitialized().encodeMap<MessageSent>(
      this as MessageSent,
    );
  }

  MessageSentCopyWith<MessageSent, MessageSent, MessageSent> get copyWith =>
      _MessageSentCopyWithImpl<MessageSent, MessageSent>(
        this as MessageSent,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MessageSentMapper.ensureInitialized().stringifyValue(
      this as MessageSent,
    );
  }

  @override
  bool operator ==(Object other) {
    return MessageSentMapper.ensureInitialized().equalsValue(
      this as MessageSent,
      other,
    );
  }

  @override
  int get hashCode {
    return MessageSentMapper.ensureInitialized().hashValue(this as MessageSent);
  }
}

/// @nodoc
extension MessageSentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MessageSent, $Out> {
  MessageSentCopyWith<$R, MessageSent, $Out> get $asMessageSent =>
      $base.as((v, t, t2) => _MessageSentCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class MessageSentCopyWith<$R, $In extends MessageSent, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({int? user, String? message});
  MessageSentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _MessageSentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MessageSent, $Out>
    implements MessageSentCopyWith<$R, MessageSent, $Out> {
  _MessageSentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MessageSent> $mapper =
      MessageSentMapper.ensureInitialized();
  @override
  $R call({int? user, String? message}) => $apply(
    FieldCopyWithData({
      if (user != null) #user: user,
      if (message != null) #message: message,
    }),
  );
  @override
  MessageSent $make(CopyWithData data) => MessageSent(
    data.get(#user, or: $value.user),
    data.get(#message, or: $value.message),
  );

  @override
  MessageSentCopyWith<$R2, MessageSent, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MessageSentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class BoardTilesSpawnedMapper extends SubClassMapperBase<BoardTilesSpawned> {
  BoardTilesSpawnedMapper._();

  static BoardTilesSpawnedMapper? _instance;
  static BoardTilesSpawnedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoardTilesSpawnedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      VectorDefinitionMapper.ensureInitialized();
      BoardTileMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoardTilesSpawned';

  static String _$table(BoardTilesSpawned v) => v.table;
  static const Field<BoardTilesSpawned, String> _f$table = Field(
    'table',
    _$table,
  );
  static Map<VectorDefinition, List<BoardTile>> _$tiles(BoardTilesSpawned v) =>
      v.tiles;
  static const Field<BoardTilesSpawned, Map<VectorDefinition, List<BoardTile>>>
  _f$tiles = Field('tiles', _$tiles, opt: true, def: const {});

  @override
  final MappableFields<BoardTilesSpawned> fields = const {
    #table: _f$table,
    #tiles: _f$tiles,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'BoardTilesSpawned';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static BoardTilesSpawned _instantiate(DecodingData data) {
    return BoardTilesSpawned(data.dec(_f$table), data.dec(_f$tiles));
  }

  @override
  final Function instantiate = _instantiate;

  static BoardTilesSpawned fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoardTilesSpawned>(map);
  }

  static BoardTilesSpawned fromJson(String json) {
    return ensureInitialized().decodeJson<BoardTilesSpawned>(json);
  }
}

/// @nodoc
mixin BoardTilesSpawnedMappable {
  String toJson() {
    return BoardTilesSpawnedMapper.ensureInitialized()
        .encodeJson<BoardTilesSpawned>(this as BoardTilesSpawned);
  }

  Map<String, dynamic> toMap() {
    return BoardTilesSpawnedMapper.ensureInitialized()
        .encodeMap<BoardTilesSpawned>(this as BoardTilesSpawned);
  }

  BoardTilesSpawnedCopyWith<
    BoardTilesSpawned,
    BoardTilesSpawned,
    BoardTilesSpawned
  >
  get copyWith =>
      _BoardTilesSpawnedCopyWithImpl<BoardTilesSpawned, BoardTilesSpawned>(
        this as BoardTilesSpawned,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BoardTilesSpawnedMapper.ensureInitialized().stringifyValue(
      this as BoardTilesSpawned,
    );
  }

  @override
  bool operator ==(Object other) {
    return BoardTilesSpawnedMapper.ensureInitialized().equalsValue(
      this as BoardTilesSpawned,
      other,
    );
  }

  @override
  int get hashCode {
    return BoardTilesSpawnedMapper.ensureInitialized().hashValue(
      this as BoardTilesSpawned,
    );
  }
}

/// @nodoc
extension BoardTilesSpawnedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoardTilesSpawned, $Out> {
  BoardTilesSpawnedCopyWith<$R, BoardTilesSpawned, $Out>
  get $asBoardTilesSpawned => $base.as(
    (v, t, t2) => _BoardTilesSpawnedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class BoardTilesSpawnedCopyWith<
  $R,
  $In extends BoardTilesSpawned,
  $Out
>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  MapCopyWith<
    $R,
    VectorDefinition,
    List<BoardTile>,
    ObjectCopyWith<$R, List<BoardTile>, List<BoardTile>>
  >
  get tiles;
  @override
  $R call({String? table, Map<VectorDefinition, List<BoardTile>>? tiles});
  BoardTilesSpawnedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _BoardTilesSpawnedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoardTilesSpawned, $Out>
    implements BoardTilesSpawnedCopyWith<$R, BoardTilesSpawned, $Out> {
  _BoardTilesSpawnedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoardTilesSpawned> $mapper =
      BoardTilesSpawnedMapper.ensureInitialized();
  @override
  MapCopyWith<
    $R,
    VectorDefinition,
    List<BoardTile>,
    ObjectCopyWith<$R, List<BoardTile>, List<BoardTile>>
  >
  get tiles => MapCopyWith(
    $value.tiles,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(tiles: v),
  );
  @override
  $R call({String? table, Map<VectorDefinition, List<BoardTile>>? tiles}) =>
      $apply(
        FieldCopyWithData({
          if (table != null) #table: table,
          if (tiles != null) #tiles: tiles,
        }),
      );
  @override
  BoardTilesSpawned $make(CopyWithData data) => BoardTilesSpawned(
    data.get(#table, or: $value.table),
    data.get(#tiles, or: $value.tiles),
  );

  @override
  BoardTilesSpawnedCopyWith<$R2, BoardTilesSpawned, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BoardTilesSpawnedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class BoardTilesChangedMapper extends SubClassMapperBase<BoardTilesChanged> {
  BoardTilesChangedMapper._();

  static BoardTilesChangedMapper? _instance;
  static BoardTilesChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoardTilesChangedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      VectorDefinitionMapper.ensureInitialized();
      BoardTileMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoardTilesChanged';

  static String _$table(BoardTilesChanged v) => v.table;
  static const Field<BoardTilesChanged, String> _f$table = Field(
    'table',
    _$table,
  );
  static Map<VectorDefinition, List<BoardTile>> _$tiles(BoardTilesChanged v) =>
      v.tiles;
  static const Field<BoardTilesChanged, Map<VectorDefinition, List<BoardTile>>>
  _f$tiles = Field('tiles', _$tiles, opt: true, def: const {});

  @override
  final MappableFields<BoardTilesChanged> fields = const {
    #table: _f$table,
    #tiles: _f$tiles,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'BoardTilesChanged';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static BoardTilesChanged _instantiate(DecodingData data) {
    return BoardTilesChanged(data.dec(_f$table), data.dec(_f$tiles));
  }

  @override
  final Function instantiate = _instantiate;

  static BoardTilesChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoardTilesChanged>(map);
  }

  static BoardTilesChanged fromJson(String json) {
    return ensureInitialized().decodeJson<BoardTilesChanged>(json);
  }
}

/// @nodoc
mixin BoardTilesChangedMappable {
  String toJson() {
    return BoardTilesChangedMapper.ensureInitialized()
        .encodeJson<BoardTilesChanged>(this as BoardTilesChanged);
  }

  Map<String, dynamic> toMap() {
    return BoardTilesChangedMapper.ensureInitialized()
        .encodeMap<BoardTilesChanged>(this as BoardTilesChanged);
  }

  BoardTilesChangedCopyWith<
    BoardTilesChanged,
    BoardTilesChanged,
    BoardTilesChanged
  >
  get copyWith =>
      _BoardTilesChangedCopyWithImpl<BoardTilesChanged, BoardTilesChanged>(
        this as BoardTilesChanged,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BoardTilesChangedMapper.ensureInitialized().stringifyValue(
      this as BoardTilesChanged,
    );
  }

  @override
  bool operator ==(Object other) {
    return BoardTilesChangedMapper.ensureInitialized().equalsValue(
      this as BoardTilesChanged,
      other,
    );
  }

  @override
  int get hashCode {
    return BoardTilesChangedMapper.ensureInitialized().hashValue(
      this as BoardTilesChanged,
    );
  }
}

/// @nodoc
extension BoardTilesChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoardTilesChanged, $Out> {
  BoardTilesChangedCopyWith<$R, BoardTilesChanged, $Out>
  get $asBoardTilesChanged => $base.as(
    (v, t, t2) => _BoardTilesChangedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class BoardTilesChangedCopyWith<
  $R,
  $In extends BoardTilesChanged,
  $Out
>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  MapCopyWith<
    $R,
    VectorDefinition,
    List<BoardTile>,
    ObjectCopyWith<$R, List<BoardTile>, List<BoardTile>>
  >
  get tiles;
  @override
  $R call({String? table, Map<VectorDefinition, List<BoardTile>>? tiles});
  BoardTilesChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _BoardTilesChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoardTilesChanged, $Out>
    implements BoardTilesChangedCopyWith<$R, BoardTilesChanged, $Out> {
  _BoardTilesChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoardTilesChanged> $mapper =
      BoardTilesChangedMapper.ensureInitialized();
  @override
  MapCopyWith<
    $R,
    VectorDefinition,
    List<BoardTile>,
    ObjectCopyWith<$R, List<BoardTile>, List<BoardTile>>
  >
  get tiles => MapCopyWith(
    $value.tiles,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(tiles: v),
  );
  @override
  $R call({String? table, Map<VectorDefinition, List<BoardTile>>? tiles}) =>
      $apply(
        FieldCopyWithData({
          if (table != null) #table: table,
          if (tiles != null) #tiles: tiles,
        }),
      );
  @override
  BoardTilesChanged $make(CopyWithData data) => BoardTilesChanged(
    data.get(#table, or: $value.table),
    data.get(#tiles, or: $value.tiles),
  );

  @override
  BoardTilesChangedCopyWith<$R2, BoardTilesChanged, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BoardTilesChangedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class DialogOpenedMapper extends SubClassMapperBase<DialogOpened> {
  DialogOpenedMapper._();

  static DialogOpenedMapper? _instance;
  static DialogOpenedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DialogOpenedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GameDialogMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DialogOpened';

  static GameDialog _$dialog(DialogOpened v) => v.dialog;
  static const Field<DialogOpened, GameDialog> _f$dialog = Field(
    'dialog',
    _$dialog,
  );
  static bool _$closeOthers(DialogOpened v) => v.closeOthers;
  static const Field<DialogOpened, bool> _f$closeOthers = Field(
    'closeOthers',
    _$closeOthers,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<DialogOpened> fields = const {
    #dialog: _f$dialog,
    #closeOthers: _f$closeOthers,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'DialogOpened';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static DialogOpened _instantiate(DecodingData data) {
    return DialogOpened(
      data.dec(_f$dialog),
      closeOthers: data.dec(_f$closeOthers),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DialogOpened fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DialogOpened>(map);
  }

  static DialogOpened fromJson(String json) {
    return ensureInitialized().decodeJson<DialogOpened>(json);
  }
}

/// @nodoc
mixin DialogOpenedMappable {
  String toJson() {
    return DialogOpenedMapper.ensureInitialized().encodeJson<DialogOpened>(
      this as DialogOpened,
    );
  }

  Map<String, dynamic> toMap() {
    return DialogOpenedMapper.ensureInitialized().encodeMap<DialogOpened>(
      this as DialogOpened,
    );
  }

  DialogOpenedCopyWith<DialogOpened, DialogOpened, DialogOpened> get copyWith =>
      _DialogOpenedCopyWithImpl<DialogOpened, DialogOpened>(
        this as DialogOpened,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DialogOpenedMapper.ensureInitialized().stringifyValue(
      this as DialogOpened,
    );
  }

  @override
  bool operator ==(Object other) {
    return DialogOpenedMapper.ensureInitialized().equalsValue(
      this as DialogOpened,
      other,
    );
  }

  @override
  int get hashCode {
    return DialogOpenedMapper.ensureInitialized().hashValue(
      this as DialogOpened,
    );
  }
}

/// @nodoc
extension DialogOpenedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DialogOpened, $Out> {
  DialogOpenedCopyWith<$R, DialogOpened, $Out> get $asDialogOpened =>
      $base.as((v, t, t2) => _DialogOpenedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class DialogOpenedCopyWith<$R, $In extends DialogOpened, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  GameDialogCopyWith<$R, GameDialog, GameDialog> get dialog;
  @override
  $R call({GameDialog? dialog, bool? closeOthers});
  DialogOpenedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _DialogOpenedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DialogOpened, $Out>
    implements DialogOpenedCopyWith<$R, DialogOpened, $Out> {
  _DialogOpenedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DialogOpened> $mapper =
      DialogOpenedMapper.ensureInitialized();
  @override
  GameDialogCopyWith<$R, GameDialog, GameDialog> get dialog =>
      $value.dialog.copyWith.$chain((v) => call(dialog: v));
  @override
  $R call({GameDialog? dialog, bool? closeOthers}) => $apply(
    FieldCopyWithData({
      if (dialog != null) #dialog: dialog,
      if (closeOthers != null) #closeOthers: closeOthers,
    }),
  );
  @override
  DialogOpened $make(CopyWithData data) => DialogOpened(
    data.get(#dialog, or: $value.dialog),
    closeOthers: data.get(#closeOthers, or: $value.closeOthers),
  );

  @override
  DialogOpenedCopyWith<$R2, DialogOpened, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DialogOpenedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class DialogsClosedMapper extends SubClassMapperBase<DialogsClosed> {
  DialogsClosedMapper._();

  static DialogsClosedMapper? _instance;
  static DialogsClosedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DialogsClosedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'DialogsClosed';

  static List<String>? _$ids(DialogsClosed v) => v.ids;
  static const Field<DialogsClosed, List<String>> _f$ids = Field('ids', _$ids);

  @override
  final MappableFields<DialogsClosed> fields = const {#ids: _f$ids};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'DialogsClosed';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static DialogsClosed _instantiate(DecodingData data) {
    return DialogsClosed(data.dec(_f$ids));
  }

  @override
  final Function instantiate = _instantiate;

  static DialogsClosed fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DialogsClosed>(map);
  }

  static DialogsClosed fromJson(String json) {
    return ensureInitialized().decodeJson<DialogsClosed>(json);
  }
}

/// @nodoc
mixin DialogsClosedMappable {
  String toJson() {
    return DialogsClosedMapper.ensureInitialized().encodeJson<DialogsClosed>(
      this as DialogsClosed,
    );
  }

  Map<String, dynamic> toMap() {
    return DialogsClosedMapper.ensureInitialized().encodeMap<DialogsClosed>(
      this as DialogsClosed,
    );
  }

  DialogsClosedCopyWith<DialogsClosed, DialogsClosed, DialogsClosed>
  get copyWith => _DialogsClosedCopyWithImpl<DialogsClosed, DialogsClosed>(
    this as DialogsClosed,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return DialogsClosedMapper.ensureInitialized().stringifyValue(
      this as DialogsClosed,
    );
  }

  @override
  bool operator ==(Object other) {
    return DialogsClosedMapper.ensureInitialized().equalsValue(
      this as DialogsClosed,
      other,
    );
  }

  @override
  int get hashCode {
    return DialogsClosedMapper.ensureInitialized().hashValue(
      this as DialogsClosed,
    );
  }
}

/// @nodoc
extension DialogsClosedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DialogsClosed, $Out> {
  DialogsClosedCopyWith<$R, DialogsClosed, $Out> get $asDialogsClosed =>
      $base.as((v, t, t2) => _DialogsClosedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class DialogsClosedCopyWith<$R, $In extends DialogsClosed, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get ids;
  @override
  $R call({List<String>? ids});
  DialogsClosedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _DialogsClosedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DialogsClosed, $Out>
    implements DialogsClosedCopyWith<$R, DialogsClosed, $Out> {
  _DialogsClosedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DialogsClosed> $mapper =
      DialogsClosedMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get ids =>
      $value.ids != null
      ? ListCopyWith(
          $value.ids!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(ids: v),
        )
      : null;
  @override
  $R call({Object? ids = $none}) =>
      $apply(FieldCopyWithData({if (ids != $none) #ids: ids}));
  @override
  DialogsClosed $make(CopyWithData data) =>
      DialogsClosed(data.get(#ids, or: $value.ids));

  @override
  DialogsClosedCopyWith<$R2, DialogsClosed, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DialogsClosedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class ImagesUpdatedMapper extends SubClassMapperBase<ImagesUpdated> {
  ImagesUpdatedMapper._();

  static ImagesUpdatedMapper? _instance;
  static ImagesUpdatedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImagesUpdatedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals.useAll([Base64IdMapHook()]);
    }
    return _instance!;
  }

  @override
  final String id = 'ImagesUpdated';

  static Map<String, Uint8List> _$images(ImagesUpdated v) => v.images;
  static const Field<ImagesUpdated, Map<String, Uint8List>> _f$images = Field(
    'images',
    _$images,
  );

  @override
  final MappableFields<ImagesUpdated> fields = const {#images: _f$images};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ImagesUpdated';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static ImagesUpdated _instantiate(DecodingData data) {
    return ImagesUpdated(data.dec(_f$images));
  }

  @override
  final Function instantiate = _instantiate;

  static ImagesUpdated fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImagesUpdated>(map);
  }

  static ImagesUpdated fromJson(String json) {
    return ensureInitialized().decodeJson<ImagesUpdated>(json);
  }
}

/// @nodoc
mixin ImagesUpdatedMappable {
  String toJson() {
    return ImagesUpdatedMapper.ensureInitialized().encodeJson<ImagesUpdated>(
      this as ImagesUpdated,
    );
  }

  Map<String, dynamic> toMap() {
    return ImagesUpdatedMapper.ensureInitialized().encodeMap<ImagesUpdated>(
      this as ImagesUpdated,
    );
  }

  ImagesUpdatedCopyWith<ImagesUpdated, ImagesUpdated, ImagesUpdated>
  get copyWith => _ImagesUpdatedCopyWithImpl<ImagesUpdated, ImagesUpdated>(
    this as ImagesUpdated,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ImagesUpdatedMapper.ensureInitialized().stringifyValue(
      this as ImagesUpdated,
    );
  }

  @override
  bool operator ==(Object other) {
    return ImagesUpdatedMapper.ensureInitialized().equalsValue(
      this as ImagesUpdated,
      other,
    );
  }

  @override
  int get hashCode {
    return ImagesUpdatedMapper.ensureInitialized().hashValue(
      this as ImagesUpdated,
    );
  }
}

/// @nodoc
extension ImagesUpdatedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ImagesUpdated, $Out> {
  ImagesUpdatedCopyWith<$R, ImagesUpdated, $Out> get $asImagesUpdated =>
      $base.as((v, t, t2) => _ImagesUpdatedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class ImagesUpdatedCopyWith<$R, $In extends ImagesUpdated, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, Uint8List, ObjectCopyWith<$R, Uint8List, Uint8List>>
  get images;
  @override
  $R call({Map<String, Uint8List>? images});
  ImagesUpdatedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _ImagesUpdatedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImagesUpdated, $Out>
    implements ImagesUpdatedCopyWith<$R, ImagesUpdated, $Out> {
  _ImagesUpdatedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImagesUpdated> $mapper =
      ImagesUpdatedMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, Uint8List, ObjectCopyWith<$R, Uint8List, Uint8List>>
  get images => MapCopyWith(
    $value.images,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(images: v),
  );
  @override
  $R call({Map<String, Uint8List>? images}) =>
      $apply(FieldCopyWithData({if (images != null) #images: images}));
  @override
  ImagesUpdated $make(CopyWithData data) =>
      ImagesUpdated(data.get(#images, or: $value.images));

  @override
  ImagesUpdatedCopyWith<$R2, ImagesUpdated, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ImagesUpdatedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class ServerStateUpdatedMapper extends SubClassMapperBase<ServerStateUpdated> {
  ServerStateUpdatedMapper._();

  static ServerStateUpdatedMapper? _instance;
  static ServerStateUpdatedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServerStateUpdatedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      ServerStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ServerStateUpdated';

  static ServerState _$state(ServerStateUpdated v) => v.state;
  static const Field<ServerStateUpdated, ServerState> _f$state = Field(
    'state',
    _$state,
  );

  @override
  final MappableFields<ServerStateUpdated> fields = const {#state: _f$state};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ServerStateUpdated';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static ServerStateUpdated _instantiate(DecodingData data) {
    return ServerStateUpdated(data.dec(_f$state));
  }

  @override
  final Function instantiate = _instantiate;

  static ServerStateUpdated fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServerStateUpdated>(map);
  }

  static ServerStateUpdated fromJson(String json) {
    return ensureInitialized().decodeJson<ServerStateUpdated>(json);
  }
}

/// @nodoc
mixin ServerStateUpdatedMappable {
  String toJson() {
    return ServerStateUpdatedMapper.ensureInitialized()
        .encodeJson<ServerStateUpdated>(this as ServerStateUpdated);
  }

  Map<String, dynamic> toMap() {
    return ServerStateUpdatedMapper.ensureInitialized()
        .encodeMap<ServerStateUpdated>(this as ServerStateUpdated);
  }

  ServerStateUpdatedCopyWith<
    ServerStateUpdated,
    ServerStateUpdated,
    ServerStateUpdated
  >
  get copyWith =>
      _ServerStateUpdatedCopyWithImpl<ServerStateUpdated, ServerStateUpdated>(
        this as ServerStateUpdated,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ServerStateUpdatedMapper.ensureInitialized().stringifyValue(
      this as ServerStateUpdated,
    );
  }

  @override
  bool operator ==(Object other) {
    return ServerStateUpdatedMapper.ensureInitialized().equalsValue(
      this as ServerStateUpdated,
      other,
    );
  }

  @override
  int get hashCode {
    return ServerStateUpdatedMapper.ensureInitialized().hashValue(
      this as ServerStateUpdated,
    );
  }
}

/// @nodoc
extension ServerStateUpdatedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServerStateUpdated, $Out> {
  ServerStateUpdatedCopyWith<$R, ServerStateUpdated, $Out>
  get $asServerStateUpdated => $base.as(
    (v, t, t2) => _ServerStateUpdatedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class ServerStateUpdatedCopyWith<
  $R,
  $In extends ServerStateUpdated,
  $Out
>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  ServerStateCopyWith<$R, ServerState, ServerState> get state;
  @override
  $R call({ServerState? state});
  ServerStateUpdatedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _ServerStateUpdatedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServerStateUpdated, $Out>
    implements ServerStateUpdatedCopyWith<$R, ServerStateUpdated, $Out> {
  _ServerStateUpdatedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ServerStateUpdated> $mapper =
      ServerStateUpdatedMapper.ensureInitialized();
  @override
  ServerStateCopyWith<$R, ServerState, ServerState> get state =>
      $value.state.copyWith.$chain((v) => call(state: v));
  @override
  $R call({ServerState? state}) =>
      $apply(FieldCopyWithData({if (state != null) #state: state}));
  @override
  ServerStateUpdated $make(CopyWithData data) =>
      ServerStateUpdated(data.get(#state, or: $value.state));

  @override
  ServerStateUpdatedCopyWith<$R2, ServerStateUpdated, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ServerStateUpdatedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class AuthenticatedRequestedMapper
    extends SubClassMapperBase<AuthenticatedRequested> {
  AuthenticatedRequestedMapper._();

  static AuthenticatedRequestedMapper? _instance;
  static AuthenticatedRequestedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthenticatedRequestedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals.useAll([Base64Uint8ListHook()]);
    }
    return _instance!;
  }

  @override
  final String id = 'AuthenticatedRequested';

  static Uint8List _$challenge(AuthenticatedRequested v) => v.challenge;
  static const Field<AuthenticatedRequested, Uint8List> _f$challenge = Field(
    'challenge',
    _$challenge,
  );
  static bool _$isRequired(AuthenticatedRequested v) => v.isRequired;
  static const Field<AuthenticatedRequested, bool> _f$isRequired = Field(
    'isRequired',
    _$isRequired,
    opt: true,
    def: true,
  );

  @override
  final MappableFields<AuthenticatedRequested> fields = const {
    #challenge: _f$challenge,
    #isRequired: _f$isRequired,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'AuthenticatedRequested';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static AuthenticatedRequested _instantiate(DecodingData data) {
    return AuthenticatedRequested(
      data.dec(_f$challenge),
      isRequired: data.dec(_f$isRequired),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AuthenticatedRequested fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthenticatedRequested>(map);
  }

  static AuthenticatedRequested fromJson(String json) {
    return ensureInitialized().decodeJson<AuthenticatedRequested>(json);
  }
}

/// @nodoc
mixin AuthenticatedRequestedMappable {
  String toJson() {
    return AuthenticatedRequestedMapper.ensureInitialized()
        .encodeJson<AuthenticatedRequested>(this as AuthenticatedRequested);
  }

  Map<String, dynamic> toMap() {
    return AuthenticatedRequestedMapper.ensureInitialized()
        .encodeMap<AuthenticatedRequested>(this as AuthenticatedRequested);
  }

  AuthenticatedRequestedCopyWith<
    AuthenticatedRequested,
    AuthenticatedRequested,
    AuthenticatedRequested
  >
  get copyWith =>
      _AuthenticatedRequestedCopyWithImpl<
        AuthenticatedRequested,
        AuthenticatedRequested
      >(this as AuthenticatedRequested, $identity, $identity);
  @override
  String toString() {
    return AuthenticatedRequestedMapper.ensureInitialized().stringifyValue(
      this as AuthenticatedRequested,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthenticatedRequestedMapper.ensureInitialized().equalsValue(
      this as AuthenticatedRequested,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthenticatedRequestedMapper.ensureInitialized().hashValue(
      this as AuthenticatedRequested,
    );
  }
}

/// @nodoc
extension AuthenticatedRequestedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthenticatedRequested, $Out> {
  AuthenticatedRequestedCopyWith<$R, AuthenticatedRequested, $Out>
  get $asAuthenticatedRequested => $base.as(
    (v, t, t2) => _AuthenticatedRequestedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class AuthenticatedRequestedCopyWith<
  $R,
  $In extends AuthenticatedRequested,
  $Out
>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({Uint8List? challenge, bool? isRequired});
  AuthenticatedRequestedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _AuthenticatedRequestedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthenticatedRequested, $Out>
    implements
        AuthenticatedRequestedCopyWith<$R, AuthenticatedRequested, $Out> {
  _AuthenticatedRequestedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthenticatedRequested> $mapper =
      AuthenticatedRequestedMapper.ensureInitialized();
  @override
  $R call({Uint8List? challenge, bool? isRequired}) => $apply(
    FieldCopyWithData({
      if (challenge != null) #challenge: challenge,
      if (isRequired != null) #isRequired: isRequired,
    }),
  );
  @override
  AuthenticatedRequested $make(CopyWithData data) => AuthenticatedRequested(
    data.get(#challenge, or: $value.challenge),
    isRequired: data.get(#isRequired, or: $value.isRequired),
  );

  @override
  AuthenticatedRequestedCopyWith<$R2, AuthenticatedRequested, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AuthenticatedRequestedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class ToolbarUpdatedMapper extends SubClassMapperBase<ToolbarUpdated> {
  ToolbarUpdatedMapper._();

  static ToolbarUpdatedMapper? _instance;
  static ToolbarUpdatedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ToolbarUpdatedMapper._());
      ServerWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GameToolbarMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ToolbarUpdated';

  static GameToolbar _$toolbar(ToolbarUpdated v) => v.toolbar;
  static const Field<ToolbarUpdated, GameToolbar> _f$toolbar = Field(
    'toolbar',
    _$toolbar,
  );

  @override
  final MappableFields<ToolbarUpdated> fields = const {#toolbar: _f$toolbar};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ToolbarUpdated';
  @override
  late final ClassMapperBase superMapper =
      ServerWorldEventMapper.ensureInitialized();

  static ToolbarUpdated _instantiate(DecodingData data) {
    return ToolbarUpdated(data.dec(_f$toolbar));
  }

  @override
  final Function instantiate = _instantiate;

  static ToolbarUpdated fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ToolbarUpdated>(map);
  }

  static ToolbarUpdated fromJson(String json) {
    return ensureInitialized().decodeJson<ToolbarUpdated>(json);
  }
}

/// @nodoc
mixin ToolbarUpdatedMappable {
  String toJson() {
    return ToolbarUpdatedMapper.ensureInitialized().encodeJson<ToolbarUpdated>(
      this as ToolbarUpdated,
    );
  }

  Map<String, dynamic> toMap() {
    return ToolbarUpdatedMapper.ensureInitialized().encodeMap<ToolbarUpdated>(
      this as ToolbarUpdated,
    );
  }

  ToolbarUpdatedCopyWith<ToolbarUpdated, ToolbarUpdated, ToolbarUpdated>
  get copyWith => _ToolbarUpdatedCopyWithImpl<ToolbarUpdated, ToolbarUpdated>(
    this as ToolbarUpdated,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ToolbarUpdatedMapper.ensureInitialized().stringifyValue(
      this as ToolbarUpdated,
    );
  }

  @override
  bool operator ==(Object other) {
    return ToolbarUpdatedMapper.ensureInitialized().equalsValue(
      this as ToolbarUpdated,
      other,
    );
  }

  @override
  int get hashCode {
    return ToolbarUpdatedMapper.ensureInitialized().hashValue(
      this as ToolbarUpdated,
    );
  }
}

/// @nodoc
extension ToolbarUpdatedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ToolbarUpdated, $Out> {
  ToolbarUpdatedCopyWith<$R, ToolbarUpdated, $Out> get $asToolbarUpdated =>
      $base.as((v, t, t2) => _ToolbarUpdatedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class ToolbarUpdatedCopyWith<$R, $In extends ToolbarUpdated, $Out>
    implements ServerWorldEventCopyWith<$R, $In, $Out> {
  GameToolbarCopyWith<$R, GameToolbar, GameToolbar> get toolbar;
  @override
  $R call({GameToolbar? toolbar});
  ToolbarUpdatedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _ToolbarUpdatedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ToolbarUpdated, $Out>
    implements ToolbarUpdatedCopyWith<$R, ToolbarUpdated, $Out> {
  _ToolbarUpdatedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ToolbarUpdated> $mapper =
      ToolbarUpdatedMapper.ensureInitialized();
  @override
  GameToolbarCopyWith<$R, GameToolbar, GameToolbar> get toolbar =>
      $value.toolbar.copyWith.$chain((v) => call(toolbar: v));
  @override
  $R call({GameToolbar? toolbar}) =>
      $apply(FieldCopyWithData({if (toolbar != null) #toolbar: toolbar}));
  @override
  ToolbarUpdated $make(CopyWithData data) =>
      ToolbarUpdated(data.get(#toolbar, or: $value.toolbar));

  @override
  ToolbarUpdatedCopyWith<$R2, ToolbarUpdated, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ToolbarUpdatedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class ClientWorldEventMapper extends SubClassMapperBase<ClientWorldEvent> {
  ClientWorldEventMapper._();

  static ClientWorldEventMapper? _instance;
  static ClientWorldEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ClientWorldEventMapper._());
      WorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      TeamJoinRequestMapper.ensureInitialized();
      TeamLeaveRequestMapper.ensureInitialized();
      CellRollRequestMapper.ensureInitialized();
      ShuffleCellRequestMapper.ensureInitialized();
      PacksChangeRequestMapper.ensureInitialized();
      MessageRequestMapper.ensureInitialized();
      BoardsSpawnRequestMapper.ensureInitialized();
      BoardRemoveRequestMapper.ensureInitialized();
      BoardMoveRequestMapper.ensureInitialized();
      DialogCloseRequestMapper.ensureInitialized();
      ImagesRequestMapper.ensureInitialized();
      ModeChangeRequestMapper.ensureInitialized();
      AuthenticateRequestMapper.ensureInitialized();
      ToolbarActionRequestMapper.ensureInitialized();
      HybridWorldEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ClientWorldEvent';

  @override
  final MappableFields<ClientWorldEvent> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ClientWorldEvent';
  @override
  late final ClassMapperBase superMapper = WorldEventMapper.ensureInitialized();

  static ClientWorldEvent _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
      'ClientWorldEvent',
      'type',
      '${data.value['type']}',
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ClientWorldEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ClientWorldEvent>(map);
  }

  static ClientWorldEvent fromJson(String json) {
    return ensureInitialized().decodeJson<ClientWorldEvent>(json);
  }
}

/// @nodoc
mixin ClientWorldEventMappable {
  String toJson();
  Map<String, dynamic> toMap();
  ClientWorldEventCopyWith<ClientWorldEvent, ClientWorldEvent, ClientWorldEvent>
  get copyWith;
}

/// @nodoc
abstract class ClientWorldEventCopyWith<$R, $In extends ClientWorldEvent, $Out>
    implements WorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  ClientWorldEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class TeamJoinRequestMapper extends SubClassMapperBase<TeamJoinRequest> {
  TeamJoinRequestMapper._();

  static TeamJoinRequestMapper? _instance;
  static TeamJoinRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TeamJoinRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'TeamJoinRequest';

  static String _$team(TeamJoinRequest v) => v.team;
  static const Field<TeamJoinRequest, String> _f$team = Field('team', _$team);

  @override
  final MappableFields<TeamJoinRequest> fields = const {#team: _f$team};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TeamJoinRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static TeamJoinRequest _instantiate(DecodingData data) {
    return TeamJoinRequest(data.dec(_f$team));
  }

  @override
  final Function instantiate = _instantiate;

  static TeamJoinRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TeamJoinRequest>(map);
  }

  static TeamJoinRequest fromJson(String json) {
    return ensureInitialized().decodeJson<TeamJoinRequest>(json);
  }
}

/// @nodoc
mixin TeamJoinRequestMappable {
  String toJson() {
    return TeamJoinRequestMapper.ensureInitialized()
        .encodeJson<TeamJoinRequest>(this as TeamJoinRequest);
  }

  Map<String, dynamic> toMap() {
    return TeamJoinRequestMapper.ensureInitialized().encodeMap<TeamJoinRequest>(
      this as TeamJoinRequest,
    );
  }

  TeamJoinRequestCopyWith<TeamJoinRequest, TeamJoinRequest, TeamJoinRequest>
  get copyWith =>
      _TeamJoinRequestCopyWithImpl<TeamJoinRequest, TeamJoinRequest>(
        this as TeamJoinRequest,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TeamJoinRequestMapper.ensureInitialized().stringifyValue(
      this as TeamJoinRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return TeamJoinRequestMapper.ensureInitialized().equalsValue(
      this as TeamJoinRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return TeamJoinRequestMapper.ensureInitialized().hashValue(
      this as TeamJoinRequest,
    );
  }
}

/// @nodoc
extension TeamJoinRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TeamJoinRequest, $Out> {
  TeamJoinRequestCopyWith<$R, TeamJoinRequest, $Out> get $asTeamJoinRequest =>
      $base.as((v, t, t2) => _TeamJoinRequestCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class TeamJoinRequestCopyWith<$R, $In extends TeamJoinRequest, $Out>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? team});
  TeamJoinRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _TeamJoinRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TeamJoinRequest, $Out>
    implements TeamJoinRequestCopyWith<$R, TeamJoinRequest, $Out> {
  _TeamJoinRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TeamJoinRequest> $mapper =
      TeamJoinRequestMapper.ensureInitialized();
  @override
  $R call({String? team}) =>
      $apply(FieldCopyWithData({if (team != null) #team: team}));
  @override
  TeamJoinRequest $make(CopyWithData data) =>
      TeamJoinRequest(data.get(#team, or: $value.team));

  @override
  TeamJoinRequestCopyWith<$R2, TeamJoinRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TeamJoinRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class TeamLeaveRequestMapper extends SubClassMapperBase<TeamLeaveRequest> {
  TeamLeaveRequestMapper._();

  static TeamLeaveRequestMapper? _instance;
  static TeamLeaveRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TeamLeaveRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'TeamLeaveRequest';

  static String _$team(TeamLeaveRequest v) => v.team;
  static const Field<TeamLeaveRequest, String> _f$team = Field('team', _$team);

  @override
  final MappableFields<TeamLeaveRequest> fields = const {#team: _f$team};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TeamLeaveRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static TeamLeaveRequest _instantiate(DecodingData data) {
    return TeamLeaveRequest(data.dec(_f$team));
  }

  @override
  final Function instantiate = _instantiate;

  static TeamLeaveRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TeamLeaveRequest>(map);
  }

  static TeamLeaveRequest fromJson(String json) {
    return ensureInitialized().decodeJson<TeamLeaveRequest>(json);
  }
}

/// @nodoc
mixin TeamLeaveRequestMappable {
  String toJson() {
    return TeamLeaveRequestMapper.ensureInitialized()
        .encodeJson<TeamLeaveRequest>(this as TeamLeaveRequest);
  }

  Map<String, dynamic> toMap() {
    return TeamLeaveRequestMapper.ensureInitialized()
        .encodeMap<TeamLeaveRequest>(this as TeamLeaveRequest);
  }

  TeamLeaveRequestCopyWith<TeamLeaveRequest, TeamLeaveRequest, TeamLeaveRequest>
  get copyWith =>
      _TeamLeaveRequestCopyWithImpl<TeamLeaveRequest, TeamLeaveRequest>(
        this as TeamLeaveRequest,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TeamLeaveRequestMapper.ensureInitialized().stringifyValue(
      this as TeamLeaveRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return TeamLeaveRequestMapper.ensureInitialized().equalsValue(
      this as TeamLeaveRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return TeamLeaveRequestMapper.ensureInitialized().hashValue(
      this as TeamLeaveRequest,
    );
  }
}

/// @nodoc
extension TeamLeaveRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TeamLeaveRequest, $Out> {
  TeamLeaveRequestCopyWith<$R, TeamLeaveRequest, $Out>
  get $asTeamLeaveRequest =>
      $base.as((v, t, t2) => _TeamLeaveRequestCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class TeamLeaveRequestCopyWith<$R, $In extends TeamLeaveRequest, $Out>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? team});
  TeamLeaveRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _TeamLeaveRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TeamLeaveRequest, $Out>
    implements TeamLeaveRequestCopyWith<$R, TeamLeaveRequest, $Out> {
  _TeamLeaveRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TeamLeaveRequest> $mapper =
      TeamLeaveRequestMapper.ensureInitialized();
  @override
  $R call({String? team}) =>
      $apply(FieldCopyWithData({if (team != null) #team: team}));
  @override
  TeamLeaveRequest $make(CopyWithData data) =>
      TeamLeaveRequest(data.get(#team, or: $value.team));

  @override
  TeamLeaveRequestCopyWith<$R2, TeamLeaveRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TeamLeaveRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class CellRollRequestMapper extends SubClassMapperBase<CellRollRequest> {
  CellRollRequestMapper._();

  static CellRollRequestMapper? _instance;
  static CellRollRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CellRollRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GlobalVectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CellRollRequest';

  static GlobalVectorDefinition _$cell(CellRollRequest v) => v.cell;
  static const Field<CellRollRequest, GlobalVectorDefinition> _f$cell = Field(
    'cell',
    _$cell,
  );
  static int? _$object(CellRollRequest v) => v.object;
  static const Field<CellRollRequest, int> _f$object = Field(
    'object',
    _$object,
    opt: true,
  );

  @override
  final MappableFields<CellRollRequest> fields = const {
    #cell: _f$cell,
    #object: _f$object,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'CellRollRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static CellRollRequest _instantiate(DecodingData data) {
    return CellRollRequest(data.dec(_f$cell), object: data.dec(_f$object));
  }

  @override
  final Function instantiate = _instantiate;

  static CellRollRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CellRollRequest>(map);
  }

  static CellRollRequest fromJson(String json) {
    return ensureInitialized().decodeJson<CellRollRequest>(json);
  }
}

/// @nodoc
mixin CellRollRequestMappable {
  String toJson() {
    return CellRollRequestMapper.ensureInitialized()
        .encodeJson<CellRollRequest>(this as CellRollRequest);
  }

  Map<String, dynamic> toMap() {
    return CellRollRequestMapper.ensureInitialized().encodeMap<CellRollRequest>(
      this as CellRollRequest,
    );
  }

  CellRollRequestCopyWith<CellRollRequest, CellRollRequest, CellRollRequest>
  get copyWith =>
      _CellRollRequestCopyWithImpl<CellRollRequest, CellRollRequest>(
        this as CellRollRequest,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CellRollRequestMapper.ensureInitialized().stringifyValue(
      this as CellRollRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return CellRollRequestMapper.ensureInitialized().equalsValue(
      this as CellRollRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return CellRollRequestMapper.ensureInitialized().hashValue(
      this as CellRollRequest,
    );
  }
}

/// @nodoc
extension CellRollRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CellRollRequest, $Out> {
  CellRollRequestCopyWith<$R, CellRollRequest, $Out> get $asCellRollRequest =>
      $base.as((v, t, t2) => _CellRollRequestCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class CellRollRequestCopyWith<$R, $In extends CellRollRequest, $Out>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get cell;
  @override
  $R call({GlobalVectorDefinition? cell, int? object});
  CellRollRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _CellRollRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CellRollRequest, $Out>
    implements CellRollRequestCopyWith<$R, CellRollRequest, $Out> {
  _CellRollRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CellRollRequest> $mapper =
      CellRollRequestMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get cell => $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  $R call({GlobalVectorDefinition? cell, Object? object = $none}) => $apply(
    FieldCopyWithData({
      if (cell != null) #cell: cell,
      if (object != $none) #object: object,
    }),
  );
  @override
  CellRollRequest $make(CopyWithData data) => CellRollRequest(
    data.get(#cell, or: $value.cell),
    object: data.get(#object, or: $value.object),
  );

  @override
  CellRollRequestCopyWith<$R2, CellRollRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CellRollRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class ShuffleCellRequestMapper extends SubClassMapperBase<ShuffleCellRequest> {
  ShuffleCellRequestMapper._();

  static ShuffleCellRequestMapper? _instance;
  static ShuffleCellRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShuffleCellRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GlobalVectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ShuffleCellRequest';

  static GlobalVectorDefinition _$cell(ShuffleCellRequest v) => v.cell;
  static const Field<ShuffleCellRequest, GlobalVectorDefinition> _f$cell =
      Field('cell', _$cell);

  @override
  final MappableFields<ShuffleCellRequest> fields = const {#cell: _f$cell};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ShuffleCellRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static ShuffleCellRequest _instantiate(DecodingData data) {
    return ShuffleCellRequest(data.dec(_f$cell));
  }

  @override
  final Function instantiate = _instantiate;

  static ShuffleCellRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ShuffleCellRequest>(map);
  }

  static ShuffleCellRequest fromJson(String json) {
    return ensureInitialized().decodeJson<ShuffleCellRequest>(json);
  }
}

/// @nodoc
mixin ShuffleCellRequestMappable {
  String toJson() {
    return ShuffleCellRequestMapper.ensureInitialized()
        .encodeJson<ShuffleCellRequest>(this as ShuffleCellRequest);
  }

  Map<String, dynamic> toMap() {
    return ShuffleCellRequestMapper.ensureInitialized()
        .encodeMap<ShuffleCellRequest>(this as ShuffleCellRequest);
  }

  ShuffleCellRequestCopyWith<
    ShuffleCellRequest,
    ShuffleCellRequest,
    ShuffleCellRequest
  >
  get copyWith =>
      _ShuffleCellRequestCopyWithImpl<ShuffleCellRequest, ShuffleCellRequest>(
        this as ShuffleCellRequest,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ShuffleCellRequestMapper.ensureInitialized().stringifyValue(
      this as ShuffleCellRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return ShuffleCellRequestMapper.ensureInitialized().equalsValue(
      this as ShuffleCellRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return ShuffleCellRequestMapper.ensureInitialized().hashValue(
      this as ShuffleCellRequest,
    );
  }
}

/// @nodoc
extension ShuffleCellRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ShuffleCellRequest, $Out> {
  ShuffleCellRequestCopyWith<$R, ShuffleCellRequest, $Out>
  get $asShuffleCellRequest => $base.as(
    (v, t, t2) => _ShuffleCellRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class ShuffleCellRequestCopyWith<
  $R,
  $In extends ShuffleCellRequest,
  $Out
>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get cell;
  @override
  $R call({GlobalVectorDefinition? cell});
  ShuffleCellRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _ShuffleCellRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ShuffleCellRequest, $Out>
    implements ShuffleCellRequestCopyWith<$R, ShuffleCellRequest, $Out> {
  _ShuffleCellRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ShuffleCellRequest> $mapper =
      ShuffleCellRequestMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get cell => $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  $R call({GlobalVectorDefinition? cell}) =>
      $apply(FieldCopyWithData({if (cell != null) #cell: cell}));
  @override
  ShuffleCellRequest $make(CopyWithData data) =>
      ShuffleCellRequest(data.get(#cell, or: $value.cell));

  @override
  ShuffleCellRequestCopyWith<$R2, ShuffleCellRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ShuffleCellRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class PacksChangeRequestMapper extends SubClassMapperBase<PacksChangeRequest> {
  PacksChangeRequestMapper._();

  static PacksChangeRequestMapper? _instance;
  static PacksChangeRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PacksChangeRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'PacksChangeRequest';

  static List<String> _$packs(PacksChangeRequest v) => v.packs;
  static const Field<PacksChangeRequest, List<String>> _f$packs = Field(
    'packs',
    _$packs,
  );

  @override
  final MappableFields<PacksChangeRequest> fields = const {#packs: _f$packs};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'PacksChangeRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static PacksChangeRequest _instantiate(DecodingData data) {
    return PacksChangeRequest(data.dec(_f$packs));
  }

  @override
  final Function instantiate = _instantiate;

  static PacksChangeRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PacksChangeRequest>(map);
  }

  static PacksChangeRequest fromJson(String json) {
    return ensureInitialized().decodeJson<PacksChangeRequest>(json);
  }
}

/// @nodoc
mixin PacksChangeRequestMappable {
  String toJson() {
    return PacksChangeRequestMapper.ensureInitialized()
        .encodeJson<PacksChangeRequest>(this as PacksChangeRequest);
  }

  Map<String, dynamic> toMap() {
    return PacksChangeRequestMapper.ensureInitialized()
        .encodeMap<PacksChangeRequest>(this as PacksChangeRequest);
  }

  PacksChangeRequestCopyWith<
    PacksChangeRequest,
    PacksChangeRequest,
    PacksChangeRequest
  >
  get copyWith =>
      _PacksChangeRequestCopyWithImpl<PacksChangeRequest, PacksChangeRequest>(
        this as PacksChangeRequest,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PacksChangeRequestMapper.ensureInitialized().stringifyValue(
      this as PacksChangeRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return PacksChangeRequestMapper.ensureInitialized().equalsValue(
      this as PacksChangeRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return PacksChangeRequestMapper.ensureInitialized().hashValue(
      this as PacksChangeRequest,
    );
  }
}

/// @nodoc
extension PacksChangeRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PacksChangeRequest, $Out> {
  PacksChangeRequestCopyWith<$R, PacksChangeRequest, $Out>
  get $asPacksChangeRequest => $base.as(
    (v, t, t2) => _PacksChangeRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class PacksChangeRequestCopyWith<
  $R,
  $In extends PacksChangeRequest,
  $Out
>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get packs;
  @override
  $R call({List<String>? packs});
  PacksChangeRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _PacksChangeRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PacksChangeRequest, $Out>
    implements PacksChangeRequestCopyWith<$R, PacksChangeRequest, $Out> {
  _PacksChangeRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PacksChangeRequest> $mapper =
      PacksChangeRequestMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get packs =>
      ListCopyWith(
        $value.packs,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(packs: v),
      );
  @override
  $R call({List<String>? packs}) =>
      $apply(FieldCopyWithData({if (packs != null) #packs: packs}));
  @override
  PacksChangeRequest $make(CopyWithData data) =>
      PacksChangeRequest(data.get(#packs, or: $value.packs));

  @override
  PacksChangeRequestCopyWith<$R2, PacksChangeRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PacksChangeRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class MessageRequestMapper extends SubClassMapperBase<MessageRequest> {
  MessageRequestMapper._();

  static MessageRequestMapper? _instance;
  static MessageRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MessageRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'MessageRequest';

  static String _$message(MessageRequest v) => v.message;
  static const Field<MessageRequest, String> _f$message = Field(
    'message',
    _$message,
  );

  @override
  final MappableFields<MessageRequest> fields = const {#message: _f$message};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'MessageRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static MessageRequest _instantiate(DecodingData data) {
    return MessageRequest(data.dec(_f$message));
  }

  @override
  final Function instantiate = _instantiate;

  static MessageRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MessageRequest>(map);
  }

  static MessageRequest fromJson(String json) {
    return ensureInitialized().decodeJson<MessageRequest>(json);
  }
}

/// @nodoc
mixin MessageRequestMappable {
  String toJson() {
    return MessageRequestMapper.ensureInitialized().encodeJson<MessageRequest>(
      this as MessageRequest,
    );
  }

  Map<String, dynamic> toMap() {
    return MessageRequestMapper.ensureInitialized().encodeMap<MessageRequest>(
      this as MessageRequest,
    );
  }

  MessageRequestCopyWith<MessageRequest, MessageRequest, MessageRequest>
  get copyWith => _MessageRequestCopyWithImpl<MessageRequest, MessageRequest>(
    this as MessageRequest,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return MessageRequestMapper.ensureInitialized().stringifyValue(
      this as MessageRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return MessageRequestMapper.ensureInitialized().equalsValue(
      this as MessageRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return MessageRequestMapper.ensureInitialized().hashValue(
      this as MessageRequest,
    );
  }
}

/// @nodoc
extension MessageRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MessageRequest, $Out> {
  MessageRequestCopyWith<$R, MessageRequest, $Out> get $asMessageRequest =>
      $base.as((v, t, t2) => _MessageRequestCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class MessageRequestCopyWith<$R, $In extends MessageRequest, $Out>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? message});
  MessageRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _MessageRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MessageRequest, $Out>
    implements MessageRequestCopyWith<$R, MessageRequest, $Out> {
  _MessageRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MessageRequest> $mapper =
      MessageRequestMapper.ensureInitialized();
  @override
  $R call({String? message}) =>
      $apply(FieldCopyWithData({if (message != null) #message: message}));
  @override
  MessageRequest $make(CopyWithData data) =>
      MessageRequest(data.get(#message, or: $value.message));

  @override
  MessageRequestCopyWith<$R2, MessageRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MessageRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class BoardsSpawnRequestMapper extends SubClassMapperBase<BoardsSpawnRequest> {
  BoardsSpawnRequestMapper._();

  static BoardsSpawnRequestMapper? _instance;
  static BoardsSpawnRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoardsSpawnRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      VectorDefinitionMapper.ensureInitialized();
      ItemLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoardsSpawnRequest';

  static String _$table(BoardsSpawnRequest v) => v.table;
  static const Field<BoardsSpawnRequest, String> _f$table = Field(
    'table',
    _$table,
  );
  static Map<VectorDefinition, List<ItemLocation>> _$assets(
    BoardsSpawnRequest v,
  ) => v.assets;
  static const Field<
    BoardsSpawnRequest,
    Map<VectorDefinition, List<ItemLocation>>
  >
  _f$assets = Field('assets', _$assets, opt: true, def: const {});

  @override
  final MappableFields<BoardsSpawnRequest> fields = const {
    #table: _f$table,
    #assets: _f$assets,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'BoardsSpawnRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static BoardsSpawnRequest _instantiate(DecodingData data) {
    return BoardsSpawnRequest(data.dec(_f$table), data.dec(_f$assets));
  }

  @override
  final Function instantiate = _instantiate;

  static BoardsSpawnRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoardsSpawnRequest>(map);
  }

  static BoardsSpawnRequest fromJson(String json) {
    return ensureInitialized().decodeJson<BoardsSpawnRequest>(json);
  }
}

/// @nodoc
mixin BoardsSpawnRequestMappable {
  String toJson() {
    return BoardsSpawnRequestMapper.ensureInitialized()
        .encodeJson<BoardsSpawnRequest>(this as BoardsSpawnRequest);
  }

  Map<String, dynamic> toMap() {
    return BoardsSpawnRequestMapper.ensureInitialized()
        .encodeMap<BoardsSpawnRequest>(this as BoardsSpawnRequest);
  }

  BoardsSpawnRequestCopyWith<
    BoardsSpawnRequest,
    BoardsSpawnRequest,
    BoardsSpawnRequest
  >
  get copyWith =>
      _BoardsSpawnRequestCopyWithImpl<BoardsSpawnRequest, BoardsSpawnRequest>(
        this as BoardsSpawnRequest,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BoardsSpawnRequestMapper.ensureInitialized().stringifyValue(
      this as BoardsSpawnRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return BoardsSpawnRequestMapper.ensureInitialized().equalsValue(
      this as BoardsSpawnRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return BoardsSpawnRequestMapper.ensureInitialized().hashValue(
      this as BoardsSpawnRequest,
    );
  }
}

/// @nodoc
extension BoardsSpawnRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoardsSpawnRequest, $Out> {
  BoardsSpawnRequestCopyWith<$R, BoardsSpawnRequest, $Out>
  get $asBoardsSpawnRequest => $base.as(
    (v, t, t2) => _BoardsSpawnRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class BoardsSpawnRequestCopyWith<
  $R,
  $In extends BoardsSpawnRequest,
  $Out
>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  MapCopyWith<
    $R,
    VectorDefinition,
    List<ItemLocation>,
    ObjectCopyWith<$R, List<ItemLocation>, List<ItemLocation>>
  >
  get assets;
  @override
  $R call({String? table, Map<VectorDefinition, List<ItemLocation>>? assets});
  BoardsSpawnRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _BoardsSpawnRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoardsSpawnRequest, $Out>
    implements BoardsSpawnRequestCopyWith<$R, BoardsSpawnRequest, $Out> {
  _BoardsSpawnRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoardsSpawnRequest> $mapper =
      BoardsSpawnRequestMapper.ensureInitialized();
  @override
  MapCopyWith<
    $R,
    VectorDefinition,
    List<ItemLocation>,
    ObjectCopyWith<$R, List<ItemLocation>, List<ItemLocation>>
  >
  get assets => MapCopyWith(
    $value.assets,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(assets: v),
  );
  @override
  $R call({String? table, Map<VectorDefinition, List<ItemLocation>>? assets}) =>
      $apply(
        FieldCopyWithData({
          if (table != null) #table: table,
          if (assets != null) #assets: assets,
        }),
      );
  @override
  BoardsSpawnRequest $make(CopyWithData data) => BoardsSpawnRequest(
    data.get(#table, or: $value.table),
    data.get(#assets, or: $value.assets),
  );

  @override
  BoardsSpawnRequestCopyWith<$R2, BoardsSpawnRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BoardsSpawnRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class BoardRemoveRequestMapper extends SubClassMapperBase<BoardRemoveRequest> {
  BoardRemoveRequestMapper._();

  static BoardRemoveRequestMapper? _instance;
  static BoardRemoveRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoardRemoveRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GlobalVectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoardRemoveRequest';

  static GlobalVectorDefinition _$position(BoardRemoveRequest v) => v.position;
  static const Field<BoardRemoveRequest, GlobalVectorDefinition> _f$position =
      Field('position', _$position);
  static int _$index(BoardRemoveRequest v) => v.index;
  static const Field<BoardRemoveRequest, int> _f$index = Field(
    'index',
    _$index,
  );

  @override
  final MappableFields<BoardRemoveRequest> fields = const {
    #position: _f$position,
    #index: _f$index,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'BoardRemoveRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static BoardRemoveRequest _instantiate(DecodingData data) {
    return BoardRemoveRequest(data.dec(_f$position), data.dec(_f$index));
  }

  @override
  final Function instantiate = _instantiate;

  static BoardRemoveRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoardRemoveRequest>(map);
  }

  static BoardRemoveRequest fromJson(String json) {
    return ensureInitialized().decodeJson<BoardRemoveRequest>(json);
  }
}

/// @nodoc
mixin BoardRemoveRequestMappable {
  String toJson() {
    return BoardRemoveRequestMapper.ensureInitialized()
        .encodeJson<BoardRemoveRequest>(this as BoardRemoveRequest);
  }

  Map<String, dynamic> toMap() {
    return BoardRemoveRequestMapper.ensureInitialized()
        .encodeMap<BoardRemoveRequest>(this as BoardRemoveRequest);
  }

  BoardRemoveRequestCopyWith<
    BoardRemoveRequest,
    BoardRemoveRequest,
    BoardRemoveRequest
  >
  get copyWith =>
      _BoardRemoveRequestCopyWithImpl<BoardRemoveRequest, BoardRemoveRequest>(
        this as BoardRemoveRequest,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BoardRemoveRequestMapper.ensureInitialized().stringifyValue(
      this as BoardRemoveRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return BoardRemoveRequestMapper.ensureInitialized().equalsValue(
      this as BoardRemoveRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return BoardRemoveRequestMapper.ensureInitialized().hashValue(
      this as BoardRemoveRequest,
    );
  }
}

/// @nodoc
extension BoardRemoveRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoardRemoveRequest, $Out> {
  BoardRemoveRequestCopyWith<$R, BoardRemoveRequest, $Out>
  get $asBoardRemoveRequest => $base.as(
    (v, t, t2) => _BoardRemoveRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class BoardRemoveRequestCopyWith<
  $R,
  $In extends BoardRemoveRequest,
  $Out
>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get position;
  @override
  $R call({GlobalVectorDefinition? position, int? index});
  BoardRemoveRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _BoardRemoveRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoardRemoveRequest, $Out>
    implements BoardRemoveRequestCopyWith<$R, BoardRemoveRequest, $Out> {
  _BoardRemoveRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoardRemoveRequest> $mapper =
      BoardRemoveRequestMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get position => $value.position.copyWith.$chain((v) => call(position: v));
  @override
  $R call({GlobalVectorDefinition? position, int? index}) => $apply(
    FieldCopyWithData({
      if (position != null) #position: position,
      if (index != null) #index: index,
    }),
  );
  @override
  BoardRemoveRequest $make(CopyWithData data) => BoardRemoveRequest(
    data.get(#position, or: $value.position),
    data.get(#index, or: $value.index),
  );

  @override
  BoardRemoveRequestCopyWith<$R2, BoardRemoveRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BoardRemoveRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class BoardMoveRequestMapper extends SubClassMapperBase<BoardMoveRequest> {
  BoardMoveRequestMapper._();

  static BoardMoveRequestMapper? _instance;
  static BoardMoveRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BoardMoveRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BoardMoveRequest';

  static String _$table(BoardMoveRequest v) => v.table;
  static const Field<BoardMoveRequest, String> _f$table = Field(
    'table',
    _$table,
  );
  static VectorDefinition _$from(BoardMoveRequest v) => v.from;
  static const Field<BoardMoveRequest, VectorDefinition> _f$from = Field(
    'from',
    _$from,
  );
  static VectorDefinition _$to(BoardMoveRequest v) => v.to;
  static const Field<BoardMoveRequest, VectorDefinition> _f$to = Field(
    'to',
    _$to,
  );
  static int _$index(BoardMoveRequest v) => v.index;
  static const Field<BoardMoveRequest, int> _f$index = Field('index', _$index);

  @override
  final MappableFields<BoardMoveRequest> fields = const {
    #table: _f$table,
    #from: _f$from,
    #to: _f$to,
    #index: _f$index,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'BoardMoveRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static BoardMoveRequest _instantiate(DecodingData data) {
    return BoardMoveRequest(
      data.dec(_f$table),
      data.dec(_f$from),
      data.dec(_f$to),
      data.dec(_f$index),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BoardMoveRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BoardMoveRequest>(map);
  }

  static BoardMoveRequest fromJson(String json) {
    return ensureInitialized().decodeJson<BoardMoveRequest>(json);
  }
}

/// @nodoc
mixin BoardMoveRequestMappable {
  String toJson() {
    return BoardMoveRequestMapper.ensureInitialized()
        .encodeJson<BoardMoveRequest>(this as BoardMoveRequest);
  }

  Map<String, dynamic> toMap() {
    return BoardMoveRequestMapper.ensureInitialized()
        .encodeMap<BoardMoveRequest>(this as BoardMoveRequest);
  }

  BoardMoveRequestCopyWith<BoardMoveRequest, BoardMoveRequest, BoardMoveRequest>
  get copyWith =>
      _BoardMoveRequestCopyWithImpl<BoardMoveRequest, BoardMoveRequest>(
        this as BoardMoveRequest,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BoardMoveRequestMapper.ensureInitialized().stringifyValue(
      this as BoardMoveRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return BoardMoveRequestMapper.ensureInitialized().equalsValue(
      this as BoardMoveRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return BoardMoveRequestMapper.ensureInitialized().hashValue(
      this as BoardMoveRequest,
    );
  }
}

/// @nodoc
extension BoardMoveRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BoardMoveRequest, $Out> {
  BoardMoveRequestCopyWith<$R, BoardMoveRequest, $Out>
  get $asBoardMoveRequest =>
      $base.as((v, t, t2) => _BoardMoveRequestCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class BoardMoveRequestCopyWith<$R, $In extends BoardMoveRequest, $Out>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get from;
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get to;
  @override
  $R call({
    String? table,
    VectorDefinition? from,
    VectorDefinition? to,
    int? index,
  });
  BoardMoveRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _BoardMoveRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BoardMoveRequest, $Out>
    implements BoardMoveRequestCopyWith<$R, BoardMoveRequest, $Out> {
  _BoardMoveRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BoardMoveRequest> $mapper =
      BoardMoveRequestMapper.ensureInitialized();
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get from =>
      $value.from.copyWith.$chain((v) => call(from: v));
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get to =>
      $value.to.copyWith.$chain((v) => call(to: v));
  @override
  $R call({
    String? table,
    VectorDefinition? from,
    VectorDefinition? to,
    int? index,
  }) => $apply(
    FieldCopyWithData({
      if (table != null) #table: table,
      if (from != null) #from: from,
      if (to != null) #to: to,
      if (index != null) #index: index,
    }),
  );
  @override
  BoardMoveRequest $make(CopyWithData data) => BoardMoveRequest(
    data.get(#table, or: $value.table),
    data.get(#from, or: $value.from),
    data.get(#to, or: $value.to),
    data.get(#index, or: $value.index),
  );

  @override
  BoardMoveRequestCopyWith<$R2, BoardMoveRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BoardMoveRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class DialogCloseRequestMapper extends SubClassMapperBase<DialogCloseRequest> {
  DialogCloseRequestMapper._();

  static DialogCloseRequestMapper? _instance;
  static DialogCloseRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DialogCloseRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GameDialogValueMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DialogCloseRequest';

  static String _$id(DialogCloseRequest v) => v.id;
  static const Field<DialogCloseRequest, String> _f$id = Field('id', _$id);
  static GameDialogValue? _$value(DialogCloseRequest v) => v.value;
  static const Field<DialogCloseRequest, GameDialogValue> _f$value = Field(
    'value',
    _$value,
  );

  @override
  final MappableFields<DialogCloseRequest> fields = const {
    #id: _f$id,
    #value: _f$value,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'DialogCloseRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static DialogCloseRequest _instantiate(DecodingData data) {
    return DialogCloseRequest(data.dec(_f$id), data.dec(_f$value));
  }

  @override
  final Function instantiate = _instantiate;

  static DialogCloseRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DialogCloseRequest>(map);
  }

  static DialogCloseRequest fromJson(String json) {
    return ensureInitialized().decodeJson<DialogCloseRequest>(json);
  }
}

/// @nodoc
mixin DialogCloseRequestMappable {
  String toJson() {
    return DialogCloseRequestMapper.ensureInitialized()
        .encodeJson<DialogCloseRequest>(this as DialogCloseRequest);
  }

  Map<String, dynamic> toMap() {
    return DialogCloseRequestMapper.ensureInitialized()
        .encodeMap<DialogCloseRequest>(this as DialogCloseRequest);
  }

  DialogCloseRequestCopyWith<
    DialogCloseRequest,
    DialogCloseRequest,
    DialogCloseRequest
  >
  get copyWith =>
      _DialogCloseRequestCopyWithImpl<DialogCloseRequest, DialogCloseRequest>(
        this as DialogCloseRequest,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DialogCloseRequestMapper.ensureInitialized().stringifyValue(
      this as DialogCloseRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return DialogCloseRequestMapper.ensureInitialized().equalsValue(
      this as DialogCloseRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return DialogCloseRequestMapper.ensureInitialized().hashValue(
      this as DialogCloseRequest,
    );
  }
}

/// @nodoc
extension DialogCloseRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DialogCloseRequest, $Out> {
  DialogCloseRequestCopyWith<$R, DialogCloseRequest, $Out>
  get $asDialogCloseRequest => $base.as(
    (v, t, t2) => _DialogCloseRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class DialogCloseRequestCopyWith<
  $R,
  $In extends DialogCloseRequest,
  $Out
>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  GameDialogValueCopyWith<$R, GameDialogValue, GameDialogValue>? get value;
  @override
  $R call({String? id, GameDialogValue? value});
  DialogCloseRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _DialogCloseRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DialogCloseRequest, $Out>
    implements DialogCloseRequestCopyWith<$R, DialogCloseRequest, $Out> {
  _DialogCloseRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DialogCloseRequest> $mapper =
      DialogCloseRequestMapper.ensureInitialized();
  @override
  GameDialogValueCopyWith<$R, GameDialogValue, GameDialogValue>? get value =>
      $value.value?.copyWith.$chain((v) => call(value: v));
  @override
  $R call({String? id, Object? value = $none}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (value != $none) #value: value,
    }),
  );
  @override
  DialogCloseRequest $make(CopyWithData data) => DialogCloseRequest(
    data.get(#id, or: $value.id),
    data.get(#value, or: $value.value),
  );

  @override
  DialogCloseRequestCopyWith<$R2, DialogCloseRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DialogCloseRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class ImagesRequestMapper extends SubClassMapperBase<ImagesRequest> {
  ImagesRequestMapper._();

  static ImagesRequestMapper? _instance;
  static ImagesRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImagesRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'ImagesRequest';

  static List<String> _$ids(ImagesRequest v) => v.ids;
  static const Field<ImagesRequest, List<String>> _f$ids = Field('ids', _$ids);

  @override
  final MappableFields<ImagesRequest> fields = const {#ids: _f$ids};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ImagesRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static ImagesRequest _instantiate(DecodingData data) {
    return ImagesRequest(data.dec(_f$ids));
  }

  @override
  final Function instantiate = _instantiate;

  static ImagesRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImagesRequest>(map);
  }

  static ImagesRequest fromJson(String json) {
    return ensureInitialized().decodeJson<ImagesRequest>(json);
  }
}

/// @nodoc
mixin ImagesRequestMappable {
  String toJson() {
    return ImagesRequestMapper.ensureInitialized().encodeJson<ImagesRequest>(
      this as ImagesRequest,
    );
  }

  Map<String, dynamic> toMap() {
    return ImagesRequestMapper.ensureInitialized().encodeMap<ImagesRequest>(
      this as ImagesRequest,
    );
  }

  ImagesRequestCopyWith<ImagesRequest, ImagesRequest, ImagesRequest>
  get copyWith => _ImagesRequestCopyWithImpl<ImagesRequest, ImagesRequest>(
    this as ImagesRequest,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ImagesRequestMapper.ensureInitialized().stringifyValue(
      this as ImagesRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return ImagesRequestMapper.ensureInitialized().equalsValue(
      this as ImagesRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return ImagesRequestMapper.ensureInitialized().hashValue(
      this as ImagesRequest,
    );
  }
}

/// @nodoc
extension ImagesRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ImagesRequest, $Out> {
  ImagesRequestCopyWith<$R, ImagesRequest, $Out> get $asImagesRequest =>
      $base.as((v, t, t2) => _ImagesRequestCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class ImagesRequestCopyWith<$R, $In extends ImagesRequest, $Out>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get ids;
  @override
  $R call({List<String>? ids});
  ImagesRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _ImagesRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImagesRequest, $Out>
    implements ImagesRequestCopyWith<$R, ImagesRequest, $Out> {
  _ImagesRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImagesRequest> $mapper =
      ImagesRequestMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get ids =>
      ListCopyWith(
        $value.ids,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(ids: v),
      );
  @override
  $R call({List<String>? ids}) =>
      $apply(FieldCopyWithData({if (ids != null) #ids: ids}));
  @override
  ImagesRequest $make(CopyWithData data) =>
      ImagesRequest(data.get(#ids, or: $value.ids));

  @override
  ImagesRequestCopyWith<$R2, ImagesRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ImagesRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class ModeChangeRequestMapper extends SubClassMapperBase<ModeChangeRequest> {
  ModeChangeRequestMapper._();

  static ModeChangeRequestMapper? _instance;
  static ModeChangeRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ModeChangeRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      ItemLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ModeChangeRequest';

  static ItemLocation? _$location(ModeChangeRequest v) => v.location;
  static const Field<ModeChangeRequest, ItemLocation> _f$location = Field(
    'location',
    _$location,
  );

  @override
  final MappableFields<ModeChangeRequest> fields = const {
    #location: _f$location,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ModeChangeRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static ModeChangeRequest _instantiate(DecodingData data) {
    return ModeChangeRequest(data.dec(_f$location));
  }

  @override
  final Function instantiate = _instantiate;

  static ModeChangeRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ModeChangeRequest>(map);
  }

  static ModeChangeRequest fromJson(String json) {
    return ensureInitialized().decodeJson<ModeChangeRequest>(json);
  }
}

/// @nodoc
mixin ModeChangeRequestMappable {
  String toJson() {
    return ModeChangeRequestMapper.ensureInitialized()
        .encodeJson<ModeChangeRequest>(this as ModeChangeRequest);
  }

  Map<String, dynamic> toMap() {
    return ModeChangeRequestMapper.ensureInitialized()
        .encodeMap<ModeChangeRequest>(this as ModeChangeRequest);
  }

  ModeChangeRequestCopyWith<
    ModeChangeRequest,
    ModeChangeRequest,
    ModeChangeRequest
  >
  get copyWith =>
      _ModeChangeRequestCopyWithImpl<ModeChangeRequest, ModeChangeRequest>(
        this as ModeChangeRequest,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ModeChangeRequestMapper.ensureInitialized().stringifyValue(
      this as ModeChangeRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return ModeChangeRequestMapper.ensureInitialized().equalsValue(
      this as ModeChangeRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return ModeChangeRequestMapper.ensureInitialized().hashValue(
      this as ModeChangeRequest,
    );
  }
}

/// @nodoc
extension ModeChangeRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ModeChangeRequest, $Out> {
  ModeChangeRequestCopyWith<$R, ModeChangeRequest, $Out>
  get $asModeChangeRequest => $base.as(
    (v, t, t2) => _ModeChangeRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class ModeChangeRequestCopyWith<
  $R,
  $In extends ModeChangeRequest,
  $Out
>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation>? get location;
  @override
  $R call({ItemLocation? location});
  ModeChangeRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _ModeChangeRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ModeChangeRequest, $Out>
    implements ModeChangeRequestCopyWith<$R, ModeChangeRequest, $Out> {
  _ModeChangeRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ModeChangeRequest> $mapper =
      ModeChangeRequestMapper.ensureInitialized();
  @override
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation>? get location =>
      $value.location?.copyWith.$chain((v) => call(location: v));
  @override
  $R call({Object? location = $none}) =>
      $apply(FieldCopyWithData({if (location != $none) #location: location}));
  @override
  ModeChangeRequest $make(CopyWithData data) =>
      ModeChangeRequest(data.get(#location, or: $value.location));

  @override
  ModeChangeRequestCopyWith<$R2, ModeChangeRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ModeChangeRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class AuthenticateRequestMapper
    extends SubClassMapperBase<AuthenticateRequest> {
  AuthenticateRequestMapper._();

  static AuthenticateRequestMapper? _instance;
  static AuthenticateRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthenticateRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals.useAll([Base64Uint8ListHook()]);
    }
    return _instance!;
  }

  @override
  final String id = 'AuthenticateRequest';

  static Uint8List _$signature(AuthenticateRequest v) => v.signature;
  static const Field<AuthenticateRequest, Uint8List> _f$signature = Field(
    'signature',
    _$signature,
  );
  static Uint8List _$publicKey(AuthenticateRequest v) => v.publicKey;
  static const Field<AuthenticateRequest, Uint8List> _f$publicKey = Field(
    'publicKey',
    _$publicKey,
  );

  @override
  final MappableFields<AuthenticateRequest> fields = const {
    #signature: _f$signature,
    #publicKey: _f$publicKey,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'AuthenticateRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static AuthenticateRequest _instantiate(DecodingData data) {
    return AuthenticateRequest(data.dec(_f$signature), data.dec(_f$publicKey));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthenticateRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthenticateRequest>(map);
  }

  static AuthenticateRequest fromJson(String json) {
    return ensureInitialized().decodeJson<AuthenticateRequest>(json);
  }
}

/// @nodoc
mixin AuthenticateRequestMappable {
  String toJson() {
    return AuthenticateRequestMapper.ensureInitialized()
        .encodeJson<AuthenticateRequest>(this as AuthenticateRequest);
  }

  Map<String, dynamic> toMap() {
    return AuthenticateRequestMapper.ensureInitialized()
        .encodeMap<AuthenticateRequest>(this as AuthenticateRequest);
  }

  AuthenticateRequestCopyWith<
    AuthenticateRequest,
    AuthenticateRequest,
    AuthenticateRequest
  >
  get copyWith =>
      _AuthenticateRequestCopyWithImpl<
        AuthenticateRequest,
        AuthenticateRequest
      >(this as AuthenticateRequest, $identity, $identity);
  @override
  String toString() {
    return AuthenticateRequestMapper.ensureInitialized().stringifyValue(
      this as AuthenticateRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthenticateRequestMapper.ensureInitialized().equalsValue(
      this as AuthenticateRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthenticateRequestMapper.ensureInitialized().hashValue(
      this as AuthenticateRequest,
    );
  }
}

/// @nodoc
extension AuthenticateRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthenticateRequest, $Out> {
  AuthenticateRequestCopyWith<$R, AuthenticateRequest, $Out>
  get $asAuthenticateRequest => $base.as(
    (v, t, t2) => _AuthenticateRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class AuthenticateRequestCopyWith<
  $R,
  $In extends AuthenticateRequest,
  $Out
>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({Uint8List? signature, Uint8List? publicKey});
  AuthenticateRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _AuthenticateRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthenticateRequest, $Out>
    implements AuthenticateRequestCopyWith<$R, AuthenticateRequest, $Out> {
  _AuthenticateRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthenticateRequest> $mapper =
      AuthenticateRequestMapper.ensureInitialized();
  @override
  $R call({Uint8List? signature, Uint8List? publicKey}) => $apply(
    FieldCopyWithData({
      if (signature != null) #signature: signature,
      if (publicKey != null) #publicKey: publicKey,
    }),
  );
  @override
  AuthenticateRequest $make(CopyWithData data) => AuthenticateRequest(
    data.get(#signature, or: $value.signature),
    data.get(#publicKey, or: $value.publicKey),
  );

  @override
  AuthenticateRequestCopyWith<$R2, AuthenticateRequest, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AuthenticateRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class ToolbarActionRequestMapper
    extends SubClassMapperBase<ToolbarActionRequest> {
  ToolbarActionRequestMapper._();

  static ToolbarActionRequestMapper? _instance;
  static ToolbarActionRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ToolbarActionRequestMapper._());
      ClientWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'ToolbarActionRequest';

  static String _$actionId(ToolbarActionRequest v) => v.actionId;
  static const Field<ToolbarActionRequest, String> _f$actionId = Field(
    'actionId',
    _$actionId,
  );

  @override
  final MappableFields<ToolbarActionRequest> fields = const {
    #actionId: _f$actionId,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ToolbarActionRequest';
  @override
  late final ClassMapperBase superMapper =
      ClientWorldEventMapper.ensureInitialized();

  static ToolbarActionRequest _instantiate(DecodingData data) {
    return ToolbarActionRequest(data.dec(_f$actionId));
  }

  @override
  final Function instantiate = _instantiate;

  static ToolbarActionRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ToolbarActionRequest>(map);
  }

  static ToolbarActionRequest fromJson(String json) {
    return ensureInitialized().decodeJson<ToolbarActionRequest>(json);
  }
}

/// @nodoc
mixin ToolbarActionRequestMappable {
  String toJson() {
    return ToolbarActionRequestMapper.ensureInitialized()
        .encodeJson<ToolbarActionRequest>(this as ToolbarActionRequest);
  }

  Map<String, dynamic> toMap() {
    return ToolbarActionRequestMapper.ensureInitialized()
        .encodeMap<ToolbarActionRequest>(this as ToolbarActionRequest);
  }

  ToolbarActionRequestCopyWith<
    ToolbarActionRequest,
    ToolbarActionRequest,
    ToolbarActionRequest
  >
  get copyWith =>
      _ToolbarActionRequestCopyWithImpl<
        ToolbarActionRequest,
        ToolbarActionRequest
      >(this as ToolbarActionRequest, $identity, $identity);
  @override
  String toString() {
    return ToolbarActionRequestMapper.ensureInitialized().stringifyValue(
      this as ToolbarActionRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return ToolbarActionRequestMapper.ensureInitialized().equalsValue(
      this as ToolbarActionRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return ToolbarActionRequestMapper.ensureInitialized().hashValue(
      this as ToolbarActionRequest,
    );
  }
}

/// @nodoc
extension ToolbarActionRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ToolbarActionRequest, $Out> {
  ToolbarActionRequestCopyWith<$R, ToolbarActionRequest, $Out>
  get $asToolbarActionRequest => $base.as(
    (v, t, t2) => _ToolbarActionRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class ToolbarActionRequestCopyWith<
  $R,
  $In extends ToolbarActionRequest,
  $Out
>
    implements ClientWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? actionId});
  ToolbarActionRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _ToolbarActionRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ToolbarActionRequest, $Out>
    implements ToolbarActionRequestCopyWith<$R, ToolbarActionRequest, $Out> {
  _ToolbarActionRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ToolbarActionRequest> $mapper =
      ToolbarActionRequestMapper.ensureInitialized();
  @override
  $R call({String? actionId}) =>
      $apply(FieldCopyWithData({if (actionId != null) #actionId: actionId}));
  @override
  ToolbarActionRequest $make(CopyWithData data) =>
      ToolbarActionRequest(data.get(#actionId, or: $value.actionId));

  @override
  ToolbarActionRequestCopyWith<$R2, ToolbarActionRequest, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ToolbarActionRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class HybridWorldEventMapper extends SubClassMapperBase<HybridWorldEvent> {
  HybridWorldEventMapper._();

  static HybridWorldEventMapper? _instance;
  static HybridWorldEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HybridWorldEventMapper._());
      WorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      CellSwitchedMapper.ensureInitialized();
      BackgroundChangedMapper.ensureInitialized();
      ObjectsSpawnedMapper.ensureInitialized();
      ObjectsMovedMapper.ensureInitialized();
      CellHideChangedMapper.ensureInitialized();
      ObjectIndexChangedMapper.ensureInitialized();
      TeamChangedMapper.ensureInitialized();
      TeamRemovedMapper.ensureInitialized();
      CellMergeStrategyChangedMapper.ensureInitialized();
      MetadataChangedMapper.ensureInitialized();
      ObjectsRemovedMapper.ensureInitialized();
      TableRenamedMapper.ensureInitialized();
      TableRemovedMapper.ensureInitialized();
      NoteChangedMapper.ensureInitialized();
      NoteRemovedMapper.ensureInitialized();
      WaypointChangedMapper.ensureInitialized();
      WaypointRemovedMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HybridWorldEvent';

  @override
  final MappableFields<HybridWorldEvent> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'HybridWorldEvent';
  @override
  late final ClassMapperBase superMapper = WorldEventMapper.ensureInitialized();

  static HybridWorldEvent _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
      'HybridWorldEvent',
      'type',
      '${data.value['type']}',
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HybridWorldEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HybridWorldEvent>(map);
  }

  static HybridWorldEvent fromJson(String json) {
    return ensureInitialized().decodeJson<HybridWorldEvent>(json);
  }
}

/// @nodoc
mixin HybridWorldEventMappable {
  String toJson();
  Map<String, dynamic> toMap();
  HybridWorldEventCopyWith<HybridWorldEvent, HybridWorldEvent, HybridWorldEvent>
  get copyWith;
}

/// @nodoc
abstract class HybridWorldEventCopyWith<$R, $In extends HybridWorldEvent, $Out>
    implements
        WorldEventCopyWith<$R, $In, $Out>,
        ClientWorldEventCopyWith<$R, $In, $Out>,
        ServerWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  HybridWorldEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class CellSwitchedMapper extends SubClassMapperBase<CellSwitched> {
  CellSwitchedMapper._();

  static CellSwitchedMapper? _instance;
  static CellSwitchedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CellSwitchedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CellSwitched';

  static VectorDefinition? _$cell(CellSwitched v) => v.cell;
  static const Field<CellSwitched, VectorDefinition> _f$cell = Field(
    'cell',
    _$cell,
  );
  static bool _$selected(CellSwitched v) => v.selected;
  static const Field<CellSwitched, bool> _f$selected = Field(
    'selected',
    _$selected,
    opt: true,
    def: true,
  );
  static bool _$teleport(CellSwitched v) => v.teleport;
  static const Field<CellSwitched, bool> _f$teleport = Field(
    'teleport',
    _$teleport,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<CellSwitched> fields = const {
    #cell: _f$cell,
    #selected: _f$selected,
    #teleport: _f$teleport,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'CellSwitched';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static CellSwitched _instantiate(DecodingData data) {
    return CellSwitched(
      data.dec(_f$cell),
      selected: data.dec(_f$selected),
      teleport: data.dec(_f$teleport),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CellSwitched fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CellSwitched>(map);
  }

  static CellSwitched fromJson(String json) {
    return ensureInitialized().decodeJson<CellSwitched>(json);
  }
}

/// @nodoc
mixin CellSwitchedMappable {
  String toJson() {
    return CellSwitchedMapper.ensureInitialized().encodeJson<CellSwitched>(
      this as CellSwitched,
    );
  }

  Map<String, dynamic> toMap() {
    return CellSwitchedMapper.ensureInitialized().encodeMap<CellSwitched>(
      this as CellSwitched,
    );
  }

  CellSwitchedCopyWith<CellSwitched, CellSwitched, CellSwitched> get copyWith =>
      _CellSwitchedCopyWithImpl<CellSwitched, CellSwitched>(
        this as CellSwitched,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CellSwitchedMapper.ensureInitialized().stringifyValue(
      this as CellSwitched,
    );
  }

  @override
  bool operator ==(Object other) {
    return CellSwitchedMapper.ensureInitialized().equalsValue(
      this as CellSwitched,
      other,
    );
  }

  @override
  int get hashCode {
    return CellSwitchedMapper.ensureInitialized().hashValue(
      this as CellSwitched,
    );
  }
}

/// @nodoc
extension CellSwitchedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CellSwitched, $Out> {
  CellSwitchedCopyWith<$R, CellSwitched, $Out> get $asCellSwitched =>
      $base.as((v, t, t2) => _CellSwitchedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class CellSwitchedCopyWith<$R, $In extends CellSwitched, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>? get cell;
  @override
  $R call({VectorDefinition? cell, bool? selected, bool? teleport});
  CellSwitchedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _CellSwitchedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CellSwitched, $Out>
    implements CellSwitchedCopyWith<$R, CellSwitched, $Out> {
  _CellSwitchedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CellSwitched> $mapper =
      CellSwitchedMapper.ensureInitialized();
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>? get cell =>
      $value.cell?.copyWith.$chain((v) => call(cell: v));
  @override
  $R call({Object? cell = $none, bool? selected, bool? teleport}) => $apply(
    FieldCopyWithData({
      if (cell != $none) #cell: cell,
      if (selected != null) #selected: selected,
      if (teleport != null) #teleport: teleport,
    }),
  );
  @override
  CellSwitched $make(CopyWithData data) => CellSwitched(
    data.get(#cell, or: $value.cell),
    selected: data.get(#selected, or: $value.selected),
    teleport: data.get(#teleport, or: $value.teleport),
  );

  @override
  CellSwitchedCopyWith<$R2, CellSwitched, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CellSwitchedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class BackgroundChangedMapper extends SubClassMapperBase<BackgroundChanged> {
  BackgroundChangedMapper._();

  static BackgroundChangedMapper? _instance;
  static BackgroundChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BackgroundChangedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      ItemLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BackgroundChanged';

  static ItemLocation _$background(BackgroundChanged v) => v.background;
  static const Field<BackgroundChanged, ItemLocation> _f$background = Field(
    'background',
    _$background,
  );

  @override
  final MappableFields<BackgroundChanged> fields = const {
    #background: _f$background,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'BackgroundChanged';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static BackgroundChanged _instantiate(DecodingData data) {
    return BackgroundChanged(data.dec(_f$background));
  }

  @override
  final Function instantiate = _instantiate;

  static BackgroundChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BackgroundChanged>(map);
  }

  static BackgroundChanged fromJson(String json) {
    return ensureInitialized().decodeJson<BackgroundChanged>(json);
  }
}

/// @nodoc
mixin BackgroundChangedMappable {
  String toJson() {
    return BackgroundChangedMapper.ensureInitialized()
        .encodeJson<BackgroundChanged>(this as BackgroundChanged);
  }

  Map<String, dynamic> toMap() {
    return BackgroundChangedMapper.ensureInitialized()
        .encodeMap<BackgroundChanged>(this as BackgroundChanged);
  }

  BackgroundChangedCopyWith<
    BackgroundChanged,
    BackgroundChanged,
    BackgroundChanged
  >
  get copyWith =>
      _BackgroundChangedCopyWithImpl<BackgroundChanged, BackgroundChanged>(
        this as BackgroundChanged,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BackgroundChangedMapper.ensureInitialized().stringifyValue(
      this as BackgroundChanged,
    );
  }

  @override
  bool operator ==(Object other) {
    return BackgroundChangedMapper.ensureInitialized().equalsValue(
      this as BackgroundChanged,
      other,
    );
  }

  @override
  int get hashCode {
    return BackgroundChangedMapper.ensureInitialized().hashValue(
      this as BackgroundChanged,
    );
  }
}

/// @nodoc
extension BackgroundChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BackgroundChanged, $Out> {
  BackgroundChangedCopyWith<$R, BackgroundChanged, $Out>
  get $asBackgroundChanged => $base.as(
    (v, t, t2) => _BackgroundChangedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class BackgroundChangedCopyWith<
  $R,
  $In extends BackgroundChanged,
  $Out
>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation> get background;
  @override
  $R call({ItemLocation? background});
  BackgroundChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _BackgroundChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BackgroundChanged, $Out>
    implements BackgroundChangedCopyWith<$R, BackgroundChanged, $Out> {
  _BackgroundChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BackgroundChanged> $mapper =
      BackgroundChangedMapper.ensureInitialized();
  @override
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation> get background =>
      $value.background.copyWith.$chain((v) => call(background: v));
  @override
  $R call({ItemLocation? background}) => $apply(
    FieldCopyWithData({if (background != null) #background: background}),
  );
  @override
  BackgroundChanged $make(CopyWithData data) =>
      BackgroundChanged(data.get(#background, or: $value.background));

  @override
  BackgroundChangedCopyWith<$R2, BackgroundChanged, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BackgroundChangedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class ObjectsSpawnedMapper extends SubClassMapperBase<ObjectsSpawned> {
  ObjectsSpawnedMapper._();

  static ObjectsSpawnedMapper? _instance;
  static ObjectsSpawnedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectsSpawnedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      VectorDefinitionMapper.ensureInitialized();
      GameObjectMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectsSpawned';

  static String _$table(ObjectsSpawned v) => v.table;
  static const Field<ObjectsSpawned, String> _f$table = Field('table', _$table);
  static Map<VectorDefinition, List<GameObject>> _$objects(ObjectsSpawned v) =>
      v.objects;
  static const Field<ObjectsSpawned, Map<VectorDefinition, List<GameObject>>>
  _f$objects = Field('objects', _$objects, opt: true, def: const {});

  @override
  final MappableFields<ObjectsSpawned> fields = const {
    #table: _f$table,
    #objects: _f$objects,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ObjectsSpawned';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static ObjectsSpawned _instantiate(DecodingData data) {
    return ObjectsSpawned(data.dec(_f$table), data.dec(_f$objects));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectsSpawned fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectsSpawned>(map);
  }

  static ObjectsSpawned fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectsSpawned>(json);
  }
}

/// @nodoc
mixin ObjectsSpawnedMappable {
  String toJson() {
    return ObjectsSpawnedMapper.ensureInitialized().encodeJson<ObjectsSpawned>(
      this as ObjectsSpawned,
    );
  }

  Map<String, dynamic> toMap() {
    return ObjectsSpawnedMapper.ensureInitialized().encodeMap<ObjectsSpawned>(
      this as ObjectsSpawned,
    );
  }

  ObjectsSpawnedCopyWith<ObjectsSpawned, ObjectsSpawned, ObjectsSpawned>
  get copyWith => _ObjectsSpawnedCopyWithImpl<ObjectsSpawned, ObjectsSpawned>(
    this as ObjectsSpawned,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ObjectsSpawnedMapper.ensureInitialized().stringifyValue(
      this as ObjectsSpawned,
    );
  }

  @override
  bool operator ==(Object other) {
    return ObjectsSpawnedMapper.ensureInitialized().equalsValue(
      this as ObjectsSpawned,
      other,
    );
  }

  @override
  int get hashCode {
    return ObjectsSpawnedMapper.ensureInitialized().hashValue(
      this as ObjectsSpawned,
    );
  }
}

/// @nodoc
extension ObjectsSpawnedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectsSpawned, $Out> {
  ObjectsSpawnedCopyWith<$R, ObjectsSpawned, $Out> get $asObjectsSpawned =>
      $base.as((v, t, t2) => _ObjectsSpawnedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class ObjectsSpawnedCopyWith<$R, $In extends ObjectsSpawned, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  MapCopyWith<
    $R,
    VectorDefinition,
    List<GameObject>,
    ObjectCopyWith<$R, List<GameObject>, List<GameObject>>
  >
  get objects;
  @override
  $R call({String? table, Map<VectorDefinition, List<GameObject>>? objects});
  ObjectsSpawnedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _ObjectsSpawnedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectsSpawned, $Out>
    implements ObjectsSpawnedCopyWith<$R, ObjectsSpawned, $Out> {
  _ObjectsSpawnedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectsSpawned> $mapper =
      ObjectsSpawnedMapper.ensureInitialized();
  @override
  MapCopyWith<
    $R,
    VectorDefinition,
    List<GameObject>,
    ObjectCopyWith<$R, List<GameObject>, List<GameObject>>
  >
  get objects => MapCopyWith(
    $value.objects,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(objects: v),
  );
  @override
  $R call({String? table, Map<VectorDefinition, List<GameObject>>? objects}) =>
      $apply(
        FieldCopyWithData({
          if (table != null) #table: table,
          if (objects != null) #objects: objects,
        }),
      );
  @override
  ObjectsSpawned $make(CopyWithData data) => ObjectsSpawned(
    data.get(#table, or: $value.table),
    data.get(#objects, or: $value.objects),
  );

  @override
  ObjectsSpawnedCopyWith<$R2, ObjectsSpawned, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ObjectsSpawnedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class ObjectsMovedMapper extends SubClassMapperBase<ObjectsMoved> {
  ObjectsMovedMapper._();

  static ObjectsMovedMapper? _instance;
  static ObjectsMovedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectsMovedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectsMoved';

  static String _$table(ObjectsMoved v) => v.table;
  static const Field<ObjectsMoved, String> _f$table = Field('table', _$table);
  static List<int> _$objects(ObjectsMoved v) => v.objects;
  static const Field<ObjectsMoved, List<int>> _f$objects = Field(
    'objects',
    _$objects,
  );
  static VectorDefinition _$from(ObjectsMoved v) => v.from;
  static const Field<ObjectsMoved, VectorDefinition> _f$from = Field(
    'from',
    _$from,
  );
  static VectorDefinition _$to(ObjectsMoved v) => v.to;
  static const Field<ObjectsMoved, VectorDefinition> _f$to = Field('to', _$to);

  @override
  final MappableFields<ObjectsMoved> fields = const {
    #table: _f$table,
    #objects: _f$objects,
    #from: _f$from,
    #to: _f$to,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ObjectsMoved';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static ObjectsMoved _instantiate(DecodingData data) {
    return ObjectsMoved(
      data.dec(_f$table),
      data.dec(_f$objects),
      data.dec(_f$from),
      data.dec(_f$to),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectsMoved fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectsMoved>(map);
  }

  static ObjectsMoved fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectsMoved>(json);
  }
}

/// @nodoc
mixin ObjectsMovedMappable {
  String toJson() {
    return ObjectsMovedMapper.ensureInitialized().encodeJson<ObjectsMoved>(
      this as ObjectsMoved,
    );
  }

  Map<String, dynamic> toMap() {
    return ObjectsMovedMapper.ensureInitialized().encodeMap<ObjectsMoved>(
      this as ObjectsMoved,
    );
  }

  ObjectsMovedCopyWith<ObjectsMoved, ObjectsMoved, ObjectsMoved> get copyWith =>
      _ObjectsMovedCopyWithImpl<ObjectsMoved, ObjectsMoved>(
        this as ObjectsMoved,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ObjectsMovedMapper.ensureInitialized().stringifyValue(
      this as ObjectsMoved,
    );
  }

  @override
  bool operator ==(Object other) {
    return ObjectsMovedMapper.ensureInitialized().equalsValue(
      this as ObjectsMoved,
      other,
    );
  }

  @override
  int get hashCode {
    return ObjectsMovedMapper.ensureInitialized().hashValue(
      this as ObjectsMoved,
    );
  }
}

/// @nodoc
extension ObjectsMovedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectsMoved, $Out> {
  ObjectsMovedCopyWith<$R, ObjectsMoved, $Out> get $asObjectsMoved =>
      $base.as((v, t, t2) => _ObjectsMovedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class ObjectsMovedCopyWith<$R, $In extends ObjectsMoved, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get objects;
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get from;
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get to;
  @override
  $R call({
    String? table,
    List<int>? objects,
    VectorDefinition? from,
    VectorDefinition? to,
  });
  ObjectsMovedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _ObjectsMovedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectsMoved, $Out>
    implements ObjectsMovedCopyWith<$R, ObjectsMoved, $Out> {
  _ObjectsMovedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectsMoved> $mapper =
      ObjectsMovedMapper.ensureInitialized();
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get objects =>
      ListCopyWith(
        $value.objects,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(objects: v),
      );
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get from =>
      $value.from.copyWith.$chain((v) => call(from: v));
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition> get to =>
      $value.to.copyWith.$chain((v) => call(to: v));
  @override
  $R call({
    String? table,
    List<int>? objects,
    VectorDefinition? from,
    VectorDefinition? to,
  }) => $apply(
    FieldCopyWithData({
      if (table != null) #table: table,
      if (objects != null) #objects: objects,
      if (from != null) #from: from,
      if (to != null) #to: to,
    }),
  );
  @override
  ObjectsMoved $make(CopyWithData data) => ObjectsMoved(
    data.get(#table, or: $value.table),
    data.get(#objects, or: $value.objects),
    data.get(#from, or: $value.from),
    data.get(#to, or: $value.to),
  );

  @override
  ObjectsMovedCopyWith<$R2, ObjectsMoved, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ObjectsMovedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class CellHideChangedMapper extends SubClassMapperBase<CellHideChanged> {
  CellHideChangedMapper._();

  static CellHideChangedMapper? _instance;
  static CellHideChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CellHideChangedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GlobalVectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CellHideChanged';

  static GlobalVectorDefinition _$cell(CellHideChanged v) => v.cell;
  static const Field<CellHideChanged, GlobalVectorDefinition> _f$cell = Field(
    'cell',
    _$cell,
  );
  static int? _$object(CellHideChanged v) => v.object;
  static const Field<CellHideChanged, int> _f$object = Field(
    'object',
    _$object,
    opt: true,
  );
  static bool? _$hide(CellHideChanged v) => v.hide;
  static const Field<CellHideChanged, bool> _f$hide = Field(
    'hide',
    _$hide,
    opt: true,
  );

  @override
  final MappableFields<CellHideChanged> fields = const {
    #cell: _f$cell,
    #object: _f$object,
    #hide: _f$hide,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'CellHideChanged';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static CellHideChanged _instantiate(DecodingData data) {
    return CellHideChanged(
      data.dec(_f$cell),
      object: data.dec(_f$object),
      hide: data.dec(_f$hide),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CellHideChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CellHideChanged>(map);
  }

  static CellHideChanged fromJson(String json) {
    return ensureInitialized().decodeJson<CellHideChanged>(json);
  }
}

/// @nodoc
mixin CellHideChangedMappable {
  String toJson() {
    return CellHideChangedMapper.ensureInitialized()
        .encodeJson<CellHideChanged>(this as CellHideChanged);
  }

  Map<String, dynamic> toMap() {
    return CellHideChangedMapper.ensureInitialized().encodeMap<CellHideChanged>(
      this as CellHideChanged,
    );
  }

  CellHideChangedCopyWith<CellHideChanged, CellHideChanged, CellHideChanged>
  get copyWith =>
      _CellHideChangedCopyWithImpl<CellHideChanged, CellHideChanged>(
        this as CellHideChanged,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CellHideChangedMapper.ensureInitialized().stringifyValue(
      this as CellHideChanged,
    );
  }

  @override
  bool operator ==(Object other) {
    return CellHideChangedMapper.ensureInitialized().equalsValue(
      this as CellHideChanged,
      other,
    );
  }

  @override
  int get hashCode {
    return CellHideChangedMapper.ensureInitialized().hashValue(
      this as CellHideChanged,
    );
  }
}

/// @nodoc
extension CellHideChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CellHideChanged, $Out> {
  CellHideChangedCopyWith<$R, CellHideChanged, $Out> get $asCellHideChanged =>
      $base.as((v, t, t2) => _CellHideChangedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class CellHideChangedCopyWith<$R, $In extends CellHideChanged, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get cell;
  @override
  $R call({GlobalVectorDefinition? cell, int? object, bool? hide});
  CellHideChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _CellHideChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CellHideChanged, $Out>
    implements CellHideChangedCopyWith<$R, CellHideChanged, $Out> {
  _CellHideChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CellHideChanged> $mapper =
      CellHideChangedMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get cell => $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  $R call({
    GlobalVectorDefinition? cell,
    Object? object = $none,
    Object? hide = $none,
  }) => $apply(
    FieldCopyWithData({
      if (cell != null) #cell: cell,
      if (object != $none) #object: object,
      if (hide != $none) #hide: hide,
    }),
  );
  @override
  CellHideChanged $make(CopyWithData data) => CellHideChanged(
    data.get(#cell, or: $value.cell),
    object: data.get(#object, or: $value.object),
    hide: data.get(#hide, or: $value.hide),
  );

  @override
  CellHideChangedCopyWith<$R2, CellHideChanged, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CellHideChangedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class ObjectIndexChangedMapper extends SubClassMapperBase<ObjectIndexChanged> {
  ObjectIndexChangedMapper._();

  static ObjectIndexChangedMapper? _instance;
  static ObjectIndexChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectIndexChangedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GlobalVectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectIndexChanged';

  static GlobalVectorDefinition _$cell(ObjectIndexChanged v) => v.cell;
  static const Field<ObjectIndexChanged, GlobalVectorDefinition> _f$cell =
      Field('cell', _$cell);
  static int _$object(ObjectIndexChanged v) => v.object;
  static const Field<ObjectIndexChanged, int> _f$object = Field(
    'object',
    _$object,
  );
  static int _$index(ObjectIndexChanged v) => v.index;
  static const Field<ObjectIndexChanged, int> _f$index = Field(
    'index',
    _$index,
  );

  @override
  final MappableFields<ObjectIndexChanged> fields = const {
    #cell: _f$cell,
    #object: _f$object,
    #index: _f$index,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ObjectIndexChanged';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static ObjectIndexChanged _instantiate(DecodingData data) {
    return ObjectIndexChanged(
      data.dec(_f$cell),
      data.dec(_f$object),
      data.dec(_f$index),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectIndexChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectIndexChanged>(map);
  }

  static ObjectIndexChanged fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectIndexChanged>(json);
  }
}

/// @nodoc
mixin ObjectIndexChangedMappable {
  String toJson() {
    return ObjectIndexChangedMapper.ensureInitialized()
        .encodeJson<ObjectIndexChanged>(this as ObjectIndexChanged);
  }

  Map<String, dynamic> toMap() {
    return ObjectIndexChangedMapper.ensureInitialized()
        .encodeMap<ObjectIndexChanged>(this as ObjectIndexChanged);
  }

  ObjectIndexChangedCopyWith<
    ObjectIndexChanged,
    ObjectIndexChanged,
    ObjectIndexChanged
  >
  get copyWith =>
      _ObjectIndexChangedCopyWithImpl<ObjectIndexChanged, ObjectIndexChanged>(
        this as ObjectIndexChanged,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ObjectIndexChangedMapper.ensureInitialized().stringifyValue(
      this as ObjectIndexChanged,
    );
  }

  @override
  bool operator ==(Object other) {
    return ObjectIndexChangedMapper.ensureInitialized().equalsValue(
      this as ObjectIndexChanged,
      other,
    );
  }

  @override
  int get hashCode {
    return ObjectIndexChangedMapper.ensureInitialized().hashValue(
      this as ObjectIndexChanged,
    );
  }
}

/// @nodoc
extension ObjectIndexChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectIndexChanged, $Out> {
  ObjectIndexChangedCopyWith<$R, ObjectIndexChanged, $Out>
  get $asObjectIndexChanged => $base.as(
    (v, t, t2) => _ObjectIndexChangedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class ObjectIndexChangedCopyWith<
  $R,
  $In extends ObjectIndexChanged,
  $Out
>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get cell;
  @override
  $R call({GlobalVectorDefinition? cell, int? object, int? index});
  ObjectIndexChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _ObjectIndexChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectIndexChanged, $Out>
    implements ObjectIndexChangedCopyWith<$R, ObjectIndexChanged, $Out> {
  _ObjectIndexChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectIndexChanged> $mapper =
      ObjectIndexChangedMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get cell => $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  $R call({GlobalVectorDefinition? cell, int? object, int? index}) => $apply(
    FieldCopyWithData({
      if (cell != null) #cell: cell,
      if (object != null) #object: object,
      if (index != null) #index: index,
    }),
  );
  @override
  ObjectIndexChanged $make(CopyWithData data) => ObjectIndexChanged(
    data.get(#cell, or: $value.cell),
    data.get(#object, or: $value.object),
    data.get(#index, or: $value.index),
  );

  @override
  ObjectIndexChangedCopyWith<$R2, ObjectIndexChanged, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ObjectIndexChangedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class TeamChangedMapper extends SubClassMapperBase<TeamChanged> {
  TeamChangedMapper._();

  static TeamChangedMapper? _instance;
  static TeamChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TeamChangedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GameTeamMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TeamChanged';

  static String _$name(TeamChanged v) => v.name;
  static const Field<TeamChanged, String> _f$name = Field('name', _$name);
  static String? _$newName(TeamChanged v) => v.newName;
  static const Field<TeamChanged, String> _f$newName = Field(
    'newName',
    _$newName,
  );
  static GameTeam _$team(TeamChanged v) => v.team;
  static const Field<TeamChanged, GameTeam> _f$team = Field('team', _$team);

  @override
  final MappableFields<TeamChanged> fields = const {
    #name: _f$name,
    #newName: _f$newName,
    #team: _f$team,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TeamChanged';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static TeamChanged _instantiate(DecodingData data) {
    return TeamChanged.rename(
      data.dec(_f$name),
      data.dec(_f$newName),
      data.dec(_f$team),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TeamChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TeamChanged>(map);
  }

  static TeamChanged fromJson(String json) {
    return ensureInitialized().decodeJson<TeamChanged>(json);
  }
}

/// @nodoc
mixin TeamChangedMappable {
  String toJson() {
    return TeamChangedMapper.ensureInitialized().encodeJson<TeamChanged>(
      this as TeamChanged,
    );
  }

  Map<String, dynamic> toMap() {
    return TeamChangedMapper.ensureInitialized().encodeMap<TeamChanged>(
      this as TeamChanged,
    );
  }

  TeamChangedCopyWith<TeamChanged, TeamChanged, TeamChanged> get copyWith =>
      _TeamChangedCopyWithImpl<TeamChanged, TeamChanged>(
        this as TeamChanged,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TeamChangedMapper.ensureInitialized().stringifyValue(
      this as TeamChanged,
    );
  }

  @override
  bool operator ==(Object other) {
    return TeamChangedMapper.ensureInitialized().equalsValue(
      this as TeamChanged,
      other,
    );
  }

  @override
  int get hashCode {
    return TeamChangedMapper.ensureInitialized().hashValue(this as TeamChanged);
  }
}

/// @nodoc
extension TeamChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TeamChanged, $Out> {
  TeamChangedCopyWith<$R, TeamChanged, $Out> get $asTeamChanged =>
      $base.as((v, t, t2) => _TeamChangedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class TeamChangedCopyWith<$R, $In extends TeamChanged, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  GameTeamCopyWith<$R, GameTeam, GameTeam> get team;
  @override
  $R call({String? name, String? newName, GameTeam? team});
  TeamChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _TeamChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TeamChanged, $Out>
    implements TeamChangedCopyWith<$R, TeamChanged, $Out> {
  _TeamChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TeamChanged> $mapper =
      TeamChangedMapper.ensureInitialized();
  @override
  GameTeamCopyWith<$R, GameTeam, GameTeam> get team =>
      $value.team.copyWith.$chain((v) => call(team: v));
  @override
  $R call({String? name, Object? newName = $none, GameTeam? team}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (newName != $none) #newName: newName,
      if (team != null) #team: team,
    }),
  );
  @override
  TeamChanged $make(CopyWithData data) => TeamChanged.rename(
    data.get(#name, or: $value.name),
    data.get(#newName, or: $value.newName),
    data.get(#team, or: $value.team),
  );

  @override
  TeamChangedCopyWith<$R2, TeamChanged, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TeamChangedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class TeamRemovedMapper extends SubClassMapperBase<TeamRemoved> {
  TeamRemovedMapper._();

  static TeamRemovedMapper? _instance;
  static TeamRemovedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TeamRemovedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'TeamRemoved';

  static String _$team(TeamRemoved v) => v.team;
  static const Field<TeamRemoved, String> _f$team = Field('team', _$team);

  @override
  final MappableFields<TeamRemoved> fields = const {#team: _f$team};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TeamRemoved';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static TeamRemoved _instantiate(DecodingData data) {
    return TeamRemoved(data.dec(_f$team));
  }

  @override
  final Function instantiate = _instantiate;

  static TeamRemoved fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TeamRemoved>(map);
  }

  static TeamRemoved fromJson(String json) {
    return ensureInitialized().decodeJson<TeamRemoved>(json);
  }
}

/// @nodoc
mixin TeamRemovedMappable {
  String toJson() {
    return TeamRemovedMapper.ensureInitialized().encodeJson<TeamRemoved>(
      this as TeamRemoved,
    );
  }

  Map<String, dynamic> toMap() {
    return TeamRemovedMapper.ensureInitialized().encodeMap<TeamRemoved>(
      this as TeamRemoved,
    );
  }

  TeamRemovedCopyWith<TeamRemoved, TeamRemoved, TeamRemoved> get copyWith =>
      _TeamRemovedCopyWithImpl<TeamRemoved, TeamRemoved>(
        this as TeamRemoved,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TeamRemovedMapper.ensureInitialized().stringifyValue(
      this as TeamRemoved,
    );
  }

  @override
  bool operator ==(Object other) {
    return TeamRemovedMapper.ensureInitialized().equalsValue(
      this as TeamRemoved,
      other,
    );
  }

  @override
  int get hashCode {
    return TeamRemovedMapper.ensureInitialized().hashValue(this as TeamRemoved);
  }
}

/// @nodoc
extension TeamRemovedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TeamRemoved, $Out> {
  TeamRemovedCopyWith<$R, TeamRemoved, $Out> get $asTeamRemoved =>
      $base.as((v, t, t2) => _TeamRemovedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class TeamRemovedCopyWith<$R, $In extends TeamRemoved, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? team});
  TeamRemovedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _TeamRemovedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TeamRemoved, $Out>
    implements TeamRemovedCopyWith<$R, TeamRemoved, $Out> {
  _TeamRemovedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TeamRemoved> $mapper =
      TeamRemovedMapper.ensureInitialized();
  @override
  $R call({String? team}) =>
      $apply(FieldCopyWithData({if (team != null) #team: team}));
  @override
  TeamRemoved $make(CopyWithData data) =>
      TeamRemoved(data.get(#team, or: $value.team));

  @override
  TeamRemovedCopyWith<$R2, TeamRemoved, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TeamRemovedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class CellMergeStrategyChangedMapper
    extends SubClassMapperBase<CellMergeStrategyChanged> {
  CellMergeStrategyChangedMapper._();

  static CellMergeStrategyChangedMapper? _instance;
  static CellMergeStrategyChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = CellMergeStrategyChangedMapper._(),
      );
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GlobalVectorDefinitionMapper.ensureInitialized();
      CellMergeStrategyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CellMergeStrategyChanged';

  static GlobalVectorDefinition _$cell(CellMergeStrategyChanged v) => v.cell;
  static const Field<CellMergeStrategyChanged, GlobalVectorDefinition> _f$cell =
      Field('cell', _$cell);
  static CellMergeStrategy? _$strategy(CellMergeStrategyChanged v) =>
      v.strategy;
  static const Field<CellMergeStrategyChanged, CellMergeStrategy> _f$strategy =
      Field('strategy', _$strategy);
  static int _$span(CellMergeStrategyChanged v) => v.span;
  static const Field<CellMergeStrategyChanged, int> _f$span = Field(
    'span',
    _$span,
    opt: true,
    def: 1,
  );

  @override
  final MappableFields<CellMergeStrategyChanged> fields = const {
    #cell: _f$cell,
    #strategy: _f$strategy,
    #span: _f$span,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'CellMergeStrategyChanged';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static CellMergeStrategyChanged _instantiate(DecodingData data) {
    return CellMergeStrategyChanged(
      data.dec(_f$cell),
      data.dec(_f$strategy),
      span: data.dec(_f$span),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CellMergeStrategyChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CellMergeStrategyChanged>(map);
  }

  static CellMergeStrategyChanged fromJson(String json) {
    return ensureInitialized().decodeJson<CellMergeStrategyChanged>(json);
  }
}

/// @nodoc
mixin CellMergeStrategyChangedMappable {
  String toJson() {
    return CellMergeStrategyChangedMapper.ensureInitialized()
        .encodeJson<CellMergeStrategyChanged>(this as CellMergeStrategyChanged);
  }

  Map<String, dynamic> toMap() {
    return CellMergeStrategyChangedMapper.ensureInitialized()
        .encodeMap<CellMergeStrategyChanged>(this as CellMergeStrategyChanged);
  }

  CellMergeStrategyChangedCopyWith<
    CellMergeStrategyChanged,
    CellMergeStrategyChanged,
    CellMergeStrategyChanged
  >
  get copyWith =>
      _CellMergeStrategyChangedCopyWithImpl<
        CellMergeStrategyChanged,
        CellMergeStrategyChanged
      >(this as CellMergeStrategyChanged, $identity, $identity);
  @override
  String toString() {
    return CellMergeStrategyChangedMapper.ensureInitialized().stringifyValue(
      this as CellMergeStrategyChanged,
    );
  }

  @override
  bool operator ==(Object other) {
    return CellMergeStrategyChangedMapper.ensureInitialized().equalsValue(
      this as CellMergeStrategyChanged,
      other,
    );
  }

  @override
  int get hashCode {
    return CellMergeStrategyChangedMapper.ensureInitialized().hashValue(
      this as CellMergeStrategyChanged,
    );
  }
}

/// @nodoc
extension CellMergeStrategyChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CellMergeStrategyChanged, $Out> {
  CellMergeStrategyChangedCopyWith<$R, CellMergeStrategyChanged, $Out>
  get $asCellMergeStrategyChanged => $base.as(
    (v, t, t2) => _CellMergeStrategyChangedCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class CellMergeStrategyChangedCopyWith<
  $R,
  $In extends CellMergeStrategyChanged,
  $Out
>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get cell;
  CellMergeStrategyCopyWith<$R, CellMergeStrategy, CellMergeStrategy>?
  get strategy;
  @override
  $R call({
    GlobalVectorDefinition? cell,
    CellMergeStrategy? strategy,
    int? span,
  });
  CellMergeStrategyChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _CellMergeStrategyChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CellMergeStrategyChanged, $Out>
    implements
        CellMergeStrategyChangedCopyWith<$R, CellMergeStrategyChanged, $Out> {
  _CellMergeStrategyChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CellMergeStrategyChanged> $mapper =
      CellMergeStrategyChangedMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get cell => $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  CellMergeStrategyCopyWith<$R, CellMergeStrategy, CellMergeStrategy>?
  get strategy => $value.strategy?.copyWith.$chain((v) => call(strategy: v));
  @override
  $R call({
    GlobalVectorDefinition? cell,
    Object? strategy = $none,
    int? span,
  }) => $apply(
    FieldCopyWithData({
      if (cell != null) #cell: cell,
      if (strategy != $none) #strategy: strategy,
      if (span != null) #span: span,
    }),
  );
  @override
  CellMergeStrategyChanged $make(CopyWithData data) => CellMergeStrategyChanged(
    data.get(#cell, or: $value.cell),
    data.get(#strategy, or: $value.strategy),
    span: data.get(#span, or: $value.span),
  );

  @override
  CellMergeStrategyChangedCopyWith<$R2, CellMergeStrategyChanged, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CellMergeStrategyChangedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class MetadataChangedMapper extends SubClassMapperBase<MetadataChanged> {
  MetadataChangedMapper._();

  static MetadataChangedMapper? _instance;
  static MetadataChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MetadataChangedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      FileMetadataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MetadataChanged';

  static FileMetadata _$metadata(MetadataChanged v) => v.metadata;
  static const Field<MetadataChanged, FileMetadata> _f$metadata = Field(
    'metadata',
    _$metadata,
  );

  @override
  final MappableFields<MetadataChanged> fields = const {#metadata: _f$metadata};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'MetadataChanged';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static MetadataChanged _instantiate(DecodingData data) {
    return MetadataChanged(data.dec(_f$metadata));
  }

  @override
  final Function instantiate = _instantiate;

  static MetadataChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MetadataChanged>(map);
  }

  static MetadataChanged fromJson(String json) {
    return ensureInitialized().decodeJson<MetadataChanged>(json);
  }
}

/// @nodoc
mixin MetadataChangedMappable {
  String toJson() {
    return MetadataChangedMapper.ensureInitialized()
        .encodeJson<MetadataChanged>(this as MetadataChanged);
  }

  Map<String, dynamic> toMap() {
    return MetadataChangedMapper.ensureInitialized().encodeMap<MetadataChanged>(
      this as MetadataChanged,
    );
  }

  MetadataChangedCopyWith<MetadataChanged, MetadataChanged, MetadataChanged>
  get copyWith =>
      _MetadataChangedCopyWithImpl<MetadataChanged, MetadataChanged>(
        this as MetadataChanged,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MetadataChangedMapper.ensureInitialized().stringifyValue(
      this as MetadataChanged,
    );
  }

  @override
  bool operator ==(Object other) {
    return MetadataChangedMapper.ensureInitialized().equalsValue(
      this as MetadataChanged,
      other,
    );
  }

  @override
  int get hashCode {
    return MetadataChangedMapper.ensureInitialized().hashValue(
      this as MetadataChanged,
    );
  }
}

/// @nodoc
extension MetadataChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MetadataChanged, $Out> {
  MetadataChangedCopyWith<$R, MetadataChanged, $Out> get $asMetadataChanged =>
      $base.as((v, t, t2) => _MetadataChangedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class MetadataChangedCopyWith<$R, $In extends MetadataChanged, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  FileMetadataCopyWith<$R, FileMetadata, FileMetadata> get metadata;
  @override
  $R call({FileMetadata? metadata});
  MetadataChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _MetadataChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MetadataChanged, $Out>
    implements MetadataChangedCopyWith<$R, MetadataChanged, $Out> {
  _MetadataChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MetadataChanged> $mapper =
      MetadataChangedMapper.ensureInitialized();
  @override
  FileMetadataCopyWith<$R, FileMetadata, FileMetadata> get metadata =>
      $value.metadata.copyWith.$chain((v) => call(metadata: v));
  @override
  $R call({FileMetadata? metadata}) =>
      $apply(FieldCopyWithData({if (metadata != null) #metadata: metadata}));
  @override
  MetadataChanged $make(CopyWithData data) =>
      MetadataChanged(data.get(#metadata, or: $value.metadata));

  @override
  MetadataChangedCopyWith<$R2, MetadataChanged, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MetadataChangedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class ObjectsRemovedMapper extends SubClassMapperBase<ObjectsRemoved> {
  ObjectsRemovedMapper._();

  static ObjectsRemovedMapper? _instance;
  static ObjectsRemovedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ObjectsRemovedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      GlobalVectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ObjectsRemoved';

  static GlobalVectorDefinition _$cell(ObjectsRemoved v) => v.cell;
  static const Field<ObjectsRemoved, GlobalVectorDefinition> _f$cell = Field(
    'cell',
    _$cell,
  );
  static List<int>? _$objects(ObjectsRemoved v) => v.objects;
  static const Field<ObjectsRemoved, List<int>> _f$objects = Field(
    'objects',
    _$objects,
    opt: true,
  );

  @override
  final MappableFields<ObjectsRemoved> fields = const {
    #cell: _f$cell,
    #objects: _f$objects,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ObjectsRemoved';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static ObjectsRemoved _instantiate(DecodingData data) {
    return ObjectsRemoved(data.dec(_f$cell), objects: data.dec(_f$objects));
  }

  @override
  final Function instantiate = _instantiate;

  static ObjectsRemoved fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ObjectsRemoved>(map);
  }

  static ObjectsRemoved fromJson(String json) {
    return ensureInitialized().decodeJson<ObjectsRemoved>(json);
  }
}

/// @nodoc
mixin ObjectsRemovedMappable {
  String toJson() {
    return ObjectsRemovedMapper.ensureInitialized().encodeJson<ObjectsRemoved>(
      this as ObjectsRemoved,
    );
  }

  Map<String, dynamic> toMap() {
    return ObjectsRemovedMapper.ensureInitialized().encodeMap<ObjectsRemoved>(
      this as ObjectsRemoved,
    );
  }

  ObjectsRemovedCopyWith<ObjectsRemoved, ObjectsRemoved, ObjectsRemoved>
  get copyWith => _ObjectsRemovedCopyWithImpl<ObjectsRemoved, ObjectsRemoved>(
    this as ObjectsRemoved,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ObjectsRemovedMapper.ensureInitialized().stringifyValue(
      this as ObjectsRemoved,
    );
  }

  @override
  bool operator ==(Object other) {
    return ObjectsRemovedMapper.ensureInitialized().equalsValue(
      this as ObjectsRemoved,
      other,
    );
  }

  @override
  int get hashCode {
    return ObjectsRemovedMapper.ensureInitialized().hashValue(
      this as ObjectsRemoved,
    );
  }
}

/// @nodoc
extension ObjectsRemovedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ObjectsRemoved, $Out> {
  ObjectsRemovedCopyWith<$R, ObjectsRemoved, $Out> get $asObjectsRemoved =>
      $base.as((v, t, t2) => _ObjectsRemovedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class ObjectsRemovedCopyWith<$R, $In extends ObjectsRemoved, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get cell;
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>>? get objects;
  @override
  $R call({GlobalVectorDefinition? cell, List<int>? objects});
  ObjectsRemovedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _ObjectsRemovedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ObjectsRemoved, $Out>
    implements ObjectsRemovedCopyWith<$R, ObjectsRemoved, $Out> {
  _ObjectsRemovedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ObjectsRemoved> $mapper =
      ObjectsRemovedMapper.ensureInitialized();
  @override
  GlobalVectorDefinitionCopyWith<
    $R,
    GlobalVectorDefinition,
    GlobalVectorDefinition
  >
  get cell => $value.cell.copyWith.$chain((v) => call(cell: v));
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>>? get objects =>
      $value.objects != null
      ? ListCopyWith(
          $value.objects!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(objects: v),
        )
      : null;
  @override
  $R call({GlobalVectorDefinition? cell, Object? objects = $none}) => $apply(
    FieldCopyWithData({
      if (cell != null) #cell: cell,
      if (objects != $none) #objects: objects,
    }),
  );
  @override
  ObjectsRemoved $make(CopyWithData data) => ObjectsRemoved(
    data.get(#cell, or: $value.cell),
    objects: data.get(#objects, or: $value.objects),
  );

  @override
  ObjectsRemovedCopyWith<$R2, ObjectsRemoved, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ObjectsRemovedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class TableRenamedMapper extends SubClassMapperBase<TableRenamed> {
  TableRenamedMapper._();

  static TableRenamedMapper? _instance;
  static TableRenamedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TableRenamedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'TableRenamed';

  static String _$name(TableRenamed v) => v.name;
  static const Field<TableRenamed, String> _f$name = Field('name', _$name);
  static String _$newName(TableRenamed v) => v.newName;
  static const Field<TableRenamed, String> _f$newName = Field(
    'newName',
    _$newName,
  );

  @override
  final MappableFields<TableRenamed> fields = const {
    #name: _f$name,
    #newName: _f$newName,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TableRenamed';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static TableRenamed _instantiate(DecodingData data) {
    return TableRenamed(data.dec(_f$name), data.dec(_f$newName));
  }

  @override
  final Function instantiate = _instantiate;

  static TableRenamed fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TableRenamed>(map);
  }

  static TableRenamed fromJson(String json) {
    return ensureInitialized().decodeJson<TableRenamed>(json);
  }
}

/// @nodoc
mixin TableRenamedMappable {
  String toJson() {
    return TableRenamedMapper.ensureInitialized().encodeJson<TableRenamed>(
      this as TableRenamed,
    );
  }

  Map<String, dynamic> toMap() {
    return TableRenamedMapper.ensureInitialized().encodeMap<TableRenamed>(
      this as TableRenamed,
    );
  }

  TableRenamedCopyWith<TableRenamed, TableRenamed, TableRenamed> get copyWith =>
      _TableRenamedCopyWithImpl<TableRenamed, TableRenamed>(
        this as TableRenamed,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TableRenamedMapper.ensureInitialized().stringifyValue(
      this as TableRenamed,
    );
  }

  @override
  bool operator ==(Object other) {
    return TableRenamedMapper.ensureInitialized().equalsValue(
      this as TableRenamed,
      other,
    );
  }

  @override
  int get hashCode {
    return TableRenamedMapper.ensureInitialized().hashValue(
      this as TableRenamed,
    );
  }
}

/// @nodoc
extension TableRenamedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TableRenamed, $Out> {
  TableRenamedCopyWith<$R, TableRenamed, $Out> get $asTableRenamed =>
      $base.as((v, t, t2) => _TableRenamedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class TableRenamedCopyWith<$R, $In extends TableRenamed, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? name, String? newName});
  TableRenamedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _TableRenamedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TableRenamed, $Out>
    implements TableRenamedCopyWith<$R, TableRenamed, $Out> {
  _TableRenamedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TableRenamed> $mapper =
      TableRenamedMapper.ensureInitialized();
  @override
  $R call({String? name, String? newName}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (newName != null) #newName: newName,
    }),
  );
  @override
  TableRenamed $make(CopyWithData data) => TableRenamed(
    data.get(#name, or: $value.name),
    data.get(#newName, or: $value.newName),
  );

  @override
  TableRenamedCopyWith<$R2, TableRenamed, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TableRenamedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class TableRemovedMapper extends SubClassMapperBase<TableRemoved> {
  TableRemovedMapper._();

  static TableRemovedMapper? _instance;
  static TableRemovedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TableRemovedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'TableRemoved';

  static String _$name(TableRemoved v) => v.name;
  static const Field<TableRemoved, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<TableRemoved> fields = const {#name: _f$name};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'TableRemoved';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static TableRemoved _instantiate(DecodingData data) {
    return TableRemoved(data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static TableRemoved fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TableRemoved>(map);
  }

  static TableRemoved fromJson(String json) {
    return ensureInitialized().decodeJson<TableRemoved>(json);
  }
}

/// @nodoc
mixin TableRemovedMappable {
  String toJson() {
    return TableRemovedMapper.ensureInitialized().encodeJson<TableRemoved>(
      this as TableRemoved,
    );
  }

  Map<String, dynamic> toMap() {
    return TableRemovedMapper.ensureInitialized().encodeMap<TableRemoved>(
      this as TableRemoved,
    );
  }

  TableRemovedCopyWith<TableRemoved, TableRemoved, TableRemoved> get copyWith =>
      _TableRemovedCopyWithImpl<TableRemoved, TableRemoved>(
        this as TableRemoved,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TableRemovedMapper.ensureInitialized().stringifyValue(
      this as TableRemoved,
    );
  }

  @override
  bool operator ==(Object other) {
    return TableRemovedMapper.ensureInitialized().equalsValue(
      this as TableRemoved,
      other,
    );
  }

  @override
  int get hashCode {
    return TableRemovedMapper.ensureInitialized().hashValue(
      this as TableRemoved,
    );
  }
}

/// @nodoc
extension TableRemovedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TableRemoved, $Out> {
  TableRemovedCopyWith<$R, TableRemoved, $Out> get $asTableRemoved =>
      $base.as((v, t, t2) => _TableRemovedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class TableRemovedCopyWith<$R, $In extends TableRemoved, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? name});
  TableRemovedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _TableRemovedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TableRemoved, $Out>
    implements TableRemovedCopyWith<$R, TableRemoved, $Out> {
  _TableRemovedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TableRemoved> $mapper =
      TableRemovedMapper.ensureInitialized();
  @override
  $R call({String? name}) =>
      $apply(FieldCopyWithData({if (name != null) #name: name}));
  @override
  TableRemoved $make(CopyWithData data) =>
      TableRemoved(data.get(#name, or: $value.name));

  @override
  TableRemovedCopyWith<$R2, TableRemoved, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TableRemovedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class NoteChangedMapper extends SubClassMapperBase<NoteChanged> {
  NoteChangedMapper._();

  static NoteChangedMapper? _instance;
  static NoteChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NoteChangedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'NoteChanged';

  static String _$name(NoteChanged v) => v.name;
  static const Field<NoteChanged, String> _f$name = Field('name', _$name);
  static String _$content(NoteChanged v) => v.content;
  static const Field<NoteChanged, String> _f$content = Field(
    'content',
    _$content,
  );

  @override
  final MappableFields<NoteChanged> fields = const {
    #name: _f$name,
    #content: _f$content,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'NoteChanged';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static NoteChanged _instantiate(DecodingData data) {
    return NoteChanged(data.dec(_f$name), data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static NoteChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NoteChanged>(map);
  }

  static NoteChanged fromJson(String json) {
    return ensureInitialized().decodeJson<NoteChanged>(json);
  }
}

/// @nodoc
mixin NoteChangedMappable {
  String toJson() {
    return NoteChangedMapper.ensureInitialized().encodeJson<NoteChanged>(
      this as NoteChanged,
    );
  }

  Map<String, dynamic> toMap() {
    return NoteChangedMapper.ensureInitialized().encodeMap<NoteChanged>(
      this as NoteChanged,
    );
  }

  NoteChangedCopyWith<NoteChanged, NoteChanged, NoteChanged> get copyWith =>
      _NoteChangedCopyWithImpl<NoteChanged, NoteChanged>(
        this as NoteChanged,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return NoteChangedMapper.ensureInitialized().stringifyValue(
      this as NoteChanged,
    );
  }

  @override
  bool operator ==(Object other) {
    return NoteChangedMapper.ensureInitialized().equalsValue(
      this as NoteChanged,
      other,
    );
  }

  @override
  int get hashCode {
    return NoteChangedMapper.ensureInitialized().hashValue(this as NoteChanged);
  }
}

/// @nodoc
extension NoteChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NoteChanged, $Out> {
  NoteChangedCopyWith<$R, NoteChanged, $Out> get $asNoteChanged =>
      $base.as((v, t, t2) => _NoteChangedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class NoteChangedCopyWith<$R, $In extends NoteChanged, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? name, String? content});
  NoteChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _NoteChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NoteChanged, $Out>
    implements NoteChangedCopyWith<$R, NoteChanged, $Out> {
  _NoteChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NoteChanged> $mapper =
      NoteChangedMapper.ensureInitialized();
  @override
  $R call({String? name, String? content}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (content != null) #content: content,
    }),
  );
  @override
  NoteChanged $make(CopyWithData data) => NoteChanged(
    data.get(#name, or: $value.name),
    data.get(#content, or: $value.content),
  );

  @override
  NoteChangedCopyWith<$R2, NoteChanged, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _NoteChangedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class NoteRemovedMapper extends SubClassMapperBase<NoteRemoved> {
  NoteRemovedMapper._();

  static NoteRemovedMapper? _instance;
  static NoteRemovedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NoteRemovedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'NoteRemoved';

  static String _$name(NoteRemoved v) => v.name;
  static const Field<NoteRemoved, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<NoteRemoved> fields = const {#name: _f$name};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'NoteRemoved';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static NoteRemoved _instantiate(DecodingData data) {
    return NoteRemoved(data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static NoteRemoved fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NoteRemoved>(map);
  }

  static NoteRemoved fromJson(String json) {
    return ensureInitialized().decodeJson<NoteRemoved>(json);
  }
}

/// @nodoc
mixin NoteRemovedMappable {
  String toJson() {
    return NoteRemovedMapper.ensureInitialized().encodeJson<NoteRemoved>(
      this as NoteRemoved,
    );
  }

  Map<String, dynamic> toMap() {
    return NoteRemovedMapper.ensureInitialized().encodeMap<NoteRemoved>(
      this as NoteRemoved,
    );
  }

  NoteRemovedCopyWith<NoteRemoved, NoteRemoved, NoteRemoved> get copyWith =>
      _NoteRemovedCopyWithImpl<NoteRemoved, NoteRemoved>(
        this as NoteRemoved,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return NoteRemovedMapper.ensureInitialized().stringifyValue(
      this as NoteRemoved,
    );
  }

  @override
  bool operator ==(Object other) {
    return NoteRemovedMapper.ensureInitialized().equalsValue(
      this as NoteRemoved,
      other,
    );
  }

  @override
  int get hashCode {
    return NoteRemovedMapper.ensureInitialized().hashValue(this as NoteRemoved);
  }
}

/// @nodoc
extension NoteRemovedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, NoteRemoved, $Out> {
  NoteRemovedCopyWith<$R, NoteRemoved, $Out> get $asNoteRemoved =>
      $base.as((v, t, t2) => _NoteRemovedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class NoteRemovedCopyWith<$R, $In extends NoteRemoved, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? name});
  NoteRemovedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _NoteRemovedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NoteRemoved, $Out>
    implements NoteRemovedCopyWith<$R, NoteRemoved, $Out> {
  _NoteRemovedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NoteRemoved> $mapper =
      NoteRemovedMapper.ensureInitialized();
  @override
  $R call({String? name}) =>
      $apply(FieldCopyWithData({if (name != null) #name: name}));
  @override
  NoteRemoved $make(CopyWithData data) =>
      NoteRemoved(data.get(#name, or: $value.name));

  @override
  NoteRemovedCopyWith<$R2, NoteRemoved, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _NoteRemovedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class WaypointChangedMapper extends SubClassMapperBase<WaypointChanged> {
  WaypointChangedMapper._();

  static WaypointChangedMapper? _instance;
  static WaypointChangedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WaypointChangedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
      WaypointMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WaypointChanged';

  static String? _$team(WaypointChanged v) => v.team;
  static const Field<WaypointChanged, String> _f$team = Field(
    'team',
    _$team,
    opt: true,
  );
  static Waypoint _$waypoint(WaypointChanged v) => v.waypoint;
  static const Field<WaypointChanged, Waypoint> _f$waypoint = Field(
    'waypoint',
    _$waypoint,
  );
  static String? _$name(WaypointChanged v) => v.name;
  static const Field<WaypointChanged, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );

  @override
  final MappableFields<WaypointChanged> fields = const {
    #team: _f$team,
    #waypoint: _f$waypoint,
    #name: _f$name,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'WaypointChanged';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static WaypointChanged _instantiate(DecodingData data) {
    return WaypointChanged(
      team: data.dec(_f$team),
      waypoint: data.dec(_f$waypoint),
      name: data.dec(_f$name),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WaypointChanged fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WaypointChanged>(map);
  }

  static WaypointChanged fromJson(String json) {
    return ensureInitialized().decodeJson<WaypointChanged>(json);
  }
}

/// @nodoc
mixin WaypointChangedMappable {
  String toJson() {
    return WaypointChangedMapper.ensureInitialized()
        .encodeJson<WaypointChanged>(this as WaypointChanged);
  }

  Map<String, dynamic> toMap() {
    return WaypointChangedMapper.ensureInitialized().encodeMap<WaypointChanged>(
      this as WaypointChanged,
    );
  }

  WaypointChangedCopyWith<WaypointChanged, WaypointChanged, WaypointChanged>
  get copyWith =>
      _WaypointChangedCopyWithImpl<WaypointChanged, WaypointChanged>(
        this as WaypointChanged,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WaypointChangedMapper.ensureInitialized().stringifyValue(
      this as WaypointChanged,
    );
  }

  @override
  bool operator ==(Object other) {
    return WaypointChangedMapper.ensureInitialized().equalsValue(
      this as WaypointChanged,
      other,
    );
  }

  @override
  int get hashCode {
    return WaypointChangedMapper.ensureInitialized().hashValue(
      this as WaypointChanged,
    );
  }
}

/// @nodoc
extension WaypointChangedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WaypointChanged, $Out> {
  WaypointChangedCopyWith<$R, WaypointChanged, $Out> get $asWaypointChanged =>
      $base.as((v, t, t2) => _WaypointChangedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class WaypointChangedCopyWith<$R, $In extends WaypointChanged, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  WaypointCopyWith<$R, Waypoint, Waypoint> get waypoint;
  @override
  $R call({String? team, Waypoint? waypoint, String? name});
  WaypointChangedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _WaypointChangedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WaypointChanged, $Out>
    implements WaypointChangedCopyWith<$R, WaypointChanged, $Out> {
  _WaypointChangedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WaypointChanged> $mapper =
      WaypointChangedMapper.ensureInitialized();
  @override
  WaypointCopyWith<$R, Waypoint, Waypoint> get waypoint =>
      $value.waypoint.copyWith.$chain((v) => call(waypoint: v));
  @override
  $R call({Object? team = $none, Waypoint? waypoint, Object? name = $none}) =>
      $apply(
        FieldCopyWithData({
          if (team != $none) #team: team,
          if (waypoint != null) #waypoint: waypoint,
          if (name != $none) #name: name,
        }),
      );
  @override
  WaypointChanged $make(CopyWithData data) => WaypointChanged(
    team: data.get(#team, or: $value.team),
    waypoint: data.get(#waypoint, or: $value.waypoint),
    name: data.get(#name, or: $value.name),
  );

  @override
  WaypointChangedCopyWith<$R2, WaypointChanged, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WaypointChangedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class WaypointRemovedMapper extends SubClassMapperBase<WaypointRemoved> {
  WaypointRemovedMapper._();

  static WaypointRemovedMapper? _instance;
  static WaypointRemovedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WaypointRemovedMapper._());
      HybridWorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'WaypointRemoved';

  static String? _$team(WaypointRemoved v) => v.team;
  static const Field<WaypointRemoved, String> _f$team = Field(
    'team',
    _$team,
    opt: true,
  );
  static String _$name(WaypointRemoved v) => v.name;
  static const Field<WaypointRemoved, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<WaypointRemoved> fields = const {
    #team: _f$team,
    #name: _f$name,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'WaypointRemoved';
  @override
  late final ClassMapperBase superMapper =
      HybridWorldEventMapper.ensureInitialized();

  static WaypointRemoved _instantiate(DecodingData data) {
    return WaypointRemoved(team: data.dec(_f$team), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static WaypointRemoved fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WaypointRemoved>(map);
  }

  static WaypointRemoved fromJson(String json) {
    return ensureInitialized().decodeJson<WaypointRemoved>(json);
  }
}

/// @nodoc
mixin WaypointRemovedMappable {
  String toJson() {
    return WaypointRemovedMapper.ensureInitialized()
        .encodeJson<WaypointRemoved>(this as WaypointRemoved);
  }

  Map<String, dynamic> toMap() {
    return WaypointRemovedMapper.ensureInitialized().encodeMap<WaypointRemoved>(
      this as WaypointRemoved,
    );
  }

  WaypointRemovedCopyWith<WaypointRemoved, WaypointRemoved, WaypointRemoved>
  get copyWith =>
      _WaypointRemovedCopyWithImpl<WaypointRemoved, WaypointRemoved>(
        this as WaypointRemoved,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WaypointRemovedMapper.ensureInitialized().stringifyValue(
      this as WaypointRemoved,
    );
  }

  @override
  bool operator ==(Object other) {
    return WaypointRemovedMapper.ensureInitialized().equalsValue(
      this as WaypointRemoved,
      other,
    );
  }

  @override
  int get hashCode {
    return WaypointRemovedMapper.ensureInitialized().hashValue(
      this as WaypointRemoved,
    );
  }
}

/// @nodoc
extension WaypointRemovedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WaypointRemoved, $Out> {
  WaypointRemovedCopyWith<$R, WaypointRemoved, $Out> get $asWaypointRemoved =>
      $base.as((v, t, t2) => _WaypointRemovedCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class WaypointRemovedCopyWith<$R, $In extends WaypointRemoved, $Out>
    implements HybridWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call({String? team, String? name});
  WaypointRemovedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _WaypointRemovedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WaypointRemoved, $Out>
    implements WaypointRemovedCopyWith<$R, WaypointRemoved, $Out> {
  _WaypointRemovedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WaypointRemoved> $mapper =
      WaypointRemovedMapper.ensureInitialized();
  @override
  $R call({Object? team = $none, String? name}) => $apply(
    FieldCopyWithData({
      if (team != $none) #team: team,
      if (name != null) #name: name,
    }),
  );
  @override
  WaypointRemoved $make(CopyWithData data) => WaypointRemoved(
    team: data.get(#team, or: $value.team),
    name: data.get(#name, or: $value.name),
  );

  @override
  WaypointRemovedCopyWith<$R2, WaypointRemoved, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WaypointRemovedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class LocalWorldEventMapper extends SubClassMapperBase<LocalWorldEvent> {
  LocalWorldEventMapper._();

  static LocalWorldEventMapper? _instance;
  static LocalWorldEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalWorldEventMapper._());
      WorldEventMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'LocalWorldEvent';

  @override
  final MappableFields<LocalWorldEvent> fields = const {};

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'LocalWorldEvent';
  @override
  late final ClassMapperBase superMapper = WorldEventMapper.ensureInitialized();

  static LocalWorldEvent _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('LocalWorldEvent');
  }

  @override
  final Function instantiate = _instantiate;

  static LocalWorldEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalWorldEvent>(map);
  }

  static LocalWorldEvent fromJson(String json) {
    return ensureInitialized().decodeJson<LocalWorldEvent>(json);
  }
}

/// @nodoc
mixin LocalWorldEventMappable {
  String toJson();
  Map<String, dynamic> toMap();
  LocalWorldEventCopyWith<LocalWorldEvent, LocalWorldEvent, LocalWorldEvent>
  get copyWith;
}

/// @nodoc
abstract class LocalWorldEventCopyWith<$R, $In extends LocalWorldEvent, $Out>
    implements
        WorldEventCopyWith<$R, $In, $Out>,
        PlayableWorldEventCopyWith<$R, $In, $Out> {
  @override
  $R call();
  LocalWorldEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

