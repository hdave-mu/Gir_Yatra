// lib/screens/nearby_places_screen.dart
// Attractions around Sasan Gir — filter by type, sort by distance / rating.

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/design_tokens.dart';
import '../data/static_data.dart';
import '../widgets/contact_actions.dart';
import '../widgets/filter_bar.dart';
import '../animations/page_transitions.dart';

const _sortOptions = <String>[
  'Distance — Nearest',
  'Distance — Farthest',
  'Top Rated',
];

class NearbyPlacesScreen extends StatefulWidget {
  const NearbyPlacesScreen({super.key});

  @override
  State<NearbyPlacesScreen> createState() => _NearbyPlacesScreenState();
}

class _NearbyPlacesScreenState extends State<NearbyPlacesScreen> {
  String _filter = 'All';
  String _sort = 'Distance — Nearest';
  late List<NearbyPlace> _cachedPlaces;

  @override
  void initState() {
    super.initState();
    _cachedPlaces = _computeVisible();
  }

  List<String> get _types {
    final set = <String>{'All', ...nearbyPlaces.map((p) => p.type)};
    return set.toList();
  }

  List<NearbyPlace> _computeVisible() {
    final filtered = _filter == 'All'
        ? List<NearbyPlace>.from(nearbyPlaces)
        : nearbyPlaces.where((p) => p.type == _filter).toList();

    switch (_sort) {
      case 'Distance — Farthest':
        filtered
            .sort((a, b) => (b.distanceKm ?? 0).compareTo(a.distanceKm ?? 0));
        break;
      case 'Top Rated':
        filtered.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
        break;
      case 'Distance — Nearest':
      default:
        filtered.sort(
            (a, b) => (a.distanceKm ?? 1e9).compareTo(b.distanceKm ?? 1e9));
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final visible = _cachedPlaces;
    return Scaffold(
      backgroundColor: AppTheme.beige,
      appBar: AppBar(
        title: Text('Nearby Places',
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              letterSpacing: 0.3,
            )),
        backgroundColor: const Color(0xFF6A1B9A),
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: false,
      ),
      body: Column(
        children: [
          _buildBanner(),
          FilterBar(
            filters: _types,
            selected: _filter,
            onSelected: (v) => setState(() {
              _filter = v;
              _cachedPlaces = _computeVisible();
            }),
            sortLabel: _shortSort(_sort),
            sortOptions: _sortOptions,
            onSortChanged: (v) => setState(() {
              _sort = v;
              _cachedPlaces = _computeVisible();
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                Text(
                  '${visible.length} attractions',
                  style: const TextStyle(
                      color: AppTheme.lightBrown,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text(
                  _sort,
                  style: const TextStyle(
                      color: AppTheme.primaryGreen,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Expanded(
            child: visible.isEmpty
                ? const Center(
                    child: Text('No places match this filter',
                        style: TextStyle(
                          color: AppTheme.primaryBrown,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                  )
                : ListView.builder(
                    cacheExtent: 600, // More aggressive pre-rendering
                    addRepaintBoundaries: true,
                    addSemanticIndexes: false, // Reduce overhead
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: visible.length,
                    itemBuilder: (_, i) => i < 3 // Animate only first 3 items
                        ? _PlaceCard(place: visible[i])
                            .animate()
                            .fadeIn(
                              delay: Duration(milliseconds: 40 * i),
                              duration: const Duration(milliseconds: 400),
                            )
                            .slideY(
                              begin: 0.05,
                              end: 0,
                              delay: Duration(milliseconds: 40 * i),
                              duration: const Duration(milliseconds: 400),
                              curve: GirCurves.entrance,
                            )
                        : _PlaceCard(place: visible[i]),
                  ),
          ),
        ],
      ),
    );
  }

  String _shortSort(String v) {
    if (v.contains('Farthest')) return 'Far → Near';
    if (v.contains('Top')) return 'Rating';
    return 'Near → Far';
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      height: 140,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5E35B1), Color(0xFF7B1FA2), Color(0xFF8E24AA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B1FA2).withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: const Color(0xFF7B1FA2).withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Opacity(
              opacity: 0.1,
              child: Container(
                width: 140,
                height: 140,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.25),
                          width: 1,
                        ),
                      ),
                      child: const Icon(Icons.explore,
                          color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Explore Beyond Gir',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Temples · Wildlife · Heritage · Beaches',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
class _PlaceCard extends StatefulWidget {
  final NearbyPlace place;
  const _PlaceCard({required this.place});

  @override
  State<_PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<_PlaceCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        Navigator.push(
          context,
          SlidePageRoute(page: PlaceDetailScreen(place: widget.place)),
        );
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: Transform.scale(
        scale: _isPressed ? 0.97 : 1.0,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: widget.place.color.withValues(alpha: 0.18),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: widget.place.color.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Place image
                Container(
                  height: 200,
                  width: double.infinity,
                  color: const Color(0xFFF5F5F5),
                  child: Image.asset(
                    widget.place.imagePath,
                    fit: BoxFit.cover,
                    cacheHeight: 400,
                    cacheWidth: 1200,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: widget.place.color.withValues(alpha: 0.15),
                        child: Center(
                          child: Icon(widget.place.icon,
                              size: 40, color: widget.place.color),
                        ),
                      );
                    },
                  ),
                ),

                // Gradient header
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.place.color,
                        widget.place.color.withValues(alpha: 0.75)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                            width: 0.8,
                          ),
                        ),
                        child: Icon(widget.place.icon,
                            color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.place.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.place.shortDescription,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (widget.place.rating != null)
                        RatingBadge(
                            rating: widget.place.rating!, compact: true),
                    ],
                  ),
                ),

                // Body
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _buildChip(Icons.category_outlined, widget.place.type,
                              widget.place.color),
                          _buildChip(Icons.directions_car,
                              widget.place.distance, AppTheme.primaryGreen),
                          _buildChip(
                              Icons.currency_rupee,
                              widget.place.entryFee.split('|').first.trim(),
                              AppTheme.goldenAmber),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.tips_and_updates,
                                    size: 13, color: widget.place.color),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    widget.place.travelTips.first,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color:
                                          widget.place.color.withValues(alpha: 0.9),
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Details',
                                style: TextStyle(
                                  color: widget.place.color,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Icon(Icons.arrow_forward_ios,
                                  size: 11, color: widget.place.color),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
class PlaceDetailScreen extends StatelessWidget {
  final NearbyPlace place;
  const PlaceDetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.beige,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: place.color,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                place.name,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      place.imagePath,
                      fit: BoxFit.cover,
                      cacheHeight: 560,
                      cacheWidth: 1080,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                place.color,
                                place.color.withValues(alpha: 0.7)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.1),
                            Colors.black.withValues(alpha: 0.3),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 70, 20, 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(place.icon, color: Colors.white, size: 36),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            place.type,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuickInfo(),
                  const SizedBox(height: 14),
                  _buildSection(
                      'About', Icons.info_outline, place.fullDescription),
                  const SizedBox(height: 12),
                  _buildTravelTips(),
                  if (place.website != null) ...[
                    const SizedBox(height: 16),
                    ContactActions(website: place.website),
                  ],
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInfo() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _QuickInfoCard(
                icon: Icons.directions_car,
                label: 'Distance',
                value: place.distance,
                color: place.color,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _QuickInfoCard(
                icon: Icons.currency_rupee,
                label: 'Entry Fee',
                value: place.entryFee,
                color: AppTheme.goldenAmber,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _QuickInfoCard(
                icon: Icons.access_time,
                label: 'Best Time',
                value: place.bestTime,
                color: AppTheme.skyBlue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection(String title, IconData icon, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: place.color, size: 22),
            const SizedBox(width: 10),
            Text(title,
                style: const TextStyle(
                    color: AppTheme.primaryBrown,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 10),
        Text(text,
            style: const TextStyle(
                color: AppTheme.lightBrown, fontSize: 13, height: 1.6)),
      ],
    );
  }

  Widget _buildTravelTips() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: place.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: place.color.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: place.color, size: 18),
              const SizedBox(width: 8),
              const Text('Travel Tips',
                  style: TextStyle(
                      color: AppTheme.primaryBrown,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          ...place.travelTips.map((tip) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle_outline,
                        size: 14, color: place.color),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(tip,
                          style: const TextStyle(
                              color: AppTheme.lightBrown, fontSize: 12)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _QuickInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _QuickInfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(label,
              style: const TextStyle(
                  color: AppTheme.primaryBrown,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppTheme.lightBrown,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
