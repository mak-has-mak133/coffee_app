import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const homeGradientStart=Color.fromRGBO(49, 49, 49, 1);
  static const homeGradientEnd=Color.fromRGBO(17, 17, 17, 1);
  static const homeGradientStops=[0.0,1.0];
  static const ColorScheme appColors = ColorScheme.dark(
    brightness: Brightness.dark,
    onPrimary: Color.fromRGBO(255, 255, 255, 1),
    primary: Color.fromRGBO(198, 124, 78, 1),
    surface: Color.fromRGBO(5, 5, 5, 1),
    onSurface: Color.fromRGBO(255, 255, 255, 1),
    onSurfaceVariant: Color.fromRGBO(162, 162, 162, 1),
    error: Color.fromRGBO(237, 81, 81, 1)
  );
  static final TextTheme appTexts = TextTheme(
    headlineMedium: GoogleFonts.sora(
      fontWeight: FontWeight.w600,
      fontSize: 32,
      height: 1.5,
      letterSpacing: 0.005,
    ),
    bodyMedium: GoogleFonts.sora(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.5,
      letterSpacing: 0.01,

    ),
  );
  static final ElevatedButtonThemeData elevatedButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: appColors.primary,
      foregroundColor: appColors.onPrimary,
      minimumSize: Size(150, 60),
      textStyle: appTexts.bodyMedium!.copyWith(
        letterSpacing: 0,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    ),
  );

  static final ThemeData appDarkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: appColors,
    textTheme: appTexts,
    elevatedButtonTheme: elevatedButton,
  );
}
