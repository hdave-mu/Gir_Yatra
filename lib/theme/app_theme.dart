// lib/theme/app_theme.dart
// Light-only, modern tourism-focused theme for Gir Yatra.
// Dark mode has been permanently removed.

import 'package:flutter/material.dart';

class AppTheme {
  // Brand palette
  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color lightGreen = Color(0xFF4CAF50);
  static const Color accentGreen = Color(0xFF81C784);
  static const Color primaryBrown = Color(0xFF5D4037);
  static const Color lightBrown = Color(0xFF8D6E63);
  static const Color beige = Color(0xFFF7F3EC);
  static const Color warmWhite = Color(0xFFFFFDF8);
  static const Color goldenAmber = Color(0xFFEF8F00);
  static const Color safariOrange = Color(0xFFE65100);
  static const Color skyBlue = Color(0xFF0277BD);
  static const Color softBorder = Color(0xFFE8E0D2);
  static const Color textDark = Color(0xFF2E1E12);

  // Opacity constants for performance—use hex values to avoid runtime creation
  static const Color white12 = Color(0x1FFFFFFF);
  static const Color white15 = Color(0x26FFFFFF);
  static const Color white20 = Color(0x33FFFFFF);
  static const Color white25 = Color(0x40FFFFFF);
  static const Color white30 = Color(0x4DFFFFFF);
  static const Color white75 = Color(0xBFFFFFFF);
  static const Color white85 = Color(0xD9FFFFFF);
  static const Color white95 = Color(0xF2FFFFFF);
  static const Color black08 = Color(0x14000000);
  static const Color black12 = Color(0x1F000000);
  static const Color black15 = Color(0x26000000);
  static const Color black20 = Color(0x33000000);
  static const Color black30 = Color(0x4D000000);
  static const Color black40 = Color(0x66000000);
  static const Color greenDim = Color(0xFF1B5E20);

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryGreen,
          primary: primaryGreen,
          secondary: primaryBrown,
          tertiary: goldenAmber,
          surface: warmWhite,
          background: beige,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: beige,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 0.3,
          ),
        ),
        cardTheme: CardThemeData(
          color: warmWhite,
          elevation: 1.5,
          shadowColor: primaryBrown.withOpacity(0.12),
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: softBorder, width: 0.8),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: primaryGreen,
          unselectedItemColor: lightBrown,
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
          unselectedLabelStyle: TextStyle(fontSize: 11),
          elevation: 8,
          type: BottomNavigationBarType.fixed,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: textDark,
              letterSpacing: -0.5),
          headlineLarge: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: primaryGreen,
              letterSpacing: -0.3),
          headlineMedium: TextStyle(
              fontSize: 21, fontWeight: FontWeight.w700, color: textDark),
          headlineSmall: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w600, color: textDark),
          titleMedium: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: textDark),
          bodyLarge: TextStyle(fontSize: 15, color: textDark, height: 1.5),
          bodyMedium:
              TextStyle(fontSize: 13.5, color: Color(0xFF4E342E), height: 1.45),
          bodySmall: TextStyle(fontSize: 12, color: lightBrown, height: 1.4),
          labelLarge: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w600, color: primaryGreen),
          labelSmall: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.3),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: warmWhite,
          selectedColor: primaryGreen,
          disabledColor: softBorder,
          labelStyle: const TextStyle(
              color: primaryBrown, fontSize: 12, fontWeight: FontWeight.w600),
          secondaryLabelStyle: const TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
          side: const BorderSide(color: softBorder),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        ),
        dividerTheme: const DividerThemeData(
          color: softBorder,
          thickness: 1,
          space: 1,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: warmWhite,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: softBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: softBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryGreen, width: 1.5),
          ),
          hintStyle: const TextStyle(color: lightBrown, fontSize: 13),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: primaryGreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle:
                const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryGreen,
            side: const BorderSide(color: primaryGreen, width: 1.2),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle:
                const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
        ),
        iconTheme: const IconThemeData(color: primaryBrown),
      );
}
