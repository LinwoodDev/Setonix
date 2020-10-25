import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaletteColors {
  static const int primary = 0xFFDB4900;
  static const Color primaryColor = const Color(primary);
  static const Color secondaryColor = const Color(0xFFFFE605);
  static const Color accentColor = const Color(0xFFFA003E);
  static const Color lightColor = const Color(0xFFFFDFB3);
  static const Color darkColor = const Color(0xFF660A00);
  static MaterialColor colorCustom = MaterialColor(primary, {
    50: primaryColor.withAlpha((255 * .1).round()),
    100: primaryColor.withAlpha((255 * .2).round()),
    200: primaryColor.withAlpha((255 * .3).round()),
    300: primaryColor.withAlpha((255 * .4).round()),
    400: primaryColor.withAlpha((255 * .5).round()),
    500: primaryColor.withAlpha((255 * .6).round()),
    600: primaryColor.withAlpha((255 * .7).round()),
    700: primaryColor.withAlpha((255 * .8).round()),
    800: primaryColor.withAlpha((255 * .9).round()),
    900: primaryColor.withAlpha(255),
  });
}
