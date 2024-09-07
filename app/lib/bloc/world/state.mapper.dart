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
      GameTableMapper.ensureInitialized();
      GameInfoMapper.ensureInitialized();
      FileMetadataMapper.ensureInitialized();
      VectorDefinitionMapper.ensureInitialized();
      ItemLocationMapper.ensureInitialized();
      ChatMessageMapper.ensureInitialized();
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
  static String? _$name(ClientWorldState v) => v.name;
  static const Field<ClientWorldState, String> _f$name =
      Field('name', _$name, opt: true);
  static GameTable _$table(ClientWorldState v) => v.table;
  static const Field<ClientWorldState, GameTable> _f$table =
      Field('table', _$table, opt: true, def: const GameTable());
  static String _$tableName(ClientWorldState v) => v.tableName;
  static const Field<ClientWorldState, String> _f$tableName =
      Field('tableName', _$tableName, opt: true, def: '');
  static GameInfo _$info(ClientWorldState v) => v.info;
  static const Field<ClientWorldState, GameInfo> _f$info =
      Field('info', _$info, opt: true, def: const GameInfo());
  static FileMetadata _$metadata(ClientWorldState v) => v.metadata;
  static const Field<ClientWorldState, FileMetadata> _f$metadata =
      Field('metadata', _$metadata, opt: true, def: const FileMetadata());
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
  static int _$id(ClientWorldState v) => v.id;
  static const Field<ClientWorldState, int> _f$id =
      Field('id', _$id, opt: true, def: kAuthorityChannel);
  static Map<String, Set<int>> _$teamMembers(ClientWorldState v) =>
      v.teamMembers;
  static const Field<ClientWorldState, Map<String, Set<int>>> _f$teamMembers =
      Field('teamMembers', _$teamMembers, opt: true, def: const {});
  static List<ChatMessage> _$messages(ClientWorldState v) => v.messages;
  static const Field<ClientWorldState, List<ChatMessage>> _f$messages =
      Field('messages', _$messages, opt: true, def: const []);
  static QuokkaData _$data(ClientWorldState v) => v.data;
  static const Field<ClientWorldState, QuokkaData> _f$data =
      Field('data', _$data);
  static DrawerView _$drawerView(ClientWorldState v) => v.drawerView;
  static const Field<ClientWorldState, DrawerView> _f$drawerView =
      Field('drawerView', _$drawerView, opt: true, def: DrawerView.chat);

  @override
  final MappableFields<ClientWorldState> fields = const {
    #multiplayer: _f$multiplayer,
    #colorScheme: _f$colorScheme,
    #assetManager: _f$assetManager,
    #name: _f$name,
    #table: _f$table,
    #tableName: _f$tableName,
    #info: _f$info,
    #metadata: _f$metadata,
    #selectedCell: _f$selectedCell,
    #selectedDeck: _f$selectedDeck,
    #showHand: _f$showHand,
    #switchCellOnMove: _f$switchCellOnMove,
    #id: _f$id,
    #teamMembers: _f$teamMembers,
    #messages: _f$messages,
    #data: _f$data,
    #drawerView: _f$drawerView,
  };

  static ClientWorldState _instantiate(DecodingData data) {
    return ClientWorldState(
        multiplayer: data.dec(_f$multiplayer),
        colorScheme: data.dec(_f$colorScheme),
        assetManager: data.dec(_f$assetManager),
        name: data.dec(_f$name),
        table: data.dec(_f$table),
        tableName: data.dec(_f$tableName),
        info: data.dec(_f$info),
        metadata: data.dec(_f$metadata),
        selectedCell: data.dec(_f$selectedCell),
        selectedDeck: data.dec(_f$selectedDeck),
        showHand: data.dec(_f$showHand),
        switchCellOnMove: data.dec(_f$switchCellOnMove),
        id: data.dec(_f$id),
        teamMembers: data.dec(_f$teamMembers),
        messages: data.dec(_f$messages),
        data: data.dec(_f$data),
        drawerView: data.dec(_f$drawerView));
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
    implements WorldStateCopyWith<$R, $In, $Out> {
  @override
  GameTableCopyWith<$R, GameTable, GameTable> get table;
  @override
  GameInfoCopyWith<$R, GameInfo, GameInfo> get info;
  @override
  FileMetadataCopyWith<$R, FileMetadata, FileMetadata> get metadata;
  VectorDefinitionCopyWith<$R, VectorDefinition, VectorDefinition>?
      get selectedCell;
  ItemLocationCopyWith<$R, ItemLocation, ItemLocation>? get selectedDeck;
  @override
  MapCopyWith<$R, String, Set<int>, ObjectCopyWith<$R, Set<int>, Set<int>>>
      get teamMembers;
  @override
  ListCopyWith<$R, ChatMessage,
      ChatMessageCopyWith<$R, ChatMessage, ChatMessage>> get messages;
  @override
  $R call(
      {MultiplayerCubit? multiplayer,
      ColorScheme? colorScheme,
      GameAssetManager? assetManager,
      String? name,
      GameTable? table,
      String? tableName,
      GameInfo? info,
      FileMetadata? metadata,
      VectorDefinition? selectedCell,
      ItemLocation? selectedDeck,
      bool? showHand,
      bool? switchCellOnMove,
      int? id,
      Map<String, Set<int>>? teamMembers,
      List<ChatMessage>? messages,
      QuokkaData? data,
      DrawerView? drawerView});
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
  GameTableCopyWith<$R, GameTable, GameTable> get table =>
      $value.table.copyWith.$chain((v) => call(table: v));
  @override
  GameInfoCopyWith<$R, GameInfo, GameInfo> get info =>
      $value.info.copyWith.$chain((v) => call(info: v));
  @override
  FileMetadataCopyWith<$R, FileMetadata, FileMetadata> get metadata =>
      $value.metadata.copyWith.$chain((v) => call(metadata: v));
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
  ListCopyWith<$R, ChatMessage,
          ChatMessageCopyWith<$R, ChatMessage, ChatMessage>>
      get messages => ListCopyWith($value.messages,
          (v, t) => v.copyWith.$chain(t), (v) => call(messages: v));
  @override
  $R call(
          {MultiplayerCubit? multiplayer,
          ColorScheme? colorScheme,
          GameAssetManager? assetManager,
          Object? name = $none,
          GameTable? table,
          String? tableName,
          GameInfo? info,
          FileMetadata? metadata,
          Object? selectedCell = $none,
          Object? selectedDeck = $none,
          bool? showHand,
          bool? switchCellOnMove,
          int? id,
          Map<String, Set<int>>? teamMembers,
          List<ChatMessage>? messages,
          QuokkaData? data,
          DrawerView? drawerView}) =>
      $apply(FieldCopyWithData({
        if (multiplayer != null) #multiplayer: multiplayer,
        if (colorScheme != null) #colorScheme: colorScheme,
        if (assetManager != null) #assetManager: assetManager,
        if (name != $none) #name: name,
        if (table != null) #table: table,
        if (tableName != null) #tableName: tableName,
        if (info != null) #info: info,
        if (metadata != null) #metadata: metadata,
        if (selectedCell != $none) #selectedCell: selectedCell,
        if (selectedDeck != $none) #selectedDeck: selectedDeck,
        if (showHand != null) #showHand: showHand,
        if (switchCellOnMove != null) #switchCellOnMove: switchCellOnMove,
        if (id != null) #id: id,
        if (teamMembers != null) #teamMembers: teamMembers,
        if (messages != null) #messages: messages,
        if (data != null) #data: data,
        if (drawerView != null) #drawerView: drawerView
      }));
  @override
  ClientWorldState $make(CopyWithData data) => ClientWorldState(
      multiplayer: data.get(#multiplayer, or: $value.multiplayer),
      colorScheme: data.get(#colorScheme, or: $value.colorScheme),
      assetManager: data.get(#assetManager, or: $value.assetManager),
      name: data.get(#name, or: $value.name),
      table: data.get(#table, or: $value.table),
      tableName: data.get(#tableName, or: $value.tableName),
      info: data.get(#info, or: $value.info),
      metadata: data.get(#metadata, or: $value.metadata),
      selectedCell: data.get(#selectedCell, or: $value.selectedCell),
      selectedDeck: data.get(#selectedDeck, or: $value.selectedDeck),
      showHand: data.get(#showHand, or: $value.showHand),
      switchCellOnMove:
          data.get(#switchCellOnMove, or: $value.switchCellOnMove),
      id: data.get(#id, or: $value.id),
      teamMembers: data.get(#teamMembers, or: $value.teamMembers),
      messages: data.get(#messages, or: $value.messages),
      data: data.get(#data, or: $value.data),
      drawerView: data.get(#drawerView, or: $value.drawerView));

  @override
  ClientWorldStateCopyWith<$R2, ClientWorldState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ClientWorldStateCopyWithImpl($value, $cast, t);
}
