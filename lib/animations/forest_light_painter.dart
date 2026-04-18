// lib/animations/forest_light_painter.dart
// Optimized dappled forest sunlight — reduced spots, pre-allocated objects.
// Uses saveLayer sparingly; paints directly to canvas for 120fps.

import 'dart:math' as math;
import 'package:flutter/material.dart';

class ForestLightPainter extends CustomPainter {
  final double animationValue;

  // Pre-allocate paint to avoid GC per frame
  static final Paint _spotPaint = Paint();

  ForestLightPainter({required this.animationValue});

  // Reduced from 6 to 4 spots — less overdraw, still looks great
  static const _spots = <_LightSpot>[
    _LightSpot(0.25, 0.20, 0.30, Color(0xFFFFD54F), 0.8, 0.0),
    _LightSpot(0.70, 0.15, 0.22, Color(0xFFFFF176), 0.6, 0.3),
    _LightSpot(0.45, 0.55, 0.26, Color(0xFFFFE082), 0.7, 0.5),
    _LightSpot(0.15, 0.75, 0.20, Color(0xFFA5D6A7), 0.5, 0.7),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    for (final spot in _spots) {
      final t = (animationValue * spot.speed + spot.phase) % 1.0;

      // Organic movement — simplified trig
      final xShift = math.sin(t * 6.283) * size.width * 0.04;
      final yShift = math.cos(t * 4.398) * size.height * 0.025;

      final centerX = spot.x * size.width + xShift;
      final centerY = spot.y * size.height + yShift;

      final radius = spot.baseRadius * size.width;

      // Pulsing intensity
      final intensity = 0.025 + (math.sin(t * 6.283) + 1) * 0.015;

      final gradient = RadialGradient(
        center: Alignment(
          (centerX / size.width) * 2 - 1,
          (centerY / size.height) * 2 - 1,
        ),
        radius: radius / size.width,
        colors: [
          spot.color.withValues(alpha: intensity),
          spot.color.withValues(alpha: 0),
        ],
      );

      _spotPaint.shader = gradient.createShader(rect);
      canvas.drawRect(rect, _spotPaint);
    }
  }

  @override
  bool shouldRepaint(ForestLightPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;

  bool get isComplex => true;
}

class _LightSpot {
  final double x;
  final double y;
  final double baseRadius;
  final Color color;
  final double speed;
  final double phase;

  const _LightSpot(
      this.x, this.y, this.baseRadius, this.color, this.speed, this.phase);
}

/// Widget that wraps the ForestLightPainter with an animation controller.
/// Animation runs at a relaxed 10s cycle — saves CPU vs faster cycles.
class ForestLightOverlay extends StatefulWidget {
  final Widget? child;

  const ForestLightOverlay({super.key, this.child});

  @override
  State<ForestLightOverlay> createState() => _ForestLightOverlayState();
}

class _ForestLightOverlayState extends State<ForestLightOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Slower = fewer repaints
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => CustomPaint(
          isComplex: true,
          willChange: true,
          painter: ForestLightPainter(animationValue: _controller.value),
          child: child,
        ),
        child: widget.child,
      ),
    );
  }
}
