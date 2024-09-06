// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'chat.dart';

class ChatMessageMapper extends ClassMapperBase<ChatMessage> {
  ChatMessageMapper._();

  static ChatMessageMapper? _instance;
  static ChatMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChatMessageMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ChatMessage';

  static int _$author(ChatMessage v) => v.author;
  static const Field<ChatMessage, int> _f$author = Field('author', _$author);
  static String _$content(ChatMessage v) => v.content;
  static const Field<ChatMessage, String> _f$content =
      Field('content', _$content);
  static DateTime _$timestamp(ChatMessage v) => v.timestamp;
  static const Field<ChatMessage, DateTime> _f$timestamp =
      Field('timestamp', _$timestamp);

  @override
  final MappableFields<ChatMessage> fields = const {
    #author: _f$author,
    #content: _f$content,
    #timestamp: _f$timestamp,
  };

  static ChatMessage _instantiate(DecodingData data) {
    return ChatMessage(
        author: data.dec(_f$author),
        content: data.dec(_f$content),
        timestamp: data.dec(_f$timestamp));
  }

  @override
  final Function instantiate = _instantiate;

  static ChatMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChatMessage>(map);
  }

  static ChatMessage fromJson(String json) {
    return ensureInitialized().decodeJson<ChatMessage>(json);
  }
}

mixin ChatMessageMappable {
  String toJson() {
    return ChatMessageMapper.ensureInitialized()
        .encodeJson<ChatMessage>(this as ChatMessage);
  }

  Map<String, dynamic> toMap() {
    return ChatMessageMapper.ensureInitialized()
        .encodeMap<ChatMessage>(this as ChatMessage);
  }

  ChatMessageCopyWith<ChatMessage, ChatMessage, ChatMessage> get copyWith =>
      _ChatMessageCopyWithImpl(this as ChatMessage, $identity, $identity);
  @override
  String toString() {
    return ChatMessageMapper.ensureInitialized()
        .stringifyValue(this as ChatMessage);
  }

  @override
  bool operator ==(Object other) {
    return ChatMessageMapper.ensureInitialized()
        .equalsValue(this as ChatMessage, other);
  }

  @override
  int get hashCode {
    return ChatMessageMapper.ensureInitialized().hashValue(this as ChatMessage);
  }
}

extension ChatMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChatMessage, $Out> {
  ChatMessageCopyWith<$R, ChatMessage, $Out> get $asChatMessage =>
      $base.as((v, t, t2) => _ChatMessageCopyWithImpl(v, t, t2));
}

abstract class ChatMessageCopyWith<$R, $In extends ChatMessage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? author, String? content, DateTime? timestamp});
  ChatMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ChatMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChatMessage, $Out>
    implements ChatMessageCopyWith<$R, ChatMessage, $Out> {
  _ChatMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChatMessage> $mapper =
      ChatMessageMapper.ensureInitialized();
  @override
  $R call({int? author, String? content, DateTime? timestamp}) =>
      $apply(FieldCopyWithData({
        if (author != null) #author: author,
        if (content != null) #content: content,
        if (timestamp != null) #timestamp: timestamp
      }));
  @override
  ChatMessage $make(CopyWithData data) => ChatMessage(
      author: data.get(#author, or: $value.author),
      content: data.get(#content, or: $value.content),
      timestamp: data.get(#timestamp, or: $value.timestamp));

  @override
  ChatMessageCopyWith<$R2, ChatMessage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ChatMessageCopyWithImpl($value, $cast, t);
}
