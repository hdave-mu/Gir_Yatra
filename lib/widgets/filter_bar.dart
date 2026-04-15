// lib/widgets/filter_bar.dart
// Horizontal filter chips + optional sort dropdown.
// Reusable across Hotels and Nearby Places screens.

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FilterBar extends StatelessWidget {
  final List<String> filters;
  final String selected;
  final ValueChanged<String> onSelected;
  final String? sortLabel;
  final List<String>? sortOptions;
  final ValueChanged<String>? onSortChanged;

  const FilterBar({
    super.key,
    required this.filters,
    required this.selected,
    required this.onSelected,
    this.sortLabel,
    this.sortOptions,
    this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.warmWhite,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: filters.map((f) {
                  final isSelected = selected == f;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(f),
                      selected: isSelected,
                      onSelected: (_) => onSelected(f),
                      selectedColor: AppTheme.primaryGreen,
                      labelStyle: TextStyle(
                        color:
                            isSelected ? Colors.white : AppTheme.primaryBrown,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      side: BorderSide(
                        color: isSelected
                            ? AppTheme.primaryGreen
                            : AppTheme.softBorder,
                        width: isSelected ? 0 : 1.2,
                      ),
                      backgroundColor: isSelected ? null : AppTheme.warmWhite,
                      elevation: isSelected ? 2 : 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          if (sortOptions != null && sortOptions!.isNotEmpty) ...[
            const SizedBox(width: 8),
            _SortMenu(
              label: sortLabel ?? 'Sort',
              options: sortOptions!,
              onChanged: onSortChanged ?? (_) {},
            ),
          ],
        ],
      ),
    );
  }
}

class _SortMenu extends StatelessWidget {
  final String label;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const _SortMenu({
    required this.label,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Sort options',
      onSelected: onChanged,
      itemBuilder: (_) => options
          .map((o) => PopupMenuItem<String>(value: o, child: Text(o)))
          .toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen.withOpacity(0.08),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
              color: AppTheme.primaryGreen.withOpacity(0.3), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryGreen.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.tune, size: 15, color: AppTheme.primaryGreen),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: AppTheme.primaryGreen,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Rating badge — small reusable widget for hotel / place cards.
class RatingBadge extends StatelessWidget {
  final double rating;
  final int? reviews;
  final bool compact;

  const RatingBadge({
    super.key,
    required this.rating,
    this.reviews,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final colour = rating >= 4.5
        ? const Color(0xFF1B5E20)
        : rating >= 4.0
            ? AppTheme.primaryGreen
            : AppTheme.goldenAmber;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: compact ? 8 : 10, vertical: compact ? 4 : 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colour.withOpacity(0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: colour.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, size: compact ? 13 : 15, color: colour),
          const SizedBox(width: 3),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              color: colour,
              fontWeight: FontWeight.w800,
              fontSize: compact ? 11.5 : 13,
              letterSpacing: 0.2,
            ),
          ),
          if (reviews != null && reviews! > 0 && !compact) ...[
            const SizedBox(width: 5),
            Text(
              '($reviews)',
              style: TextStyle(
                color: colour.withOpacity(0.75),
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
