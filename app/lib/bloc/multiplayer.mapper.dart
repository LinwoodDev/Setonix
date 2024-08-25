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
      MultiplayerDisabledStateMapper.ensureInitialized();
      MultiplayerConnectingStateMapper.ensureInitialized();
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

class MultiplayerDisabledStateMapper
    extends ClassMapperBase<MultiplayerDisabledState> {
  MultiplayerDisabledStateMapper._();

  static MultiplayerDisabledStateMapper? _instance;
  static MultiplayerDisabledStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = MultiplayerDisabledStateMapper._());
      MultiplayerStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MultiplayerDisabledState';

  @override
  final MappableFields<MultiplayerDisabledState> fields = const {};

  static MultiplayerDisabledState _instantiate(DecodingData data) {
    return MultiplayerDisabledState();
  }

  @override
  final Function instantiate = _instantiate;

  static MultiplayerDisabledState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MultiplayerDisabledState>(map);
  }

  static MultiplayerDisabledState fromJson(String json) {
    return ensureInitialized().decodeJson<MultiplayerDisabledState>(json);
  }
}

mixin MultiplayerDisabledStateMappable {
  String toJson() {
    return MultiplayerDisabledStateMapper.ensureInitialized()
        .encodeJson<MultiplayerDisabledState>(this as MultiplayerDisabledState);
  }

  Map<String, dynamic> toMap() {
    return MultiplayerDisabledStateMapper.ensureInitialized()
        .encodeMap<MultiplayerDisabledState>(this as MultiplayerDisabledState);
  }

  MultiplayerDisabledStateCopyWith<MultiplayerDisabledState,
          MultiplayerDisabledState, MultiplayerDisabledState>
      get copyWith => _MultiplayerDisabledStateCopyWithImpl(
          this as MultiplayerDisabledState, $identity, $identity);
  @override
  String toString() {
    return MultiplayerDisabledStateMapper.ensureInitialized()
        .stringifyValue(this as MultiplayerDisabledState);
  }

  @override
  bool operator ==(Object other) {
    return MultiplayerDisabledStateMapper.ensureInitialized()
        .equalsValue(this as MultiplayerDisabledState, other);
  }

  @override
  int get hashCode {
    return MultiplayerDisabledStateMapper.ensureInitialized()
        .hashValue(this as MultiplayerDisabledState);
  }
}

extension MultiplayerDisabledStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MultiplayerDisabledState, $Out> {
  MultiplayerDisabledStateCopyWith<$R, MultiplayerDisabledState, $Out>
      get $asMultiplayerDisabledState => $base
          .as((v, t, t2) => _MultiplayerDisabledStateCopyWithImpl(v, t, t2));
}

abstract class MultiplayerDisabledStateCopyWith<
    $R,
    $In extends MultiplayerDisabledState,
    $Out> implements MultiplayerStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  MultiplayerDisabledStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _MultiplayerDisabledStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MultiplayerDisabledState, $Out>
    implements
        MultiplayerDisabledStateCopyWith<$R, MultiplayerDisabledState, $Out> {
  _MultiplayerDisabledStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MultiplayerDisabledState> $mapper =
      MultiplayerDisabledStateMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  MultiplayerDisabledState $make(CopyWithData data) =>
      MultiplayerDisabledState();

  @override
  MultiplayerDisabledStateCopyWith<$R2, MultiplayerDisabledState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _MultiplayerDisabledStateCopyWithImpl($value, $cast, t);
}

class MultiplayerConnectingStateMapper
    extends ClassMapperBase<MultiplayerConnectingState> {
  MultiplayerConnectingStateMapper._();

  static MultiplayerConnectingStateMapper? _instance;
  static MultiplayerConnectingStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = MultiplayerConnectingStateMapper._());
      MultiplayerStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MultiplayerConnectingState';

  @override
  final MappableFields<MultiplayerConnectingState> fields = const {};

  static MultiplayerConnectingState _instantiate(DecodingData data) {
    return MultiplayerConnectingState();
  }

  @override
  final Function instantiate = _instantiate;

  static MultiplayerConnectingState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MultiplayerConnectingState>(map);
  }

  static MultiplayerConnectingState fromJson(String json) {
    return ensureInitialized().decodeJson<MultiplayerConnectingState>(json);
  }
}

mixin MultiplayerConnectingStateMappable {
  String toJson() {
    return MultiplayerConnectingStateMapper.ensureInitialized()
        .encodeJson<MultiplayerConnectingState>(
            this as MultiplayerConnectingState);
  }

  Map<String, dynamic> toMap() {
    return MultiplayerConnectingStateMapper.ensureInitialized()
        .encodeMap<MultiplayerConnectingState>(
            this as MultiplayerConnectingState);
  }

  MultiplayerConnectingStateCopyWith<MultiplayerConnectingState,
          MultiplayerConnectingState, MultiplayerConnectingState>
      get copyWith => _MultiplayerConnectingStateCopyWithImpl(
          this as MultiplayerConnectingState, $identity, $identity);
  @override
  String toString() {
    return MultiplayerConnectingStateMapper.ensureInitialized()
        .stringifyValue(this as MultiplayerConnectingState);
  }

  @override
  bool operator ==(Object other) {
    return MultiplayerConnectingStateMapper.ensureInitialized()
        .equalsValue(this as MultiplayerConnectingState, other);
  }

  @override
  int get hashCode {
    return MultiplayerConnectingStateMapper.ensureInitialized()
        .hashValue(this as MultiplayerConnectingState);
  }
}

extension MultiplayerConnectingStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MultiplayerConnectingState, $Out> {
  MultiplayerConnectingStateCopyWith<$R, MultiplayerConnectingState, $Out>
      get $asMultiplayerConnectingState => $base
          .as((v, t, t2) => _MultiplayerConnectingStateCopyWithImpl(v, t, t2));
}

abstract class MultiplayerConnectingStateCopyWith<
    $R,
    $In extends MultiplayerConnectingState,
    $Out> implements MultiplayerStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  MultiplayerConnectingStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _MultiplayerConnectingStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MultiplayerConnectingState, $Out>
    implements
        MultiplayerConnectingStateCopyWith<$R, MultiplayerConnectingState,
            $Out> {
  _MultiplayerConnectingStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MultiplayerConnectingState> $mapper =
      MultiplayerConnectingStateMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  MultiplayerConnectingState $make(CopyWithData data) =>
      MultiplayerConnectingState();

  @override
  MultiplayerConnectingStateCopyWith<$R2, MultiplayerConnectingState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _MultiplayerConnectingStateCopyWithImpl($value, $cast, t);
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
      MultiplayerConnectedStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MultiplayerDisconnectedState';

  static Object? _$error(MultiplayerDisconnectedState v) => v.error;
  static const Field<MultiplayerDisconnectedState, Object> _f$error =
      Field('error', _$error, opt: true);
  static MultiplayerConnectedState? _$oldState(
          MultiplayerDisconnectedState v) =>
      v.oldState;
  static const Field<MultiplayerDisconnectedState, MultiplayerConnectedState>
      _f$oldState = Field('oldState', _$oldState, opt: true);

  @override
  final MappableFields<MultiplayerDisconnectedState> fields = const {
    #error: _f$error,
    #oldState: _f$oldState,
  };

  static MultiplayerDisconnectedState _instantiate(DecodingData data) {
    return MultiplayerDisconnectedState(
        error: data.dec(_f$error), oldState: data.dec(_f$oldState));
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
  MultiplayerConnectedStateCopyWith<$R, MultiplayerConnectedState,
      MultiplayerConnectedState>? get oldState;
  @override
  $R call({Object? error, MultiplayerConnectedState? oldState});
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
  MultiplayerConnectedStateCopyWith<$R, MultiplayerConnectedState,
          MultiplayerConnectedState>?
      get oldState =>
          $value.oldState?.copyWith.$chain((v) => call(oldState: v));
  @override
  $R call({Object? error = $none, Object? oldState = $none}) =>
      $apply(FieldCopyWithData({
        if (error != $none) #error: error,
        if (oldState != $none) #oldState: oldState
      }));
  @override
  MultiplayerDisconnectedState $make(CopyWithData data) =>
      MultiplayerDisconnectedState(
          error: data.get(#error, or: $value.error),
          oldState: data.get(#oldState, or: $value.oldState));

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
      WorldEventMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MultiplayerConnectedState';

  static NetworkerBase _$networker(MultiplayerConnectedState v) => v.networker;
  static const Field<MultiplayerConnectedState, NetworkerBase> _f$networker =
      Field('networker', _$networker);
  static SimpleNetworkerPipe<WorldEvent> _$pipe(MultiplayerConnectedState v) =>
      v.pipe;
  static const Field<MultiplayerConnectedState, SimpleNetworkerPipe<WorldEvent>>
      _f$pipe = Field('pipe', _$pipe);

  @override
  final MappableFields<MultiplayerConnectedState> fields = const {
    #networker: _f$networker,
    #pipe: _f$pipe,
  };

  static MultiplayerConnectedState _instantiate(DecodingData data) {
    return MultiplayerConnectedState(data.dec(_f$networker), data.dec(_f$pipe));
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
  $R call({NetworkerBase? networker, SimpleNetworkerPipe<WorldEvent>? pipe});
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
  $R call({NetworkerBase? networker, SimpleNetworkerPipe<WorldEvent>? pipe}) =>
      $apply(FieldCopyWithData({
        if (networker != null) #networker: networker,
        if (pipe != null) #pipe: pipe
      }));
  @override
  MultiplayerConnectedState $make(CopyWithData data) =>
      MultiplayerConnectedState(data.get(#networker, or: $value.networker),
          data.get(#pipe, or: $value.pipe));

  @override
  MultiplayerConnectedStateCopyWith<$R2, MultiplayerConnectedState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _MultiplayerConnectedStateCopyWithImpl($value, $cast, t);
}
