// lib/theme/app_theme.dart
// Defines the complete theme for Gir Yatra app

import 'package:flutter/material.dart';

class AppTheme {
  // ── Brand Colors ──────────────────────────────────────────────
  static const Color primaryGreen   = Color(0xFF2E7D32);  // Forest green
  static const Color lightGreen     = Color(0xFF4CAF50);  // Leaf green
  static const Color accentGreen    = Color(0xFF81C784);  // Soft green
  static const Color primaryBrown   = Color(0xFF5D4037);  // Earth brown
  static const Color lightBrown     = Color(0xFF8D6E63);  // Light brown
  static const Color beige          = Color(0xFFF5F0E8);  // Natural beige
  static const Color warmWhite      = Color(0xFFFFFBF5);  // Warm white bg
  static const Color goldenAmber    = Color(0xFFFF8F00);  // Accent amber
  static const Color safariOrange   = Color(0xFFE65100);  // Safari orange
  static const Color skyBlue        = Color(0xFF0277BD);  // Sky blue

  // ── Light Theme ───────────────────────────────────────────────
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      primary: primaryGreen,
      secondary: primaryBrown,
      tertiary: goldenAmber,
      surface: warmWhite,
      background: beige,
    ),
    scaffoldBackgroundColor: beige,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryGreen,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
    ),
    cardTheme: CardThemeData(
      color: warmWhite,
      elevation: 3,
      shadowColor: primaryBrown.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryGreen,
      unselectedItemColor: lightBrown,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
      elevation: 10,
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 26, fontWeight: FontWeight.bold, color: primaryGreen,
      ),
      headlineMedium: TextStyle(
        fontSize: 22, fontWeight: FontWeight.bold, color: primaryBrown,
      ),
      headlineSmall: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: primaryBrown,
      ),
      bodyLarge: TextStyle(
        fontSize: 15, color: Color(0xFF3E2723), height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 13, color: Color(0xFF4E342E), height: 1.4,
      ),
      labelLarge: TextStyle(
        fontSize: 13, fontWeight: FontWeight.w600, color: primaryGreen,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: accentGreen.withOpacity(0.3),
      labelStyle: const TextStyle(color: primaryGreen, fontSize: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    dividerTheme: DividerThemeData(
      color: primaryBrown.withOpacity(0.2),
      thickness: 1,
    ),
  );

  // ── Dark Theme ────────────────────────────────────────────────
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      brightness: Brightness.dark,
      primary: lightGreen,
      secondary: lightBrown,
      surface: const Color(0xFF1B2320),
      background: const Color(0xFF121A14),
    ),
    scaffoldBackgroundColor: const Color(0xFF121A14),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1B2E1E),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E2D22),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1B2320),
      selectedItemColor: lightGreen,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
