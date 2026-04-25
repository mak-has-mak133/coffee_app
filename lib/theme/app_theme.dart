import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const ColorScheme appColors = ColorScheme.dark(
    brightness: Brightness.dark,
    onPrimary: Color.fromRGBO(255, 255, 255, 1),
    primary: Color.fromRGBO(198, 124, 78, 1),
    surface: Color.fromRGBO(5, 5, 5, 1),
    onSurface: Color.fromRGBO(255, 255, 255, 1),
    onSurfaceVariant: Color.fromRGBO(162, 162, 162, 1),
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
  static final BoxDecoration onboardingFadeDecoration = BoxDecoration(
    borderRadius: BorderRadius.only(topLeft:Radius.circular(40),topRight: Radius.circular(40)),
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [appColors.surface.withValues(alpha: 0.0), appColors.surface],
      stops: const [0.0, 1],
    ),
  );

  static final ThemeData appDarkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: appColors,
    textTheme: appTexts,
    elevatedButtonTheme: elevatedButton,
  );
}
