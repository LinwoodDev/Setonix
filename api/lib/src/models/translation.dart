import 'package:dart_mappable/dart_mappable.dart';

part 'translation.mapper.dart';

const kFallbackLocale = 'en';

String? getDefaultLocale() => null;

class TranslationsStore {
  final String? Function() getLocale;
  final Map<String, PackTranslation> translations;

  TranslationsStore({
    Iterable<MapEntry<String, PackTranslation>> translations = const [],
    this.getLocale = getDefaultLocale,
  }) : translations = Map.fromEntries(translations);

  PackTranslation getTranslation([String? locale]) =>
      translations[locale ?? getLocale()] ??
      translations[kFallbackLocale] ??
      PackTranslation();

  T findTranslation<T>(
    T? Function(PackTranslation) finder,
    T fallback, [
    String? locale,
  ]) =>
      finder(getTranslation(locale)) ??
      finder(getTranslation(kFallbackLocale)) ??
      fallback;

  DeckTranslation getDeckTranslation(String key, [String? locale]) =>
      findTranslation((t) => t.decks[key], DeckTranslation(name: key), locale);

  FigureTranslation getFigureTranslation(String key, [String? locale]) =>
      findTranslation(
        (t) => t.figures[key],
        FigureTranslation(name: key),
        locale,
      );

  FigureVariationTranslation getFigureVariationTranslation(
    String figureKey,
    String key, [
    String? locale,
  ]) => findTranslation(
    (t) => t.figures[figureKey]?.variations[key],
    FigureVariationTranslation(name: key),
    locale,
  );

  BackgroundTranslation getBackgroundTranslation(
    String key, [
    String? locale,
  ]) => findTranslation(
    (t) => t.backgrounds[key],
    BackgroundTranslation(name: key),
    locale,
  );

  BoardTranslation getBoardTranslation(String key, [String? locale]) =>
      findTranslation(
        (t) => t.boards[key],
        BoardTranslation(name: key),
        locale,
      );

  ModeTranslation getModeTranslation(String key, [String? locale]) =>
      findTranslation((t) => t.modes[key], ModeTranslation(name: key), locale);

  RoleTranslation getRoleTranslation(
    String key, {
    String? locale,
    String? fallback,
  }) => findTranslation(
    (t) => t.roles[key],
    RoleTranslation(name: fallback ?? key),
    locale,
  );

  PermissionTranslation getPermissionTranslation(
    String key, {
    String? locale,
    String? fallback,
  }) => findTranslation(
    (t) => t.permissions[key],
    PermissionTranslation(name: fallback ?? key),
    locale,
  );
}

@MappableClass()
class PackTranslation with PackTranslationMappable {
  final Map<String, DeckTranslation> decks;
  final Map<String, BackgroundTranslation> backgrounds;
  final Map<String, FigureTranslation> figures;
  final Map<String, BoardTranslation> boards;
  final Map<String, ModeTranslation> modes;
  final Map<String, RoleTranslation> roles;
  final Map<String, PermissionTranslation> permissions;

  PackTranslation({
    this.decks = const {},
    this.figures = const {},
    this.backgrounds = const {},
    this.boards = const {},
    this.modes = const {},
    this.roles = const {},
    this.permissions = const {},
  });
}

@MappableClass()
sealed class DescriptiveTranslation with DescriptiveTranslationMappable {
  final String name;
  final String? description;

  DescriptiveTranslation({required this.name, this.description});
}

@MappableClass()
class DeckTranslation extends DescriptiveTranslation
    with DeckTranslationMappable {
  DeckTranslation({required super.name, super.description});
}

@MappableClass()
class BackgroundTranslation extends DescriptiveTranslation
    with BackgroundTranslationMappable {
  BackgroundTranslation({required super.name, super.description});
}

@MappableClass()
class FigureVariationTranslation extends DescriptiveTranslation
    with FigureVariationTranslationMappable {
  FigureVariationTranslation({required super.name, super.description});
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

@MappableClass()
class BoardTranslation extends DescriptiveTranslation
    with BoardTranslationMappable {
  BoardTranslation({required super.name, super.description});
}

@MappableClass()
class ModeTranslation extends DescriptiveTranslation
    with ModeTranslationMappable {
  ModeTranslation({required super.name, super.description});
}

@MappableClass()
class RoleTranslation extends DescriptiveTranslation
    with RoleTranslationMappable {
  RoleTranslation({required super.name, super.description});
}

@MappableClass()
class PermissionTranslation extends DescriptiveTranslation
    with PermissionTranslationMappable {
  PermissionTranslation({required super.name, super.description});
}
