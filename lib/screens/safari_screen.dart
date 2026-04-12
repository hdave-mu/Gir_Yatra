// lib/screens/safari_screen.dart
// Wildlife & Safari Information Screen

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/static_data.dart';
import '../widgets/custom_card.dart';

class SafariScreen extends StatelessWidget {
  const SafariScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.beige,
      appBar: AppBar(
        title: const Text('🐾 Safari Information'),
        backgroundColor: AppTheme.primaryGreen,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          // Hero Banner
          _buildHeroBanner(),

          // Safari Timings
          const SectionHeader(
            title: 'Safari Timings',
            icon: Icons.schedule,
            iconColor: AppTheme.primaryGreen,
          ),
          _buildSafariTimings(),

          // Entry Fees
          const SectionHeader(
            title: 'Entry Fees',
            icon: Icons.currency_rupee,
            iconColor: AppTheme.goldenAmber,
          ),
          _buildEntryFees(),

          // Booking Process
          const SectionHeader(
            title: 'How to Book',
            icon: Icons.book_online,
            iconColor: AppTheme.skyBlue,
          ),
          _buildBookingProcess(),

          // Best Season
          const SectionHeader(
            title: 'Best Season to Visit',
            icon: Icons.wb_sunny_outlined,
            iconColor: AppTheme.safariOrange,
          ),
          _buildBestSeason(),

          // Safari Rules
          const SectionHeader(
            title: 'Safari Rules',
            subtitle: 'Please respect the forest',
            icon: Icons.rule,
            iconColor: Colors.red,
          ),
          _buildSafariRules(),

          // Important Note
          _buildImportantNote(),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF33691E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Row(
        children: [
          Text('🦁', style: TextStyle(fontSize: 60)),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gir National Park',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'The last wild refuge of\nAsiatic Lions on Earth',
                  style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children: [
                    _StatChip(label: '1,412 sq km'),
                    _StatChip(label: '674 Lions'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafariTimings() {
    return Column(
      children: safariTimings.map((timing) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(timing.icon, color: AppTheme.primaryGreen, size: 24),
            ),
            title: Text(
              timing.session,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: AppTheme.lightBrown),
                    const SizedBox(width: 4),
                    Text(timing.time, style: const TextStyle(color: AppTheme.primaryBrown)),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.calendar_month, size: 14, color: AppTheme.lightBrown),
                    const SizedBox(width: 4),
                    Text(timing.season, style: const TextStyle(color: AppTheme.lightBrown, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEntryFees() {
    return Column(
      children: entryFees.map((fee) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.goldenAmber.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        fee.category,
                        style: const TextStyle(
                          color: AppTheme.goldenAmber,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _FeeBox(label: 'Per Person', value: fee.feePerPerson),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _FeeBox(label: 'Vehicle', value: fee.vehicleFee),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _FeeBox(label: 'Guide', value: fee.guideCharge),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBookingProcess() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.skyBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.language, color: AppTheme.skyBlue, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'sasangir.gujarat.gov.in',
                    style: TextStyle(
                      color: AppTheme.skyBlue,
                      fontWeight: FontWeight.bold,
                    ),
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
                height: 1.8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBestSeason() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
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
                color: Colors.red.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red.withOpacity(0.2)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning_amber, color: Colors.red, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Forest is CLOSED for tourists during July–September (Monsoon)',
                      style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600),
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

  Widget _buildSafariRules() {
    return Column(
      children: List.generate(safariRules.length, (index) {
        final rule = safariRules[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 1,
          child: ListTile(
            dense: true,
            leading: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.red.withOpacity(0.1),
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              rule,
              style: const TextStyle(fontSize: 13, color: AppTheme.primaryBrown),
            ),
            trailing: const Icon(Icons.check_circle_outline, color: AppTheme.primaryGreen, size: 18),
          ),
        );
      }),
    );
  }

  Widget _buildImportantNote() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.goldenAmber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.goldenAmber.withOpacity(0.4)),
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
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '• Early morning safari (6 AM) has the highest lion sighting probability\n'
            '• October to December is peak season — book 2–3 weeks in advance\n'
            '• Each jeep (Gypsy) has 6 seats — book as a group to save cost\n'
            '• A forest guide is MANDATORY — they know where lions frequent\n'
            '• Don\'t forget a light jacket for morning safari — forest is cool at 6 AM',
            style: TextStyle(
              color: AppTheme.primaryBrown,
              fontSize: 13,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Helper Widgets ─────────────────────────────────────────────
class _StatChip extends StatelessWidget {
  final String label;
  const _StatChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
    );
  }
}

class _FeeBox extends StatelessWidget {
  final String label;
  final String value;
  const _FeeBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: AppTheme.beige,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryGreen,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.lightBrown,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// End of safari_screen.dart
