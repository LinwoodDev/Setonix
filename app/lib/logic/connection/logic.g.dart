// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GamePlayer _$$_GamePlayerFromJson(Map json) => _$_GamePlayer(
      name: json['name'] as String,
      id: json['id'] as int,
    );

Map<String, dynamic> _$$_GamePlayerToJson(_$_GamePlayer instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };

_$AvailableCardIndex _$$AvailableCardIndexFromJson(Map json) =>
    _$AvailableCardIndex(
      GameCard.fromJson(Map<String, dynamic>.from(json['card'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AvailableCardIndexToJson(
        _$AvailableCardIndex instance) =>
    <String, dynamic>{
      'card': instance.card.toJson(),
      'type': instance.$type,
    };

_$DeckCardIndex _$$DeckCardIndexFromJson(Map json) => _$DeckCardIndex(
      json['cardIndex'] as int,
      json['deckIndex'] as int,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DeckCardIndexToJson(_$DeckCardIndex instance) =>
    <String, dynamic>{
      'cardIndex': instance.cardIndex,
      'deckIndex': instance.deckIndex,
      'type': instance.$type,
    };

_$SeatCardIndex _$$SeatCardIndexFromJson(Map json) => _$SeatCardIndex(
      json['cardIndex'] as int,
      json['deckIndex'] as int,
      json['seatIndex'] as int,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$SeatCardIndexToJson(_$SeatCardIndex instance) =>
    <String, dynamic>{
      'cardIndex': instance.cardIndex,
      'deckIndex': instance.deckIndex,
      'seatIndex': instance.seatIndex,
      'type': instance.$type,
    };
