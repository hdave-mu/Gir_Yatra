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
        title: const Text('Emergency & Safety',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 20,
              letterSpacing: 0.5,
            )),
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: TabBar(
            controller: _tab,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            tabs: const [
              Tab(icon: Icon(Icons.phone), text: 'Contacts', height: 56),
              Tab(
                  icon: Icon(Icons.medical_information),
                  text: 'First Aid',
                  height: 56),
            ],
          ),
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
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        // SOS banner
        _buildSOSBanner(),

        const SizedBox(height: 24),

        // Quick-dial row (three most critical)
        _buildQuickDial(),

        const SizedBox(height: 28),

        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'All Emergency Numbers',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: AppTheme.primaryBrown,
              letterSpacing: 0.2,
            ),
          ),
        ),

        ...emergencyContacts.map((c) => _ContactCard(contact: c)),
      ],
    );
  }

  Widget _buildSOSBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFD32F2F),
            Color(0xFFC62828),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD32F2F).withOpacity(0.35),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.emergency, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Life-Threatening Emergency?',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        letterSpacing: 0.2)),
                const SizedBox(height: 4),
                Text('Call 112\nWorks without mobile network signal',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.w500)),
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

    return Column(
      children: quickNums.map((q) {
        final (label, num, icon, color) = q;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _copyNumber(num),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: color.withOpacity(0.25), width: 1.5),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: color, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(label,
                              style: const TextStyle(
                                  color: AppTheme.primaryBrown,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13)),
                          Text(num,
                              style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  letterSpacing: 0.5)),
                        ],
                      ),
                    ),
                    Icon(Icons.content_copy,
                        color: color.withOpacity(0.6), size: 18),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _copyNumber(String num) {
    Clipboard.setData(ClipboardData(text: num));
  }
}

class _ContactCard extends StatefulWidget {
  final EmergencyContact contact;
  const _ContactCard({required this.contact});

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          onTap: () {
            Clipboard.setData(ClipboardData(text: widget.contact.number));
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.white),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${widget.contact.number} copied',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                duration: const Duration(seconds: 2),
                backgroundColor: AppTheme.primaryGreen,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _pressed
                    ? widget.contact.color.withOpacity(0.4)
                    : Colors.transparent,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: _pressed
                      ? widget.contact.color.withOpacity(0.25)
                      : Colors.black.withOpacity(0.08),
                  blurRadius: _pressed ? 10 : 6,
                  offset: _pressed ? const Offset(0, 4) : const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: widget.contact.color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(widget.contact.icon,
                      color: widget.contact.color, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.contact.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: AppTheme.primaryBrown,
                              letterSpacing: 0.1)),
                      const SizedBox(height: 3),
                      Text(widget.contact.note,
                          style: TextStyle(
                              color: AppTheme.lightBrown.withOpacity(0.75),
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
                  decoration: BoxDecoration(
                    color: widget.contact.color,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: widget.contact.color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(widget.contact.number,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          letterSpacing: 0.3)),
                ),
              ],
            ),
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
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFFF8F00).withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFFF8F00).withOpacity(0.25),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8F00).withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.info_outline,
                    color: Color(0xFFFF8F00), size: 18),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'General guidelines. Always call emergency services for serious incidents.',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.primaryBrown,
                      height: 1.5,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
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

class _FirstAidCardState extends State<_FirstAidCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _expanded = !_expanded;
              if (_expanded) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
            });
          },
          borderRadius: BorderRadius.circular(14),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _expanded
                    ? widget.tip.color.withOpacity(0.3)
                    : Colors.transparent,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: _expanded
                      ? widget.tip.color.withOpacity(0.2)
                      : Colors.black.withOpacity(0.05),
                  blurRadius: _expanded ? 8 : 4,
                  offset: _expanded ? const Offset(0, 2) : const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                          color: widget.tip.color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(11),
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
                                    fontWeight: FontWeight.w700,
                                    color: widget.tip.color,
                                    fontSize: 14,
                                    letterSpacing: 0.1)),
                            const SizedBox(height: 4),
                            Text(widget.tip.immediateAction,
                                style: const TextStyle(
                                    color: AppTheme.primaryBrown,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4)),
                          ],
                        ),
                      ),
                      RotationTransition(
                        turns: Tween(begin: 0.0, end: 0.5)
                            .animate(_animationController),
                        child: Icon(
                          Icons.expand_more,
                          color: widget.tip.color.withOpacity(0.6),
                          size: 24,
                        ),
                      ),
                    ],
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
                        Divider(
                          color: widget.tip.color.withOpacity(0.15),
                          height: 16,
                          thickness: 1,
                        ),
                        const SizedBox(height: 8),
                        ...List.generate(widget.tip.steps.length, (i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: widget.tip.color.withOpacity(0.12),
                                    border: Border.all(
                                      color: widget.tip.color.withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text('${i + 1}',
                                      style: TextStyle(
                                          color: widget.tip.color,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Text(widget.tip.steps[i],
                                        style: const TextStyle(
                                            color: AppTheme.primaryBrown,
                                            fontSize: 13,
                                            height: 1.5,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: widget.tip.color.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: widget.tip.color.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.phone,
                                  color: widget.tip.color.withOpacity(0.8),
                                  size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text('Call: ${widget.tip.callNumber}',
                                    style: TextStyle(
                                        color: widget.tip.color,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        letterSpacing: 0.2)),
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
                  duration: const Duration(milliseconds: 300),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
