// lib/screens/safari_screen.dart
// Safari info — timings, zones, fees, rules, booking (girlion.gujarat.gov.in).

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/static_data.dart';
import '../widgets/custom_card.dart';
import '../widgets/contact_actions.dart';

class SafariScreen extends StatelessWidget {
  const SafariScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.beige,
      appBar: AppBar(
        title: Text('Safari Information',
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              letterSpacing: 0.3,
            )),
        backgroundColor: AppTheme.forestDepth,
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: false,
      ),
      body: ListView(
        cacheExtent: 600, // Pre-render offscreen content
        padding: const EdgeInsets.only(bottom: 28),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          _buildHero(context),
          const SectionHeader(
            title: 'Safari Timings',
            subtitle: 'Seasonal slots — based on the official Gir portal',
            icon: Icons.schedule,
          ),
          _buildTimings(),
          const SectionHeader(
            title: 'Safari Zones',
            subtitle: 'Pick a zone while booking',
            icon: Icons.map_outlined,
          ),
          _buildZones(),
          const SectionHeader(
            title: 'Permit Fees',
            subtitle: 'Weekday vs Weekend · up to 6 pax per permit',
            icon: Icons.currency_rupee,
            iconColor: AppTheme.goldenAmber,
          ),
          _buildPermitFees(),
          const SectionHeader(
            title: 'Vehicle & Guide',
            subtitle: 'Paid separately at Sinh Sadan',
            icon: Icons.directions_car,
            iconColor: AppTheme.safariOrange,
          ),
          _buildVehicleGuideFees(),
          const SectionHeader(
            title: 'How to Book',
            subtitle: 'Only girlion.gujarat.gov.in is official',
            icon: Icons.book_online,
            iconColor: AppTheme.skyBlue,
          ),
          _buildBooking(context),
          const SectionHeader(
            title: 'Best Season',
            icon: Icons.wb_sunny_outlined,
            iconColor: AppTheme.safariOrange,
          ),
          _buildSeason(),
          const SectionHeader(
            title: 'Guidelines',
            subtitle: 'Please respect the forest',
            icon: Icons.rule,
            iconColor: Colors.red,
          ),
          _buildRules(),
          _buildImportantNote(),
        ],
      ),
    );
  }

  // ── Hero ─────────────────────────────────────────────────────
  Widget _buildHero(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D3B1E), Color(0xFF1B5E20), Color(0xFF2E7D32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🦁', style: TextStyle(fontSize: 46)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gir National Park',
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Last wild refuge of the Asiatic Lion',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _PillChip(label: '1,412 sq km'),
              _PillChip(label: '674 Lions'),
              _PillChip(label: '300+ Bird species'),
            ],
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: () => launchWebsite(context, officialBookingUrl),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppTheme.primaryGreen,
            ),
            icon: const Icon(Icons.open_in_new, size: 16),
            label: const Text('Book on official portal'),
          ),
        ],
      ),
    );
  }

  Widget _buildTimings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: safariTimings.map((t) {
          final closed = t.session.toLowerCase().contains('closure');
          final color = closed ? Colors.red : AppTheme.primaryGreen;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(t.icon, color: color, size: 22),
              ),
              title: Text(
                t.session,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: AppTheme.textDark,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 13, color: AppTheme.lightBrown),
                      const SizedBox(width: 4),
                      Text(t.time,
                          style: const TextStyle(
                              color: AppTheme.primaryBrown, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month,
                          size: 13, color: AppTheme.lightBrown),
                      const SizedBox(width: 4),
                      Text(t.season,
                          style: const TextStyle(
                              color: AppTheme.lightBrown, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildZones() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: safariZones.map((z) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: z.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(z.icon, color: z.color, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(z.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: AppTheme.textDark,
                                )),
                            Text(z.code,
                                style: TextStyle(
                                  color: z.color,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    z.description,
                    style: const TextStyle(
                      color: AppTheme.primaryBrown,
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 10),
                  InfoRow(
                    icon: Icons.place_outlined,
                    label: 'Entry',
                    value: z.entryPoint,
                  ),
                  InfoRow(
                    icon: Icons.pets,
                    label: 'Expect',
                    value: z.highlight,
                    iconColor: z.color,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPermitFees() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: entryFees.map((f) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.goldenAmber.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      f.category,
                      style: const TextStyle(
                        color: AppTheme.goldenAmber,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _FeeLine(label: 'Permit', value: f.feePerPerson),
                  _FeeLine(label: 'Vehicle', value: f.vehicleFee),
                  _FeeLine(label: 'Guide', value: f.guideCharge),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildVehicleGuideFees() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _FeeListCard(
              title: 'Gypsy',
              icon: Icons.directions_car,
              color: AppTheme.safariOrange,
              lines: vehicleFees,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _FeeListCard(
              title: 'Guide',
              icon: Icons.person,
              color: AppTheme.primaryGreen,
              lines: guideFees,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBooking(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.skyBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified, color: AppTheme.skyBlue, size: 18),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'girlion.gujarat.gov.in',
                      style: TextStyle(
                        color: AppTheme.skyBlue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => launchWebsite(context, officialBookingUrl),
                    icon: const Icon(Icons.open_in_new, size: 14),
                    label: const Text('Open'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              bookingProcess,
              style: TextStyle(
                color: AppTheme.primaryBrown,
                fontSize: 13,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 12),
            const ContactActions(
              phone: forestOfficePhone,
              website: officialBookingUrl,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeason() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              bestSeasonInfo,
              style: TextStyle(
                color: AppTheme.primaryBrown,
                fontSize: 13,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red.withValues(alpha: 0.25)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning_amber, color: Colors.red, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Forest is CLOSED 16 June – 15 October (monsoon)',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRules() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: List.generate(safariRules.length, (i) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
            elevation: 0.5,
            child: ListTile(
              dense: true,
              leading: CircleAvatar(
                radius: 13,
                backgroundColor: Colors.red.withValues(alpha: 0.1),
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              title: Text(
                safariRules[i],
                style:
                    const TextStyle(fontSize: 13, color: AppTheme.primaryBrown),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildImportantNote() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.goldenAmber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.goldenAmber.withValues(alpha: 0.35)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: AppTheme.goldenAmber, size: 20),
              SizedBox(width: 8),
              Text(
                'Important Tips',
                style: TextStyle(
                  color: AppTheme.goldenAmber,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '• Early morning safari has the highest lion sighting probability\n'
            '• Nov – Feb is peak — book at least 2–3 weeks in advance\n'
            '• A single permit covers up to 6 adults + 1 child (3–12 yrs)\n'
            '• Guide is mandatory — they know where lions frequent\n'
            '• Carry a light jacket for the morning safari',
            style: TextStyle(
              color: AppTheme.primaryBrown,
              fontSize: 13,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Small helpers ─────────────────────────────────────────────

class _PillChip extends StatelessWidget {
  final String label;
  const _PillChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 11)),
    );
  }
}

class _FeeLine extends StatelessWidget {
  final String label;
  final String value;
  const _FeeLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Text(
              label,
              style: const TextStyle(
                color: AppTheme.lightBrown,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppTheme.primaryBrown,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeeListCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<SafariFeeLine> lines;

  const _FeeListCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.lines,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 18),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const Divider(height: 14),
            ...lines.map((l) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          l.label,
                          style: const TextStyle(
                            color: AppTheme.primaryBrown,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        l.value,
                        style: const TextStyle(
                          color: AppTheme.textDark,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
