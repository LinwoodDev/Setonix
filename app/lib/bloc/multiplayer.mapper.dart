// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'multiplayer.dart';

class MultiplayerStateMapper extends ClassMapperBase<MultiplayerState> {
  MultiplayerStateMapper._();

  static MultiplayerStateMapper? _instance;
  static MultiplayerStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MultiplayerStateMapper._());
      MultiplayerDisconnectedStateMapper.ensureInitialized();
      MultiplayerConnectedStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MultiplayerState';

  @override
  final MappableFields<MultiplayerState> fields = const {};

  static MultiplayerState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('MultiplayerState');
  }

  @override
  final Function instantiate = _instantiate;

  static MultiplayerState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MultiplayerState>(map);
  }

  static MultiplayerState fromJson(String json) {
    return ensureInitialized().decodeJson<MultiplayerState>(json);
  }
}

mixin MultiplayerStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  MultiplayerStateCopyWith<MultiplayerState, MultiplayerState, MultiplayerState>
      get copyWith;
}

abstract class MultiplayerStateCopyWith<$R, $In extends MultiplayerState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  MultiplayerStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class MultiplayerDisconnectedStateMapper
    extends ClassMapperBase<MultiplayerDisconnectedState> {
  MultiplayerDisconnectedStateMapper._();

  static MultiplayerDisconnectedStateMapper? _instance;
  static MultiplayerDisconnectedStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = MultiplayerDisconnectedStateMapper._());
      MultiplayerStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MultiplayerDisconnectedState';

  @override
  final MappableFields<MultiplayerDisconnectedState> fields = const {};

  static MultiplayerDisconnectedState _instantiate(DecodingData data) {
    return MultiplayerDisconnectedState();
  }

  @override
  final Function instantiate = _instantiate;

  static MultiplayerDisconnectedState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MultiplayerDisconnectedState>(map);
  }

  static MultiplayerDisconnectedState fromJson(String json) {
    return ensureInitialized().decodeJson<MultiplayerDisconnectedState>(json);
  }
}

mixin MultiplayerDisconnectedStateMappable {
  String toJson() {
    return MultiplayerDisconnectedStateMapper.ensureInitialized()
        .encodeJson<MultiplayerDisconnectedState>(
            this as MultiplayerDisconnectedState);
  }

  Map<String, dynamic> toMap() {
    return MultiplayerDisconnectedStateMapper.ensureInitialized()
        .encodeMap<MultiplayerDisconnectedState>(
            this as MultiplayerDisconnectedState);
  }

  MultiplayerDisconnectedStateCopyWith<MultiplayerDisconnectedState,
          MultiplayerDisconnectedState, MultiplayerDisconnectedState>
      get copyWith => _MultiplayerDisconnectedStateCopyWithImpl(
          this as MultiplayerDisconnectedState, $identity, $identity);
  @override
  String toString() {
    return MultiplayerDisconnectedStateMapper.ensureInitialized()
        .stringifyValue(this as MultiplayerDisconnectedState);
  }

  @override
  bool operator ==(Object other) {
    return MultiplayerDisconnectedStateMapper.ensureInitialized()
        .equalsValue(this as MultiplayerDisconnectedState, other);
  }

  @override
  int get hashCode {
    return MultiplayerDisconnectedStateMapper.ensureInitialized()
        .hashValue(this as MultiplayerDisconnectedState);
  }
}

extension MultiplayerDisconnectedStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MultiplayerDisconnectedState, $Out> {
  MultiplayerDisconnectedStateCopyWith<$R, MultiplayerDisconnectedState, $Out>
      get $asMultiplayerDisconnectedState => $base.as(
          (v, t, t2) => _MultiplayerDisconnectedStateCopyWithImpl(v, t, t2));
}

abstract class MultiplayerDisconnectedStateCopyWith<
    $R,
    $In extends MultiplayerDisconnectedState,
    $Out> implements MultiplayerStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  MultiplayerDisconnectedStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _MultiplayerDisconnectedStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MultiplayerDisconnectedState, $Out>
    implements
        MultiplayerDisconnectedStateCopyWith<$R, MultiplayerDisconnectedState,
            $Out> {
  _MultiplayerDisconnectedStateCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MultiplayerDisconnectedState> $mapper =
      MultiplayerDisconnectedStateMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  MultiplayerDisconnectedState $make(CopyWithData data) =>
      MultiplayerDisconnectedState();

  @override
  MultiplayerDisconnectedStateCopyWith<$R2, MultiplayerDisconnectedState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _MultiplayerDisconnectedStateCopyWithImpl($value, $cast, t);
}

class MultiplayerConnectedStateMapper
    extends ClassMapperBase<MultiplayerConnectedState> {
  MultiplayerConnectedStateMapper._();

  static MultiplayerConnectedStateMapper? _instance;
  static MultiplayerConnectedStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = MultiplayerConnectedStateMapper._());
      MultiplayerStateMapper.ensureInitialized();
      BoardEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MultiplayerConnectedState';

  static NetworkerBase _$networker(MultiplayerConnectedState v) => v.networker;
  static const Field<MultiplayerConnectedState, NetworkerBase> _f$networker =
      Field('networker', _$networker);
  static NetworkerPipeTransformer<String, BoardEvent> _$transformer(
          MultiplayerConnectedState v) =>
      v.transformer;
  static const Field<MultiplayerConnectedState,
          NetworkerPipeTransformer<String, BoardEvent>> _f$transformer =
      Field('transformer', _$transformer);

  @override
  final MappableFields<MultiplayerConnectedState> fields = const {
    #networker: _f$networker,
    #transformer: _f$transformer,
  };

  static MultiplayerConnectedState _instantiate(DecodingData data) {
    return MultiplayerConnectedState(
        data.dec(_f$networker), data.dec(_f$transformer));
  }

  @override
  final Function instantiate = _instantiate;

  static MultiplayerConnectedState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MultiplayerConnectedState>(map);
  }

  static MultiplayerConnectedState fromJson(String json) {
    return ensureInitialized().decodeJson<MultiplayerConnectedState>(json);
  }
}

mixin MultiplayerConnectedStateMappable {
  String toJson() {
    return MultiplayerConnectedStateMapper.ensureInitialized()
        .encodeJson<MultiplayerConnectedState>(
            this as MultiplayerConnectedState);
  }

  Map<String, dynamic> toMap() {
    return MultiplayerConnectedStateMapper.ensureInitialized()
        .encodeMap<MultiplayerConnectedState>(
            this as MultiplayerConnectedState);
  }

  MultiplayerConnectedStateCopyWith<MultiplayerConnectedState,
          MultiplayerConnectedState, MultiplayerConnectedState>
      get copyWith => _MultiplayerConnectedStateCopyWithImpl(
          this as MultiplayerConnectedState, $identity, $identity);
  @override
  String toString() {
    return MultiplayerConnectedStateMapper.ensureInitialized()
        .stringifyValue(this as MultiplayerConnectedState);
  }

  @override
  bool operator ==(Object other) {
    return MultiplayerConnectedStateMapper.ensureInitialized()
        .equalsValue(this as MultiplayerConnectedState, other);
  }

  @override
  int get hashCode {
    return MultiplayerConnectedStateMapper.ensureInitialized()
        .hashValue(this as MultiplayerConnectedState);
  }
}

extension MultiplayerConnectedStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MultiplayerConnectedState, $Out> {
  MultiplayerConnectedStateCopyWith<$R, MultiplayerConnectedState, $Out>
      get $asMultiplayerConnectedState => $base
          .as((v, t, t2) => _MultiplayerConnectedStateCopyWithImpl(v, t, t2));
}

abstract class MultiplayerConnectedStateCopyWith<
    $R,
    $In extends MultiplayerConnectedState,
    $Out> implements MultiplayerStateCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {NetworkerBase? networker,
      NetworkerPipeTransformer<String, BoardEvent>? transformer});
  MultiplayerConnectedStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _MultiplayerConnectedStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MultiplayerConnectedState, $Out>
    implements
        MultiplayerConnectedStateCopyWith<$R, MultiplayerConnectedState, $Out> {
  _MultiplayerConnectedStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MultiplayerConnectedState> $mapper =
      MultiplayerConnectedStateMapper.ensureInitialized();
  @override
  $R call(
          {NetworkerBase? networker,
          NetworkerPipeTransformer<String, BoardEvent>? transformer}) =>
      $apply(FieldCopyWithData({
        if (networker != null) #networker: networker,
        if (transformer != null) #transformer: transformer
      }));
  @override
  MultiplayerConnectedState $make(CopyWithData data) =>
      MultiplayerConnectedState(data.get(#networker, or: $value.networker),
          data.get(#transformer, or: $value.transformer));

  @override
  MultiplayerConnectedStateCopyWith<$R2, MultiplayerConnectedState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _MultiplayerConnectedStateCopyWithImpl($value, $cast, t);
}
