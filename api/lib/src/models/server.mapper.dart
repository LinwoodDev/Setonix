// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'server.dart';

/// @nodoc
class GameServerMapper extends ClassMapperBase<GameServer> {
  GameServerMapper._();

  static GameServerMapper? _instance;
  static GameServerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameServerMapper._());
      LanGameServerMapper.ensureInitialized();
      ListGameServerMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameServer';

  static String _$address(GameServer v) => v.address;
  static const Field<GameServer, String> _f$address = Field(
    'address',
    _$address,
  );
  static bool _$secure(GameServer v) => v.secure;
  static const Field<GameServer, bool> _f$secure = Field(
    'secure',
    _$secure,
    opt: true,
    def: true,
  );

  @override
  final MappableFields<GameServer> fields = const {
    #address: _f$address,
    #secure: _f$secure,
  };

  static GameServer _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('GameServer');
  }

  @override
  final Function instantiate = _instantiate;

  static GameServer fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameServer>(map);
  }

  static GameServer fromJson(String json) {
    return ensureInitialized().decodeJson<GameServer>(json);
  }
}

/// @nodoc
mixin GameServerMappable {
  String toJson();
  Map<String, dynamic> toMap();
  GameServerCopyWith<GameServer, GameServer, GameServer> get copyWith;
}

/// @nodoc
abstract class GameServerCopyWith<$R, $In extends GameServer, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? address, bool? secure});
  GameServerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class LanGameServerMapper extends ClassMapperBase<LanGameServer> {
  LanGameServerMapper._();

  static LanGameServerMapper? _instance;
  static LanGameServerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanGameServerMapper._());
      GameServerMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanGameServer';

  static String _$address(LanGameServer v) => v.address;
  static const Field<LanGameServer, String> _f$address = Field(
    'address',
    _$address,
  );
  static bool _$secure(LanGameServer v) => v.secure;
  static const Field<LanGameServer, bool> _f$secure = Field(
    'secure',
    _$secure,
    opt: true,
    def: true,
  );

  @override
  final MappableFields<LanGameServer> fields = const {
    #address: _f$address,
    #secure: _f$secure,
  };

  static LanGameServer _instantiate(DecodingData data) {
    return LanGameServer(
      address: data.dec(_f$address),
      secure: data.dec(_f$secure),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LanGameServer fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanGameServer>(map);
  }

  static LanGameServer fromJson(String json) {
    return ensureInitialized().decodeJson<LanGameServer>(json);
  }
}

/// @nodoc
mixin LanGameServerMappable {
  String toJson() {
    return LanGameServerMapper.ensureInitialized().encodeJson<LanGameServer>(
      this as LanGameServer,
    );
  }

  Map<String, dynamic> toMap() {
    return LanGameServerMapper.ensureInitialized().encodeMap<LanGameServer>(
      this as LanGameServer,
    );
  }

  LanGameServerCopyWith<LanGameServer, LanGameServer, LanGameServer>
  get copyWith => _LanGameServerCopyWithImpl<LanGameServer, LanGameServer>(
    this as LanGameServer,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return LanGameServerMapper.ensureInitialized().stringifyValue(
      this as LanGameServer,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanGameServerMapper.ensureInitialized().equalsValue(
      this as LanGameServer,
      other,
    );
  }

  @override
  int get hashCode {
    return LanGameServerMapper.ensureInitialized().hashValue(
      this as LanGameServer,
    );
  }
}

/// @nodoc
extension LanGameServerValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanGameServer, $Out> {
  LanGameServerCopyWith<$R, LanGameServer, $Out> get $asLanGameServer =>
      $base.as((v, t, t2) => _LanGameServerCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class LanGameServerCopyWith<$R, $In extends LanGameServer, $Out>
    implements GameServerCopyWith<$R, $In, $Out> {
  @override
  $R call({String? address, bool? secure});
  LanGameServerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _LanGameServerCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanGameServer, $Out>
    implements LanGameServerCopyWith<$R, LanGameServer, $Out> {
  _LanGameServerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanGameServer> $mapper =
      LanGameServerMapper.ensureInitialized();
  @override
  $R call({String? address, bool? secure}) => $apply(
    FieldCopyWithData({
      if (address != null) #address: address,
      if (secure != null) #secure: secure,
    }),
  );
  @override
  LanGameServer $make(CopyWithData data) => LanGameServer(
    address: data.get(#address, or: $value.address),
    secure: data.get(#secure, or: $value.secure),
  );

  @override
  LanGameServerCopyWith<$R2, LanGameServer, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LanGameServerCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class ListGameServerMapper extends ClassMapperBase<ListGameServer> {
  ListGameServerMapper._();

  static ListGameServerMapper? _instance;
  static ListGameServerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ListGameServerMapper._());
      GameServerMapper.ensureInitialized();
      BrowsedGameServerMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ListGameServer';

  static String _$name(ListGameServer v) => v.name;
  static const Field<ListGameServer, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );
  static String _$thumbnail(ListGameServer v) => v.thumbnail;
  static const Field<ListGameServer, String> _f$thumbnail = Field(
    'thumbnail',
    _$thumbnail,
    opt: true,
    def: '',
  );
  static String _$address(ListGameServer v) => v.address;
  static const Field<ListGameServer, String> _f$address = Field(
    'address',
    _$address,
  );
  static bool _$secure(ListGameServer v) => v.secure;
  static const Field<ListGameServer, bool> _f$secure = Field(
    'secure',
    _$secure,
    opt: true,
    def: true,
  );
  static bool _$highlighted(ListGameServer v) => v.highlighted;
  static const Field<ListGameServer, bool> _f$highlighted = Field(
    'highlighted',
    _$highlighted,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<ListGameServer> fields = const {
    #name: _f$name,
    #thumbnail: _f$thumbnail,
    #address: _f$address,
    #secure: _f$secure,
    #highlighted: _f$highlighted,
  };

  static ListGameServer _instantiate(DecodingData data) {
    return ListGameServer(
      name: data.dec(_f$name),
      thumbnail: data.dec(_f$thumbnail),
      address: data.dec(_f$address),
      secure: data.dec(_f$secure),
      highlighted: data.dec(_f$highlighted),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ListGameServer fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ListGameServer>(map);
  }

  static ListGameServer fromJson(String json) {
    return ensureInitialized().decodeJson<ListGameServer>(json);
  }
}

/// @nodoc
mixin ListGameServerMappable {
  String toJson() {
    return ListGameServerMapper.ensureInitialized().encodeJson<ListGameServer>(
      this as ListGameServer,
    );
  }

  Map<String, dynamic> toMap() {
    return ListGameServerMapper.ensureInitialized().encodeMap<ListGameServer>(
      this as ListGameServer,
    );
  }

  ListGameServerCopyWith<ListGameServer, ListGameServer, ListGameServer>
  get copyWith => _ListGameServerCopyWithImpl<ListGameServer, ListGameServer>(
    this as ListGameServer,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ListGameServerMapper.ensureInitialized().stringifyValue(
      this as ListGameServer,
    );
  }

  @override
  bool operator ==(Object other) {
    return ListGameServerMapper.ensureInitialized().equalsValue(
      this as ListGameServer,
      other,
    );
  }

  @override
  int get hashCode {
    return ListGameServerMapper.ensureInitialized().hashValue(
      this as ListGameServer,
    );
  }
}

/// @nodoc
extension ListGameServerValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ListGameServer, $Out> {
  ListGameServerCopyWith<$R, ListGameServer, $Out> get $asListGameServer =>
      $base.as((v, t, t2) => _ListGameServerCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class ListGameServerCopyWith<$R, $In extends ListGameServer, $Out>
    implements GameServerCopyWith<$R, $In, $Out> {
  @override
  $R call({
    String? name,
    String? thumbnail,
    String? address,
    bool? secure,
    bool? highlighted,
  });
  ListGameServerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _ListGameServerCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ListGameServer, $Out>
    implements ListGameServerCopyWith<$R, ListGameServer, $Out> {
  _ListGameServerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ListGameServer> $mapper =
      ListGameServerMapper.ensureInitialized();
  @override
  $R call({
    String? name,
    String? thumbnail,
    String? address,
    bool? secure,
    bool? highlighted,
  }) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (thumbnail != null) #thumbnail: thumbnail,
      if (address != null) #address: address,
      if (secure != null) #secure: secure,
      if (highlighted != null) #highlighted: highlighted,
    }),
  );
  @override
  ListGameServer $make(CopyWithData data) => ListGameServer(
    name: data.get(#name, or: $value.name),
    thumbnail: data.get(#thumbnail, or: $value.thumbnail),
    address: data.get(#address, or: $value.address),
    secure: data.get(#secure, or: $value.secure),
    highlighted: data.get(#highlighted, or: $value.highlighted),
  );

  @override
  ListGameServerCopyWith<$R2, ListGameServer, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ListGameServerCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class BrowsedGameServerMapper extends ClassMapperBase<BrowsedGameServer> {
  BrowsedGameServerMapper._();

  static BrowsedGameServerMapper? _instance;
  static BrowsedGameServerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BrowsedGameServerMapper._());
      ListGameServerMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BrowsedGameServer';

  static String _$name(BrowsedGameServer v) => v.name;
  static const Field<BrowsedGameServer, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );
  static String _$thumbnail(BrowsedGameServer v) => v.thumbnail;
  static const Field<BrowsedGameServer, String> _f$thumbnail = Field(
    'thumbnail',
    _$thumbnail,
    opt: true,
    def: '',
  );
  static String _$address(BrowsedGameServer v) => v.address;
  static const Field<BrowsedGameServer, String> _f$address = Field(
    'address',
    _$address,
  );
  static bool _$secure(BrowsedGameServer v) => v.secure;
  static const Field<BrowsedGameServer, bool> _f$secure = Field(
    'secure',
    _$secure,
    opt: true,
    def: true,
  );
  static bool _$highlighted(BrowsedGameServer v) => v.highlighted;
  static const Field<BrowsedGameServer, bool> _f$highlighted = Field(
    'highlighted',
    _$highlighted,
    opt: true,
    def: false,
  );

  @override
  final MappableFields<BrowsedGameServer> fields = const {
    #name: _f$name,
    #thumbnail: _f$thumbnail,
    #address: _f$address,
    #secure: _f$secure,
    #highlighted: _f$highlighted,
  };

  static BrowsedGameServer _instantiate(DecodingData data) {
    return BrowsedGameServer(
      name: data.dec(_f$name),
      thumbnail: data.dec(_f$thumbnail),
      address: data.dec(_f$address),
      secure: data.dec(_f$secure),
      highlighted: data.dec(_f$highlighted),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BrowsedGameServer fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BrowsedGameServer>(map);
  }

  static BrowsedGameServer fromJson(String json) {
    return ensureInitialized().decodeJson<BrowsedGameServer>(json);
  }
}

/// @nodoc
mixin BrowsedGameServerMappable {
  String toJson() {
    return BrowsedGameServerMapper.ensureInitialized()
        .encodeJson<BrowsedGameServer>(this as BrowsedGameServer);
  }

  Map<String, dynamic> toMap() {
    return BrowsedGameServerMapper.ensureInitialized()
        .encodeMap<BrowsedGameServer>(this as BrowsedGameServer);
  }

  BrowsedGameServerCopyWith<
    BrowsedGameServer,
    BrowsedGameServer,
    BrowsedGameServer
  >
  get copyWith =>
      _BrowsedGameServerCopyWithImpl<BrowsedGameServer, BrowsedGameServer>(
        this as BrowsedGameServer,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BrowsedGameServerMapper.ensureInitialized().stringifyValue(
      this as BrowsedGameServer,
    );
  }

  @override
  bool operator ==(Object other) {
    return BrowsedGameServerMapper.ensureInitialized().equalsValue(
      this as BrowsedGameServer,
      other,
    );
  }

  @override
  int get hashCode {
    return BrowsedGameServerMapper.ensureInitialized().hashValue(
      this as BrowsedGameServer,
    );
  }
}

/// @nodoc
extension BrowsedGameServerValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BrowsedGameServer, $Out> {
  BrowsedGameServerCopyWith<$R, BrowsedGameServer, $Out>
  get $asBrowsedGameServer => $base.as(
    (v, t, t2) => _BrowsedGameServerCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

/// @nodoc
abstract class BrowsedGameServerCopyWith<
  $R,
  $In extends BrowsedGameServer,
  $Out
>
    implements ListGameServerCopyWith<$R, $In, $Out> {
  @override
  $R call({
    String? name,
    String? thumbnail,
    String? address,
    bool? secure,
    bool? highlighted,
  });
  BrowsedGameServerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

/// @nodoc
class _BrowsedGameServerCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BrowsedGameServer, $Out>
    implements BrowsedGameServerCopyWith<$R, BrowsedGameServer, $Out> {
  _BrowsedGameServerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BrowsedGameServer> $mapper =
      BrowsedGameServerMapper.ensureInitialized();
  @override
  $R call({
    String? name,
    String? thumbnail,
    String? address,
    bool? secure,
    bool? highlighted,
  }) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (thumbnail != null) #thumbnail: thumbnail,
      if (address != null) #address: address,
      if (secure != null) #secure: secure,
      if (highlighted != null) #highlighted: highlighted,
    }),
  );
  @override
  BrowsedGameServer $make(CopyWithData data) => BrowsedGameServer(
    name: data.get(#name, or: $value.name),
    thumbnail: data.get(#thumbnail, or: $value.thumbnail),
    address: data.get(#address, or: $value.address),
    secure: data.get(#secure, or: $value.secure),
    highlighted: data.get(#highlighted, or: $value.highlighted),
  );

  @override
  BrowsedGameServerCopyWith<$R2, BrowsedGameServer, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BrowsedGameServerCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class GamePropertyMapper extends ClassMapperBase<GameProperty> {
  GamePropertyMapper._();

  static GamePropertyMapper? _instance;
  static GamePropertyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GamePropertyMapper._());
      LanPropertyMapper.ensureInitialized();
      ListPropertyMapper.ensureInitialized();
      SignatureMetadataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GameProperty';

  static String _$description(GameProperty v) => v.description;
  static const Field<GameProperty, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static bool _$hasThumbnail(GameProperty v) => v.hasThumbnail;
  static const Field<GameProperty, bool> _f$hasThumbnail = Field(
    'hasThumbnail',
    _$hasThumbnail,
    opt: true,
    def: false,
  );
  static int? _$maxPlayers(GameProperty v) => v.maxPlayers;
  static const Field<GameProperty, int> _f$maxPlayers = Field(
    'maxPlayers',
    _$maxPlayers,
    opt: true,
  );
  static int _$currentPlayers(GameProperty v) => v.currentPlayers;
  static const Field<GameProperty, int> _f$currentPlayers = Field(
    'currentPlayers',
    _$currentPlayers,
    opt: true,
    def: 0,
  );
  static Map<String, SignatureMetadata> _$packsSignature(GameProperty v) =>
      v.packsSignature;
  static const Field<GameProperty, Map<String, SignatureMetadata>>
  _f$packsSignature = Field(
    'packsSignature',
    _$packsSignature,
    opt: true,
    def: const {},
  );

  @override
  final MappableFields<GameProperty> fields = const {
    #description: _f$description,
    #hasThumbnail: _f$hasThumbnail,
    #maxPlayers: _f$maxPlayers,
    #currentPlayers: _f$currentPlayers,
    #packsSignature: _f$packsSignature,
  };

  static GameProperty _instantiate(DecodingData data) {
    return GameProperty(
      description: data.dec(_f$description),
      hasThumbnail: data.dec(_f$hasThumbnail),
      maxPlayers: data.dec(_f$maxPlayers),
      currentPlayers: data.dec(_f$currentPlayers),
      packsSignature: data.dec(_f$packsSignature),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GameProperty fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameProperty>(map);
  }

  static GameProperty fromJson(String json) {
    return ensureInitialized().decodeJson<GameProperty>(json);
  }
}

/// @nodoc
mixin GamePropertyMappable {
  String toJson() {
    return GamePropertyMapper.ensureInitialized().encodeJson<GameProperty>(
      this as GameProperty,
    );
  }

  Map<String, dynamic> toMap() {
    return GamePropertyMapper.ensureInitialized().encodeMap<GameProperty>(
      this as GameProperty,
    );
  }

  GamePropertyCopyWith<GameProperty, GameProperty, GameProperty> get copyWith =>
      _GamePropertyCopyWithImpl<GameProperty, GameProperty>(
        this as GameProperty,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GamePropertyMapper.ensureInitialized().stringifyValue(
      this as GameProperty,
    );
  }

  @override
  bool operator ==(Object other) {
    return GamePropertyMapper.ensureInitialized().equalsValue(
      this as GameProperty,
      other,
    );
  }

  @override
  int get hashCode {
    return GamePropertyMapper.ensureInitialized().hashValue(
      this as GameProperty,
    );
  }
}

/// @nodoc
extension GamePropertyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameProperty, $Out> {
  GamePropertyCopyWith<$R, GameProperty, $Out> get $asGameProperty =>
      $base.as((v, t, t2) => _GamePropertyCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class GamePropertyCopyWith<$R, $In extends GameProperty, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<
    $R,
    String,
    SignatureMetadata,
    SignatureMetadataCopyWith<$R, SignatureMetadata, SignatureMetadata>
  >
  get packsSignature;
  $R call({
    String? description,
    bool? hasThumbnail,
    int? maxPlayers,
    int? currentPlayers,
    Map<String, SignatureMetadata>? packsSignature,
  });
  GamePropertyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _GamePropertyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameProperty, $Out>
    implements GamePropertyCopyWith<$R, GameProperty, $Out> {
  _GamePropertyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameProperty> $mapper =
      GamePropertyMapper.ensureInitialized();
  @override
  MapCopyWith<
    $R,
    String,
    SignatureMetadata,
    SignatureMetadataCopyWith<$R, SignatureMetadata, SignatureMetadata>
  >
  get packsSignature => MapCopyWith(
    $value.packsSignature,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(packsSignature: v),
  );
  @override
  $R call({
    String? description,
    bool? hasThumbnail,
    Object? maxPlayers = $none,
    int? currentPlayers,
    Map<String, SignatureMetadata>? packsSignature,
  }) => $apply(
    FieldCopyWithData({
      if (description != null) #description: description,
      if (hasThumbnail != null) #hasThumbnail: hasThumbnail,
      if (maxPlayers != $none) #maxPlayers: maxPlayers,
      if (currentPlayers != null) #currentPlayers: currentPlayers,
      if (packsSignature != null) #packsSignature: packsSignature,
    }),
  );
  @override
  GameProperty $make(CopyWithData data) => GameProperty(
    description: data.get(#description, or: $value.description),
    hasThumbnail: data.get(#hasThumbnail, or: $value.hasThumbnail),
    maxPlayers: data.get(#maxPlayers, or: $value.maxPlayers),
    currentPlayers: data.get(#currentPlayers, or: $value.currentPlayers),
    packsSignature: data.get(#packsSignature, or: $value.packsSignature),
  );

  @override
  GamePropertyCopyWith<$R2, GameProperty, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GamePropertyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class LanPropertyMapper extends ClassMapperBase<LanProperty> {
  LanPropertyMapper._();

  static LanPropertyMapper? _instance;
  static LanPropertyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanPropertyMapper._());
      GamePropertyMapper.ensureInitialized();
      SignatureMetadataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanProperty';

  static int _$port(LanProperty v) => v.port;
  static const Field<LanProperty, int> _f$port = Field(
    'port',
    _$port,
    opt: true,
    def: kDefaultPort,
  );
  static int _$currentPlayers(LanProperty v) => v.currentPlayers;
  static const Field<LanProperty, int> _f$currentPlayers = Field(
    'currentPlayers',
    _$currentPlayers,
    opt: true,
    def: 0,
  );
  static int? _$maxPlayers(LanProperty v) => v.maxPlayers;
  static const Field<LanProperty, int> _f$maxPlayers = Field(
    'maxPlayers',
    _$maxPlayers,
    opt: true,
  );
  static String _$description(LanProperty v) => v.description;
  static const Field<LanProperty, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static bool _$hasThumbnail(LanProperty v) => v.hasThumbnail;
  static const Field<LanProperty, bool> _f$hasThumbnail = Field(
    'hasThumbnail',
    _$hasThumbnail,
    opt: true,
    def: false,
  );
  static Map<String, SignatureMetadata> _$packsSignature(LanProperty v) =>
      v.packsSignature;
  static const Field<LanProperty, Map<String, SignatureMetadata>>
  _f$packsSignature = Field(
    'packsSignature',
    _$packsSignature,
    opt: true,
    def: const {},
  );

  @override
  final MappableFields<LanProperty> fields = const {
    #port: _f$port,
    #currentPlayers: _f$currentPlayers,
    #maxPlayers: _f$maxPlayers,
    #description: _f$description,
    #hasThumbnail: _f$hasThumbnail,
    #packsSignature: _f$packsSignature,
  };

  static LanProperty _instantiate(DecodingData data) {
    return LanProperty(
      port: data.dec(_f$port),
      currentPlayers: data.dec(_f$currentPlayers),
      maxPlayers: data.dec(_f$maxPlayers),
      description: data.dec(_f$description),
      hasThumbnail: data.dec(_f$hasThumbnail),
      packsSignature: data.dec(_f$packsSignature),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LanProperty fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanProperty>(map);
  }

  static LanProperty fromJson(String json) {
    return ensureInitialized().decodeJson<LanProperty>(json);
  }
}

/// @nodoc
mixin LanPropertyMappable {
  String toJson() {
    return LanPropertyMapper.ensureInitialized().encodeJson<LanProperty>(
      this as LanProperty,
    );
  }

  Map<String, dynamic> toMap() {
    return LanPropertyMapper.ensureInitialized().encodeMap<LanProperty>(
      this as LanProperty,
    );
  }

  LanPropertyCopyWith<LanProperty, LanProperty, LanProperty> get copyWith =>
      _LanPropertyCopyWithImpl<LanProperty, LanProperty>(
        this as LanProperty,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LanPropertyMapper.ensureInitialized().stringifyValue(
      this as LanProperty,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanPropertyMapper.ensureInitialized().equalsValue(
      this as LanProperty,
      other,
    );
  }

  @override
  int get hashCode {
    return LanPropertyMapper.ensureInitialized().hashValue(this as LanProperty);
  }
}

/// @nodoc
extension LanPropertyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanProperty, $Out> {
  LanPropertyCopyWith<$R, LanProperty, $Out> get $asLanProperty =>
      $base.as((v, t, t2) => _LanPropertyCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class LanPropertyCopyWith<$R, $In extends LanProperty, $Out>
    implements GamePropertyCopyWith<$R, $In, $Out> {
  @override
  MapCopyWith<
    $R,
    String,
    SignatureMetadata,
    SignatureMetadataCopyWith<$R, SignatureMetadata, SignatureMetadata>
  >
  get packsSignature;
  @override
  $R call({
    int? port,
    int? currentPlayers,
    int? maxPlayers,
    String? description,
    bool? hasThumbnail,
    Map<String, SignatureMetadata>? packsSignature,
  });
  LanPropertyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _LanPropertyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanProperty, $Out>
    implements LanPropertyCopyWith<$R, LanProperty, $Out> {
  _LanPropertyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanProperty> $mapper =
      LanPropertyMapper.ensureInitialized();
  @override
  MapCopyWith<
    $R,
    String,
    SignatureMetadata,
    SignatureMetadataCopyWith<$R, SignatureMetadata, SignatureMetadata>
  >
  get packsSignature => MapCopyWith(
    $value.packsSignature,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(packsSignature: v),
  );
  @override
  $R call({
    int? port,
    int? currentPlayers,
    Object? maxPlayers = $none,
    String? description,
    bool? hasThumbnail,
    Map<String, SignatureMetadata>? packsSignature,
  }) => $apply(
    FieldCopyWithData({
      if (port != null) #port: port,
      if (currentPlayers != null) #currentPlayers: currentPlayers,
      if (maxPlayers != $none) #maxPlayers: maxPlayers,
      if (description != null) #description: description,
      if (hasThumbnail != null) #hasThumbnail: hasThumbnail,
      if (packsSignature != null) #packsSignature: packsSignature,
    }),
  );
  @override
  LanProperty $make(CopyWithData data) => LanProperty(
    port: data.get(#port, or: $value.port),
    currentPlayers: data.get(#currentPlayers, or: $value.currentPlayers),
    maxPlayers: data.get(#maxPlayers, or: $value.maxPlayers),
    description: data.get(#description, or: $value.description),
    hasThumbnail: data.get(#hasThumbnail, or: $value.hasThumbnail),
    packsSignature: data.get(#packsSignature, or: $value.packsSignature),
  );

  @override
  LanPropertyCopyWith<$R2, LanProperty, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LanPropertyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class ListPropertyMapper extends ClassMapperBase<ListProperty> {
  ListPropertyMapper._();

  static ListPropertyMapper? _instance;
  static ListPropertyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ListPropertyMapper._());
      GamePropertyMapper.ensureInitialized();
      SignatureMetadataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ListProperty';

  static int _$index(ListProperty v) => v.index;
  static const Field<ListProperty, int> _f$index = Field('index', _$index);
  static int _$currentPlayers(ListProperty v) => v.currentPlayers;
  static const Field<ListProperty, int> _f$currentPlayers = Field(
    'currentPlayers',
    _$currentPlayers,
    opt: true,
    def: 0,
  );
  static int? _$maxPlayers(ListProperty v) => v.maxPlayers;
  static const Field<ListProperty, int> _f$maxPlayers = Field(
    'maxPlayers',
    _$maxPlayers,
    opt: true,
  );
  static String _$description(ListProperty v) => v.description;
  static const Field<ListProperty, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static bool _$hasThumbnail(ListProperty v) => v.hasThumbnail;
  static const Field<ListProperty, bool> _f$hasThumbnail = Field(
    'hasThumbnail',
    _$hasThumbnail,
    opt: true,
    def: false,
  );
  static Map<String, SignatureMetadata> _$packsSignature(ListProperty v) =>
      v.packsSignature;
  static const Field<ListProperty, Map<String, SignatureMetadata>>
  _f$packsSignature = Field(
    'packsSignature',
    _$packsSignature,
    opt: true,
    def: const {},
  );

  @override
  final MappableFields<ListProperty> fields = const {
    #index: _f$index,
    #currentPlayers: _f$currentPlayers,
    #maxPlayers: _f$maxPlayers,
    #description: _f$description,
    #hasThumbnail: _f$hasThumbnail,
    #packsSignature: _f$packsSignature,
  };

  static ListProperty _instantiate(DecodingData data) {
    return ListProperty(
      index: data.dec(_f$index),
      currentPlayers: data.dec(_f$currentPlayers),
      maxPlayers: data.dec(_f$maxPlayers),
      description: data.dec(_f$description),
      hasThumbnail: data.dec(_f$hasThumbnail),
      packsSignature: data.dec(_f$packsSignature),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ListProperty fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ListProperty>(map);
  }

  static ListProperty fromJson(String json) {
    return ensureInitialized().decodeJson<ListProperty>(json);
  }
}

/// @nodoc
mixin ListPropertyMappable {
  String toJson() {
    return ListPropertyMapper.ensureInitialized().encodeJson<ListProperty>(
      this as ListProperty,
    );
  }

  Map<String, dynamic> toMap() {
    return ListPropertyMapper.ensureInitialized().encodeMap<ListProperty>(
      this as ListProperty,
    );
  }

  ListPropertyCopyWith<ListProperty, ListProperty, ListProperty> get copyWith =>
      _ListPropertyCopyWithImpl<ListProperty, ListProperty>(
        this as ListProperty,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ListPropertyMapper.ensureInitialized().stringifyValue(
      this as ListProperty,
    );
  }

  @override
  bool operator ==(Object other) {
    return ListPropertyMapper.ensureInitialized().equalsValue(
      this as ListProperty,
      other,
    );
  }

  @override
  int get hashCode {
    return ListPropertyMapper.ensureInitialized().hashValue(
      this as ListProperty,
    );
  }
}

/// @nodoc
extension ListPropertyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ListProperty, $Out> {
  ListPropertyCopyWith<$R, ListProperty, $Out> get $asListProperty =>
      $base.as((v, t, t2) => _ListPropertyCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class ListPropertyCopyWith<$R, $In extends ListProperty, $Out>
    implements GamePropertyCopyWith<$R, $In, $Out> {
  @override
  MapCopyWith<
    $R,
    String,
    SignatureMetadata,
    SignatureMetadataCopyWith<$R, SignatureMetadata, SignatureMetadata>
  >
  get packsSignature;
  @override
  $R call({
    int? index,
    int? currentPlayers,
    int? maxPlayers,
    String? description,
    bool? hasThumbnail,
    Map<String, SignatureMetadata>? packsSignature,
  });
  ListPropertyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _ListPropertyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ListProperty, $Out>
    implements ListPropertyCopyWith<$R, ListProperty, $Out> {
  _ListPropertyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ListProperty> $mapper =
      ListPropertyMapper.ensureInitialized();
  @override
  MapCopyWith<
    $R,
    String,
    SignatureMetadata,
    SignatureMetadataCopyWith<$R, SignatureMetadata, SignatureMetadata>
  >
  get packsSignature => MapCopyWith(
    $value.packsSignature,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(packsSignature: v),
  );
  @override
  $R call({
    int? index,
    int? currentPlayers,
    Object? maxPlayers = $none,
    String? description,
    bool? hasThumbnail,
    Map<String, SignatureMetadata>? packsSignature,
  }) => $apply(
    FieldCopyWithData({
      if (index != null) #index: index,
      if (currentPlayers != null) #currentPlayers: currentPlayers,
      if (maxPlayers != $none) #maxPlayers: maxPlayers,
      if (description != null) #description: description,
      if (hasThumbnail != null) #hasThumbnail: hasThumbnail,
      if (packsSignature != null) #packsSignature: packsSignature,
    }),
  );
  @override
  ListProperty $make(CopyWithData data) => ListProperty(
    index: data.get(#index, or: $value.index),
    currentPlayers: data.get(#currentPlayers, or: $value.currentPlayers),
    maxPlayers: data.get(#maxPlayers, or: $value.maxPlayers),
    description: data.get(#description, or: $value.description),
    hasThumbnail: data.get(#hasThumbnail, or: $value.hasThumbnail),
    packsSignature: data.get(#packsSignature, or: $value.packsSignature),
  );

  @override
  ListPropertyCopyWith<$R2, ListProperty, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ListPropertyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class PlayerInfoMapper extends ClassMapperBase<PlayerInfo> {
  PlayerInfoMapper._();

  static PlayerInfoMapper? _instance;
  static PlayerInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlayerInfoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PlayerInfo';

  static int _$id(PlayerInfo v) => v.id;
  static const Field<PlayerInfo, int> _f$id = Field('id', _$id);
  static String? _$name(PlayerInfo v) => v.name;
  static const Field<PlayerInfo, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );

  @override
  final MappableFields<PlayerInfo> fields = const {#id: _f$id, #name: _f$name};

  static PlayerInfo _instantiate(DecodingData data) {
    return PlayerInfo(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static PlayerInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PlayerInfo>(map);
  }

  static PlayerInfo fromJson(String json) {
    return ensureInitialized().decodeJson<PlayerInfo>(json);
  }
}

/// @nodoc
mixin PlayerInfoMappable {
  String toJson() {
    return PlayerInfoMapper.ensureInitialized().encodeJson<PlayerInfo>(
      this as PlayerInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return PlayerInfoMapper.ensureInitialized().encodeMap<PlayerInfo>(
      this as PlayerInfo,
    );
  }

  PlayerInfoCopyWith<PlayerInfo, PlayerInfo, PlayerInfo> get copyWith =>
      _PlayerInfoCopyWithImpl<PlayerInfo, PlayerInfo>(
        this as PlayerInfo,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PlayerInfoMapper.ensureInitialized().stringifyValue(
      this as PlayerInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    return PlayerInfoMapper.ensureInitialized().equalsValue(
      this as PlayerInfo,
      other,
    );
  }

  @override
  int get hashCode {
    return PlayerInfoMapper.ensureInitialized().hashValue(this as PlayerInfo);
  }
}

/// @nodoc
extension PlayerInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PlayerInfo, $Out> {
  PlayerInfoCopyWith<$R, PlayerInfo, $Out> get $asPlayerInfo =>
      $base.as((v, t, t2) => _PlayerInfoCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class PlayerInfoCopyWith<$R, $In extends PlayerInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? id, String? name});
  PlayerInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _PlayerInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PlayerInfo, $Out>
    implements PlayerInfoCopyWith<$R, PlayerInfo, $Out> {
  _PlayerInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PlayerInfo> $mapper =
      PlayerInfoMapper.ensureInitialized();
  @override
  $R call({int? id, Object? name = $none}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != $none) #name: name,
    }),
  );
  @override
  PlayerInfo $make(CopyWithData data) => PlayerInfo(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
  );

  @override
  PlayerInfoCopyWith<$R2, PlayerInfo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PlayerInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class ServerStateMapper extends ClassMapperBase<ServerState> {
  ServerStateMapper._();

  static ServerStateMapper? _instance;
  static ServerStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServerStateMapper._());
      PlayerInfoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ServerState';

  static String? _$link(ServerState v) => v.link;
  static const Field<ServerState, String> _f$link = Field(
    'link',
    _$link,
    opt: true,
  );
  static List<PlayerInfo> _$players(ServerState v) => v.players;
  static const Field<ServerState, List<PlayerInfo>> _f$players = Field(
    'players',
    _$players,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<ServerState> fields = const {
    #link: _f$link,
    #players: _f$players,
  };

  static ServerState _instantiate(DecodingData data) {
    return ServerState(link: data.dec(_f$link), players: data.dec(_f$players));
  }

  @override
  final Function instantiate = _instantiate;

  static ServerState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServerState>(map);
  }

  static ServerState fromJson(String json) {
    return ensureInitialized().decodeJson<ServerState>(json);
  }
}

/// @nodoc
mixin ServerStateMappable {
  String toJson() {
    return ServerStateMapper.ensureInitialized().encodeJson<ServerState>(
      this as ServerState,
    );
  }

  Map<String, dynamic> toMap() {
    return ServerStateMapper.ensureInitialized().encodeMap<ServerState>(
      this as ServerState,
    );
  }

  ServerStateCopyWith<ServerState, ServerState, ServerState> get copyWith =>
      _ServerStateCopyWithImpl<ServerState, ServerState>(
        this as ServerState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ServerStateMapper.ensureInitialized().stringifyValue(
      this as ServerState,
    );
  }

  @override
  bool operator ==(Object other) {
    return ServerStateMapper.ensureInitialized().equalsValue(
      this as ServerState,
      other,
    );
  }

  @override
  int get hashCode {
    return ServerStateMapper.ensureInitialized().hashValue(this as ServerState);
  }
}

/// @nodoc
extension ServerStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServerState, $Out> {
  ServerStateCopyWith<$R, ServerState, $Out> get $asServerState =>
      $base.as((v, t, t2) => _ServerStateCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class ServerStateCopyWith<$R, $In extends ServerState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, PlayerInfo, PlayerInfoCopyWith<$R, PlayerInfo, PlayerInfo>>
  get players;
  $R call({String? link, List<PlayerInfo>? players});
  ServerStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _ServerStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServerState, $Out>
    implements ServerStateCopyWith<$R, ServerState, $Out> {
  _ServerStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ServerState> $mapper =
      ServerStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, PlayerInfo, PlayerInfoCopyWith<$R, PlayerInfo, PlayerInfo>>
  get players => ListCopyWith(
    $value.players,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(players: v),
  );
  @override
  $R call({Object? link = $none, List<PlayerInfo>? players}) => $apply(
    FieldCopyWithData({
      if (link != $none) #link: link,
      if (players != null) #players: players,
    }),
  );
  @override
  ServerState $make(CopyWithData data) => ServerState(
    link: data.get(#link, or: $value.link),
    players: data.get(#players, or: $value.players),
  );

  @override
  ServerStateCopyWith<$R2, ServerState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ServerStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

/// @nodoc
class ServerListMapper extends ClassMapperBase<ServerList> {
  ServerListMapper._();

  static ServerListMapper? _instance;
  static ServerListMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServerListMapper._());
      ListGameServerMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ServerList';

  static List<ListGameServer> _$servers(ServerList v) => v.servers;
  static const Field<ServerList, List<ListGameServer>> _f$servers = Field(
    'servers',
    _$servers,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<ServerList> fields = const {#servers: _f$servers};

  static ServerList _instantiate(DecodingData data) {
    return ServerList(servers: data.dec(_f$servers));
  }

  @override
  final Function instantiate = _instantiate;

  static ServerList fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServerList>(map);
  }

  static ServerList fromJson(String json) {
    return ensureInitialized().decodeJson<ServerList>(json);
  }
}

/// @nodoc
mixin ServerListMappable {
  String toJson() {
    return ServerListMapper.ensureInitialized().encodeJson<ServerList>(
      this as ServerList,
    );
  }

  Map<String, dynamic> toMap() {
    return ServerListMapper.ensureInitialized().encodeMap<ServerList>(
      this as ServerList,
    );
  }

  ServerListCopyWith<ServerList, ServerList, ServerList> get copyWith =>
      _ServerListCopyWithImpl<ServerList, ServerList>(
        this as ServerList,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ServerListMapper.ensureInitialized().stringifyValue(
      this as ServerList,
    );
  }

  @override
  bool operator ==(Object other) {
    return ServerListMapper.ensureInitialized().equalsValue(
      this as ServerList,
      other,
    );
  }

  @override
  int get hashCode {
    return ServerListMapper.ensureInitialized().hashValue(this as ServerList);
  }
}

/// @nodoc
extension ServerListValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServerList, $Out> {
  ServerListCopyWith<$R, ServerList, $Out> get $asServerList =>
      $base.as((v, t, t2) => _ServerListCopyWithImpl<$R, $Out>(v, t, t2));
}

/// @nodoc
abstract class ServerListCopyWith<$R, $In extends ServerList, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    ListGameServer,
    ListGameServerCopyWith<$R, ListGameServer, ListGameServer>
  >
  get servers;
  $R call({List<ListGameServer>? servers});
  ServerListCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

/// @nodoc
class _ServerListCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServerList, $Out>
    implements ServerListCopyWith<$R, ServerList, $Out> {
  _ServerListCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ServerList> $mapper =
      ServerListMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    ListGameServer,
    ListGameServerCopyWith<$R, ListGameServer, ListGameServer>
  >
  get servers => ListCopyWith(
    $value.servers,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(servers: v),
  );
  @override
  $R call({List<ListGameServer>? servers}) =>
      $apply(FieldCopyWithData({if (servers != null) #servers: servers}));
  @override
  ServerList $make(CopyWithData data) =>
      ServerList(servers: data.get(#servers, or: $value.servers));

  @override
  ServerListCopyWith<$R2, ServerList, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ServerListCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

