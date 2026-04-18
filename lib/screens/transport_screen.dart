// lib/screens/transport_screen.dart
// How to reach Sasan Gir — all transport modes with real-life details

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/extra_data.dart';
import '../widgets/custom_card.dart';

class TransportScreen extends StatelessWidget {
  const TransportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.beige,
      appBar: AppBar(
        title: Text('🚌 How to Reach',
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              letterSpacing: 0.3,
            )),
        backgroundColor: AppTheme.primaryBrown,
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: false,
      ),
      body: ListView(
        cacheExtent: 600,
        padding: const EdgeInsets.only(bottom: 28),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          _buildHero(),
          const SectionHeader(
            title: 'Travel Options',
            subtitle: 'Choose your preferred mode',
            icon: Icons.route,
            iconColor: AppTheme.primaryBrown,
          ),
          ...transportOptions.map((t) => _TransportCard(option: t)),
          const SectionHeader(
            title: 'Nearest Stations & Airports',
            icon: Icons.place,
            iconColor: AppTheme.skyBlue,
          ),
          _buildStationGrid(),
          const SectionHeader(
            title: 'Distance from Sasan Gir',
            icon: Icons.map_outlined,
            iconColor: AppTheme.primaryGreen,
          ),
          _buildDistanceTable(),
          _buildLocalTransportTips(),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3E2723), Color(0xFF5D4037)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Text('🗺️', style: TextStyle(fontSize: 50)),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Getting to Sasan Gir',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                    'Gujarat, India · 390 km from Ahmedabad\n160 km from Rajkot Airport',
                    style: TextStyle(
                        color: Colors.white70, fontSize: 12, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStationGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2.6,
        ),
        itemCount: nearbyStations.length,
        itemBuilder: (_, i) {
          final s = nearbyStations[i];
          return Container(
            decoration: BoxDecoration(
              color: AppTheme.warmWhite,
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: AppTheme.primaryBrown.withValues(alpha: 0.15)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Icon(s.icon, size: 18, color: AppTheme.primaryBrown),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(s.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: AppTheme.primaryBrown),
                          overflow: TextOverflow.ellipsis),
                      Text(s.distance,
                          style: const TextStyle(
                              color: AppTheme.lightBrown, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDistanceTable() {
    final entries = distanceMatrix['Sasan Gir']!.entries.toList();
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: List.generate(entries.length, (i) {
            final e = entries[i];
            final pct = e.value / 400;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              child: Row(
                children: [
                  SizedBox(
                    width: 130,
                    child: Text(e.key,
                        style: const TextStyle(
                            fontSize: 13, color: AppTheme.primaryBrown)),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBrown.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: pct.clamp(0.05, 1.0),
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: _distColor(e.value),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('${e.value} km',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppTheme.primaryBrown)),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Color _distColor(int km) {
    if (km <= 50) return AppTheme.primaryGreen;
    if (km <= 100) return AppTheme.goldenAmber;
    return AppTheme.safariOrange;
  }

  Widget _buildLocalTransportTips() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.primaryGreen.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.electric_rickshaw, color: AppTheme.primaryGreen),
              SizedBox(width: 8),
              Text('Local Transport at Sasan Gir',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreen,
                      fontSize: 14)),
            ],
          ),
          const SizedBox(height: 10),
          _tip(
              'Auto-rickshaws available from Sasan village to Devalia (₹100–150)'),
          _tip('Taxis from Sasan to Somnath: ₹600–800'),
          _tip(
              'Forest dept. jeeps for official safaris — no private vehicles inside'),
          _tip(
              'Hire a local guide at ₹150–300 — worth every rupee for navigation'),
          _tip(
              'Self-drive is fine on paved roads, but use caution near forest buffer'),
        ],
      ),
    );
  }

  Widget _tip(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline,
              color: AppTheme.primaryGreen, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 13, color: AppTheme.primaryBrown, height: 1.4)),
          ),
        ],
      ),
    );
  }
}

class _TransportCard extends StatefulWidget {
  final TransportOption option;
  const _TransportCard({required this.option});

  @override
  State<_TransportCard> createState() => _TransportCardState();
}

class _TransportCardState extends State<_TransportCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final o = widget.option;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: InkWell(
        onTap: () => setState(() => _expanded = !_expanded),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: o.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(o.icon, color: o.color, size: 26),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(o.mode,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: o.color)),
                        Text(o.from,
                            style: const TextStyle(
                                color: AppTheme.lightBrown, fontSize: 12)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(o.duration,
                          style: TextStyle(
                              color: o.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                      Icon(_expanded ? Icons.expand_less : Icons.expand_more,
                          color: AppTheme.lightBrown, size: 20),
                    ],
                  ),
                ],
              ),
            ),

            // Quick chips
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
              child: Row(
                children: [
                  _Chip(Icons.route, o.distance, o.color),
                  const SizedBox(width: 8),
                  _Chip(Icons.currency_rupee, o.fare, AppTheme.goldenAmber),
                ],
              ),
            ),

            // Expanded detail
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: o.color.withValues(alpha: 0.2)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 14, color: o.color),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text('Frequency: ${o.frequency}',
                              style: const TextStyle(
                                  color: AppTheme.primaryBrown, fontSize: 13)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: o.color.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.tips_and_updates,
                              size: 14, color: o.color),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(o.tips,
                                style: const TextStyle(
                                    color: AppTheme.primaryBrown,
                                    fontSize: 12,
                                    height: 1.5)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState: _expanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 220),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const _Chip(this.icon, this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
            Expanded(
              child: Text(text,
                  style: TextStyle(
                      color: color, fontSize: 11, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
