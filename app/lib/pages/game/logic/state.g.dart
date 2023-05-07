// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassicGameCard _$$ClassicGameCardFromJson(Map<String, dynamic> json) =>
    _$ClassicGameCard(
      color: $enumDecodeNullable(_$GameCardColorEnumMap, json['color']) ??
          GameCardColor.heart,
      number: json['number'] as int? ?? 1,
    );

Map<String, dynamic> _$$ClassicGameCardToJson(_$ClassicGameCard instance) =>
    <String, dynamic>{
      'color': _$GameCardColorEnumMap[instance.color]!,
      'number': instance.number,
    };

const _$GameCardColorEnumMap = {
  GameCardColor.heart: 'heart',
  GameCardColor.diamond: 'diamond',
  GameCardColor.spade: 'spade',
  GameCardColor.club: 'club',
};

_$_DeckRefillNone _$$_DeckRefillNoneFromJson(Map<String, dynamic> json) =>
    _$_DeckRefillNone(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_DeckRefillNoneToJson(_$_DeckRefillNone instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_DeckRefillShuffle _$$_DeckRefillShuffleFromJson(Map<String, dynamic> json) =>
    _$_DeckRefillShuffle(
      count: json['count'] as int?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_DeckRefillShuffleToJson(
        _$_DeckRefillShuffle instance) =>
    <String, dynamic>{
      'count': instance.count,
      'runtimeType': instance.$type,
    };

_$_DeckRefillFirst _$$_DeckRefillFirstFromJson(Map<String, dynamic> json) =>
    _$_DeckRefillFirst(
      count: json['count'] as int?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_DeckRefillFirstToJson(_$_DeckRefillFirst instance) =>
    <String, dynamic>{
      'count': instance.count,
      'runtimeType': instance.$type,
    };

_$_GameDeck _$$_GameDeckFromJson(Map<String, dynamic> json) => _$_GameDeck(
      name: json['name'] as String? ?? '',
      visibility:
          $enumDecodeNullable(_$DeckVisibilityEnumMap, json['visibility']) ??
              DeckVisibility.hidden,
      cards: (json['cards'] as List<dynamic>?)
              ?.map((e) => GameCard.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_GameDeckToJson(_$_GameDeck instance) =>
    <String, dynamic>{
      'name': instance.name,
      'visibility': _$DeckVisibilityEnumMap[instance.visibility]!,
      'cards': instance.cards,
    };

const _$DeckVisibilityEnumMap = {
  DeckVisibility.hidden: 'hidden',
  DeckVisibility.onlyTop: 'onlyTop',
  DeckVisibility.visible: 'visible',
};
