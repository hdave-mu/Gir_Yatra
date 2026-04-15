// lib/screens/home_screen.dart
// Gir Yatra v2 — Main home with drawer navigation + full dashboard

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/static_data.dart';
import '../data/extra_data.dart';
import '../widgets/custom_card.dart';
import 'safari_screen.dart';
import 'stay_screen.dart';
import 'food_culture_screen.dart';
import 'nearby_places_screen.dart';
import 'itinerary_screen.dart';
import 'emergency_screen.dart';
import 'transport_screen.dart';
import 'checklist_screen.dart';
import 'seasonal_screen.dart';
import 'search_screen.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const _DashboardPage(),
    const NearbyPlacesScreen(),
    const ItineraryScreen(),
    const ChecklistScreen(),
    const _ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.place_outlined),
                activeIcon: Icon(Icons.place),
                label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                activeIcon: Icon(Icons.calendar_month),
                label: 'Itinerary'),
            BottomNavigationBarItem(
                icon: Icon(Icons.checklist_outlined),
                activeIcon: Icon(Icons.checklist),
                label: 'Checklist'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Dashboard page
// ─────────────────────────────────────────────────────────────────────────────
class _DashboardPage extends StatelessWidget {
  const _DashboardPage();

  void _push(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.beige,
      drawer: _GirDrawer(onNavigate: (screen) => _push(context, screen)),
      body: CustomScrollView(
        slivers: [
          // Sliver app bar with glassmorphism effect
          SliverAppBar(
            expandedHeight: 210,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: RepaintBoundary(
              child: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    // Gradient background with glass effect
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppTheme.primaryGreen.withOpacity(0.95),
                            AppTheme.primaryGreen.withOpacity(0.85),
                          ],
                        ),
                      ),
                    ),
                    // Background image with caching for performance
                    Positioned.fill(
                      child: Image.asset(
                        'Image/Sasan Gir.jpg',
                        fit: BoxFit.cover,
                        opacity: const AlwaysStoppedAnimation(0.95),
                        cacheHeight: 600, // Optimized for high-res screens
                        cacheWidth: 1080,
                      ),
                    ),
                    // Dark gradient scrim for text readability
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.08),
                              Colors.black.withOpacity(0.2),
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Welcome to',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              shadows: [
                                Shadow(
                                  offset: const Offset(1, 1),
                                  blurRadius: 3,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Sasan Gir',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: const Offset(1, 2),
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                'Explore the Land of Asiatic Lions',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  shadows: [
                                    Shadow(
                                      offset: const Offset(1, 1),
                                      blurRadius: 2,
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                collapseMode: CollapseMode.parallax,
              ),
            ),
            leading: Builder(
              builder: (ctx) => Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () => Scaffold.of(ctx).openDrawer(),
                    ),
                  ),
                ),
              ),
            ),
            title: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.white, Colors.white.withOpacity(0.9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.25),
                          width: 1,
                        ),
                      ),
                      child: Image.asset(
                        'gir_yatra_icon.png',
                        width: 28,
                        height: 28,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Gir Yatra',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 21,
                      letterSpacing: 0.3,
                      shadows: [
                        Shadow(
                          offset: const Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () => _push(context, const SearchScreen()),
                      icon: const Icon(Icons.search, color: Colors.white),
                      tooltip: 'Search',
                    ),
                  ),
                ),
              ),
            ],
            elevation: 0,
            shadowColor: Colors.transparent,
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Emergency quick-access
                _buildEmergencyBanner(context),

                // This month's forest status
                _buildForestStatusCard(context),

                // Feature grid (8 tiles)
                const SectionHeader(
                  title: 'Explore Gir',
                  subtitle: 'Complete offline guide',
                  icon: Icons.explore,
                ),
                _buildFeatureGrid(context),

                const SizedBox(height: 10),

                // Wildlife facts carousel
                _buildWildlifeFacts(),

                // Eco tips banner
                _buildEcoBanner(context),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const EmergencyScreen())),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red.withOpacity(0.12),
              Colors.red.withOpacity(0.06)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.withOpacity(0.35), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.emergency_share,
                  color: Colors.red, size: 20),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emergency & Safety',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Contacts & first-aid guide →',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                size: 14, color: Colors.red.withOpacity(0.6)),
          ],
        ),
      ),
    );
  }

  Widget _buildForestStatusCard(BuildContext context) {
    final now = DateTime.now();
    final currentMonth =
    seasonalCalendar.firstWhere((m) => m.monthIndex == now.month);

    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const SeasonalScreen())),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              currentMonth.statusColor.withOpacity(0.12),
              currentMonth.statusColor.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: currentMonth.statusColor.withOpacity(0.35),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: currentMonth.statusColor.withOpacity(0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: currentMonth.statusColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child:
              Icon(Icons.forest, color: currentMonth.statusColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${currentMonth.month}: ${currentMonth.forestStatus}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: currentMonth.statusColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    currentMonth.wildlifeActivity,
                    style: const TextStyle(
                      color: AppTheme.primaryBrown,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: currentMonth.statusColor.withOpacity(0.6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    final items = [
      _Feat(
          'Safari Info',
          'Timings & fees',
          Icons.directions_car,
          [const Color(0xFF2E7D32), const Color(0xFF1B5E20)],
              () => _push(context, const SafariScreen())),
      _Feat(
          'Stay',
          'Hotels & resorts',
          Icons.hotel,
          [const Color(0xFF5D4037), const Color(0xFF3E2723)],
              () => _push(context, const StayScreen())),
      _Feat(
          'Food & Culture',
          'Local cuisine',
          Icons.restaurant_menu,
          [const Color(0xFFE65100), const Color(0xFFBF360C)],
              () => _push(context, const FoodCultureScreen())),
      _Feat(
          'How to Reach',
          'Bus, train & car',
          Icons.directions_bus,
          [const Color(0xFF6A1B9A), const Color(0xFF4A148C)],
              () => _push(context, const TransportScreen())),
      _Feat(
          'Seasonal Guide',
          'Best time to visit',
          Icons.wb_sunny_outlined,
          [const Color(0xFFFF8F00), const Color(0xFFE65100)],
              () => _push(context, const SeasonalScreen())),
      _Feat(
          'Nearby Places',
          'Somnath & more',
          Icons.place,
          [const Color(0xFF00695C), const Color(0xFF004D40)],
              () => _push(context, const NearbyPlacesScreen())),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.4,
        ),
        itemCount: items.length,
        itemBuilder: (_, i) => _FeatureCard(feat: items[i]),
      ),
    );
  }

  Widget _buildWildlifeFacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Did You Know?',
          subtitle: 'Wildlife facts about Gir',
          icon: Icons.lightbulb_outlined,
          iconColor: AppTheme.goldenAmber,
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: wildlifeFacts.length,
            itemBuilder: (_, i) {
              final f = wildlifeFacts[i];
              return Container(
                width: 280,
                margin: const EdgeInsets.only(right: 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      f.color.withOpacity(0.12),
                      f.color.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: f.color.withOpacity(0.25),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: f.color.withOpacity(0.18),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: f.color.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Decorative background element
                    Positioned(
                      right: -20,
                      top: -20,
                      child: Opacity(
                        opacity: 0.04,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: f.color,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: f.color.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: f.color.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  f.emoji,
                                  style: const TextStyle(fontSize: 22),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  f.animal,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: f.color,
                                    fontSize: 14,
                                    letterSpacing: 0.2,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Text(
                              f.fact,
                              style: const TextStyle(
                                color: AppTheme.primaryBrown,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEcoBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => _showEcoSheet(context),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.primaryGreen.withOpacity(0.14),
              AppTheme.primaryGreen.withOpacity(0.06),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppTheme.primaryGreen.withOpacity(0.3),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryGreen.withOpacity(0.15),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: AppTheme.primaryGreen.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative circles
            Positioned(
              left: -20,
              top: -20,
              child: Opacity(
                opacity: 0.04,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryGreen,
                  ),
                ),
              ),
            ),
            Positioned(
              right: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.03,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryGreen,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppTheme.primaryGreen.withOpacity(0.25),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryGreen.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.eco,
                    color: AppTheme.primaryGreen,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Be an Eco-Conscious Tourist!',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primaryGreen,
                          fontSize: 14,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Tap to see green travel tips 🌿',
                        style: TextStyle(
                          color: AppTheme.primaryGreen.withOpacity(0.7),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppTheme.primaryGreen.withOpacity(0.5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showEcoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.65,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        builder: (_, ctrl) => Container(
          decoration: const BoxDecoration(
            color: AppTheme.warmWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2)),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.eco, color: AppTheme.primaryGreen),
                    SizedBox(width: 10),
                    Text('Eco-Friendly Travel Tips',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryGreen)),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  controller: ctrl,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: ecoTips.length,
                  itemBuilder: (_, i) => EcoTipCard(tip: ecoTips[i], index: i),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Profile page helpers
// ─────────────────────────────────────────────────────────────────────────────
Widget _profileErrorWidget(String title, String msg) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red.shade600),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(msg, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
        ],
      ),
    ),
  );
}

Widget _profileNotSignedInWidget(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        const SizedBox(height: 40),
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryGreen.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(Icons.person_outline, size: 64, color: Colors.white),
        ),
        const SizedBox(height: 32),
        const Text(
          'Welcome to Sasan Gir',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppTheme.primaryGreen),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to track your journey and personalize your experience',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: AppTheme.textDark.withOpacity(0.6), height: 1.5),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
            icon: const Icon(Icons.login),
            label: const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    ),
  );
}

Widget _profileSignedInWidget(BuildContext context, String initials, String name, String email) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.primaryGreen.withOpacity(0.1), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryGreen.withOpacity(0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(initials, style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900)),
              ),
              const SizedBox(height: 16),
              Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppTheme.textDark)),
              const SizedBox(height: 4),
              Text(email, style: TextStyle(fontSize: 14, color: AppTheme.textDark.withOpacity(0.6))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryGreen.withOpacity(0.12),
                      AppTheme.primaryGreen.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.25), width: 1.2),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.check_circle, color: AppTheme.primaryGreen, size: 24),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Account Status', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.primaryGreen)),
                          SizedBox(height: 2),
                          Text('Active', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Log out?'),
                        content: const Text('You will need to sign in again to access your profile.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          FilledButton(
                            style: FilledButton.styleFrom(backgroundColor: Colors.red),
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Log Out'),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      await AuthService.instance.signOut();
                    }
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Log Out', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Profile page (shown in bottom nav 5th tab)
// ─────────────────────────────────────────────────────────────────────────────
class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.beige,
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          color: AppTheme.textDark,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      body: StreamBuilder<User?>(
        stream: AuthService.instance.authStateChanges().handleError((e) {
          debugPrint('Auth stream error: $e');
        }),
        builder: (context, authSnap) {
          if (authSnap.hasError) {
            return _profileErrorWidget('Auth error', 'Please try again');
          }
          final user = authSnap.data;
          if (user == null) {
            return _profileNotSignedInWidget(context);
          }
          return _UserDataWidget(user: user);
        },
      ),
    );
  }
}

class _UserDataWidget extends StatelessWidget {
  final User user;
  const _UserDataWidget({required this.user});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: AuthService.instance.userDocStream(user.uid).handleError((e) {
        debugPrint('Firestore error: $e');
      }),
      builder: (context, docSnap) {
        if (docSnap.hasError) {
          return _profileErrorWidget('Load failed', 'Try refreshing');
        }
        if (docSnap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        try {
          final data = docSnap.data?.data() ?? <String, dynamic>{};
          final name = (data['name'] as String?) ?? user.displayName ?? 'User';
          final email = user.email ?? '';
          final initials = _initialsOf(name);
          return _profileSignedInWidget(context, initials, name, email);
        } catch (e) {
          debugPrint('Profile data error: $e');
          return _profileErrorWidget('Data error', 'Failed to load profile');
        }
      },
    );
  }
}


// ─────────────────────────────────────────────────────────────────────────────
// Drawer widget
// ─────────────────────────────────────────────────────────────────────────────
class _GirDrawer extends StatelessWidget {
  final void Function(Widget) onNavigate;
  const _GirDrawer({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    void go(Widget screen) {
      Navigator.pop(context);
      onNavigate(screen);
    }

    return Drawer(
      backgroundColor: AppTheme.warmWhite,
      child: Column(
        children: [
          // Enhanced header with glassmorphism
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 20,
                right: 20,
                bottom: 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1B5E20),
                  Color(0xFF2E7D32),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.25),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'gir_yatra_icon.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.95),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Text(
                    'Gir Yatra',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ગિર યાત્રા · Offline Guide',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Menu
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              children: [
                _MenuSection(
                  title: 'MAIN',
                  items: [
                    _MenuItem(
                      Icons.home_outlined,
                      'Home',
                          () => Navigator.pop(context),
                    ),
                    _MenuItem(
                      Icons.directions_car_outlined,
                      'Safari Info',
                          () => go(const SafariScreen()),
                    ),
                    _MenuItem(
                      Icons.hotel_outlined,
                      'Stay & Accommodation',
                          () => go(const StayScreen()),
                    ),
                    _MenuItem(
                      Icons.restaurant_menu_outlined,
                      'Food & Culture',
                          () => go(const FoodCultureScreen()),
                    ),
                    _MenuItem(
                      Icons.place_outlined,
                      'Nearby Places',
                          () => go(const NearbyPlacesScreen()),
                    ),
                    _MenuItem(
                      Icons.calendar_month_outlined,
                      'Itinerary',
                          () => go(const ItineraryScreen()),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _MenuSection(
                  title: 'TRAVEL',
                  items: [
                    _MenuItem(
                      Icons.directions_bus_outlined,
                      'How to Reach',
                          () => go(const TransportScreen()),
                    ),
                    _MenuItem(
                      Icons.wb_sunny_outlined,
                      'Seasonal Guide',
                          () => go(const SeasonalScreen()),
                    ),
                    _MenuItem(
                      Icons.checklist_outlined,
                      'Packing Checklist',
                          () => go(const ChecklistScreen()),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _MenuSection(
                  title: 'SUPPORT',
                  items: [
                    _MenuItem(
                      Icons.emergency_share_outlined,
                      'Emergency & Safety',
                          () => go(const EmergencyScreen()),
                      color: Colors.red,
                    ),
                    _MenuItem(
                      Icons.search_outlined,
                      'Search Everything',
                          () => go(const SearchScreen()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _initialsOf(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty || parts.first.isEmpty) return '?';
  if (parts.length == 1) return parts.first[0].toUpperCase();
  return (parts.first[0] + parts.last[0]).toUpperCase();
}


class _MenuSection extends StatelessWidget {
  final String title;
  final List<_MenuItem> items;

  const _MenuSection({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              color: AppTheme.primaryGreen,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ),
        ...items.map((item) => _MenuTile(item: item)),
      ],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color color;

  const _MenuItem(
      this.icon,
      this.title,
      this.onTap, {
        this.color = AppTheme.primaryGreen,
      });
}

class _MenuTile extends StatefulWidget {
  final _MenuItem item;

  const _MenuTile({required this.item});

  @override
  State<_MenuTile> createState() => _MenuTileState();
}

class _MenuTileState extends State<_MenuTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.item.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.item.color.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? widget.item.color.withOpacity(0.2)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.item.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                widget.item.icon,
                color: widget.item.color,
                size: 20,
              ),
            ),
            title: Text(
              widget.item.title,
              style: const TextStyle(
                color: AppTheme.primaryBrown,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: _isHovered
                ? Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: widget.item.color.withOpacity(0.6),
            )
                : null,
            horizontalTitleGap: 12,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Feature card
// ─────────────────────────────────────────────────────────────────────────────
class _Feat {
  final String title, subtitle;
  final IconData icon;
  final List<Color> colors;
  final VoidCallback onTap;
  const _Feat(this.title, this.subtitle, this.icon, this.colors, this.onTap);
}

class _FeatureCard extends StatefulWidget {
  final _Feat feat;
  const _FeatureCard({required this.feat});

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.feat.onTap,
      child: RepaintBoundary(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.feat.colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: widget.feat.colors.first.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        widget.feat.icon,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.feat.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.feat.subtitle,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
    );
  }
}
