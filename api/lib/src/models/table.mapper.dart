// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'table.dart';

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
      case 'pink':
        return TeamColor.pink;
      case 'red':
        return TeamColor.red;
      case 'orange':
        return TeamColor.orange;
      case 'yellow':
        return TeamColor.yellow;
      case 'green':
        return TeamColor.green;
      case 'blue':
        return TeamColor.blue;
      case 'indigo':
        return TeamColor.indigo;
      case 'purple':
        return TeamColor.purple;
      case 'brown':
        return TeamColor.brown;
      case 'white':
        return TeamColor.white;
      case 'black':
        return TeamColor.black;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(TeamColor self) {
    switch (self) {
      case TeamColor.pink:
        return 'pink';
      case TeamColor.red:
        return 'red';
      case TeamColor.orange:
        return 'orange';
      case TeamColor.yellow:
        return 'yellow';
      case TeamColor.green:
        return 'green';
      case TeamColor.blue:
        return 'blue';
      case TeamColor.indigo:
        return 'indigo';
      case TeamColor.purple:
        return 'purple';
      case TeamColor.brown:
        return 'brown';
      case TeamColor.white:
        return 'white';
      case TeamColor.black:
        return 'black';
    }
  }
}

extension TeamColorMapperExtension on TeamColor {
  String toValue() {
    TeamColorMapper.ensureInitialized();
    return MapperContainer.globals.toValue<TeamColor>(this) as String;
  }
}

class GameTableMapper extends ClassMapperBase<GameTable> {
  GameTableMapper._();

  static GameTableMapper? _instance;
  static GameTableMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameTableMapper._());
      VectorDefinitionMapper.ensureInitialized();
      TableCellMapper.ensureInitialized();
      GameBoardMapper.ensureInitialized();
      ItemLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameTable';

  static Map<VectorDefinition, TableCell> _$cells(GameTable v) => v.cells;
  static const Field<GameTable, Map<VectorDefinition, TableCell>> _f$cells =
      Field('cells', _$cells, opt: true, def: const {}, hook: VectorMapHook());
  static Map<VectorDefinition, GameBoard> _$boards(GameTable v) => v.boards;
  static const Field<GameTable, Map<VectorDefinition, GameBoard>> _f$boards =
      Field('boards', _$boards,
          opt: true, def: const {}, hook: VectorMapHook());
  static ItemLocation? _$background(GameTable v) => v.background;
  static const Field<GameTable, ItemLocation> _f$background =
      Field('background', _$background, opt: true);

  @override
  final MappableFields<GameTable> fields = const {
    #cells: _f$cells,
    #boards: _f$boards,
    #background: _f$background,
  };

  static GameTable _instantiate(DecodingData data) {
    return GameTable(
        cells: data.dec(_f$cells),
        boards: data.dec(_f$boards),
        background: data.dec(_f$background));
  }

  @override
  final Function instantiate = _instantiate;

  static GameTable fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameTable>(map);
  }

  static GameTable fromJson(String json) {
    return ensureInitialized().decodeJson<GameTable>(json);
  }
}

mixin GameTableMappable {
  String toJson() {
    return GameTableMapper.ensureInitialized()
        .encodeJson<GameTable>(this as GameTable);
  }

  Map<String, dynamic> toMap() {
    return GameTableMapper.ensureInitialized()
        .encodeMap<GameTable>(this as GameTable);
  }

  GameTableCopyWith<GameTable, GameTable, GameTable> get copyWith =>
      _GameTableCopyWithImpl(this as GameTable, $identity, $identity);
  @override
  String toString() {
    return GameTableMapper.ensureInitialized()
        .stringifyValue(this as GameTable);
  }

  @override
  bool operator ==(Object other) {
    return GameTableMapper.ensureInitialized()
        .equalsValue(this as GameTable, other);
  }

  @override
  int get hashCode {
    return GameTableMapper.ensureInitialized().hashValue(this as GameTable);
  }
}

extension GameTableValueCopy<$R, $Out> on ObjectCopyWith<$R, GameTable, $Out> {
  GameTableCopyWith<$R, GameTable, $Out> get $asGameTable =>
      $base.as((v, t, t2) => _GameTableCopyWithImpl(v, t, t2));
}

abstract class GameTableCopyWith<$R, $In extends GameTable, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, VectorDefinition, TableCell,
      TableCellCopyWith<$R, TableCell, TableCell>> get cells;
  MapCopyWith<$R, VectorDefinition, GameBoard,
      GameBoardCopyWith<$R, GameBoard, GameBoard>> get boards;
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation>? get background;
  $R call(
      {Map<VectorDefinition, TableCell>? cells,
      Map<VectorDefinition, GameBoard>? boards,
      ItemLocation? background});
  GameTableCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameTableCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameTable, $Out>
    implements GameTableCopyWith<$R, GameTable, $Out> {
  _GameTableCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameTable> $mapper =
      GameTableMapper.ensureInitialized();
  @override
  MapCopyWith<$R, VectorDefinition, TableCell,
          TableCellCopyWith<$R, TableCell, TableCell>>
      get cells => MapCopyWith(
          $value.cells, (v, t) => v.copyWith.$chain(t), (v) => call(cells: v));
  @override
  MapCopyWith<$R, VectorDefinition, GameBoard,
          GameBoardCopyWith<$R, GameBoard, GameBoard>>
      get boards => MapCopyWith($value.boards, (v, t) => v.copyWith.$chain(t),
          (v) => call(boards: v));
  @override
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation>? get background =>
      $value.background?.copyWith.$chain((v) => call(background: v));
  @override
  $R call(
          {Map<VectorDefinition, TableCell>? cells,
          Map<VectorDefinition, GameBoard>? boards,
          Object? background = $none}) =>
      $apply(FieldCopyWithData({
        if (cells != null) #cells: cells,
        if (boards != null) #boards: boards,
        if (background != $none) #background: background
      }));
  @override
  GameTable $make(CopyWithData data) => GameTable(
      cells: data.get(#cells, or: $value.cells),
      boards: data.get(#boards, or: $value.boards),
      background: data.get(#background, or: $value.background));

  @override
  GameTableCopyWith<$R2, GameTable, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameTableCopyWithImpl($value, $cast, t);
}

class TableCellMapper extends ClassMapperBase<TableCell> {
  TableCellMapper._();

  static TableCellMapper? _instance;
  static TableCellMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TableCellMapper._());
      GameObjectMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TableCell';

  static List<GameObject> _$objects(TableCell v) => v.objects;
  static const Field<TableCell, List<GameObject>> _f$objects =
      Field('objects', _$objects, opt: true, def: const []);
  static String? _$team(TableCell v) => v.team;
  static const Field<TableCell, String> _f$team =
      Field('team', _$team, opt: true);
  static int _$reveal(TableCell v) => v.reveal;
  static const Field<TableCell, int> _f$reveal =
      Field('reveal', _$reveal, opt: true, def: -1);
  static int? _$teamReveal(TableCell v) => v.teamReveal;
  static const Field<TableCell, int> _f$teamReveal =
      Field('teamReveal', _$teamReveal, opt: true);

  @override
  final MappableFields<TableCell> fields = const {
    #objects: _f$objects,
    #team: _f$team,
    #reveal: _f$reveal,
    #teamReveal: _f$teamReveal,
  };

  static TableCell _instantiate(DecodingData data) {
    return TableCell(
        objects: data.dec(_f$objects),
        team: data.dec(_f$team),
        reveal: data.dec(_f$reveal),
        teamReveal: data.dec(_f$teamReveal));
  }

  @override
  final Function instantiate = _instantiate;

  static TableCell fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TableCell>(map);
  }

  static TableCell fromJson(String json) {
    return ensureInitialized().decodeJson<TableCell>(json);
  }
}

mixin TableCellMappable {
  String toJson() {
    return TableCellMapper.ensureInitialized()
        .encodeJson<TableCell>(this as TableCell);
  }

  Map<String, dynamic> toMap() {
    return TableCellMapper.ensureInitialized()
        .encodeMap<TableCell>(this as TableCell);
  }

  TableCellCopyWith<TableCell, TableCell, TableCell> get copyWith =>
      _TableCellCopyWithImpl(this as TableCell, $identity, $identity);
  @override
  String toString() {
    return TableCellMapper.ensureInitialized()
        .stringifyValue(this as TableCell);
  }

  @override
  bool operator ==(Object other) {
    return TableCellMapper.ensureInitialized()
        .equalsValue(this as TableCell, other);
  }

  @override
  int get hashCode {
    return TableCellMapper.ensureInitialized().hashValue(this as TableCell);
  }
}

extension TableCellValueCopy<$R, $Out> on ObjectCopyWith<$R, TableCell, $Out> {
  TableCellCopyWith<$R, TableCell, $Out> get $asTableCell =>
      $base.as((v, t, t2) => _TableCellCopyWithImpl(v, t, t2));
}

abstract class TableCellCopyWith<$R, $In extends TableCell, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, GameObject, GameObjectCopyWith<$R, GameObject, GameObject>>
      get objects;
  $R call(
      {List<GameObject>? objects, String? team, int? reveal, int? teamReveal});
  TableCellCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TableCellCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TableCell, $Out>
    implements TableCellCopyWith<$R, TableCell, $Out> {
  _TableCellCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TableCell> $mapper =
      TableCellMapper.ensureInitialized();
  @override
  ListCopyWith<$R, GameObject, GameObjectCopyWith<$R, GameObject, GameObject>>
      get objects => ListCopyWith($value.objects,
          (v, t) => v.copyWith.$chain(t), (v) => call(objects: v));
  @override
  $R call(
          {List<GameObject>? objects,
          Object? team = $none,
          int? reveal,
          Object? teamReveal = $none}) =>
      $apply(FieldCopyWithData({
        if (objects != null) #objects: objects,
        if (team != $none) #team: team,
        if (reveal != null) #reveal: reveal,
        if (teamReveal != $none) #teamReveal: teamReveal
      }));
  @override
  TableCell $make(CopyWithData data) => TableCell(
      objects: data.get(#objects, or: $value.objects),
      team: data.get(#team, or: $value.team),
      reveal: data.get(#reveal, or: $value.reveal),
      teamReveal: data.get(#teamReveal, or: $value.teamReveal));

  @override
  TableCellCopyWith<$R2, TableCell, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TableCellCopyWithImpl($value, $cast, t);
}

class GameObjectMapper extends ClassMapperBase<GameObject> {
  GameObjectMapper._();

  static GameObjectMapper? _instance;
  static GameObjectMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameObjectMapper._());
      ItemLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameObject';

  static ItemLocation _$asset(GameObject v) => v.asset;
  static const Field<GameObject, ItemLocation> _f$asset =
      Field('asset', _$asset);
  static String? _$variation(GameObject v) => v.variation;
  static const Field<GameObject, String> _f$variation =
      Field('variation', _$variation, opt: true);
  static bool _$hidden(GameObject v) => v.hidden;
  static const Field<GameObject, bool> _f$hidden =
      Field('hidden', _$hidden, opt: true, def: false);

  @override
  final MappableFields<GameObject> fields = const {
    #asset: _f$asset,
    #variation: _f$variation,
    #hidden: _f$hidden,
  };

  static GameObject _instantiate(DecodingData data) {
    return GameObject(
        asset: data.dec(_f$asset),
        variation: data.dec(_f$variation),
        hidden: data.dec(_f$hidden));
  }

  @override
  final Function instantiate = _instantiate;

  static GameObject fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameObject>(map);
  }

  static GameObject fromJson(String json) {
    return ensureInitialized().decodeJson<GameObject>(json);
  }
}

mixin GameObjectMappable {
  String toJson() {
    return GameObjectMapper.ensureInitialized()
        .encodeJson<GameObject>(this as GameObject);
  }

  Map<String, dynamic> toMap() {
    return GameObjectMapper.ensureInitialized()
        .encodeMap<GameObject>(this as GameObject);
  }

  GameObjectCopyWith<GameObject, GameObject, GameObject> get copyWith =>
      _GameObjectCopyWithImpl(this as GameObject, $identity, $identity);
  @override
  String toString() {
    return GameObjectMapper.ensureInitialized()
        .stringifyValue(this as GameObject);
  }

  @override
  bool operator ==(Object other) {
    return GameObjectMapper.ensureInitialized()
        .equalsValue(this as GameObject, other);
  }

  @override
  int get hashCode {
    return GameObjectMapper.ensureInitialized().hashValue(this as GameObject);
  }
}

extension GameObjectValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameObject, $Out> {
  GameObjectCopyWith<$R, GameObject, $Out> get $asGameObject =>
      $base.as((v, t, t2) => _GameObjectCopyWithImpl(v, t, t2));
}

abstract class GameObjectCopyWith<$R, $In extends GameObject, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation> get asset;
  $R call({ItemLocation? asset, String? variation, bool? hidden});
  GameObjectCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameObjectCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameObject, $Out>
    implements GameObjectCopyWith<$R, GameObject, $Out> {
  _GameObjectCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameObject> $mapper =
      GameObjectMapper.ensureInitialized();
  @override
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation> get asset =>
      $value.asset.copyWith.$chain((v) => call(asset: v));
  @override
  $R call({ItemLocation? asset, Object? variation = $none, bool? hidden}) =>
      $apply(FieldCopyWithData({
        if (asset != null) #asset: asset,
        if (variation != $none) #variation: variation,
        if (hidden != null) #hidden: hidden
      }));
  @override
  GameObject $make(CopyWithData data) => GameObject(
      asset: data.get(#asset, or: $value.asset),
      variation: data.get(#variation, or: $value.variation),
      hidden: data.get(#hidden, or: $value.hidden));

  @override
  GameObjectCopyWith<$R2, GameObject, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameObjectCopyWithImpl($value, $cast, t);
}

class ItemLocationMapper extends ClassMapperBase<ItemLocation> {
  ItemLocationMapper._();

  static ItemLocationMapper? _instance;
  static ItemLocationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ItemLocationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ItemLocation';

  static String _$namespace(ItemLocation v) => v.namespace;
  static const Field<ItemLocation, String> _f$namespace =
      Field('namespace', _$namespace);
  static String _$id(ItemLocation v) => v.id;
  static const Field<ItemLocation, String> _f$id = Field('id', _$id);

  @override
  final MappableFields<ItemLocation> fields = const {
    #namespace: _f$namespace,
    #id: _f$id,
  };

  static ItemLocation _instantiate(DecodingData data) {
    return ItemLocation(data.dec(_f$namespace), data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static ItemLocation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ItemLocation>(map);
  }

  static ItemLocation fromJson(String json) {
    return ensureInitialized().decodeJson<ItemLocation>(json);
  }
}

mixin ItemLocationMappable {
  String toJson() {
    return ItemLocationMapper.ensureInitialized()
        .encodeJson<ItemLocation>(this as ItemLocation);
  }

  Map<String, dynamic> toMap() {
    return ItemLocationMapper.ensureInitialized()
        .encodeMap<ItemLocation>(this as ItemLocation);
  }

  ItemLocationCopyWith<ItemLocation, ItemLocation, ItemLocation> get copyWith =>
      _ItemLocationCopyWithImpl(this as ItemLocation, $identity, $identity);
  @override
  String toString() {
    return ItemLocationMapper.ensureInitialized()
        .stringifyValue(this as ItemLocation);
  }

  @override
  bool operator ==(Object other) {
    return ItemLocationMapper.ensureInitialized()
        .equalsValue(this as ItemLocation, other);
  }

  @override
  int get hashCode {
    return ItemLocationMapper.ensureInitialized()
        .hashValue(this as ItemLocation);
  }
}

extension ItemLocationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ItemLocation, $Out> {
  ItemLocationCopyWith<$R, ItemLocation, $Out> get $asItemLocation =>
      $base.as((v, t, t2) => _ItemLocationCopyWithImpl(v, t, t2));
}

abstract class ItemLocationCopyWith<$R, $In extends ItemLocation, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? namespace, String? id});
  ItemLocationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ItemLocationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ItemLocation, $Out>
    implements ItemLocationCopyWith<$R, ItemLocation, $Out> {
  _ItemLocationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ItemLocation> $mapper =
      ItemLocationMapper.ensureInitialized();
  @override
  $R call({String? namespace, String? id}) => $apply(FieldCopyWithData(
      {if (namespace != null) #namespace: namespace, if (id != null) #id: id}));
  @override
  ItemLocation $make(CopyWithData data) => ItemLocation(
      data.get(#namespace, or: $value.namespace), data.get(#id, or: $value.id));

  @override
  ItemLocationCopyWith<$R2, ItemLocation, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ItemLocationCopyWithImpl($value, $cast, t);
}

class GameBoardMapper extends ClassMapperBase<GameBoard> {
  GameBoardMapper._();

  static GameBoardMapper? _instance;
  static GameBoardMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameBoardMapper._());
      ItemLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameBoard';

  static ItemLocation _$asset(GameBoard v) => v.asset;
  static const Field<GameBoard, ItemLocation> _f$asset =
      Field('asset', _$asset);

  @override
  final MappableFields<GameBoard> fields = const {
    #asset: _f$asset,
  };

  static GameBoard _instantiate(DecodingData data) {
    return GameBoard(data.dec(_f$asset));
  }

  @override
  final Function instantiate = _instantiate;

  static GameBoard fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameBoard>(map);
  }

  static GameBoard fromJson(String json) {
    return ensureInitialized().decodeJson<GameBoard>(json);
  }
}

mixin GameBoardMappable {
  String toJson() {
    return GameBoardMapper.ensureInitialized()
        .encodeJson<GameBoard>(this as GameBoard);
  }

  Map<String, dynamic> toMap() {
    return GameBoardMapper.ensureInitialized()
        .encodeMap<GameBoard>(this as GameBoard);
  }

  GameBoardCopyWith<GameBoard, GameBoard, GameBoard> get copyWith =>
      _GameBoardCopyWithImpl(this as GameBoard, $identity, $identity);
  @override
  String toString() {
    return GameBoardMapper.ensureInitialized()
        .stringifyValue(this as GameBoard);
  }

  @override
  bool operator ==(Object other) {
    return GameBoardMapper.ensureInitialized()
        .equalsValue(this as GameBoard, other);
  }

  @override
  int get hashCode {
    return GameBoardMapper.ensureInitialized().hashValue(this as GameBoard);
  }
}

extension GameBoardValueCopy<$R, $Out> on ObjectCopyWith<$R, GameBoard, $Out> {
  GameBoardCopyWith<$R, GameBoard, $Out> get $asGameBoard =>
      $base.as((v, t, t2) => _GameBoardCopyWithImpl(v, t, t2));
}

abstract class GameBoardCopyWith<$R, $In extends GameBoard, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation> get asset;
  $R call({ItemLocation? asset});
  GameBoardCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameBoardCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameBoard, $Out>
    implements GameBoardCopyWith<$R, GameBoard, $Out> {
  _GameBoardCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameBoard> $mapper =
      GameBoardMapper.ensureInitialized();
  @override
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation> get asset =>
      $value.asset.copyWith.$chain((v) => call(asset: v));
  @override
  $R call({ItemLocation? asset}) =>
      $apply(FieldCopyWithData({if (asset != null) #asset: asset}));
  @override
  GameBoard $make(CopyWithData data) =>
      GameBoard(data.get(#asset, or: $value.asset));

  @override
  GameBoardCopyWith<$R2, GameBoard, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameBoardCopyWithImpl($value, $cast, t);
}

class GameInfoMapper extends ClassMapperBase<GameInfo> {
  GameInfoMapper._();

  static GameInfoMapper? _instance;
  static GameInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameInfoMapper._());
      GameTeamMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameInfo';

  static Map<String, GameTeam> _$teams(GameInfo v) => v.teams;
  static const Field<GameInfo, Map<String, GameTeam>> _f$teams =
      Field('teams', _$teams, opt: true, def: const {});

  @override
  final MappableFields<GameInfo> fields = const {
    #teams: _f$teams,
  };

  static GameInfo _instantiate(DecodingData data) {
    return GameInfo(teams: data.dec(_f$teams));
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

mixin GameInfoMappable {
  String toJson() {
    return GameInfoMapper.ensureInitialized()
        .encodeJson<GameInfo>(this as GameInfo);
  }

  Map<String, dynamic> toMap() {
    return GameInfoMapper.ensureInitialized()
        .encodeMap<GameInfo>(this as GameInfo);
  }

  GameInfoCopyWith<GameInfo, GameInfo, GameInfo> get copyWith =>
      _GameInfoCopyWithImpl(this as GameInfo, $identity, $identity);
  @override
  String toString() {
    return GameInfoMapper.ensureInitialized().stringifyValue(this as GameInfo);
  }

  @override
  bool operator ==(Object other) {
    return GameInfoMapper.ensureInitialized()
        .equalsValue(this as GameInfo, other);
  }

  @override
  int get hashCode {
    return GameInfoMapper.ensureInitialized().hashValue(this as GameInfo);
  }
}

extension GameInfoValueCopy<$R, $Out> on ObjectCopyWith<$R, GameInfo, $Out> {
  GameInfoCopyWith<$R, GameInfo, $Out> get $asGameInfo =>
      $base.as((v, t, t2) => _GameInfoCopyWithImpl(v, t, t2));
}

abstract class GameInfoCopyWith<$R, $In extends GameInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, GameTeam, GameTeamCopyWith<$R, GameTeam, GameTeam>>
      get teams;
  $R call({Map<String, GameTeam>? teams});
  GameInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

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
          $value.teams, (v, t) => v.copyWith.$chain(t), (v) => call(teams: v));
  @override
  $R call({Map<String, GameTeam>? teams}) =>
      $apply(FieldCopyWithData({if (teams != null) #teams: teams}));
  @override
  GameInfo $make(CopyWithData data) =>
      GameInfo(teams: data.get(#teams, or: $value.teams));

  @override
  GameInfoCopyWith<$R2, GameInfo, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameInfoCopyWithImpl($value, $cast, t);
}

class GameTeamMapper extends ClassMapperBase<GameTeam> {
  GameTeamMapper._();

  static GameTeamMapper? _instance;
  static GameTeamMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameTeamMapper._());
      TeamColorMapper.ensureInitialized();
      GlobalVectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameTeam';

  static String _$description(GameTeam v) => v.description;
  static const Field<GameTeam, String> _f$description =
      Field('description', _$description, opt: true, def: '');
  static TeamColor? _$color(GameTeam v) => v.color;
  static const Field<GameTeam, TeamColor> _f$color =
      Field('color', _$color, opt: true);
  static Set<GlobalVectorDefinition> _$claimedCells(GameTeam v) =>
      v.claimedCells;
  static const Field<GameTeam, Set<GlobalVectorDefinition>> _f$claimedCells =
      Field('claimedCells', _$claimedCells, opt: true, def: const {});

  @override
  final MappableFields<GameTeam> fields = const {
    #description: _f$description,
    #color: _f$color,
    #claimedCells: _f$claimedCells,
  };

  static GameTeam _instantiate(DecodingData data) {
    return GameTeam(
        description: data.dec(_f$description),
        color: data.dec(_f$color),
        claimedCells: data.dec(_f$claimedCells));
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

mixin GameTeamMappable {
  String toJson() {
    return GameTeamMapper.ensureInitialized()
        .encodeJson<GameTeam>(this as GameTeam);
  }

  Map<String, dynamic> toMap() {
    return GameTeamMapper.ensureInitialized()
        .encodeMap<GameTeam>(this as GameTeam);
  }

  GameTeamCopyWith<GameTeam, GameTeam, GameTeam> get copyWith =>
      _GameTeamCopyWithImpl(this as GameTeam, $identity, $identity);
  @override
  String toString() {
    return GameTeamMapper.ensureInitialized().stringifyValue(this as GameTeam);
  }

  @override
  bool operator ==(Object other) {
    return GameTeamMapper.ensureInitialized()
        .equalsValue(this as GameTeam, other);
  }

  @override
  int get hashCode {
    return GameTeamMapper.ensureInitialized().hashValue(this as GameTeam);
  }
}

extension GameTeamValueCopy<$R, $Out> on ObjectCopyWith<$R, GameTeam, $Out> {
  GameTeamCopyWith<$R, GameTeam, $Out> get $asGameTeam =>
      $base.as((v, t, t2) => _GameTeamCopyWithImpl(v, t, t2));
}

abstract class GameTeamCopyWith<$R, $In extends GameTeam, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? description,
      TeamColor? color,
      Set<GlobalVectorDefinition>? claimedCells});
  GameTeamCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameTeamCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameTeam, $Out>
    implements GameTeamCopyWith<$R, GameTeam, $Out> {
  _GameTeamCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameTeam> $mapper =
      GameTeamMapper.ensureInitialized();
  @override
  $R call(
          {String? description,
          Object? color = $none,
          Set<GlobalVectorDefinition>? claimedCells}) =>
      $apply(FieldCopyWithData({
        if (description != null) #description: description,
        if (color != $none) #color: color,
        if (claimedCells != null) #claimedCells: claimedCells
      }));
  @override
  GameTeam $make(CopyWithData data) => GameTeam(
      description: data.get(#description, or: $value.description),
      color: data.get(#color, or: $value.color),
      claimedCells: data.get(#claimedCells, or: $value.claimedCells));

  @override
  GameTeamCopyWith<$R2, GameTeam, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameTeamCopyWithImpl($value, $cast, t);
}

class GlobalVectorDefinitionMapper
    extends ClassMapperBase<GlobalVectorDefinition> {
  GlobalVectorDefinitionMapper._();

  static GlobalVectorDefinitionMapper? _instance;
  static GlobalVectorDefinitionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GlobalVectorDefinitionMapper._());
      VectorDefinitionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GlobalVectorDefinition';

  static String _$world(GlobalVectorDefinition v) => v.world;
  static const Field<GlobalVectorDefinition, String> _f$world =
      Field('world', _$world);
  static int _$x(GlobalVectorDefinition v) => v.x;
  static const Field<GlobalVectorDefinition, int> _f$x = Field('x', _$x);
  static int _$y(GlobalVectorDefinition v) => v.y;
  static const Field<GlobalVectorDefinition, int> _f$y = Field('y', _$y);

  @override
  final MappableFields<GlobalVectorDefinition> fields = const {
    #world: _f$world,
    #x: _f$x,
    #y: _f$y,
  };

  @override
  final MappingHook superHook = const VectorDefinitionHook();

  static GlobalVectorDefinition _instantiate(DecodingData data) {
    return GlobalVectorDefinition(
        data.dec(_f$world), data.dec(_f$x), data.dec(_f$y));
  }

  @override
  final Function instantiate = _instantiate;

  static GlobalVectorDefinition fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GlobalVectorDefinition>(map);
  }

  static GlobalVectorDefinition fromJson(String json) {
    return ensureInitialized().decodeJson<GlobalVectorDefinition>(json);
  }
}

mixin GlobalVectorDefinitionMappable {
  String toJson() {
    return GlobalVectorDefinitionMapper.ensureInitialized()
        .encodeJson<GlobalVectorDefinition>(this as GlobalVectorDefinition);
  }

  Map<String, dynamic> toMap() {
    return GlobalVectorDefinitionMapper.ensureInitialized()
        .encodeMap<GlobalVectorDefinition>(this as GlobalVectorDefinition);
  }

  GlobalVectorDefinitionCopyWith<GlobalVectorDefinition, GlobalVectorDefinition,
          GlobalVectorDefinition>
      get copyWith => _GlobalVectorDefinitionCopyWithImpl(
          this as GlobalVectorDefinition, $identity, $identity);
  @override
  String toString() {
    return GlobalVectorDefinitionMapper.ensureInitialized()
        .stringifyValue(this as GlobalVectorDefinition);
  }

  @override
  bool operator ==(Object other) {
    return GlobalVectorDefinitionMapper.ensureInitialized()
        .equalsValue(this as GlobalVectorDefinition, other);
  }

  @override
  int get hashCode {
    return GlobalVectorDefinitionMapper.ensureInitialized()
        .hashValue(this as GlobalVectorDefinition);
  }
}

extension GlobalVectorDefinitionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GlobalVectorDefinition, $Out> {
  GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition, $Out>
      get $asGlobalVectorDefinition =>
          $base.as((v, t, t2) => _GlobalVectorDefinitionCopyWithImpl(v, t, t2));
}

abstract class GlobalVectorDefinitionCopyWith<
    $R,
    $In extends GlobalVectorDefinition,
    $Out> implements VectorDefinitionCopyWith<$R, $In, $Out> {
  @override
  $R call({String? world, int? x, int? y});
  GlobalVectorDefinitionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GlobalVectorDefinitionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GlobalVectorDefinition, $Out>
    implements
        GlobalVectorDefinitionCopyWith<$R, GlobalVectorDefinition, $Out> {
  _GlobalVectorDefinitionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GlobalVectorDefinition> $mapper =
      GlobalVectorDefinitionMapper.ensureInitialized();
  @override
  $R call({String? world, int? x, int? y}) => $apply(FieldCopyWithData({
        if (world != null) #world: world,
        if (x != null) #x: x,
        if (y != null) #y: y
      }));
  @override
  GlobalVectorDefinition $make(CopyWithData data) => GlobalVectorDefinition(
      data.get(#world, or: $value.world),
      data.get(#x, or: $value.x),
      data.get(#y, or: $value.y));

  @override
  GlobalVectorDefinitionCopyWith<$R2, GlobalVectorDefinition, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _GlobalVectorDefinitionCopyWithImpl($value, $cast, t);
}

class GameSeatMapper extends ClassMapperBase<GameSeat> {
  GameSeatMapper._();

  static GameSeatMapper? _instance;
  static GameSeatMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameSeatMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GameSeat';

  static int? _$color(GameSeat v) => v.color;
  static const Field<GameSeat, int> _f$color =
      Field('color', _$color, opt: true);

  @override
  final MappableFields<GameSeat> fields = const {
    #color: _f$color,
  };

  static GameSeat _instantiate(DecodingData data) {
    return GameSeat(color: data.dec(_f$color));
  }

  @override
  final Function instantiate = _instantiate;

  static GameSeat fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameSeat>(map);
  }

  static GameSeat fromJson(String json) {
    return ensureInitialized().decodeJson<GameSeat>(json);
  }
}

mixin GameSeatMappable {
  String toJson() {
    return GameSeatMapper.ensureInitialized()
        .encodeJson<GameSeat>(this as GameSeat);
  }

  Map<String, dynamic> toMap() {
    return GameSeatMapper.ensureInitialized()
        .encodeMap<GameSeat>(this as GameSeat);
  }

  GameSeatCopyWith<GameSeat, GameSeat, GameSeat> get copyWith =>
      _GameSeatCopyWithImpl(this as GameSeat, $identity, $identity);
  @override
  String toString() {
    return GameSeatMapper.ensureInitialized().stringifyValue(this as GameSeat);
  }

  @override
  bool operator ==(Object other) {
    return GameSeatMapper.ensureInitialized()
        .equalsValue(this as GameSeat, other);
  }

  @override
  int get hashCode {
    return GameSeatMapper.ensureInitialized().hashValue(this as GameSeat);
  }
}

extension GameSeatValueCopy<$R, $Out> on ObjectCopyWith<$R, GameSeat, $Out> {
  GameSeatCopyWith<$R, GameSeat, $Out> get $asGameSeat =>
      $base.as((v, t, t2) => _GameSeatCopyWithImpl(v, t, t2));
}

abstract class GameSeatCopyWith<$R, $In extends GameSeat, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? color});
  GameSeatCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GameSeatCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameSeat, $Out>
    implements GameSeatCopyWith<$R, GameSeat, $Out> {
  _GameSeatCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameSeat> $mapper =
      GameSeatMapper.ensureInitialized();
  @override
  $R call({Object? color = $none}) =>
      $apply(FieldCopyWithData({if (color != $none) #color: color}));
  @override
  GameSeat $make(CopyWithData data) =>
      GameSeat(color: data.get(#color, or: $value.color));

  @override
  GameSeatCopyWith<$R2, GameSeat, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameSeatCopyWithImpl($value, $cast, t);
}