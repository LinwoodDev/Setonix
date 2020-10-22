import 'package:flutter/material.dart';
import 'package:minigamesparty/services/localization.dart';

enum LobbyType { unlimited, win, board }

extension LobbyTypeExtension on LobbyType {
  String getName() {
    switch (this) {
      case LobbyType.board:
        return "Board";
      case LobbyType.unlimited:
        return "Unlimited";
      case LobbyType.win:
        return "Win";
    }
    return null;
  }

  String getDescription(BuildContext context) {
    switch (this) {
      case LobbyType.board:
        AppLocalizations.of(context).translate("lobby-types.board");
      case LobbyType.unlimited:
        AppLocalizations.of(context).translate("lobby-types.unlimited");
      case LobbyType.win:
        AppLocalizations.of(context).translate("lobby-types.win");
    }
    return null;
  }
}
