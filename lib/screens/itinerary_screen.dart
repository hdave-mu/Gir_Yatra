// lib/screens/itinerary_screen.dart
// Smart Itinerary Screen — 1-Day and 2-Day plans in timeline format

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/static_data.dart';

class ItineraryScreen extends StatefulWidget {
  const ItineraryScreen({super.key});

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.beige,
      appBar: AppBar(
        title: Text('Itinerary Planner',
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 26,
              letterSpacing: 0.5,
            )),
        backgroundColor: AppTheme.primaryGreen,
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: false,
        toolbarHeight: 76,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryGreen,
                AppTheme.primaryGreen.withValues(alpha: 0.85),
              ],
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 28),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withValues(alpha: 0.5),
              labelStyle: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                letterSpacing: 0.3,
              ),
              unselectedLabelStyle: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                letterSpacing: 0.2,
              ),
              dividerColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              tabs: const [
                Tab(
                  icon: Icon(Icons.looks_one_outlined, size: 20),
                  text: '1-Day Plan',
                  iconMargin: EdgeInsets.only(bottom: 6),
                ),
                Tab(
                  icon: Icon(Icons.looks_two_outlined, size: 20),
                  text: '2-Day Plan',
                  iconMargin: EdgeInsets.only(bottom: 6),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ItineraryDayView(plans: oneDayItinerary),
          _ItineraryDayView(plans: twoDayItinerary),
        ],
      ),
    );
  }
}

class _ItineraryDayView extends StatelessWidget {
  final List<ItineraryDay> plans;

  const _ItineraryDayView({required this.plans});

  @override
  Widget build(BuildContext context) {
    return ListView(
      cacheExtent: 600,
      padding: const EdgeInsets.only(bottom: 32),
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: [
        // Overview banner
        _buildOverviewBanner(plans),

        // Days
        ...plans.map((day) => _DayTimeline(day: day)),

        // Footer tips
        _buildFooterTips(),
      ],
    );
  }

  Widget _buildOverviewBanner(List<ItineraryDay> plans) {
    final isOneDay = plans.length == 1;
    final totalSteps = plans.fold<int>(0, (sum, d) => sum + d.steps.length);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E5902), Color(0xFF558B2F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF558B2F).withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Text(
              isOneDay ? '☀️' : '🌅',
              style: const TextStyle(fontSize: 44),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isOneDay ? '1-Day Adventure' : '2-Day Expedition',
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  plans.map((d) => d.theme).join(' · '),
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.88),
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _StatBadge(
                        label:
                            '${plans.length} Day${plans.length > 1 ? 's' : ''}'),
                    const SizedBox(width: 8),
                    _StatBadge(label: '$totalSteps Stops'),
                    const SizedBox(width: 8),
                    const _StatBadge(label: 'Offline Ready'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterTips() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryGreen.withValues(alpha: 0.12),
            AppTheme.primaryGreen.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryGreen.withValues(alpha: 0.25),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.lightbulb_outline,
                  color: AppTheme.primaryGreen,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Planning Tips',
                style: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryGreen,
                  fontSize: 15,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _note('📅 Book safari 2–3 days in advance during peak season'),
          _note('⏱️ Add 30 min buffer between activities for travel'),
          _note('📱 Download itinerary offline before forest entry'),
          _note('🗺️ Distances approximate — actual time may vary'),
        ],
      ),
    );
  }

  Widget _note(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 2),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.5,
                color: AppTheme.primaryBrown.withValues(alpha: 0.85),
                height: 1.6,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Day Timeline Widget ────────────────────────────────────────
class _DayTimeline extends StatelessWidget {
  final ItineraryDay day;

  const _DayTimeline({required this.day});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Day header
        Container(
          margin: const EdgeInsets.fromLTRB(16, 18, 16, 14),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
                color: AppTheme.primaryBrown.withValues(alpha: 0.12),
                width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 6,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryBrown,
                      AppTheme.primaryBrown.withValues(alpha: 0.85),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryBrown.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Day ${day.day}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day.title,
                      style: GoogleFonts.playfairDisplay(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryBrown,
                        fontSize: 17,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      day.theme,
                      style: TextStyle(
                        color: AppTheme.lightBrown.withValues(alpha: 0.8),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.15,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryGreen.withValues(alpha: 0.15),
                      AppTheme.primaryGreen.withValues(alpha: 0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.25),
                      width: 1.2),
                ),
                child: Text(
                  '${day.steps.length} Stops',
                  style: const TextStyle(
                    color: AppTheme.primaryGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Timeline steps
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 16),
          child: Column(
            children: List.generate(day.steps.length, (index) {
              final step = day.steps[index];
              final isLast = index == day.steps.length - 1;
              return _TimelineStep(step: step, isLast: isLast, index: index);
            }),
          ),
        ),
      ],
    );
  }
}

class _TimelineStep extends StatefulWidget {
  final ItineraryStep step;
  final bool isLast;
  final int index;

  const _TimelineStep({
    required this.step,
    required this.isLast,
    required this.index,
  });

  @override
  State<_TimelineStep> createState() => _TimelineStepState();
}

class _TimelineStepState extends State<_TimelineStep> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line & dot
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: widget.step.color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: widget.step.color.withValues(alpha: 0.35),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(widget.step.icon, color: Colors.white, size: 16),
              ),
              if (!widget.isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: widget.step.color.withValues(alpha: 0.25),
                    margin: const EdgeInsets.symmetric(vertical: 3),
                  ),
                ),
              if (widget.isLast) const SizedBox(height: 16),
            ],
          ),

          const SizedBox(width: 12),

          // Content card
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _isExpanded
                        ? widget.step.color.withValues(alpha: 0.35)
                        : Colors.transparent,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _isExpanded
                          ? widget.step.color.withValues(alpha: 0.15)
                          : Colors.black.withValues(alpha: 0.05),
                      blurRadius: _isExpanded ? 10 : 6,
                      offset:
                          _isExpanded ? const Offset(0, 3) : const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 15, 14, 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color:
                                      widget.step.color.withValues(alpha: 0.18),
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: widget.step.color
                                          .withValues(alpha: 0.25),
                                      width: 1),
                                ),
                                child: Text(
                                  widget.step.time,
                                  style: TextStyle(
                                    color: widget.step.color,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.15,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  widget.step.activity,
                                  style: GoogleFonts.playfairDisplay(
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.primaryBrown,
                                    fontSize: 15,
                                    letterSpacing: 0.1,
                                  ),
                                ),
                              ),
                              AnimatedRotation(
                                turns: _isExpanded ? 0.5 : 0,
                                duration: const Duration(milliseconds: 300),
                                child: Icon(
                                  Icons.expand_more,
                                  color:
                                      widget.step.color.withValues(alpha: 0.55),
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.place_outlined,
                                size: 13,
                                color:
                                    AppTheme.lightBrown.withValues(alpha: 0.75),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                widget.step.location,
                                style: TextStyle(
                                  color: AppTheme.lightBrown
                                      .withValues(alpha: 0.8),
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Expanded description
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: Container(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              color: widget.step.color.withValues(alpha: 0.15),
                              height: 14,
                              thickness: 1,
                            ),
                            Text(
                              widget.step.description,
                              style: TextStyle(
                                color: AppTheme.primaryBrown
                                    .withValues(alpha: 0.85),
                                fontSize: 13,
                                height: 1.6,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      crossFadeState: _isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 250),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String label;

  const _StatBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}
