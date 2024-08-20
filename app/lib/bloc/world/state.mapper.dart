// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'state.dart';

class WorldStateMapper extends ClassMapperBase<WorldState> {
  WorldStateMapper._();

  static WorldStateMapper? _instance;
  static WorldStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WorldStateMapper._());
      GameTableMapper.ensureInitialized();
      VectorDefinitionMapper.ensureInitialized();
      ItemLocationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WorldState';

  static MultiplayerCubit _$multiplayer(WorldState v) => v.multiplayer;
  static const Field<WorldState, MultiplayerCubit> _f$multiplayer =
      Field('multiplayer', _$multiplayer);
  static QuokkaFileSystem _$fileSystem(WorldState v) => v.fileSystem;
  static const Field<WorldState, QuokkaFileSystem> _f$fileSystem =
      Field('fileSystem', _$fileSystem);
  static ColorScheme _$colorScheme(WorldState v) => v.colorScheme;
  static const Field<WorldState, ColorScheme> _f$colorScheme =
      Field('colorScheme', _$colorScheme);
  static String? _$name(WorldState v) => v.name;
  static const Field<WorldState, String> _f$name =
      Field('name', _$name, opt: true);
  static GameTable _$table(WorldState v) => v.table;
  static const Field<WorldState, GameTable> _f$table =
      Field('table', _$table, opt: true, def: const GameTable());
  static VectorDefinition? _$selectedCell(WorldState v) => v.selectedCell;
  static const Field<WorldState, VectorDefinition> _f$selectedCell =
      Field('selectedCell', _$selectedCell, opt: true);
  static ItemLocation? _$selectedDeck(WorldState v) => v.selectedDeck;
  static const Field<WorldState, ItemLocation> _f$selectedDeck =
      Field('selectedDeck', _$selectedDeck, opt: true);
  static bool _$showHand(WorldState v) => v.showHand;
  static const Field<WorldState, bool> _f$showHand =
      Field('showHand', _$showHand, opt: true, def: false);
  static int _$id(WorldState v) => v.id;
  static const Field<WorldState, int> _f$id =
      Field('id', _$id, opt: true, def: kAuthorityChannel);
  static Map<String, Set<int>> _$teamMembers(WorldState v) => v.teamMembers;
  static const Field<WorldState, Map<String, Set<int>>> _f$teamMembers =
      Field('teamMembers', _$teamMembers, opt: true, def: const {});
  static QuokkaData _$data(WorldState v) => v.data;
  static const Field<WorldState, QuokkaData> _f$data = Field('data', _$data);

  @override
  final MappableFields<WorldState> fields = const {
    #multiplayer: _f$multiplayer,
    #fileSystem: _f$fileSystem,
    #colorScheme: _f$colorScheme,
    #name: _f$name,
    #table: _f$table,
    #selectedCell: _f$selectedCell,
    #selectedDeck: _f$selectedDeck,
    #showHand: _f$showHand,
    #id: _f$id,
    #teamMembers: _f$teamMembers,
    #data: _f$data,
  };

  static WorldState _instantiate(DecodingData data) {
    return WorldState(
        multiplayer: data.dec(_f$multiplayer),
        fileSystem: data.dec(_f$fileSystem),
        colorScheme: data.dec(_f$colorScheme),
        name: data.dec(_f$name),
        table: data.dec(_f$table),
        selectedCell: data.dec(_f$selectedCell),
        selectedDeck: data.dec(_f$selectedDeck),
        showHand: data.dec(_f$showHand),
        id: data.dec(_f$id),
        teamMembers: data.dec(_f$teamMembers),
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
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>?
      get selectedCell;
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation>? get selectedDeck;
  MapCopyWith<$R, String, Set<int>, ObjectCopyWith<$R, Set<int>, Set<int>>>
      get teamMembers;
  $R call(
      {MultiplayerCubit? multiplayer,
      QuokkaFileSystem? fileSystem,
      ColorScheme? colorScheme,
      String? name,
      GameTable? table,
      VectorDefinition? selectedCell,
      ItemLocation? selectedDeck,
      bool? showHand,
      int? id,
      Map<String, Set<int>>? teamMembers,
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
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>?
      get selectedCell =>
          $value.selectedCell?.copyWith.$chain((v) => call(selectedCell: v));
  @override
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation>? get selectedDeck =>
      $value.selectedDeck?.copyWith.$chain((v) => call(selectedDeck: v));
  @override
  MapCopyWith<$R, String, Set<int>, ObjectCopyWith<$R, Set<int>, Set<int>>>
      get teamMembers => MapCopyWith(
          $value.teamMembers,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(teamMembers: v));
  @override
  $R call(
          {MultiplayerCubit? multiplayer,
          QuokkaFileSystem? fileSystem,
          ColorScheme? colorScheme,
          Object? name = $none,
          GameTable? table,
          Object? selectedCell = $none,
          Object? selectedDeck = $none,
          bool? showHand,
          int? id,
          Map<String, Set<int>>? teamMembers,
          QuokkaData? data}) =>
      $apply(FieldCopyWithData({
        if (multiplayer != null) #multiplayer: multiplayer,
        if (fileSystem != null) #fileSystem: fileSystem,
        if (colorScheme != null) #colorScheme: colorScheme,
        if (name != $none) #name: name,
        if (table != null) #table: table,
        if (selectedCell != $none) #selectedCell: selectedCell,
        if (selectedDeck != $none) #selectedDeck: selectedDeck,
        if (showHand != null) #showHand: showHand,
        if (id != null) #id: id,
        if (teamMembers != null) #teamMembers: teamMembers,
        if (data != null) #data: data
      }));
  @override
  WorldState $make(CopyWithData data) => WorldState(
      multiplayer: data.get(#multiplayer, or: $value.multiplayer),
      fileSystem: data.get(#fileSystem, or: $value.fileSystem),
      colorScheme: data.get(#colorScheme, or: $value.colorScheme),
      name: data.get(#name, or: $value.name),
      table: data.get(#table, or: $value.table),
      selectedCell: data.get(#selectedCell, or: $value.selectedCell),
      selectedDeck: data.get(#selectedDeck, or: $value.selectedDeck),
      showHand: data.get(#showHand, or: $value.showHand),
      id: data.get(#id, or: $value.id),
      teamMembers: data.get(#teamMembers, or: $value.teamMembers),
      data: data.get(#data, or: $value.data));

  @override
  WorldStateCopyWith<$R2, WorldState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WorldStateCopyWithImpl($value, $cast, t);
}
