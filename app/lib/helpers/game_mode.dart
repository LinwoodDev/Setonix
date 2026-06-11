import 'package:flutter/widgets.dart';
import 'package:setonix/src/generated/i18n/app_localizations.dart';
import 'package:setonix_api/setonix_api.dart';

String getGameModeLabel(BuildContext context, PackItem<GameMode> mode) {
  final translations = mode.pack.getTranslationsStore(
    getLocale: () => Localizations.localeOf(context).languageCode,
  );
  return translations.getModeTranslation(mode.id).name;
}

String getGameModeOrSandboxLabel(
  BuildContext context,
  PackItem<GameMode>? mode,
) => mode == null
    ? AppLocalizations.of(context).sandbox
    : getGameModeLabel(context, mode);
