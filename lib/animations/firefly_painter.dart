// lib/animations/firefly_painter.dart
// Optimized firefly particle system — pre-allocated paints, reduced draw calls.
// Wrapped in RepaintBoundary with isComplex=true for GPU layer caching.

import 'dart:math' as math;
import 'package:flutter/material.dart';

class Firefly {
  double x;
  double y;
  double radius;
  double opacity;
  double speed;
  double drift;
  double phase;

  Firefly({
    required this.x,
    required this.y,
    required this.radius,
    required this.opacity,
    required this.speed,
    required this.drift,
    required this.phase,
  });
}

class FireflyPainter extends CustomPainter {
  final double animationValue;
  final List<Firefly> fireflies;
  final Color glowColor;

  // Pre-allocated paint objects — avoids GC pressure every frame
  static final Paint _glowPaint = Paint()
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
  static final Paint _corePaint = Paint();

  FireflyPainter({
    required this.animationValue,
    required this.fireflies,
    this.glowColor = const Color(0xFFFFD54F),
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final fly in fireflies) {
      final t = (animationValue + fly.phase) % 1.0;

      // Organic vertical float
      final yOffset = math.sin(t * math.pi * 2 * fly.speed) * 25;
      // Horizontal drift
      final xOffset = math.cos(t * math.pi * 2 * fly.drift) * 15;

      final cx = fly.x * size.width + xOffset;
      final cy = fly.y * size.height + yOffset;

      // Pulsing opacity
      final pulse = (math.sin(t * math.pi * 2) + 1) * 0.5;
      final currentOpacity = fly.opacity * (0.3 + pulse * 0.7);

      // Outer glow — single draw call
      _glowPaint.color = glowColor.withValues(alpha: currentOpacity * 0.25);
      canvas.drawCircle(Offset(cx, cy), fly.radius * 3.5, _glowPaint);

      // Core dot — skip inner glow for perf (barely visible at this size)
      _corePaint.color = Colors.white.withValues(alpha: currentOpacity);
      canvas.drawCircle(Offset(cx, cy), fly.radius, _corePaint);
    }
  }

  @override
  bool shouldRepaint(FireflyPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;

  /// Hint to framework: this layer is complex and should be cached as a texture.
  bool get isComplex => true;
}

/// Creates a list of randomized fireflies.
/// Reduced default count from 25 to 18 for better frame budget.
List<Firefly> generateFireflies({int count = 18}) {
  final rng = math.Random(42); // Fixed seed for consistency
  return List.generate(count, (_) {
    return Firefly(
      x: rng.nextDouble(),
      y: rng.nextDouble(),
      radius: 1.0 + rng.nextDouble() * 1.2,
      opacity: 0.3 + rng.nextDouble() * 0.6,
      speed: 0.3 + rng.nextDouble() * 0.5,
      drift: 0.2 + rng.nextDouble() * 0.4,
      phase: rng.nextDouble(),
    );
  });
}
