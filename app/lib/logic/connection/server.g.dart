// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FetchPlayersServerConnectionMessage
    _$$FetchPlayersServerConnectionMessageFromJson(Map json) =>
        _$FetchPlayersServerConnectionMessage(
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$FetchPlayersServerConnectionMessageToJson(
        _$FetchPlayersServerConnectionMessage instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$ChatMessageServerConnectionMessage
    _$$ChatMessageServerConnectionMessageFromJson(Map json) =>
        _$ChatMessageServerConnectionMessage(
          json['message'] as String,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$ChatMessageServerConnectionMessageToJson(
        _$ChatMessageServerConnectionMessage instance) =>
    <String, dynamic>{
      'message': instance.message,
      'type': instance.$type,
    };

_$AddDeckServerConnectionMessage _$$AddDeckServerConnectionMessageFromJson(
        Map json) =>
    _$AddDeckServerConnectionMessage(
      GameDeck.fromJson(Map<String, dynamic>.from(json['deck'] as Map)),
      json['seatIndex'] as int?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AddDeckServerConnectionMessageToJson(
        _$AddDeckServerConnectionMessage instance) =>
    <String, dynamic>{
      'deck': instance.deck.toJson(),
      'seatIndex': instance.seatIndex,
      'type': instance.$type,
    };

_$RemoveDeckServerConnectionMessage
    _$$RemoveDeckServerConnectionMessageFromJson(Map json) =>
        _$RemoveDeckServerConnectionMessage(
          json['index'] as int,
          json['seatIndex'] as int?,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$RemoveDeckServerConnectionMessageToJson(
        _$RemoveDeckServerConnectionMessage instance) =>
    <String, dynamic>{
      'index': instance.index,
      'seatIndex': instance.seatIndex,
      'type': instance.$type,
    };

_$AddSeatServerConnectionMessage _$$AddSeatServerConnectionMessageFromJson(
        Map json) =>
    _$AddSeatServerConnectionMessage(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AddSeatServerConnectionMessageToJson(
        _$AddSeatServerConnectionMessage instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$AddCardsServerConnectionMessage _$$AddCardsServerConnectionMessageFromJson(
        Map json) =>
    _$AddCardsServerConnectionMessage(
      (json['cards'] as List<dynamic>)
          .map((e) => CardIndex.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      json['deckIndex'] as int,
      json['seatIndex'] as int?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AddCardsServerConnectionMessageToJson(
        _$AddCardsServerConnectionMessage instance) =>
    <String, dynamic>{
      'cards': instance.cards.map((e) => e.toJson()).toList(),
      'deckIndex': instance.deckIndex,
      'seatIndex': instance.seatIndex,
      'type': instance.$type,
    };

_$PutCardsServerConnectionMessage _$$PutCardsServerConnectionMessageFromJson(
        Map json) =>
    _$PutCardsServerConnectionMessage(
      json['deckIndex'] as int,
      json['seatIndex'] as int?,
      $enumDecode(_$PickLocationEnumMap, json['location']),
      json['count'] as int,
      json['movedDeckIndex'] as int,
      json['movedSeatIndex'] as int?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PutCardsServerConnectionMessageToJson(
        _$PutCardsServerConnectionMessage instance) =>
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

_$RemoveCardsServerConnectionMessage
    _$$RemoveCardsServerConnectionMessageFromJson(Map json) =>
        _$RemoveCardsServerConnectionMessage(
          (json['cards'] as List<dynamic>)
              .map((e) =>
                  CardIndex.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList(),
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$RemoveCardsServerConnectionMessageToJson(
        _$RemoveCardsServerConnectionMessage instance) =>
    <String, dynamic>{
      'cards': instance.cards.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

_$RemoveSeatServerConnectionMessage
    _$$RemoveSeatServerConnectionMessageFromJson(Map json) =>
        _$RemoveSeatServerConnectionMessage(
          json['index'] as int,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$RemoveSeatServerConnectionMessageToJson(
        _$RemoveSeatServerConnectionMessage instance) =>
    <String, dynamic>{
      'index': instance.index,
      'type': instance.$type,
    };

_$JoinSeatServerConnectionMessage _$$JoinSeatServerConnectionMessageFromJson(
        Map json) =>
    _$JoinSeatServerConnectionMessage(
      json['index'] as int,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$JoinSeatServerConnectionMessageToJson(
        _$JoinSeatServerConnectionMessage instance) =>
    <String, dynamic>{
      'index': instance.index,
      'type': instance.$type,
    };

_$LeaveSeatServerConnectionMessage _$$LeaveSeatServerConnectionMessageFromJson(
        Map json) =>
    _$LeaveSeatServerConnectionMessage(
      json['index'] as int,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LeaveSeatServerConnectionMessageToJson(
        _$LeaveSeatServerConnectionMessage instance) =>
    <String, dynamic>{
      'index': instance.index,
      'type': instance.$type,
    };

_$ShuffleServerConnectionMessage _$$ShuffleServerConnectionMessageFromJson(
        Map json) =>
    _$ShuffleServerConnectionMessage(
      json['deckIndex'] as int,
      json['seatIndex'] as int?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ShuffleServerConnectionMessageToJson(
        _$ShuffleServerConnectionMessage instance) =>
    <String, dynamic>{
      'deckIndex': instance.deckIndex,
      'seatIndex': instance.seatIndex,
      'type': instance.$type,
    };

_$ChangeVisibilityServerConnectionMessage
    _$$ChangeVisibilityServerConnectionMessageFromJson(Map json) =>
        _$ChangeVisibilityServerConnectionMessage(
          json['deckIndex'] as int,
          json['seatIndex'] as int?,
          $enumDecode(_$DeckVisibilityEnumMap, json['visibility']),
          $enumDecodeNullable(_$DeckVisibilityEnumMap, json['ownVisibility']),
          json['type'] as String?,
        );

Map<String, dynamic> _$$ChangeVisibilityServerConnectionMessageToJson(
        _$ChangeVisibilityServerConnectionMessage instance) =>
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
