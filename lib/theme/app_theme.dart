import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextTheme textTheme() {
    return TextTheme(
      displayLarge: GoogleFonts.epilogue(fontWeight: FontWeight.w600, fontSize: 50.0),
      displayMedium: GoogleFonts.epilogue(fontWeight: FontWeight.w400, fontSize: 12.0),
      labelLarge: GoogleFonts.epilogue(fontWeight: FontWeight.w700, fontSize: 25.0),
      labelMedium: GoogleFonts.epilogue(fontWeight: FontWeight.w600, fontSize: 20.0),
      labelSmall: GoogleFonts.epilogue(fontWeight: FontWeight.w600, fontSize: 14.0),
      bodyLarge: GoogleFonts.epilogue(fontWeight: FontWeight.w400, fontSize: 20.0),
      bodyMedium: GoogleFonts.epilogue(fontWeight: FontWeight.w800, fontSize: 16.0),
      bodySmall: GoogleFonts.epilogue(fontWeight: FontWeight.w500, fontSize: 15.0),
    );
  }

  static ThemeData light() {
    const Color primary = Color(0xFF4CAF50);
    const Color secondary = Color(0xFF1976D2);
    const Color background = Color(0xFFF5F5F5);
    const Color surface = Colors.white;
    const Color error = Color(0xFFD32F2F);
    const Color onPrimary = Colors.white;
    const Color onSecondary = Colors.white;
    const Color onBackground = Colors.black;
    const Color onSurface = Colors.black;

    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primary,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        background: background,
        onBackground: onBackground,
        surface: surface,
        onSurface: onSurface,
        error: error,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: background,
      textTheme: textTheme(),
    );
  }

  static ThemeData dark() {
    const Color primary = Color(0xFF81C784);
    const Color secondary = Color(0xFF64B5F6);
    const Color background = Color(0xFF121212);
    const Color surface = Color(0xFF1E1E1E);
    const Color error = Color(0xFFEF5350);
    const Color onPrimary = Colors.black;
    const Color onSecondary = Colors.black;
    const Color onBackground = Colors.white;
    const Color onSurface = Colors.white;

    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primary,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        background: background,
        onBackground: onBackground,
        surface: surface,
        onSurface: onSurface,
        error: error,
        onError: Colors.black,
      ),
      scaffoldBackgroundColor: background,
      textTheme: textTheme(),
    );
  }
}
