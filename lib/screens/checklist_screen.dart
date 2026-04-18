// lib/screens/checklist_screen.dart
// Interactive packing checklist for safari/Gir trip

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: Text('Packing Checklist',
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 22,
              letterSpacing: 0.4,
            )),
        backgroundColor: AppTheme.primaryGreen,
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: false,
        toolbarHeight: 68,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onPressed: () => state.clearChecklist(),
                  child: Text('Reset',
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                const SizedBox(width: 8),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onPressed: () => state.checkAllItems(total),
                  child: Text('All',
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress header
          _buildProgressHeader(context, checked, total),

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

  Widget _buildProgressHeader(BuildContext context, int checked, int total) {
    final pct = total == 0 ? 0.0 : checked / total;
    final isReady = checked == total;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryGreen.withValues(alpha: 0.12),
            AppTheme.primaryGreen.withValues(alpha: 0.06),
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: AppTheme.primaryGreen.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isReady ? '🎒 Ready to explore!' : 'Packing Progress',
                      style: GoogleFonts.playfairDisplay(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: isReady
                            ? AppTheme.primaryGreen
                            : AppTheme.primaryGreen,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isReady
                          ? 'All items packed successfully!'
                          : '$checked of $total items packed',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppTheme.primaryGreen.withValues(alpha: 0.75),
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.primaryGreen.withValues(alpha: 0.25),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      '${(pct * 100).round()}%',
                      style: GoogleFonts.playfairDisplay(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryGreen,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Complete',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryGreen.withValues(alpha: 0.7),
                        fontSize: 10,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 12,
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: (MediaQuery.of(context).size.width * pct - 36)
                          .clamp(0, double.infinity),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppTheme.primaryGreen,
                            AppTheme.lightGreen,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
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
      margin: const EdgeInsets.fromLTRB(14, 12, 14, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      color: Colors.white,
      child: Column(
        children: [
          // Category header
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    allDone
                        ? AppTheme.primaryGreen.withValues(alpha: 0.08)
                        : cat.color.withValues(alpha: 0.08),
                    allDone
                        ? AppTheme.primaryGreen.withValues(alpha: 0.03)
                        : cat.color.withValues(alpha: 0.03),
                  ],
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            (allDone ? AppTheme.primaryGreen : cat.color)
                                .withValues(alpha: 0.2),
                            (allDone ? AppTheme.primaryGreen : cat.color)
                                .withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: (allDone ? AppTheme.primaryGreen : cat.color)
                              .withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        allDone ? Icons.check_circle : cat.icon,
                        color: allDone ? AppTheme.primaryGreen : cat.color,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cat.category,
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: allDone
                                    ? AppTheme.primaryGreen
                                    : AppTheme.primaryBrown,
                                letterSpacing: 0.2,
                              )),
                          const SizedBox(height: 3),
                          Text('$checkedInCat / ${cat.items.length} packed',
                              style: TextStyle(
                                  color: allDone
                                      ? AppTheme.primaryGreen
                                          .withValues(alpha: 0.7)
                                      : AppTheme.lightBrown,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.1)),
                        ],
                      ),
                    ),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.expand_more,
                        color: allDone
                            ? AppTheme.primaryGreen.withValues(alpha: 0.6)
                            : AppTheme.lightBrown.withValues(alpha: 0.7),
                        size: 26,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Items
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: [
                Divider(
                  color: AppTheme.primaryBrown.withValues(alpha: 0.08),
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                Column(
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
              ],
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
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
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Animated checkbox
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                gradient: isChecked
                    ? LinearGradient(
                        colors: [
                          categoryColor,
                          categoryColor.withValues(alpha: 0.8),
                        ],
                      )
                    : null,
                color: isChecked ? null : Colors.transparent,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: isChecked
                      ? categoryColor
                      : AppTheme.lightBrown.withValues(alpha: 0.4),
                  width: 2,
                ),
                boxShadow: isChecked
                    ? [
                        BoxShadow(
                          color: categoryColor.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: isChecked
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
            const SizedBox(width: 14),

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
                            fontSize: 13.5,
                            color: isChecked
                                ? AppTheme.lightBrown.withValues(alpha: 0.65)
                                : AppTheme.primaryBrown,
                            decoration: isChecked
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationThickness: 1.5,
                            fontWeight:
                                isChecked ? FontWeight.w500 : FontWeight.w500,
                            height: 1.4,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                      if (item.isEssential)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.red.withValues(alpha: 0.15),
                                Colors.red.withValues(alpha: 0.08),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.red.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Text('Must',
                              style: GoogleFonts.playfairDisplay(
                                color: Colors.red.withValues(alpha: 0.85),
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                              )),
                        ),
                    ],
                  ),
                  if (item.note != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(item.note!,
                          style: TextStyle(
                              fontSize: 11.5,
                              color: AppTheme.lightBrown.withValues(alpha: 0.7),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              letterSpacing: 0.1)),
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
