import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaletteColors {
  static const int primary = 0xFFDB4900;
  static const Color primaryColor = const Color(primary);
  static const int secondary = 0xFFFFE605;
  static const Color secondaryColor = const Color(secondary);
  static const Color accentColor = const Color(0xFFFA003E);
  static const Color lightColor = const Color(0xFFFFDFB3);
  static const Color darkColor = const Color(0xFF660A00);
  static final MaterialColor primaryPalette = _generateColors(primary);
  static final MaterialColor secondaryPalette = _generateColors(secondary);

  static MaterialColor _generateColors(int hex) {
    var color = Color(hex);
    return MaterialColor(hex, {
      50: color.withAlpha((255 * .1).round()),
      100: color.withAlpha((255 * .2).round()),
      200: color.withAlpha((255 * .3).round()),
      300: color.withAlpha((255 * .4).round()),
      400: color.withAlpha((255 * .5).round()),
      500: color.withAlpha((255 * .6).round()),
      600: color.withAlpha((255 * .7).round()),
      700: color.withAlpha((255 * .8).round()),
      800: color.withAlpha((255 * .9).round()),
      900: color.withAlpha(255),
    });
  }
}
