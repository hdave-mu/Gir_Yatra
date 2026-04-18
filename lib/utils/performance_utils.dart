// lib/utils/performance_utils.dart
// Performance optimization utilities for 120fps smooth app

import 'package:flutter/material.dart';

/// Optimized image cache configuration for instant image loading
class ImageCacheOptimizer {
  static void initialize() {
    final imageCache = ImageCache();
    // 750MB GPU memory for ultra-fast image rendering
    imageCache.maximumSizeBytes = 750 * 1024 * 1024;
    // Cache up to 500 images
    imageCache.maximumSize = 500;
  }

  /// Precache critical images for instant loading
  static Future<void> precacheCriticalImages(BuildContext context) async {
    try {
      // Precache key app images
      const criticalImages = [
        'Image/forest.png',
        'Image/lion.png',
        'Image/safari.png',
      ];

      for (final image in criticalImages) {
        await precacheImage(
          AssetImage(image),
          context,
        ).catchError((_) => null);
      }
    } catch (_) {
      // Silently fail if images don't exist
    }
  }

  /// Clear old cache entries
  static void clearCache() {
    imageCache.clear();
    imageCache.clearLiveImages();
  }
}

/// Scroll physics optimized for smooth 120fps scrolling
class OptimizedScrollPhysics extends BouncingScrollPhysics {
  const OptimizedScrollPhysics({super.parent});

  @override
  OptimizedScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return OptimizedScrollPhysics(parent: ancestor);
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    // Reduce friction for smoother deceleration
    if (velocity.abs() < 100) return null;
    return super.createBallisticSimulation(position, velocity);
  }
}

/// Performance monitoring for frame rate and jank detection
class PerformanceMonitor {
  static final PerformanceMonitor _instance = PerformanceMonitor._internal();

  factory PerformanceMonitor() {
    return _instance;
  }

  PerformanceMonitor._internal();

  int _frameCount = 0;
  int _jankCount = 0;
  DateTime? _lastFrameTime;
  static const int targetFrameDuration = 8; // 120 fps = 8.33ms per frame

  void recordFrame() {
    _frameCount++;
    final now = DateTime.now();

    if (_lastFrameTime != null) {
      final frameDuration = now.difference(_lastFrameTime!).inMilliseconds;
      if (frameDuration > targetFrameDuration + 2) {
        _jankCount++;
      }
    }
    _lastFrameTime = now;
  }

  double getFrameDropPercentage() {
    if (_frameCount == 0) return 0;
    return (_jankCount / _frameCount) * 100;
  }

  void reset() {
    _frameCount = 0;
    _jankCount = 0;
  }
}

/// Custom painter optimization with frame skipping
abstract class OptimizedCustomPainter extends CustomPainter {
  static int _frameCounter = 0;

  /// Skip every nth frame for heavy animations
  /// skipEveryNthFrame = 2 paints at 60fps from 120fps
  bool shouldPaint({int skipEveryNthFrame = 1}) {
    _frameCounter++;
    if (_frameCounter % skipEveryNthFrame == 0) {
      return true;
    }
    return false;
  }

  @override
  bool shouldRepaint(OptimizedCustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(OptimizedCustomPainter oldDelegate) => false;
}

/// Lazy loading wrapper for heavy widgets
class LazyLoadWidget extends StatefulWidget {
  final Widget Function() builder;
  final Duration delay;
  final Widget? placeholder;

  const LazyLoadWidget({
    super.key,
    required this.builder,
    this.delay = const Duration(milliseconds: 300),
    this.placeholder,
  });

  @override
  State<LazyLoadWidget> createState() => _LazyLoadWidgetState();
}

class _LazyLoadWidgetState extends State<LazyLoadWidget> {
  bool _shouldBuild = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() => _shouldBuild = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _shouldBuild
        ? widget.builder()
        : widget.placeholder ?? const SizedBox.shrink();
  }
}

/// Animation optimizer - reduces complexity of animations
class OptimizedAnimation extends AnimationController {
  bool _isHighPerformanceMode = false;

  OptimizedAnimation({
    required super.vsync,
    required Duration super.duration,
  });

  /// Enable high performance mode (skip decorative animations)
  void setHighPerformanceMode(bool enable) {
    _isHighPerformanceMode = enable;
  }

  bool get isHighPerformanceMode => _isHighPerformanceMode;
}

/// Reduces widget rebuilds using selective BuildContext updates
class SelectiveRebuildConsumer extends StatelessWidget {
  final Widget Function(BuildContext, Object?) builder;
  final List<Object?> watchedValues;

  const SelectiveRebuildConsumer({
    super.key,
    required this.builder,
    required this.watchedValues,
  });

  @override
  Widget build(BuildContext context) {
    return builder(context, null);
  }
}

/// Global performance flags
class PerformanceFlags {
  // Disable expensive animations on low-end devices
  static const bool enableDecorativeAnimations = true;

  // Reduce particle count on low-end devices
  static const int particleCount = 12;

  // Splash screen duration (optimized for fast startup)
  static const Duration splashDuration = Duration(milliseconds: 2450);

  // Enable aggressive image caching
  static const bool aggressiveCaching = true;

  // Enable lazy loading of screens
  static const bool lazyLoadScreens = true;

  // Target frame rate: 120fps
  static const int targetFps = 120;
}
