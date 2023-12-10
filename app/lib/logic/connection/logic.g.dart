// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GamePlayerImpl _$$GamePlayerImplFromJson(Map json) => _$GamePlayerImpl(
      name: json['name'] as String,
      id: json['id'] as int,
    );

Map<String, dynamic> _$$GamePlayerImplToJson(_$GamePlayerImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };

_$AvailableCardIndexImpl _$$AvailableCardIndexImplFromJson(Map json) =>
    _$AvailableCardIndexImpl(
      GameCard.fromJson(Map<String, dynamic>.from(json['card'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AvailableCardIndexImplToJson(
        _$AvailableCardIndexImpl instance) =>
    <String, dynamic>{
      'card': instance.card.toJson(),
      'type': instance.$type,
    };

_$DeckCardIndexImpl _$$DeckCardIndexImplFromJson(Map json) =>
    _$DeckCardIndexImpl(
      json['cardIndex'] as int,
      json['deckIndex'] as int,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DeckCardIndexImplToJson(_$DeckCardIndexImpl instance) =>
    <String, dynamic>{
      'cardIndex': instance.cardIndex,
      'deckIndex': instance.deckIndex,
      'type': instance.$type,
    };

_$SeatCardIndexImpl _$$SeatCardIndexImplFromJson(Map json) =>
    _$SeatCardIndexImpl(
      json['cardIndex'] as int,
      json['deckIndex'] as int,
      json['seatIndex'] as int,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$SeatCardIndexImplToJson(_$SeatCardIndexImpl instance) =>
    <String, dynamic>{
      'cardIndex': instance.cardIndex,
      'deckIndex': instance.deckIndex,
      'seatIndex': instance.seatIndex,
      'type': instance.$type,
    };
