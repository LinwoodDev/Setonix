// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'info.dart';

/// @nodoc

class TeamColorMapper extends EnumMapper<TeamColor> {
  TeamColorMapper._();

  static TeamColorMapper? _instance;
  static TeamColorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TeamColorMapper._());
    }
    return _instance!;
  }

  static TeamColor fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  TeamColor decode(dynamic value) {
    switch (value) {
      case r'pink':
        return TeamColor.pink;
      case r'red':
        return TeamColor.red;
      case r'orange':
        return TeamColor.orange;
      case r'yellow':
        return TeamColor.yellow;
      case r'green':
        return TeamColor.green;
      case r'blue':
        return TeamColor.blue;
      case r'indigo':
        return TeamColor.indigo;
      case r'purple':
        return TeamColor.purple;
      case r'brown':
        return TeamColor.brown;
      case r'white':
        return TeamColor.white;
      case r'black':
        return TeamColor.black;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(TeamColor self) {
    switch (self) {
      case TeamColor.pink:
        return r'pink';
      case TeamColor.red:
        return r'red';
      case TeamColor.orange:
        return r'orange';
      case TeamColor.yellow:
        return r'yellow';
      case TeamColor.green:
        return r'green';
      case TeamColor.blue:
        return r'blue';
      case TeamColor.indigo:
        return r'indigo';
      case TeamColor.purple:
        return r'purple';
      case TeamColor.brown:
        return r'brown';
      case TeamColor.white:
        return r'white';
      case TeamColor.black:
        return r'black';
    }
  }
}

/// @nodoc

extension TeamColorMapperExtension on TeamColor {
  String toValue() {
    TeamColorMapper.ensureInitialized();
    return MapperContainer.globals.toValue<TeamColor>(this) as String;
  }
}

/// @nodoc
class GameInfoMapper extends ClassMapperBase<GameInfo> {
  GameInfoMapper._();

  static GameInfoMapper? _instance;
  static GameInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameInfoMapper._());
      GameTeamMapper.ensureInitialized();
      ItemLocationMapper.ensureInitialized();
      WaypointMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameInfo';

  static Map<String, GameTeam> _$teams(GameInfo v) => v.teams;
  static const Field<GameInfo, Map<String, GameTeam>> _f$teams = Field(
    'teams',
    _$teams,
    opt: true,
    def: const {},
  );
  static List<String> _$packs(GameInfo v) => v.packs;
  static const Field<GameInfo, List<String>> _f$packs = Field(
    'packs',
    _$packs,
    opt: true,
    def: const [],
  );
  static ItemLocation? _$gameMode(GameInfo v) => v.gameMode;
  static const Field<GameInfo, ItemLocation> _f$gameMode = Field(
    'gameMode',
    _$gameMode,
    opt: true,
  );
  static List<Waypoint> _$waypoints(GameInfo v) => v.waypoints;
  static const Field<GameInfo, List<Waypoint>> _f$waypoints = Field(
    'waypoints',
    _$waypoints,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<GameInfo> fields = const {
    #teams: _f$teams,
    #packs: _f$packs,
    #gameMode: _f$gameMode,
    #waypoints: _f$waypoints,
  };

  static GameInfo _instantiate(DecodingData data) {
    return GameInfo(
      teams: data.dec(_f$teams),
      packs: data.dec(_f$packs),
      gameMode: data.dec(_f$gameMode),
      waypoints: data.dec(_f$waypoints),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GameInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameInfo>(map);
  }

  static GameInfo fromJson(String json) {
    return ensureInitialized().decodeJson<GameInfo>(json);
  }
}

/// @nodoc
mixin GameInfoMappable {
  String toJson() {
    return GameInfoMapper.ensureInitialized().encodeJson<GameInfo>(
      this as GameInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return GameInfoMapper.ensureInitialized().encodeMap<GameInfo>(
      this as GameInfo,
    );
  }

  GameInfoCopyWith<GameInfo, GameInfo, GameInfo> get copyWith =>
      _GameInfoCopyWithImpl<GameInfo, GameInfo>(
        this as GameInfo,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GameInfoMapper.ensureInitialized().stringifyValue(this as GameInfo);
  }

  @override
  bool operator ==(Object other) {
    return GameInfoMapper.ensureInitialized().equalsValue(
      this as GameInfo,
      other,
    );
  }

  @override
  int get hashCode {
    return GameInfoMapper.ensureInitialized().hashValue(this as GameInfo);
  }
}

/// @nodoc
extension GameInfoValueCopy<$R, $Out> on ObjectCopyWith<$R, GameInfo, $Out> {
  GameInfoCopyWith<$R, GameInfo, $Out> get $asGameInfo =>
      $base.as((v, t, t2) => _GameInfoCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class GameInfoCopyWith<$R, $In extends GameInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, GameTeam, GameTeamCopyWith<$R, GameTeam, GameTeam>>
  get teams;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get packs;
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation>? get gameMode;
  ListCopyWith<$R, Waypoint, WaypointCopyWith<$R, Waypoint, Waypoint>>
  get waypoints;
  $R call({
    Map<String, GameTeam>? teams,
    List<String>? packs,
    ItemLocation? gameMode,
    List<Waypoint>? waypoints,
  });
  GameInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _GameInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameInfo, $Out>
    implements GameInfoCopyWith<$R, GameInfo, $Out> {
  _GameInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameInfo> $mapper =
      GameInfoMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, GameTeam, GameTeamCopyWith<$R, GameTeam, GameTeam>>
  get teams => MapCopyWith(
    $value.teams,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(teams: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get packs =>
      ListCopyWith(
        $value.packs,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(packs: v),
      );
  @override
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation>? get gameMode =>
      $value.gameMode?.copyWith.$chain((v) => call(gameMode: v));
  @override
  ListCopyWith<$R, Waypoint, WaypointCopyWith<$R, Waypoint, Waypoint>>
  get waypoints => ListCopyWith(
    $value.waypoints,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(waypoints: v),
  );
  @override
  $R call({
    Map<String, GameTeam>? teams,
    List<String>? packs,
    Object? gameMode = $none,
    List<Waypoint>? waypoints,
  }) => $apply(
    FieldCopyWithData({
      if (teams != null) #teams: teams,
      if (packs != null) #packs: packs,
      if (gameMode != $none) #gameMode: gameMode,
      if (waypoints != null) #waypoints: waypoints,
    }),
  );
  @override
  GameInfo $make(CopyWithData data) => GameInfo(
    teams: data.get(#teams, or: $value.teams),
    packs: data.get(#packs, or: $value.packs),
    gameMode: data.get(#gameMode, or: $value.gameMode),
    waypoints: data.get(#waypoints, or: $value.waypoints),
  );

  @override
  GameInfoCopyWith<$R2, GameInfo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GameInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class GameTeamMapper extends ClassMapperBase<GameTeam> {
  GameTeamMapper._();

  static GameTeamMapper? _instance;
  static GameTeamMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameTeamMapper._());
      TeamColorMapper.ensureInitialized();
      GlobalVectorDefinitionMapper.ensureInitialized();
      WaypointMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameTeam';

  static String _$description(GameTeam v) => v.description;
  static const Field<GameTeam, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static TeamColor? _$color(GameTeam v) => v.color;
  static const Field<GameTeam, TeamColor> _f$color = Field(
    'color',
    _$color,
    opt: true,
  );
  static Set<GlobalVectorDefinition> _$claimedCells(GameTeam v) =>
      v.claimedCells;
  static const Field<GameTeam, Set<GlobalVectorDefinition>> _f$claimedCells =
      Field('claimedCells', _$claimedCells, opt: true, def: const {});
  static List<Waypoint> _$waypoints(GameTeam v) => v.waypoints;
  static const Field<GameTeam, List<Waypoint>> _f$waypoints = Field(
    'waypoints',
    _$waypoints,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<GameTeam> fields = const {
    #description: _f$description,
    #color: _f$color,
    #claimedCells: _f$claimedCells,
    #waypoints: _f$waypoints,
  };

  static GameTeam _instantiate(DecodingData data) {
    return GameTeam(
      description: data.dec(_f$description),
      color: data.dec(_f$color),
      claimedCells: data.dec(_f$claimedCells),
      waypoints: data.dec(_f$waypoints),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GameTeam fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameTeam>(map);
  }

  static GameTeam fromJson(String json) {
    return ensureInitialized().decodeJson<GameTeam>(json);
  }
}

/// @nodoc
mixin GameTeamMappable {
  String toJson() {
    return GameTeamMapper.ensureInitialized().encodeJson<GameTeam>(
      this as GameTeam,
    );
  }

  Map<String, dynamic> toMap() {
    return GameTeamMapper.ensureInitialized().encodeMap<GameTeam>(
      this as GameTeam,
    );
  }

  GameTeamCopyWith<GameTeam, GameTeam, GameTeam> get copyWith =>
      _GameTeamCopyWithImpl<GameTeam, GameTeam>(
        this as GameTeam,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GameTeamMapper.ensureInitialized().stringifyValue(this as GameTeam);
  }

  @override
  bool operator ==(Object other) {
    return GameTeamMapper.ensureInitialized().equalsValue(
      this as GameTeam,
      other,
    );
  }

  @override
  int get hashCode {
    return GameTeamMapper.ensureInitialized().hashValue(this as GameTeam);
  }
}

/// @nodoc
extension GameTeamValueCopy<$R, $Out> on ObjectCopyWith<$R, GameTeam, $Out> {
  GameTeamCopyWith<$R, GameTeam, $Out> get $asGameTeam =>
      $base.as((v, t, t2) => _GameTeamCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class GameTeamCopyWith<$R, $In extends GameTeam, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Waypoint, WaypointCopyWith<$R, Waypoint, Waypoint>>
  get waypoints;
  $R call({
    String? description,
    TeamColor? color,
    Set<GlobalVectorDefinition>? claimedCells,
    List<Waypoint>? waypoints,
  });
  GameTeamCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _GameTeamCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameTeam, $Out>
    implements GameTeamCopyWith<$R, GameTeam, $Out> {
  _GameTeamCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameTeam> $mapper =
      GameTeamMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Waypoint, WaypointCopyWith<$R, Waypoint, Waypoint>>
  get waypoints => ListCopyWith(
    $value.waypoints,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(waypoints: v),
  );
  @override
  $R call({
    String? description,
    Object? color = $none,
    Set<GlobalVectorDefinition>? claimedCells,
    List<Waypoint>? waypoints,
  }) => $apply(
    FieldCopyWithData({
      if (description != null) #description: description,
      if (color != $none) #color: color,
      if (claimedCells != null) #claimedCells: claimedCells,
      if (waypoints != null) #waypoints: waypoints,
    }),
  );
  @override
  GameTeam $make(CopyWithData data) => GameTeam(
    description: data.get(#description, or: $value.description),
    color: data.get(#color, or: $value.color),
    claimedCells: data.get(#claimedCells, or: $value.claimedCells),
    waypoints: data.get(#waypoints, or: $value.waypoints),
  );

  @override
  GameTeamCopyWith<$R2, GameTeam, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GameTeamCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

