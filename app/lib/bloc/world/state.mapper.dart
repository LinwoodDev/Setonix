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

class DrawerViewMapper extends EnumMapper<DrawerView> {
  DrawerViewMapper._();

  static DrawerViewMapper? _instance;
  static DrawerViewMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DrawerViewMapper._());
    }
    return _instance!;
  }

  static DrawerView fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  DrawerView decode(dynamic value) {
    switch (value) {
      case 'chat':
        return DrawerView.chat;
      case 'notes':
        return DrawerView.notes;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(DrawerView self) {
    switch (self) {
      case DrawerView.chat:
        return 'chat';
      case DrawerView.notes:
        return 'notes';
    }
  }
}

extension DrawerViewMapperExtension on DrawerView {
  String toValue() {
    DrawerViewMapper.ensureInitialized();
    return MapperContainer.globals.toValue<DrawerView>(this) as String;
  }
}

class ClientWorldStateMapper extends ClassMapperBase<ClientWorldState> {
  ClientWorldStateMapper._();

  static ClientWorldStateMapper? _instance;
  static ClientWorldStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ClientWorldStateMapper._());
      WorldStateMapper.ensureInitialized();
      VectorDefinitionMapper.ensureInitialized();
      ItemLocationMapper.ensureInitialized();
      DrawerViewMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ClientWorldState';

  static MultiplayerCubit _$multiplayer(ClientWorldState v) => v.multiplayer;
  static const Field<ClientWorldState, MultiplayerCubit> _f$multiplayer =
      Field('multiplayer', _$multiplayer);
  static ColorScheme _$colorScheme(ClientWorldState v) => v.colorScheme;
  static const Field<ClientWorldState, ColorScheme> _f$colorScheme =
      Field('colorScheme', _$colorScheme);
  static GameAssetManager _$assetManager(ClientWorldState v) => v.assetManager;
  static const Field<ClientWorldState, GameAssetManager> _f$assetManager =
      Field('assetManager', _$assetManager);
  static WorldState _$world(ClientWorldState v) => v.world;
  static const Field<ClientWorldState, WorldState> _f$world =
      Field('world', _$world);
  static VectorDefinition? _$selectedCell(ClientWorldState v) => v.selectedCell;
  static const Field<ClientWorldState, VectorDefinition> _f$selectedCell =
      Field('selectedCell', _$selectedCell, opt: true);
  static ItemLocation? _$selectedDeck(ClientWorldState v) => v.selectedDeck;
  static const Field<ClientWorldState, ItemLocation> _f$selectedDeck =
      Field('selectedDeck', _$selectedDeck, opt: true);
  static bool _$showHand(ClientWorldState v) => v.showHand;
  static const Field<ClientWorldState, bool> _f$showHand =
      Field('showHand', _$showHand, opt: true, def: false);
  static bool _$switchCellOnMove(ClientWorldState v) => v.switchCellOnMove;
  static const Field<ClientWorldState, bool> _f$switchCellOnMove =
      Field('switchCellOnMove', _$switchCellOnMove, opt: true, def: false);
  static DrawerView _$drawerView(ClientWorldState v) => v.drawerView;
  static const Field<ClientWorldState, DrawerView> _f$drawerView =
      Field('drawerView', _$drawerView, opt: true, def: DrawerView.chat);
  static double _$zoom(ClientWorldState v) => v.zoom;
  static const Field<ClientWorldState, double> _f$zoom =
      Field('zoom', _$zoom, opt: true, def: 1.0);

  @override
  final MappableFields<ClientWorldState> fields = const {
    #multiplayer: _f$multiplayer,
    #colorScheme: _f$colorScheme,
    #assetManager: _f$assetManager,
    #world: _f$world,
    #selectedCell: _f$selectedCell,
    #selectedDeck: _f$selectedDeck,
    #showHand: _f$showHand,
    #switchCellOnMove: _f$switchCellOnMove,
    #drawerView: _f$drawerView,
    #zoom: _f$zoom,
  };

  static ClientWorldState _instantiate(DecodingData data) {
    return ClientWorldState(
        multiplayer: data.dec(_f$multiplayer),
        colorScheme: data.dec(_f$colorScheme),
        assetManager: data.dec(_f$assetManager),
        world: data.dec(_f$world),
        selectedCell: data.dec(_f$selectedCell),
        selectedDeck: data.dec(_f$selectedDeck),
        showHand: data.dec(_f$showHand),
        switchCellOnMove: data.dec(_f$switchCellOnMove),
        drawerView: data.dec(_f$drawerView),
        zoom: data.dec(_f$zoom));
  }

  @override
  final Function instantiate = _instantiate;

  static ClientWorldState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ClientWorldState>(map);
  }

  static ClientWorldState fromJson(String json) {
    return ensureInitialized().decodeJson<ClientWorldState>(json);
  }
}

mixin ClientWorldStateMappable {
  String toJson() {
    return ClientWorldStateMapper.ensureInitialized()
        .encodeJson<ClientWorldState>(this as ClientWorldState);
  }

  Map<String, dynamic> toMap() {
    return ClientWorldStateMapper.ensureInitialized()
        .encodeMap<ClientWorldState>(this as ClientWorldState);
  }

  ClientWorldStateCopyWith<ClientWorldState, ClientWorldState, ClientWorldState>
      get copyWith => _ClientWorldStateCopyWithImpl(
          this as ClientWorldState, $identity, $identity);
  @override
  String toString() {
    return ClientWorldStateMapper.ensureInitialized()
        .stringifyValue(this as ClientWorldState);
  }

  @override
  bool operator ==(Object other) {
    return ClientWorldStateMapper.ensureInitialized()
        .equalsValue(this as ClientWorldState, other);
  }

  @override
  int get hashCode {
    return ClientWorldStateMapper.ensureInitialized()
        .hashValue(this as ClientWorldState);
  }
}

extension ClientWorldStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ClientWorldState, $Out> {
  ClientWorldStateCopyWith<$R, ClientWorldState, $Out>
      get $asClientWorldState =>
          $base.as((v, t, t2) => _ClientWorldStateCopyWithImpl(v, t, t2));
}

abstract class ClientWorldStateCopyWith<$R, $In extends ClientWorldState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  WorldStateCopyWith<$R, WorldState, WorldState> get world;
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>?
      get selectedCell;
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation>? get selectedDeck;
  $R call(
      {MultiplayerCubit? multiplayer,
      ColorScheme? colorScheme,
      GameAssetManager? assetManager,
      WorldState? world,
      VectorDefinition? selectedCell,
      ItemLocation? selectedDeck,
      bool? showHand,
      bool? switchCellOnMove,
      DrawerView? drawerView,
      double? zoom});
  ClientWorldStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ClientWorldStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ClientWorldState, $Out>
    implements ClientWorldStateCopyWith<$R, ClientWorldState, $Out> {
  _ClientWorldStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ClientWorldState> $mapper =
      ClientWorldStateMapper.ensureInitialized();
  @override
  WorldStateCopyWith<$R, WorldState, WorldState> get world =>
      $value.world.copyWith.$chain((v) => call(world: v));
  @override
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>?
      get selectedCell =>
          $value.selectedCell?.copyWith.$chain((v) => call(selectedCell: v));
  @override
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation>? get selectedDeck =>
      $value.selectedDeck?.copyWith.$chain((v) => call(selectedDeck: v));
  @override
  $R call(
          {MultiplayerCubit? multiplayer,
          ColorScheme? colorScheme,
          GameAssetManager? assetManager,
          WorldState? world,
          Object? selectedCell = $none,
          Object? selectedDeck = $none,
          bool? showHand,
          bool? switchCellOnMove,
          DrawerView? drawerView,
          double? zoom}) =>
      $apply(FieldCopyWithData({
        if (multiplayer != null) #multiplayer: multiplayer,
        if (colorScheme != null) #colorScheme: colorScheme,
        if (assetManager != null) #assetManager: assetManager,
        if (world != null) #world: world,
        if (selectedCell != $none) #selectedCell: selectedCell,
        if (selectedDeck != $none) #selectedDeck: selectedDeck,
        if (showHand != null) #showHand: showHand,
        if (switchCellOnMove != null) #switchCellOnMove: switchCellOnMove,
        if (drawerView != null) #drawerView: drawerView,
        if (zoom != null) #zoom: zoom
      }));
  @override
  ClientWorldState $make(CopyWithData data) => ClientWorldState(
      multiplayer: data.get(#multiplayer, or: $value.multiplayer),
      colorScheme: data.get(#colorScheme, or: $value.colorScheme),
      assetManager: data.get(#assetManager, or: $value.assetManager),
      world: data.get(#world, or: $value.world),
      selectedCell: data.get(#selectedCell, or: $value.selectedCell),
      selectedDeck: data.get(#selectedDeck, or: $value.selectedDeck),
      showHand: data.get(#showHand, or: $value.showHand),
      switchCellOnMove:
          data.get(#switchCellOnMove, or: $value.switchCellOnMove),
      drawerView: data.get(#drawerView, or: $value.drawerView),
      zoom: data.get(#zoom, or: $value.zoom));

  @override
  ClientWorldStateCopyWith<$R2, ClientWorldState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ClientWorldStateCopyWithImpl($value, $cast, t);
}
