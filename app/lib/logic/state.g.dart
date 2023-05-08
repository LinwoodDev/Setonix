// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassicGameCard _$$ClassicGameCardFromJson(Map<String, dynamic> json) =>
    _$ClassicGameCard(
      color:
          $enumDecodeNullable(_$ClassicGameCardColorEnumMap, json['color']) ??
              ClassicGameCardColor.heart,
      number: json['number'] as int? ?? 1,
    );

Map<String, dynamic> _$$ClassicGameCardToJson(_$ClassicGameCard instance) =>
    <String, dynamic>{
      'color': _$ClassicGameCardColorEnumMap[instance.color]!,
      'number': instance.number,
    };

const _$ClassicGameCardColorEnumMap = {
  ClassicGameCardColor.heart: 'heart',
  ClassicGameCardColor.diamond: 'diamond',
  ClassicGameCardColor.spade: 'spade',
  ClassicGameCardColor.club: 'club',
};

_$_GameState _$$_GameStateFromJson(Map<String, dynamic> json) => _$_GameState(
      decks: (json['decks'] as List<dynamic>?)
              ?.map((e) => GameDeck.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      seats: (json['seats'] as List<dynamic>?)
              ?.map((e) => GameSeat.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_GameStateToJson(_$_GameState instance) =>
    <String, dynamic>{
      'decks': instance.decks,
      'seats': instance.seats,
    };

_$_GameSeat _$$_GameSeatFromJson(Map<String, dynamic> json) => _$_GameSeat(
      name: json['name'] as String? ?? '',
      decks: (json['decks'] as List<dynamic>?)
              ?.map((e) => GameDeck.fromJson(e as Map<String, dynamic>))
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
      'decks': instance.decks,
      'players': instance.players,
      'ownDeckVisibility': _$DeckVisibilityEnumMap[instance.ownDeckVisibility],
    };

const _$DeckVisibilityEnumMap = {
  DeckVisibility.hidden: 'hidden',
  DeckVisibility.onlyTop: 'onlyTop',
  DeckVisibility.visible: 'visible',
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
      ownVisibility:
          $enumDecodeNullable(_$DeckVisibilityEnumMap, json['ownVisibility']),
      cards: (json['cards'] as List<dynamic>?)
              ?.map((e) => GameCard.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_GameDeckToJson(_$_GameDeck instance) =>
    <String, dynamic>{
      'name': instance.name,
      'visibility': _$DeckVisibilityEnumMap[instance.visibility]!,
      'ownVisibility': _$DeckVisibilityEnumMap[instance.ownVisibility],
      'cards': instance.cards,
    };
