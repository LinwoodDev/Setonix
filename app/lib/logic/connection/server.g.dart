// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FetchPlayersServerConnectionMessageImpl
    _$$FetchPlayersServerConnectionMessageImplFromJson(Map json) =>
        _$FetchPlayersServerConnectionMessageImpl(
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$FetchPlayersServerConnectionMessageImplToJson(
        _$FetchPlayersServerConnectionMessageImpl instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$ChatMessageServerConnectionMessageImpl
    _$$ChatMessageServerConnectionMessageImplFromJson(Map json) =>
        _$ChatMessageServerConnectionMessageImpl(
          json['message'] as String,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$ChatMessageServerConnectionMessageImplToJson(
        _$ChatMessageServerConnectionMessageImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'type': instance.$type,
    };

_$AddDeckServerConnectionMessageImpl
    _$$AddDeckServerConnectionMessageImplFromJson(Map json) =>
        _$AddDeckServerConnectionMessageImpl(
          GameDeck.fromJson(Map<String, dynamic>.from(json['deck'] as Map)),
          json['seatIndex'] as int?,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$AddDeckServerConnectionMessageImplToJson(
        _$AddDeckServerConnectionMessageImpl instance) =>
    <String, dynamic>{
      'deck': instance.deck.toJson(),
      'seatIndex': instance.seatIndex,
      'type': instance.$type,
    };

_$RemoveDeckServerConnectionMessageImpl
    _$$RemoveDeckServerConnectionMessageImplFromJson(Map json) =>
        _$RemoveDeckServerConnectionMessageImpl(
          json['index'] as int,
          json['seatIndex'] as int?,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$RemoveDeckServerConnectionMessageImplToJson(
        _$RemoveDeckServerConnectionMessageImpl instance) =>
    <String, dynamic>{
      'index': instance.index,
      'seatIndex': instance.seatIndex,
      'type': instance.$type,
    };

_$AddSeatServerConnectionMessageImpl
    _$$AddSeatServerConnectionMessageImplFromJson(Map json) =>
        _$AddSeatServerConnectionMessageImpl(
          json['name'] as String,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$AddSeatServerConnectionMessageImplToJson(
        _$AddSeatServerConnectionMessageImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$AddCardsServerConnectionMessageImpl
    _$$AddCardsServerConnectionMessageImplFromJson(Map json) =>
        _$AddCardsServerConnectionMessageImpl(
          (json['cards'] as List<dynamic>)
              .map((e) =>
                  CardIndex.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList(),
          json['deckIndex'] as int,
          json['seatIndex'] as int?,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$AddCardsServerConnectionMessageImplToJson(
        _$AddCardsServerConnectionMessageImpl instance) =>
    <String, dynamic>{
      'cards': instance.cards.map((e) => e.toJson()).toList(),
      'deckIndex': instance.deckIndex,
      'seatIndex': instance.seatIndex,
      'type': instance.$type,
    };

_$PutCardsServerConnectionMessageImpl
    _$$PutCardsServerConnectionMessageImplFromJson(Map json) =>
        _$PutCardsServerConnectionMessageImpl(
          json['deckIndex'] as int,
          json['seatIndex'] as int?,
          $enumDecode(_$PickLocationEnumMap, json['location']),
          json['count'] as int,
          json['movedDeckIndex'] as int,
          json['movedSeatIndex'] as int?,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$PutCardsServerConnectionMessageImplToJson(
        _$PutCardsServerConnectionMessageImpl instance) =>
    <String, dynamic>{
      'deckIndex': instance.deckIndex,
      'seatIndex': instance.seatIndex,
      'location': _$PickLocationEnumMap[instance.location]!,
      'count': instance.count,
      'movedDeckIndex': instance.movedDeckIndex,
      'movedSeatIndex': instance.movedSeatIndex,
      'type': instance.$type,
    };

const _$PickLocationEnumMap = {
  PickLocation.top: 'top',
  PickLocation.bottom: 'bottom',
  PickLocation.random: 'random',
};

_$RemoveCardsServerConnectionMessageImpl
    _$$RemoveCardsServerConnectionMessageImplFromJson(Map json) =>
        _$RemoveCardsServerConnectionMessageImpl(
          (json['cards'] as List<dynamic>)
              .map((e) =>
                  CardIndex.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList(),
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$RemoveCardsServerConnectionMessageImplToJson(
        _$RemoveCardsServerConnectionMessageImpl instance) =>
    <String, dynamic>{
      'cards': instance.cards.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

_$RemoveSeatServerConnectionMessageImpl
    _$$RemoveSeatServerConnectionMessageImplFromJson(Map json) =>
        _$RemoveSeatServerConnectionMessageImpl(
          json['index'] as int,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$RemoveSeatServerConnectionMessageImplToJson(
        _$RemoveSeatServerConnectionMessageImpl instance) =>
    <String, dynamic>{
      'index': instance.index,
      'type': instance.$type,
    };

_$JoinSeatServerConnectionMessageImpl
    _$$JoinSeatServerConnectionMessageImplFromJson(Map json) =>
        _$JoinSeatServerConnectionMessageImpl(
          json['index'] as int,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$JoinSeatServerConnectionMessageImplToJson(
        _$JoinSeatServerConnectionMessageImpl instance) =>
    <String, dynamic>{
      'index': instance.index,
      'type': instance.$type,
    };

_$LeaveSeatServerConnectionMessageImpl
    _$$LeaveSeatServerConnectionMessageImplFromJson(Map json) =>
        _$LeaveSeatServerConnectionMessageImpl(
          json['index'] as int,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$LeaveSeatServerConnectionMessageImplToJson(
        _$LeaveSeatServerConnectionMessageImpl instance) =>
    <String, dynamic>{
      'index': instance.index,
      'type': instance.$type,
    };

_$ShuffleServerConnectionMessageImpl
    _$$ShuffleServerConnectionMessageImplFromJson(Map json) =>
        _$ShuffleServerConnectionMessageImpl(
          json['deckIndex'] as int,
          json['seatIndex'] as int?,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$ShuffleServerConnectionMessageImplToJson(
        _$ShuffleServerConnectionMessageImpl instance) =>
    <String, dynamic>{
      'deckIndex': instance.deckIndex,
      'seatIndex': instance.seatIndex,
      'type': instance.$type,
    };

_$ChangeVisibilityServerConnectionMessageImpl
    _$$ChangeVisibilityServerConnectionMessageImplFromJson(Map json) =>
        _$ChangeVisibilityServerConnectionMessageImpl(
          json['deckIndex'] as int,
          json['seatIndex'] as int?,
          $enumDecode(_$DeckVisibilityEnumMap, json['visibility']),
          $enumDecodeNullable(_$DeckVisibilityEnumMap, json['ownVisibility']),
          json['type'] as String?,
        );

Map<String, dynamic> _$$ChangeVisibilityServerConnectionMessageImplToJson(
        _$ChangeVisibilityServerConnectionMessageImpl instance) =>
    <String, dynamic>{
      'deckIndex': instance.deckIndex,
      'seatIndex': instance.seatIndex,
      'visibility': _$DeckVisibilityEnumMap[instance.visibility]!,
      'ownVisibility': _$DeckVisibilityEnumMap[instance.ownVisibility],
      'type': instance.$type,
    };

const _$DeckVisibilityEnumMap = {
  DeckVisibility.hidden: 'hidden',
  DeckVisibility.onlyTop: 'onlyTop',
  DeckVisibility.visible: 'visible',
};
