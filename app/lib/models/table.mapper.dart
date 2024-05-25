// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'table.dart';

class GridLocationMapper extends ClassMapperBase<GridLocation> {
  GridLocationMapper._();

  static GridLocationMapper? _instance;
  static GridLocationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GridLocationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GridLocation';

  static int _$x(GridLocation v) => v.x;
  static const Field<GridLocation, int> _f$x = Field('x', _$x);
  static int _$y(GridLocation v) => v.y;
  static const Field<GridLocation, int> _f$y = Field('y', _$y);

  @override
  final MappableFields<GridLocation> fields = const {
    #x: _f$x,
    #y: _f$y,
  };

  static GridLocation _instantiate(DecodingData data) {
    return GridLocation(data.dec(_f$x), data.dec(_f$y));
  }

  @override
  final Function instantiate = _instantiate;

  static GridLocation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GridLocation>(map);
  }

  static GridLocation fromJson(String json) {
    return ensureInitialized().decodeJson<GridLocation>(json);
  }
}

mixin GridLocationMappable {
  String toJson() {
    return GridLocationMapper.ensureInitialized()
        .encodeJson<GridLocation>(this as GridLocation);
  }

  Map<String, dynamic> toMap() {
    return GridLocationMapper.ensureInitialized()
        .encodeMap<GridLocation>(this as GridLocation);
  }

  GridLocationCopyWith<GridLocation, GridLocation, GridLocation> get copyWith =>
      _GridLocationCopyWithImpl(this as GridLocation, $identity, $identity);
  @override
  String toString() {
    return GridLocationMapper.ensureInitialized()
        .stringifyValue(this as GridLocation);
  }

  @override
  bool operator ==(Object other) {
    return GridLocationMapper.ensureInitialized()
        .equalsValue(this as GridLocation, other);
  }

  @override
  int get hashCode {
    return GridLocationMapper.ensureInitialized()
        .hashValue(this as GridLocation);
  }
}

extension GridLocationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GridLocation, $Out> {
  GridLocationCopyWith<$R, GridLocation, $Out> get $asGridLocation =>
      $base.as((v, t, t2) => _GridLocationCopyWithImpl(v, t, t2));
}

abstract class GridLocationCopyWith<$R, $In extends GridLocation, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? x, int? y});
  GridLocationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GridLocationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GridLocation, $Out>
    implements GridLocationCopyWith<$R, GridLocation, $Out> {
  _GridLocationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GridLocation> $mapper =
      GridLocationMapper.ensureInitialized();
  @override
  $R call({int? x, int? y}) =>
      $apply(FieldCopyWithData({if (x != null) #x: x, if (y != null) #y: y}));
  @override
  GridLocation $make(CopyWithData data) =>
      GridLocation(data.get(#x, or: $value.x), data.get(#y, or: $value.y));

  @override
  GridLocationCopyWith<$R2, GridLocation, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GridLocationCopyWithImpl($value, $cast, t);
}

class GameTableMapper extends ClassMapperBase<GameTable> {
  GameTableMapper._();

  static GameTableMapper? _instance;
  static GameTableMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameTableMapper._());
      GridLocationMapper.ensureInitialized();
      TableCellMapper.ensureInitialized();
      GameBoardMapper.ensureInitialized();
      GameSeatMapper.ensureInitialized();
      GamePlayerMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameTable';

  static Map<GridLocation, TableCell> _$cells(GameTable v) => v.cells;
  static const Field<GameTable, Map<GridLocation, TableCell>> _f$cells =
      Field('cells', _$cells, opt: true, def: const {});
  static Map<GridLocation, GameBoard> _$boards(GameTable v) => v.boards;
  static const Field<GameTable, Map<GridLocation, GameBoard>> _f$boards =
      Field('boards', _$boards, opt: true, def: const {});
  static Map<String, GameSeat> _$seats(GameTable v) => v.seats;
  static const Field<GameTable, Map<String, GameSeat>> _f$seats =
      Field('seats', _$seats, opt: true, def: const {});
  static Map<String, GamePlayer> _$players(GameTable v) => v.players;
  static const Field<GameTable, Map<String, GamePlayer>> _f$players =
      Field('players', _$players, opt: true, def: const {});

  @override
  final MappableFields<GameTable> fields = const {
    #cells: _f$cells,
    #boards: _f$boards,
    #seats: _f$seats,
    #players: _f$players,
  };

  static GameTable _instantiate(DecodingData data) {
    return GameTable(
        cells: data.dec(_f$cells),
        boards: data.dec(_f$boards),
        seats: data.dec(_f$seats),
        players: data.dec(_f$players));
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
  MapCopyWith<$R, GridLocation, TableCell,
      TableCellCopyWith<$R, TableCell, TableCell>> get cells;
  MapCopyWith<$R, GridLocation, GameBoard,
      GameBoardCopyWith<$R, GameBoard, GameBoard>> get boards;
  MapCopyWith<$R, String, GameSeat, GameSeatCopyWith<$R, GameSeat, GameSeat>>
      get seats;
  MapCopyWith<$R, String, GamePlayer,
      GamePlayerCopyWith<$R, GamePlayer, GamePlayer>> get players;
  $R call(
      {Map<GridLocation, TableCell>? cells,
      Map<GridLocation, GameBoard>? boards,
      Map<String, GameSeat>? seats,
      Map<String, GamePlayer>? players});
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
  MapCopyWith<$R, GridLocation, TableCell,
          TableCellCopyWith<$R, TableCell, TableCell>>
      get cells => MapCopyWith(
          $value.cells, (v, t) => v.copyWith.$chain(t), (v) => call(cells: v));
  @override
  MapCopyWith<$R, GridLocation, GameBoard,
          GameBoardCopyWith<$R, GameBoard, GameBoard>>
      get boards => MapCopyWith($value.boards, (v, t) => v.copyWith.$chain(t),
          (v) => call(boards: v));
  @override
  MapCopyWith<$R, String, GameSeat, GameSeatCopyWith<$R, GameSeat, GameSeat>>
      get seats => MapCopyWith(
          $value.seats, (v, t) => v.copyWith.$chain(t), (v) => call(seats: v));
  @override
  MapCopyWith<$R, String, GamePlayer,
          GamePlayerCopyWith<$R, GamePlayer, GamePlayer>>
      get players => MapCopyWith($value.players, (v, t) => v.copyWith.$chain(t),
          (v) => call(players: v));
  @override
  $R call(
          {Map<GridLocation, TableCell>? cells,
          Map<GridLocation, GameBoard>? boards,
          Map<String, GameSeat>? seats,
          Map<String, GamePlayer>? players}) =>
      $apply(FieldCopyWithData({
        if (cells != null) #cells: cells,
        if (boards != null) #boards: boards,
        if (seats != null) #seats: seats,
        if (players != null) #players: players
      }));
  @override
  GameTable $make(CopyWithData data) => GameTable(
      cells: data.get(#cells, or: $value.cells),
      boards: data.get(#boards, or: $value.boards),
      seats: data.get(#seats, or: $value.seats),
      players: data.get(#players, or: $value.players));

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
      AssetLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameObject';

  static AssetLocation _$asset(GameObject v) => v.asset;
  static const Field<GameObject, AssetLocation> _f$asset =
      Field('asset', _$asset);
  static String? _$variation(GameObject v) => v.variation;
  static const Field<GameObject, String> _f$variation =
      Field('variation', _$variation, opt: true);

  @override
  final MappableFields<GameObject> fields = const {
    #asset: _f$asset,
    #variation: _f$variation,
  };

  static GameObject _instantiate(DecodingData data) {
    return GameObject(
        asset: data.dec(_f$asset), variation: data.dec(_f$variation));
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
  AssetLocationCopyWith<$R, AssetLocation, AssetLocation> get asset;
  $R call({AssetLocation? asset, String? variation});
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
  AssetLocationCopyWith<$R, AssetLocation, AssetLocation> get asset =>
      $value.asset.copyWith.$chain((v) => call(asset: v));
  @override
  $R call({AssetLocation? asset, Object? variation = $none}) =>
      $apply(FieldCopyWithData({
        if (asset != null) #asset: asset,
        if (variation != $none) #variation: variation
      }));
  @override
  GameObject $make(CopyWithData data) => GameObject(
      asset: data.get(#asset, or: $value.asset),
      variation: data.get(#variation, or: $value.variation));

  @override
  GameObjectCopyWith<$R2, GameObject, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameObjectCopyWithImpl($value, $cast, t);
}

class AssetLocationMapper extends ClassMapperBase<AssetLocation> {
  AssetLocationMapper._();

  static AssetLocationMapper? _instance;
  static AssetLocationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssetLocationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AssetLocation';

  static String _$namespace(AssetLocation v) => v.namespace;
  static const Field<AssetLocation, String> _f$namespace =
      Field('namespace', _$namespace);
  static String _$id(AssetLocation v) => v.id;
  static const Field<AssetLocation, String> _f$id = Field('id', _$id);

  @override
  final MappableFields<AssetLocation> fields = const {
    #namespace: _f$namespace,
    #id: _f$id,
  };

  static AssetLocation _instantiate(DecodingData data) {
    return AssetLocation(data.dec(_f$namespace), data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static AssetLocation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AssetLocation>(map);
  }

  static AssetLocation fromJson(String json) {
    return ensureInitialized().decodeJson<AssetLocation>(json);
  }
}

mixin AssetLocationMappable {
  String toJson() {
    return AssetLocationMapper.ensureInitialized()
        .encodeJson<AssetLocation>(this as AssetLocation);
  }

  Map<String, dynamic> toMap() {
    return AssetLocationMapper.ensureInitialized()
        .encodeMap<AssetLocation>(this as AssetLocation);
  }

  AssetLocationCopyWith<AssetLocation, AssetLocation, AssetLocation>
      get copyWith => _AssetLocationCopyWithImpl(
          this as AssetLocation, $identity, $identity);
  @override
  String toString() {
    return AssetLocationMapper.ensureInitialized()
        .stringifyValue(this as AssetLocation);
  }

  @override
  bool operator ==(Object other) {
    return AssetLocationMapper.ensureInitialized()
        .equalsValue(this as AssetLocation, other);
  }

  @override
  int get hashCode {
    return AssetLocationMapper.ensureInitialized()
        .hashValue(this as AssetLocation);
  }
}

extension AssetLocationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AssetLocation, $Out> {
  AssetLocationCopyWith<$R, AssetLocation, $Out> get $asAssetLocation =>
      $base.as((v, t, t2) => _AssetLocationCopyWithImpl(v, t, t2));
}

abstract class AssetLocationCopyWith<$R, $In extends AssetLocation, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? namespace, String? id});
  AssetLocationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AssetLocationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AssetLocation, $Out>
    implements AssetLocationCopyWith<$R, AssetLocation, $Out> {
  _AssetLocationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AssetLocation> $mapper =
      AssetLocationMapper.ensureInitialized();
  @override
  $R call({String? namespace, String? id}) => $apply(FieldCopyWithData(
      {if (namespace != null) #namespace: namespace, if (id != null) #id: id}));
  @override
  AssetLocation $make(CopyWithData data) => AssetLocation(
      data.get(#namespace, or: $value.namespace), data.get(#id, or: $value.id));

  @override
  AssetLocationCopyWith<$R2, AssetLocation, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AssetLocationCopyWithImpl($value, $cast, t);
}

class GameBoardMapper extends ClassMapperBase<GameBoard> {
  GameBoardMapper._();

  static GameBoardMapper? _instance;
  static GameBoardMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameBoardMapper._());
      AssetLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameBoard';

  static AssetLocation _$asset(GameBoard v) => v.asset;
  static const Field<GameBoard, AssetLocation> _f$asset =
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
  AssetLocationCopyWith<$R, AssetLocation, AssetLocation> get asset;
  $R call({AssetLocation? asset});
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
  AssetLocationCopyWith<$R, AssetLocation, AssetLocation> get asset =>
      $value.asset.copyWith.$chain((v) => call(asset: v));
  @override
  $R call({AssetLocation? asset}) =>
      $apply(FieldCopyWithData({if (asset != null) #asset: asset}));
  @override
  GameBoard $make(CopyWithData data) =>
      GameBoard(data.get(#asset, or: $value.asset));

  @override
  GameBoardCopyWith<$R2, GameBoard, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GameBoardCopyWithImpl($value, $cast, t);
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

class GamePlayerMapper extends ClassMapperBase<GamePlayer> {
  GamePlayerMapper._();

  static GamePlayerMapper? _instance;
  static GamePlayerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GamePlayerMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GamePlayer';

  static String _$name(GamePlayer v) => v.name;
  static const Field<GamePlayer, String> _f$name = Field('name', _$name);
  static List<String>? _$teams(GamePlayer v) => v.teams;
  static const Field<GamePlayer, List<String>> _f$teams =
      Field('teams', _$teams, opt: true, def: const []);

  @override
  final MappableFields<GamePlayer> fields = const {
    #name: _f$name,
    #teams: _f$teams,
  };

  static GamePlayer _instantiate(DecodingData data) {
    return GamePlayer(name: data.dec(_f$name), teams: data.dec(_f$teams));
  }

  @override
  final Function instantiate = _instantiate;

  static GamePlayer fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GamePlayer>(map);
  }

  static GamePlayer fromJson(String json) {
    return ensureInitialized().decodeJson<GamePlayer>(json);
  }
}

mixin GamePlayerMappable {
  String toJson() {
    return GamePlayerMapper.ensureInitialized()
        .encodeJson<GamePlayer>(this as GamePlayer);
  }

  Map<String, dynamic> toMap() {
    return GamePlayerMapper.ensureInitialized()
        .encodeMap<GamePlayer>(this as GamePlayer);
  }

  GamePlayerCopyWith<GamePlayer, GamePlayer, GamePlayer> get copyWith =>
      _GamePlayerCopyWithImpl(this as GamePlayer, $identity, $identity);
  @override
  String toString() {
    return GamePlayerMapper.ensureInitialized()
        .stringifyValue(this as GamePlayer);
  }

  @override
  bool operator ==(Object other) {
    return GamePlayerMapper.ensureInitialized()
        .equalsValue(this as GamePlayer, other);
  }

  @override
  int get hashCode {
    return GamePlayerMapper.ensureInitialized().hashValue(this as GamePlayer);
  }
}

extension GamePlayerValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GamePlayer, $Out> {
  GamePlayerCopyWith<$R, GamePlayer, $Out> get $asGamePlayer =>
      $base.as((v, t, t2) => _GamePlayerCopyWithImpl(v, t, t2));
}

abstract class GamePlayerCopyWith<$R, $In extends GamePlayer, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get teams;
  $R call({String? name, List<String>? teams});
  GamePlayerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GamePlayerCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GamePlayer, $Out>
    implements GamePlayerCopyWith<$R, GamePlayer, $Out> {
  _GamePlayerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GamePlayer> $mapper =
      GamePlayerMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get teams =>
      $value.teams != null
          ? ListCopyWith($value.teams!,
              (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(teams: v))
          : null;
  @override
  $R call({String? name, Object? teams = $none}) => $apply(FieldCopyWithData(
      {if (name != null) #name: name, if (teams != $none) #teams: teams}));
  @override
  GamePlayer $make(CopyWithData data) => GamePlayer(
      name: data.get(#name, or: $value.name),
      teams: data.get(#teams, or: $value.teams));

  @override
  GamePlayerCopyWith<$R2, GamePlayer, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GamePlayerCopyWithImpl($value, $cast, t);
}
