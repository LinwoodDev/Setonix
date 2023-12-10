// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassicGameCardImpl _$$ClassicGameCardImplFromJson(Map json) =>
    _$ClassicGameCardImpl(
      color:
          $enumDecodeNullable(_$ClassicGameCardColorEnumMap, json['color']) ??
              ClassicGameCardColor.heart,
      number: json['number'] as int? ?? 1,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ClassicGameCardImplToJson(
        _$ClassicGameCardImpl instance) =>
    <String, dynamic>{
      'color': _$ClassicGameCardColorEnumMap[instance.color]!,
      'number': instance.number,
      'type': instance.$type,
    };

const _$ClassicGameCardColorEnumMap = {
  ClassicGameCardColor.heart: 'heart',
  ClassicGameCardColor.diamond: 'diamond',
  ClassicGameCardColor.spade: 'spade',
  ClassicGameCardColor.club: 'club',
};

_$BackgroundGameCardImpl _$$BackgroundGameCardImplFromJson(Map json) =>
    _$BackgroundGameCardImpl(
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$BackgroundGameCardImplToJson(
        _$BackgroundGameCardImpl instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$GameStateImpl _$$GameStateImplFromJson(Map json) => _$GameStateImpl(
      decks: (json['decks'] as List<dynamic>?)
              ?.map(
                  (e) => GameDeck.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      seats: (json['seats'] as List<dynamic>?)
              ?.map(
                  (e) => GameSeat.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GameStateImplToJson(_$GameStateImpl instance) =>
    <String, dynamic>{
      'decks': instance.decks.map((e) => e.toJson()).toList(),
      'seats': instance.seats.map((e) => e.toJson()).toList(),
    };

_$GameSeatImpl _$$GameSeatImplFromJson(Map json) => _$GameSeatImpl(
      name: json['name'] as String? ?? '',
      decks: (json['decks'] as List<dynamic>?)
              ?.map(
                  (e) => GameDeck.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      players:
          (json['players'] as List<dynamic>?)?.map((e) => e as int).toList() ??
              const [],
      ownDeckVisibility: $enumDecodeNullable(
          _$DeckVisibilityEnumMap, json['ownDeckVisibility']),
    );

Map<String, dynamic> _$$GameSeatImplToJson(_$GameSeatImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'decks': instance.decks.map((e) => e.toJson()).toList(),
      'players': instance.players,
      'ownDeckVisibility': _$DeckVisibilityEnumMap[instance.ownDeckVisibility],
    };

const _$DeckVisibilityEnumMap = {
  DeckVisibility.hidden: 'hidden',
  DeckVisibility.onlyTop: 'onlyTop',
  DeckVisibility.visible: 'visible',
};

_$DeckRefillNoneImpl _$$DeckRefillNoneImplFromJson(Map json) =>
    _$DeckRefillNoneImpl(
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DeckRefillNoneImplToJson(
        _$DeckRefillNoneImpl instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$DeckRefillShuffleImpl _$$DeckRefillShuffleImplFromJson(Map json) =>
    _$DeckRefillShuffleImpl(
      count: json['count'] as int?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DeckRefillShuffleImplToJson(
        _$DeckRefillShuffleImpl instance) =>
    <String, dynamic>{
      'count': instance.count,
      'type': instance.$type,
    };

_$DeckRefillFirstImpl _$$DeckRefillFirstImplFromJson(Map json) =>
    _$DeckRefillFirstImpl(
      count: json['count'] as int?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DeckRefillFirstImplToJson(
        _$DeckRefillFirstImpl instance) =>
    <String, dynamic>{
      'count': instance.count,
      'type': instance.$type,
    };

_$GameDeckImpl _$$GameDeckImplFromJson(Map json) => _$GameDeckImpl(
      name: json['name'] as String? ?? '',
      visibility:
          $enumDecodeNullable(_$DeckVisibilityEnumMap, json['visibility']) ??
              DeckVisibility.hidden,
      ownVisibility:
          $enumDecodeNullable(_$DeckVisibilityEnumMap, json['ownVisibility']),
      cards: (json['cards'] as List<dynamic>?)
              ?.map(
                  (e) => GameCard.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GameDeckImplToJson(_$GameDeckImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'visibility': _$DeckVisibilityEnumMap[instance.visibility]!,
      'ownVisibility': _$DeckVisibilityEnumMap[instance.ownVisibility],
      'cards': instance.cards.map((e) => e.toJson()).toList(),
    };
