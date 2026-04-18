// lib/theme/design_tokens.dart
// Centralized spacing, elevation, duration, and curve constants.

import 'package:flutter/material.dart';

/// Consistent spacing scale (multiples of 4).
class GirSpacing {
  GirSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double base = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
  static const double hero = 64;
}

/// Elevation levels for layered depth.
class GirElevation {
  GirElevation._();
  static const double none = 0;
  static const double card = 2;
  static const double raised = 4;
  static const double floating = 8;
  static const double modal = 16;
  static const double overlay = 24;
}

/// Animation durations.
class GirDurations {
  GirDurations._();
  static const Duration instant = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 600);
  static const Duration dramatic = Duration(milliseconds: 800);
  static const Duration cinematic = Duration(milliseconds: 1200);
  static const Duration staggerDelay = Duration(milliseconds: 80);
}

/// Premium easing curves for organic motion.
class GirCurves {
  GirCurves._();
  static const Curve entrance = Curves.easeOutCubic;
  static const Curve exit = Curves.easeInCubic;
  static const Curve bounce = Curves.elasticOut;
  static const Curve smooth = Curves.easeInOutCubic;
  static const Curve overshoot = Curves.easeOutBack;
  static const Curve decelerate = Curves.decelerate;
}

/// Border radius presets.
class GirRadius {
  GirRadius._();
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double pill = 100;

  static final BorderRadius borderSm = BorderRadius.circular(sm);
  static final BorderRadius borderMd = BorderRadius.circular(md);
  static final BorderRadius borderLg = BorderRadius.circular(lg);
  static final BorderRadius borderXl = BorderRadius.circular(xl);
  static final BorderRadius borderXxl = BorderRadius.circular(xxl);
  static final BorderRadius borderPill = BorderRadius.circular(pill);
}
