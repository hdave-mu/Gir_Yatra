// lib/screens/itinerary_screen.dart
// Smart Itinerary Screen — 1-Day and 2-Day plans in timeline format

import 'package:flutter/material.dart';
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
        title: const Text('🗓️ Itinerary Planner',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              letterSpacing: 0.3,
            )),
        backgroundColor: const Color(0xFF558B2F),
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: false,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
          tabs: const [
            Tab(
              icon: Icon(Icons.looks_one_outlined),
              text: '1-Day Plan',
            ),
            Tab(
              icon: Icon(Icons.looks_two_outlined),
              text: '2-Day Plan',
            ),
          ],
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
      padding: const EdgeInsets.only(bottom: 32),
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E5902), Color(0xFF558B2F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF558B2F).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            isOneDay ? '☀️' : '🌅',
            style: const TextStyle(fontSize: 48),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isOneDay ? '1-Day Adventure' : '2-Day Expedition',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  plans.map((d) => d.theme).join(' · '),
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 8),
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.eco, color: AppTheme.primaryGreen, size: 18),
              SizedBox(width: 8),
              Text(
                'Planning Notes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _note('Book safari at least 2–3 days in advance during peak season'),
          _note('Keep a buffer of 30 min between activities for travel time'),
          _note('Download this itinerary offline before entering the forest'),
          _note('Distances are approximate — actual drive time may vary'),
        ],
      ),
    );
  }

  Widget _note(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: AppTheme.primaryGreen)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 12, color: AppTheme.primaryBrown, height: 1.4),
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
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.primaryBrown.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.primaryBrown.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: AppTheme.primaryBrown,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'D${day.day}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryBrown,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      day.theme,
                      style: const TextStyle(
                        color: AppTheme.lightBrown,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${day.steps.length} stops',
                style: const TextStyle(
                  color: AppTheme.primaryGreen,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
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
                      color: widget.step.color.withOpacity(0.35),
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
                    color: widget.step.color.withOpacity(0.25),
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
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: AppTheme.warmWhite,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _isExpanded
                        ? widget.step.color.withOpacity(0.4)
                        : Colors.transparent,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 3),
                                decoration: BoxDecoration(
                                  color: widget.step.color.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  widget.step.time,
                                  style: TextStyle(
                                    color: widget.step.color,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  widget.step.activity,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryBrown,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Icon(
                                _isExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: AppTheme.lightBrown,
                                size: 18,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.place_outlined,
                                size: 12,
                                color: AppTheme.lightBrown,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                widget.step.location,
                                style: const TextStyle(
                                  color: AppTheme.lightBrown,
                                  fontSize: 11,
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
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              color: widget.step.color.withOpacity(0.2),
                              height: 12,
                            ),
                            Text(
                              widget.step.description,
                              style: const TextStyle(
                                color: AppTheme.primaryBrown,
                                fontSize: 13,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      crossFadeState: _isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 200),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}
