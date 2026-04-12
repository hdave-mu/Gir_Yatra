// lib/screens/seasonal_screen.dart
// Month-by-month seasonal guide — best time to visit, weather, events

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/extra_data.dart';

class SeasonalScreen extends StatefulWidget {
  const SeasonalScreen({super.key});

  @override
  State<SeasonalScreen> createState() => _SeasonalScreenState();
}

class _SeasonalScreenState extends State<SeasonalScreen> {
  // Auto-select current month
  int _selectedMonth = DateTime.now().month;

  MonthInfo get _selected =>
      seasonalCalendar.firstWhere((m) => m.monthIndex == _selectedMonth);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.beige,
      appBar: AppBar(
        title: const Text('📅 Seasonal Guide'),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: Column(
        children: [
          // Month selector strip
          _buildMonthStrip(),

          // Month detail
          Expanded(
            child: _buildMonthDetail(_selected),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthStrip() {
    return Container(
      color: AppTheme.warmWhite,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: seasonalCalendar.map((m) {
            final isSelected = m.monthIndex == _selectedMonth;
            return GestureDetector(
              onTap: () => setState(() => _selectedMonth = m.monthIndex),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? m.statusColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? m.statusColor
                        : m.statusColor.withOpacity(0.3),
                    width: isSelected ? 0 : 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(m.shortMonth,
                        style: TextStyle(
                          color: isSelected ? Colors.white : m.statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        )),
                    const SizedBox(height: 2),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withOpacity(0.6)
                            : m.statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMonthDetail(MonthInfo m) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Month hero card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [m.statusColor, m.statusColor.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(m.month,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      m.isOpen ? 'Forest Open ✓' : 'Forest Closed ✗',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _infoBadge(Icons.thermostat_outlined, m.temperature),
                  const SizedBox(width: 10),
                  _infoBadge(Icons.cloud_outlined, m.weather),
                ],
              ),
              const SizedBox(height: 8),
              _infoBadge(Icons.people_outlined, 'Crowd: ${m.crowdLevel}'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Wildlife activity
        _infoCard(
          icon: Icons.pets,
          title: 'Wildlife Activity',
          content: m.wildlifeActivity,
          color: AppTheme.primaryGreen,
        ),

        const SizedBox(height: 10),

        // Special events
        _infoCard(
          icon: Icons.celebration,
          title: 'Special Events',
          content: m.specialEvents,
          color: const Color(0xFF6A1B9A),
        ),

        const SizedBox(height: 10),

        // Forest status
        _infoCard(
          icon: Icons.forest,
          title: 'Forest Status',
          content: m.forestStatus,
          color: m.isOpen ? AppTheme.primaryGreen : Colors.red,
        ),

        const SizedBox(height: 14),

        // Highlights
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: m.statusColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: m.statusColor.withOpacity(0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: m.statusColor, size: 18),
                  const SizedBox(width: 8),
                  Text('Month Highlights',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: m.statusColor,
                          fontSize: 14)),
                ],
              ),
              const SizedBox(height: 10),
              ...m.highlights.map((h) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle,
                            color: m.statusColor, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(h,
                              style: TextStyle(
                                  color: m.statusColor.withOpacity(0.85),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Annual pattern legend
        _buildAnnualLegend(),
      ],
    );
  }

  Widget _infoBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 5),
          Text(text,
              style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _infoCard(
      {required IconData icon,
      required String title,
      required String content,
      required Color color}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.warmWhite,
        borderRadius: BorderRadius.circular(14),
        border:
            Border.all(color: AppTheme.primaryBrown.withOpacity(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                        fontSize: 13)),
                const SizedBox(height: 3),
                Text(content,
                    style: const TextStyle(
                        color: AppTheme.primaryBrown,
                        fontSize: 13,
                        height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnualLegend() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.warmWhite,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Annual Pattern',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryBrown,
                  fontSize: 13)),
          const SizedBox(height: 10),
          Row(
            children: seasonalCalendar.map((m) {
              final isSelected = m.monthIndex == _selectedMonth;
              return Expanded(
                child: GestureDetector(
                  onTap: () =>
                      setState(() => _selectedMonth = m.monthIndex),
                  child: Tooltip(
                    message: m.month,
                    child: Container(
                      height: 28,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: m.statusColor.withOpacity(
                            m.isOpen ? 0.75 : 0.35),
                        borderRadius: BorderRadius.circular(4),
                        border: isSelected
                            ? Border.all(
                                color: AppTheme.primaryBrown, width: 2)
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        m.shortMonth[0],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendDot(AppTheme.primaryGreen, 'Best season'),
              const SizedBox(width: 16),
              _legendDot(AppTheme.goldenAmber, 'Good — hot'),
              const SizedBox(width: 16),
              _legendDot(Colors.red, 'Closed'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label,
            style:
                const TextStyle(fontSize: 11, color: AppTheme.lightBrown)),
      ],
    );
  }
}
