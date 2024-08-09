import 'package:dart_mappable/dart_mappable.dart';

part 'translation.mapper.dart';

class TranslationsStore {
  final String Function() getLocale;
  final Map<String, PackTranslation> translations;

  TranslationsStore({
    Iterable<MapEntry<String, PackTranslation>> translations = const [],
    required this.getLocale,
  }) : translations = Map.fromEntries(translations);

  PackTranslation getTranslation([String? locale]) =>
      (locale == null ? null : translations[locale]) ??
      translations[this.getLocale()] ??
      PackTranslation();

  T findTranslation<T>(T? Function(PackTranslation) finder, T fallback,
          [String? locale]) =>
      finder(getTranslation(locale)) ?? finder(getTranslation()) ?? fallback;

  DeckTranslation getDeckTranslation(String key, [String? locale]) =>
      findTranslation(
        (t) => t.decks[key],
        DeckTranslation(name: key),
        locale,
      );

  FigureTranslation getFigureTranslation(String key, [String? locale]) =>
      findTranslation(
        (t) => t.figures[key],
        FigureTranslation(name: key),
        locale,
      );

  FigureVariationTranslation getFigureVariationTranslation(
          String figureKey, String key,
          [String? locale]) =>
      findTranslation(
        (t) => t.figures[figureKey]?.variations[key],
        FigureVariationTranslation(name: key),
        locale,
      );
}

@MappableClass()
class PackTranslation with PackTranslationMappable {
  final Map<String, DeckTranslation> decks;
  final Map<String, FigureTranslation> figures;

  PackTranslation({
    this.decks = const {},
    this.figures = const {},
  });
}

@MappableClass()
sealed class DescriptiveTranslation with DescriptiveTranslationMappable {
  final String name;
  final String? description;

  DescriptiveTranslation({
    required this.name,
    this.description,
  });
}

@MappableClass()
class DeckTranslation extends DescriptiveTranslation
    with DeckTranslationMappable {
  DeckTranslation({
    required super.name,
    super.description,
  });
}

@MappableClass()
class FigureVariationTranslation extends DescriptiveTranslation
    with FigureVariationTranslationMappable {
  FigureVariationTranslation({
    required super.name,
    super.description,
  });
}

@MappableClass()
class FigureTranslation extends DescriptiveTranslation
    with FigureTranslationMappable {
  final Map<String, FigureVariationTranslation> variations;

  FigureTranslation({
    required super.name,
    super.description,
    this.variations = const {},
  });
}
