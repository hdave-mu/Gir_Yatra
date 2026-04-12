// lib/screens/emergency_screen.dart
// Emergency contacts + Forest first-aid tips — critical for real-life use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../data/extra_data.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.beige,
      appBar: AppBar(
        backgroundColor: const Color(0xFFD32F2F),
        title: const Row(
          children: [
            Icon(Icons.emergency, color: Colors.white, size: 22),
            SizedBox(width: 8),
            Text('Emergency & Safety',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        bottom: TabBar(
          controller: _tab,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(icon: Icon(Icons.phone), text: 'Contacts'),
            Tab(icon: Icon(Icons.medical_information), text: 'First Aid'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _ContactsTab(),
          _FirstAidTab(),
        ],
      ),
    );
  }
}

// ── Contacts Tab ──────────────────────────────────────────────
class _ContactsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        // SOS banner
        _buildSOSBanner(),

        // Quick-dial row (three most critical)
        _buildQuickDial(),

        const Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text(
            'All Emergency Numbers',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppTheme.primaryBrown,
            ),
          ),
        ),

        ...emergencyContacts.map((c) => _ContactCard(contact: c)),
      ],
    );
  }

  Widget _buildSOSBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFD32F2F),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD32F2F).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.emergency, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('In a Life-Threatening Emergency',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                const SizedBox(height: 3),
                Text('Call 112 — National Emergency Number\nworks even without mobile network signal',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8), fontSize: 12, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickDial() {
    final quickNums = [
      ('Police', '100', Icons.local_police, const Color(0xFF1565C0)),
      ('Ambulance', '108', Icons.local_hospital, const Color(0xFFD32F2F)),
      ('National', '112', Icons.emergency, const Color(0xFF6A1B9A)),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: quickNums.map((q) {
          final (label, num, icon, color) = q;
          return Expanded(
            child: GestureDetector(
              onTap: () => _copyNumber(num),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Icon(icon, color: color, size: 26),
                    const SizedBox(height: 6),
                    Text(num,
                        style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                            fontSize: 22)),
                    Text(label,
                        style: TextStyle(
                            color: color.withOpacity(0.7), fontSize: 11)),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _copyNumber(String num) {
    Clipboard.setData(ClipboardData(text: num));
  }
}

class _ContactCard extends StatelessWidget {
  final EmergencyContact contact;
  const _ContactCard({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: contact.color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(contact.icon, color: contact.color, size: 22),
        ),
        title: Text(contact.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppTheme.primaryBrown)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(contact.note,
                style: const TextStyle(
                    color: AppTheme.lightBrown, fontSize: 12)),
          ],
        ),
        trailing: GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: contact.number));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${contact.number} copied to clipboard'),
                duration: const Duration(seconds: 2),
                backgroundColor: AppTheme.primaryGreen,
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: contact.color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(contact.number,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13)),
          ),
        ),
      ),
    );
  }
}

// ── First Aid Tab ─────────────────────────────────────────────
class _FirstAidTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFF8F00).withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: const Color(0xFFFF8F00).withOpacity(0.35)),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: Color(0xFFFF8F00)),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'These are general guidelines. Always call emergency services for serious incidents.',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.primaryBrown,
                      height: 1.4),
                ),
              ),
            ],
          ),
        ),
        ...firstAidTips.map((tip) => _FirstAidCard(tip: tip)),
      ],
    );
  }
}

class _FirstAidCard extends StatefulWidget {
  final FirstAidTip tip;
  const _FirstAidCard({required this.tip});

  @override
  State<_FirstAidCard> createState() => _FirstAidCardState();
}

class _FirstAidCardState extends State<_FirstAidCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: widget.tip.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(widget.tip.icon,
                        color: widget.tip.color, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.tip.situation,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: widget.tip.color,
                                fontSize: 14)),
                        const SizedBox(height: 3),
                        Text(widget.tip.immediateAction,
                            style: const TextStyle(
                                color: AppTheme.primaryBrown,
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: AppTheme.lightBrown,
                  ),
                ],
              ),
            ),
          ),

          // Expanded steps
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: widget.tip.color.withOpacity(0.2)),
                  const SizedBox(height: 4),
                  ...List.generate(widget.tip.steps.length, (i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: widget.tip.color,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text('${i + 1}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(widget.tip.steps[i],
                                style: const TextStyle(
                                    color: AppTheme.primaryBrown,
                                    fontSize: 13,
                                    height: 1.4)),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: widget.tip.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.phone, color: widget.tip.color, size: 16),
                        const SizedBox(width: 8),
                        Text('Emergency: ${widget.tip.callNumber}',
                            style: TextStyle(
                                color: widget.tip.color,
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
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
