// lib/screens/stay_screen.dart
// Hotels & stay options — filter by type, sort by rating / price.

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/static_data.dart';
import '../widgets/contact_actions.dart';
import '../widgets/filter_bar.dart';

const _sortOptions = <String>[
  'Top Rated',
  'Price — Low to High',
  'Price — High to Low',
  'Most Reviewed',
];

class StayScreen extends StatefulWidget {
  const StayScreen({super.key});

  @override
  State<StayScreen> createState() => _StayScreenState();
}

class _StayScreenState extends State<StayScreen> {
  String _filter = 'All';
  String _sort = 'Top Rated';

  List<Hotel> get _visibleHotels {
    // 1. Filter by type.
    final filtered = _filter == 'All'
        ? List<Hotel>.from(hotels)
        : hotels.where((h) => h.type == _filter).toList();

    // 2. Sort the filtered subset.
    switch (_sort) {
      case 'Price — Low to High':
        filtered.sort((a, b) => a.priceMin.compareTo(b.priceMin));
        break;
      case 'Price — High to Low':
        filtered.sort((a, b) => b.priceMax.compareTo(a.priceMax));
        break;
      case 'Most Reviewed':
        filtered.sort((a, b) => b.reviews.compareTo(a.reviews));
        break;
      case 'Top Rated':
      default:
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visibleHotels;
    return Scaffold(
      backgroundColor: AppTheme.beige,
      appBar: AppBar(
        title: const Text('Stay & Accommodation',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 20,
              letterSpacing: 0.5,
            )),
        backgroundColor: AppTheme.primaryBrown,
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: false,
      ),
      body: Column(
        children: [
          FilterBar(
            filters: hotelTypeFilters,
            selected: _filter,
            onSelected: (v) => setState(() => _filter = v),
            sortLabel: _shortSort(_sort),
            sortOptions: _sortOptions,
            onSortChanged: (v) => setState(() => _sort = v),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Text(
                  '${visible.length} hotels',
                  style: const TextStyle(
                      color: AppTheme.lightBrown,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _sort,
                    style: const TextStyle(
                        color: AppTheme.primaryGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: visible.isEmpty
                ? const _EmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: visible.length,
                    itemBuilder: (_, i) => _HotelCard(hotel: visible[i]),
                  ),
          ),
        ],
      ),
    );
  }

  String _shortSort(String v) {
    if (v.contains('Low')) return 'Price ↑';
    if (v.contains('High')) return 'Price ↓';
    if (v.contains('Reviewed')) return 'Reviews';
    return 'Rating';
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.lightBrown.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.hotel_outlined,
                size: 60, color: AppTheme.lightBrown.withOpacity(0.5)),
          ),
          const SizedBox(height: 16),
          const Text('No hotels match this filter',
              style: TextStyle(
                color: AppTheme.primaryBrown,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              )),
          const SizedBox(height: 6),
          Text('Try adjusting your criteria',
              style: TextStyle(
                color: AppTheme.lightBrown.withOpacity(0.7),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
class _HotelCard extends StatefulWidget {
  final Hotel hotel;
  const _HotelCard({required this.hotel});

  @override
  State<_HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<_HotelCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          onTap: () => _showDetail(context),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _pressed
                    ? AppTheme.primaryGreen.withOpacity(0.3)
                    : Colors.transparent,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: _pressed
                      ? AppTheme.primaryGreen.withOpacity(0.2)
                      : Colors.black.withOpacity(0.08),
                  blurRadius: _pressed ? 12 : 6,
                  offset: _pressed ? const Offset(0, 4) : const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                const SizedBox(height: 12),
                Text(
                  widget.hotel.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppTheme.primaryBrown,
                    fontSize: 13,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                _priceAndType(),
                const SizedBox(height: 10),
                _amenitiesRow(),
                const SizedBox(height: 12),
                ContactActions(
                  phone: widget.hotel.phone,
                  website: widget.hotel.website ?? widget.hotel.contact,
                  compact: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: AppTheme.primaryBrown.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child:
              Icon(widget.hotel.icon, color: AppTheme.primaryBrown, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.hotel.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.5,
                  color: AppTheme.textDark,
                  letterSpacing: 0.1,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.place_outlined,
                      size: 13, color: AppTheme.lightBrown),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      widget.hotel.location,
                      style: const TextStyle(
                        color: AppTheme.lightBrown,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        RatingBadge(rating: widget.hotel.rating, reviews: widget.hotel.reviews),
      ],
    );
  }

  Widget _priceAndType() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.goldenAmber.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppTheme.goldenAmber.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.currency_rupee,
                  size: 13, color: AppTheme.goldenAmber),
              const SizedBox(width: 4),
              Text(
                widget.hotel.priceRange,
                style: const TextStyle(
                  color: AppTheme.goldenAmber,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppTheme.primaryGreen.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Text(
            widget.hotel.type,
            style: const TextStyle(
              color: AppTheme.primaryGreen,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _amenitiesRow() {
    // Show first 4 amenities inline, "+N more" if overflow.
    final shown = widget.hotel.amenities.take(4).toList();
    final more = widget.hotel.amenities.length - shown.length;
    return Wrap(
      spacing: 7,
      runSpacing: 5,
      children: [
        ...shown.map((a) => _amenityChip(a)),
        if (more > 0) _amenityChip('+$more more'),
      ],
    );
  }

  Widget _amenityChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.accentGreen.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryGreen.withOpacity(0.15),
          width: 0.8,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppTheme.primaryGreen,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  void _showDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _HotelDetailSheet(hotel: widget.hotel),
    );
  }
}

// ─────────────────────────────────────────────────────────────
class _HotelDetailSheet extends StatelessWidget {
  final Hotel hotel;
  const _HotelDetailSheet({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      builder: (_, ctrl) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.warmWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ListView(
          controller: ctrl,
          padding: EdgeInsets.zero,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBrown.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(hotel.icon,
                        size: 32, color: AppTheme.primaryBrown),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotel.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: AppTheme.textDark,
                            letterSpacing: 0.1,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          hotel.type,
                          style: const TextStyle(
                            color: AppTheme.primaryGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RatingBadge(rating: hotel.rating, reviews: hotel.reviews),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.2),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DetailRow(
                      icon: Icons.place_outlined,
                      label: 'Location',
                      value: hotel.location),
                  _DetailRow(
                      icon: Icons.currency_rupee,
                      label: 'Price',
                      value: hotel.priceRange,
                      color: AppTheme.goldenAmber),
                  if (hotel.phone != null)
                    _DetailRow(
                        icon: Icons.phone_outlined,
                        label: 'Phone',
                        value: hotel.phone!,
                        color: AppTheme.primaryGreen),
                  if (hotel.website != null || hotel.contact.isNotEmpty)
                    _DetailRow(
                        icon: Icons.public,
                        label: 'Website',
                        value: hotel.website ?? hotel.contact,
                        color: AppTheme.skyBlue),
                  const SizedBox(height: 20),
                  const Text(
                    'About',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: AppTheme.textDark,
                      letterSpacing: 0.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    hotel.description,
                    style: const TextStyle(
                      color: AppTheme.primaryBrown,
                      height: 1.6,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Amenities',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: AppTheme.textDark,
                      letterSpacing: 0.1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: hotel.amenities
                        .map((a) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppTheme.accentGreen.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      AppTheme.primaryGreen.withOpacity(0.15),
                                  width: 0.8,
                                ),
                              ),
                              child: Text(
                                a,
                                style: const TextStyle(
                                  color: AppTheme.primaryGreen,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.1,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  ContactActions(
                    phone: hotel.phone,
                    website: hotel.website ?? hotel.contact,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.color = AppTheme.primaryBrown,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 15, color: color),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: const TextStyle(
                color: AppTheme.lightBrown,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.1,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
