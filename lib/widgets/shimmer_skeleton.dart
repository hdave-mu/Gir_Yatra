// lib/widgets/shimmer_skeleton.dart
// Premium shimmer loading skeletons for cards, images, and lists.

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_theme.dart';

/// Generic shimmer placeholder that can mimic any shape.
class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.softBorder.withValues(alpha: 0.5),
      highlightColor: AppTheme.warmWhite,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppTheme.softBorder,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// Shimmer skeleton for a feature card in the grid.
class ShimmerFeatureCard extends StatelessWidget {
  const ShimmerFeatureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.softBorder.withValues(alpha: 0.5),
      highlightColor: AppTheme.warmWhite,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.softBorder,
          borderRadius: BorderRadius.circular(22),
        ),
      ),
    );
  }
}

/// Shimmer skeleton for a list card (hotel, place, etc.).
class ShimmerListCard extends StatelessWidget {
  const ShimmerListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.softBorder.withValues(alpha: 0.5),
      highlightColor: AppTheme.warmWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: AppTheme.softBorder,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

/// Shimmer skeleton for horizontal carousel items.
class ShimmerCarouselCard extends StatelessWidget {
  const ShimmerCarouselCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.softBorder.withValues(alpha: 0.5),
      highlightColor: AppTheme.warmWhite,
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: AppTheme.softBorder,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

/// Wraps content with a shimmer → real content transition.
class ShimmerToContent extends StatefulWidget {
  final Widget child;
  final Widget shimmer;
  final Duration delay;

  const ShimmerToContent({
    super.key,
    required this.child,
    required this.shimmer,
    this.delay = const Duration(milliseconds: 600),
  });

  @override
  State<ShimmerToContent> createState() => _ShimmerToContentState();
}

class _ShimmerToContentState extends State<ShimmerToContent> {
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _showContent = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: _showContent ? widget.child : widget.shimmer,
    );
  }
}
