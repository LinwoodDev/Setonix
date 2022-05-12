import 'package:flutter/material.dart';
import 'package:bits/services/localization.dart';

enum LobbyType { unlimited, win, board }

extension LobbyTypeExtension on LobbyType {
  String? getName(BuildContext context) {
    switch (this) {
      case LobbyType.board:
        return AppLocalizations.of(context)!
            .translate("lobby-types.board.name");
      case LobbyType.unlimited:
        return AppLocalizations.of(context)!
            .translate("lobby-types.unlimited.name");
      case LobbyType.win:
        return AppLocalizations.of(context)!.translate("lobby-types.win.name");
      default:
        return null;
    }
  }

  String? getDescription(BuildContext context) {
    switch (this) {
      case LobbyType.board:
        return AppLocalizations.of(context)!
            .translate("lobby-types.board.description");
      case LobbyType.unlimited:
        return AppLocalizations.of(context)!
            .translate("lobby-types.unlimited.description");
      case LobbyType.win:
        return AppLocalizations.of(context)!
            .translate("lobby-types.win.description");
      default:
        return null;
    }
  }
}
