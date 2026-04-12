// lib/screens/stay_screen.dart
// Hotels & Accommodation screen

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/static_data.dart';
import '../widgets/custom_card.dart';

class StayScreen extends StatefulWidget {
  const StayScreen({super.key});

  @override
  State<StayScreen> createState() => _StayScreenState();
}

class _StayScreenState extends State<StayScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Budget', 'Mid-Range', 'Luxury', 'Eco-Lodge'];

  List<Hotel> get _filteredHotels {
    if (_selectedFilter == 'All') return hotels;
    return hotels.where((h) {
      switch (_selectedFilter) {
        case 'Budget':
          return h.type.contains('Budget') || h.type.contains('Government');
        case 'Luxury':
          return h.type.contains('Luxury');
        case 'Eco-Lodge':
          return h.type.contains('Eco') || h.type.contains('Jungle');
        case 'Mid-Range':
          return h.type.contains('Camp') || h.type.contains('Safari');
        default:
          return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.beige,
      appBar: AppBar(
        title: const Text('🏨 Stay & Accommodation'),
        backgroundColor: AppTheme.primaryBrown,
      ),
      body: Column(
        children: [
          // Filter chips
          _buildFilterBar(),

          // Hotel list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              itemCount: _filteredHotels.length,
              itemBuilder: (context, index) {
                return _HotelCard(hotel: _filteredHotels[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      color: AppTheme.warmWhite,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _filters.map((filter) {
            final isSelected = _selectedFilter == filter;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(filter),
                selected: isSelected,
                onSelected: (_) => setState(() => _selectedFilter = filter),
                selectedColor: AppTheme.primaryBrown.withOpacity(0.2),
                checkmarkColor: AppTheme.primaryBrown,
                labelStyle: TextStyle(
                  color: isSelected ? AppTheme.primaryBrown : AppTheme.lightBrown,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
                backgroundColor: AppTheme.beige,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected
                        ? AppTheme.primaryBrown
                        : AppTheme.lightBrown.withOpacity(0.3),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _HotelCard extends StatelessWidget {
  final Hotel hotel;

  const _HotelCard({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      shadowColor: AppTheme.primaryBrown.withOpacity(0.15),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showHotelDetail(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBrown.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(hotel.icon, color: AppTheme.primaryBrown, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotel.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppTheme.primaryBrown,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.place_outlined, size: 14, color: AppTheme.lightBrown),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Text(
                                hotel.location,
                                style: const TextStyle(
                                  color: AppTheme.lightBrown,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      hotel.type,
                      style: const TextStyle(
                        color: AppTheme.primaryGreen,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Description
              Text(
                hotel.description,
                style: const TextStyle(
                  color: AppTheme.primaryBrown,
                  fontSize: 13,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 12),

              // Price & Contact row
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.goldenAmber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.currency_rupee, size: 14, color: AppTheme.goldenAmber),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              hotel.priceRange,
                              style: const TextStyle(
                                color: AppTheme.goldenAmber,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.skyBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.phone_outlined, size: 14, color: AppTheme.skyBlue),
                        SizedBox(width: 4),
                        Text(
                          'Call',
                          style: TextStyle(
                            color: AppTheme.skyBlue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Amenities
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: hotel.amenities.map((amenity) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppTheme.accentGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      amenity,
                      style: const TextStyle(
                        color: AppTheme.primaryGreen,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHotelDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _HotelDetailSheet(hotel: hotel),
    );
  }
}

class _HotelDetailSheet extends StatelessWidget {
  final Hotel hotel;
  const _HotelDetailSheet({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.warmWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ListView(
          controller: controller,
          children: [
            // Handle
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Header
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryBrown.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(hotel.icon, size: 36, color: AppTheme.primaryBrown),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotel.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppTheme.primaryBrown,
                          ),
                        ),
                        Text(
                          hotel.type,
                          style: const TextStyle(
                            color: AppTheme.primaryGreen,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(icon: Icons.place, label: 'Location', value: hotel.location),
                  InfoRow(icon: Icons.currency_rupee, label: 'Price Range', value: hotel.priceRange, iconColor: AppTheme.goldenAmber),
                  InfoRow(icon: Icons.phone, label: 'Contact', value: hotel.contact, iconColor: AppTheme.skyBlue),
                  const SizedBox(height: 12),
                  const Text('About', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.primaryBrown)),
                  const SizedBox(height: 6),
                  Text(hotel.description, style: const TextStyle(color: AppTheme.primaryBrown, height: 1.5, fontSize: 13)),
                  const SizedBox(height: 16),
                  const Text('Amenities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.primaryBrown)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: hotel.amenities.map((a) {
                      return Chip(
                        label: Text(a, style: const TextStyle(fontSize: 12)),
                        backgroundColor: AppTheme.accentGreen.withOpacity(0.2),
                        side: BorderSide.none,
                      );
                    }).toList(),
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
