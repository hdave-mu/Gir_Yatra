// lib/theme/app_theme.dart
// Light-only, premium "Living Forest Luxury" theme for Gir Yatra.
// Dark mode has been permanently removed.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ── Original Brand Palette (preserved) ──────────────────────
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

  // ── NEW: Cinematic Forest Tones ──────────────────────────────
  static const Color forestDepth = Color(0xFF0D3B1E);
  static const Color amberLight = Color(0xFFFBC02D);
  static const Color mistGray = Color(0xFFE8E4DF);
  static const Color duskViolet = Color(0xFF4A2040);
  static const Color canopyGold = Color(0xFFD4A017);
  static const Color earthRust = Color(0xFF8B4513);
  static const Color mistyGreen = Color(0xFF9DB8A0);
  static const Color warmIvory = Color(0xFFFFF8F0);
  static const Color deepTeal = Color(0xFF004D40);
  static const Color sunsetCoral = Color(0xFFFF7043);

  // ── Opacity constants (unchanged) ────────────────────────────
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

  // ── Premium Gradients ─────────────────────────────────────────
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x00000000),
      Color(0x15000000),
      Color(0x60000000),
      Color(0xCC000000),
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );

  static const LinearGradient forestGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0D3B1E),
      Color(0xFF1B5E20),
      Color(0xFF2E7D32),
    ],
  );

  static const LinearGradient goldenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFD54F),
      Color(0xFFFBC02D),
      Color(0xFFEF8F00),
    ],
  );

  // ── Premium Box Shadows ──────────────────────────────────────
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: primaryBrown.withValues(alpha: 0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: primaryBrown.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get elevatedShadow => [
        BoxShadow(
          color: primaryBrown.withValues(alpha: 0.12),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: primaryBrown.withValues(alpha: 0.06),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  // ── Theme Data ───────────────────────────────────────────────
  static ThemeData get lightTheme {
    // Premium typography with Google Fonts
    const displayFont = GoogleFonts.playfairDisplay;
    const bodyFont = GoogleFonts.dmSans;
    const labelFont = GoogleFonts.josefinSans;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        secondary: primaryBrown,
        tertiary: goldenAmber,
        surface: warmWhite,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: beige,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: displayFont(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: 0.3,
        ),
      ),
      cardTheme: CardThemeData(
        color: warmWhite,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: softBorder.withValues(alpha: 0.6), width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        indicatorColor: primaryGreen.withValues(alpha: 0.12),
        elevation: 0,
        height: 68,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return labelFont(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: primaryGreen,
            );
          }
          return labelFont(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: lightBrown,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryGreen, size: 24);
          }
          return const IconThemeData(color: lightBrown, size: 22);
        }),
      ),
      textTheme: TextTheme(
        displayLarge: displayFont(
          fontSize: 34,
          fontWeight: FontWeight.w800,
          color: textDark,
          letterSpacing: -0.5,
          height: 1.2,
        ),
        displayMedium: displayFont(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: textDark,
          letterSpacing: -0.3,
        ),
        headlineLarge: displayFont(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: primaryGreen,
          letterSpacing: -0.3,
        ),
        headlineMedium: displayFont(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
        headlineSmall: displayFont(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        titleLarge: bodyFont(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: textDark,
          letterSpacing: 0.1,
        ),
        titleMedium: bodyFont(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        bodyLarge: bodyFont(
          fontSize: 15,
          color: textDark,
          height: 1.6,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: bodyFont(
          fontSize: 13.5,
          color: const Color(0xFF4E342E),
          height: 1.5,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: bodyFont(
          fontSize: 12,
          color: lightBrown,
          height: 1.4,
        ),
        labelLarge: labelFont(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: primaryGreen,
          letterSpacing: 0.5,
        ),
        labelMedium: labelFont(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: primaryBrown,
          letterSpacing: 0.3,
        ),
        labelSmall: labelFont(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: warmWhite,
        selectedColor: primaryGreen,
        disabledColor: softBorder,
        labelStyle: GoogleFonts.josefinSans(
          color: primaryBrown,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        secondaryLabelStyle: GoogleFonts.josefinSans(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        side: const BorderSide(color: softBorder),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: softBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: softBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primaryGreen, width: 1.5),
        ),
        hintStyle: GoogleFonts.dmSans(color: lightBrown, fontSize: 13),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: GoogleFonts.dmSans(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 0.3,
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryGreen,
          side: const BorderSide(color: primaryGreen, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: GoogleFonts.dmSans(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            letterSpacing: 0.3,
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: primaryBrown),
    );
  }
}
