// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassicGameCard _$$ClassicGameCardFromJson(Map json) => _$ClassicGameCard(
      color:
          $enumDecodeNullable(_$ClassicGameCardColorEnumMap, json['color']) ??
              ClassicGameCardColor.heart,
      number: json['number'] as int? ?? 1,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ClassicGameCardToJson(_$ClassicGameCard instance) =>
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

_$BackgroundGameCard _$$BackgroundGameCardFromJson(Map json) =>
    _$BackgroundGameCard(
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$BackgroundGameCardToJson(
        _$BackgroundGameCard instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$_GameState _$$_GameStateFromJson(Map json) => _$_GameState(
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

Map<String, dynamic> _$$_GameStateToJson(_$_GameState instance) =>
    <String, dynamic>{
      'decks': instance.decks.map((e) => e.toJson()).toList(),
      'seats': instance.seats.map((e) => e.toJson()).toList(),
    };

_$_GameSeat _$$_GameSeatFromJson(Map json) => _$_GameSeat(
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

Map<String, dynamic> _$$_GameSeatToJson(_$_GameSeat instance) =>
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

_$_DeckRefillNone _$$_DeckRefillNoneFromJson(Map json) => _$_DeckRefillNone(
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$_DeckRefillNoneToJson(_$_DeckRefillNone instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$_DeckRefillShuffle _$$_DeckRefillShuffleFromJson(Map json) =>
    _$_DeckRefillShuffle(
      count: json['count'] as int?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$_DeckRefillShuffleToJson(
        _$_DeckRefillShuffle instance) =>
    <String, dynamic>{
      'count': instance.count,
      'type': instance.$type,
    };

_$_DeckRefillFirst _$$_DeckRefillFirstFromJson(Map json) => _$_DeckRefillFirst(
      count: json['count'] as int?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$_DeckRefillFirstToJson(_$_DeckRefillFirst instance) =>
    <String, dynamic>{
      'count': instance.count,
      'type': instance.$type,
    };

_$_GameDeck _$$_GameDeckFromJson(Map json) => _$_GameDeck(
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

Map<String, dynamic> _$$_GameDeckToJson(_$_GameDeck instance) =>
    <String, dynamic>{
      'name': instance.name,
      'visibility': _$DeckVisibilityEnumMap[instance.visibility]!,
      'ownVisibility': _$DeckVisibilityEnumMap[instance.ownVisibility],
      'cards': instance.cards.map((e) => e.toJson()).toList(),
    };
