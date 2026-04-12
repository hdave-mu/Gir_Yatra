// lib/screens/checklist_screen.dart
// Interactive packing checklist for safari/Gir trip

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/extra_data.dart';
import '../state/app_state.dart';

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateProvider.of(context);
    final total = allChecklistItems.length;
    final checked = state.checkedCount;

    return Scaffold(
      backgroundColor: AppTheme.beige,
      appBar: AppBar(
        title: const Text('✅ Packing Checklist'),
        backgroundColor: const Color(0xFF1565C0),
        actions: [
          TextButton(
            onPressed: () => state.clearChecklist(),
            child: const Text('Reset',
                style: TextStyle(color: Colors.white70, fontSize: 13)),
          ),
          TextButton(
            onPressed: () => state.checkAllItems(total),
            child: const Text('All',
                style: TextStyle(color: Colors.white, fontSize: 13,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress header
          _buildProgressHeader(checked, total),

          // Categories
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 32),
              itemCount: checklistCategories.length,
              itemBuilder: (ctx, catIdx) {
                // Compute global start index for this category
                int startIdx = 0;
                for (int i = 0; i < catIdx; i++) {
                  startIdx += checklistCategories[i].items.length;
                }
                return _ChecklistCategory(
                  category: checklistCategories[catIdx],
                  startIndex: startIdx,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressHeader(int checked, int total) {
    final pct = total == 0 ? 0.0 : checked / total;
    final isReady = checked == total;

    return Container(
      color: AppTheme.warmWhite,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isReady ? '🎒 All packed! Ready to go!' : '$checked of $total items packed',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: isReady ? AppTheme.primaryGreen : AppTheme.primaryBrown,
                ),
              ),
              Text(
                '${(pct * 100).round()}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isReady ? AppTheme.primaryGreen : AppTheme.primaryBrown,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              backgroundColor: AppTheme.primaryBrown.withOpacity(0.15),
              color: isReady ? AppTheme.primaryGreen : const Color(0xFF1565C0),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChecklistCategory extends StatefulWidget {
  final ChecklistCategory category;
  final int startIndex;

  const _ChecklistCategory({
    required this.category,
    required this.startIndex,
  });

  @override
  State<_ChecklistCategory> createState() => _ChecklistCategoryState();
}

class _ChecklistCategoryState extends State<_ChecklistCategory> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    final state = AppStateProvider.of(context);
    final cat = widget.category;
    final checkedInCat = List.generate(cat.items.length, (i) {
      return state.isChecked(widget.startIndex + i);
    }).where((v) => v).length;
    final allDone = checkedInCat == cat.items.length;

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Column(
        children: [
          // Category header
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: allDone
                          ? AppTheme.primaryGreen.withOpacity(0.15)
                          : cat.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      allDone ? Icons.check_circle : cat.icon,
                      color: allDone ? AppTheme.primaryGreen : cat.color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cat.category,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: allDone
                                    ? AppTheme.primaryGreen
                                    : AppTheme.primaryBrown)),
                        Text('$checkedInCat / ${cat.items.length} packed',
                            style: TextStyle(
                                color: allDone
                                    ? AppTheme.primaryGreen
                                    : AppTheme.lightBrown,
                                fontSize: 11)),
                      ],
                    ),
                  ),
                  Icon(_expanded ? Icons.expand_less : Icons.expand_more,
                      color: AppTheme.lightBrown),
                ],
              ),
            ),
          ),

          // Items
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: List.generate(cat.items.length, (i) {
                final globalIdx = widget.startIndex + i;
                final item = cat.items[i];
                return _ChecklistItemTile(
                  item: item,
                  globalIndex: globalIdx,
                  categoryColor: cat.color,
                );
              }),
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 220),
          ),
        ],
      ),
    );
  }
}

class _ChecklistItemTile extends StatelessWidget {
  final ChecklistItem item;
  final int globalIndex;
  final Color categoryColor;

  const _ChecklistItemTile({
    required this.item,
    required this.globalIndex,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    final state = AppStateProvider.of(context);
    final isChecked = state.isChecked(globalIndex);

    return InkWell(
      onTap: () => state.toggleChecklistItem(globalIndex),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 6, 14, 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom checkbox
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              margin: const EdgeInsets.only(top: 1),
              decoration: BoxDecoration(
                color: isChecked ? categoryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isChecked
                      ? categoryColor
                      : AppTheme.lightBrown.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              child: isChecked
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            const SizedBox(width: 12),

            // Text + essential badge
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.item,
                          style: TextStyle(
                            fontSize: 13,
                            color: isChecked
                                ? AppTheme.lightBrown
                                : AppTheme.primaryBrown,
                            decoration: isChecked
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            height: 1.3,
                          ),
                        ),
                      ),
                      if (item.isEssential)
                        Container(
                          margin: const EdgeInsets.only(left: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('Must',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                  if (item.note != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(item.note!,
                          style: TextStyle(
                              fontSize: 11,
                              color: AppTheme.lightBrown.withOpacity(0.8),
                              fontStyle: FontStyle.italic)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
