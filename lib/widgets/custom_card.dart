// lib/widgets/custom_card.dart
// Reusable card and UI widgets for Gir Yatra

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ── Section Header ────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        (iconColor ?? AppTheme.primaryGreen).withOpacity(0.2),
                        (iconColor ?? AppTheme.primaryGreen).withOpacity(0.08),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (iconColor ?? AppTheme.primaryGreen)
                          .withOpacity(0.15),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: iconColor ?? AppTheme.primaryGreen,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.3,
                              ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.lightBrown,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 3,
            width: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  iconColor ?? AppTheme.primaryGreen,
                  (iconColor ?? AppTheme.primaryGreen).withOpacity(0.4),
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: (iconColor ?? AppTheme.primaryGreen).withOpacity(0.15),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Info Row Tile ─────────────────────────────────────────────
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: iconColor ?? AppTheme.primaryGreen),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Quick Fact Chip ───────────────────────────────────────────
class QuickFactChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const QuickFactChip({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = color.withOpacity(0.08);
    final borderColor = color.withOpacity(0.25);
    final labelColor = color.withOpacity(0.7);

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 3),
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  height: 1.0,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 1),
              Text(
                label,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 9,
                  height: 1.0,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Eco Tip Card ──────────────────────────────────────────────
class EcoTipCard extends StatelessWidget {
  final String tip;
  final int index;

  const EcoTipCard({super.key, required this.tip, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.accentGreen.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.accentGreen.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              color: AppTheme.primaryGreen,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.primaryBrown,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
