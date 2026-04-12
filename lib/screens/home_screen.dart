// lib/screens/home_screen.dart
// Gir Yatra v2 — Main home with drawer navigation + full dashboard

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/static_data.dart';
import '../data/extra_data.dart';
import '../state/app_state.dart';
import '../widgets/custom_card.dart';
import 'safari_screen.dart';
import 'stay_screen.dart';
import 'food_culture_screen.dart';
import 'map_screen.dart';
import 'nearby_places_screen.dart';
import 'itinerary_screen.dart';
import 'emergency_screen.dart';
import 'transport_screen.dart';
import 'checklist_screen.dart';
import 'seasonal_screen.dart';
import 'search_screen.dart';

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
    final state = AppStateProvider.of(context);

    return Scaffold(
      backgroundColor: AppTheme.beige,
      drawer: _GirDrawer(onNavigate: (screen) => _push(context, screen)),
      body: CustomScrollView(
        slivers: [
          // Sliver app bar with collapsing hero
          SliverAppBar(
            expandedHeight: 210,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.primaryGreen,
            leading: Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            ),
            title: const Text('🦁 Gir Yatra',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            actions: [
              IconButton(
                onPressed: () =>
                    _push(context, const SearchScreen()),
                icon: const Icon(Icons.search, color: Colors.white),
                tooltip: 'Search',
              ),
              IconButton(
                onPressed: () => state.toggleDarkMode(),
                icon: Icon(
                    state.data.isDarkMode
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    color: Colors.white),
                tooltip: 'Toggle theme',
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeroHeader(),
              collapseMode: CollapseMode.parallax,
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Emergency quick-access
                _buildEmergencyBanner(context),

                // This month's forest status
                _buildForestStatusCard(context),

                // Quick facts horizontal scroll
                _buildQuickFacts(),

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

  Widget _buildHeroHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF33691E)],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
              right: 10,
              top: 20,
              child: Opacity(
                  opacity: 0.07,
                  child: Text('🐾',
                      style: TextStyle(fontSize: 100)))),
          const Positioned(
              right: 65,
              bottom: 10,
              child: Opacity(
                  opacity: 0.05,
                  child: Text('🦁',
                      style: TextStyle(fontSize: 60)))),
          Padding(
            padding:
                const EdgeInsets.fromLTRB(20, 90, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Welcome to',
                    style: TextStyle(
                        color: Colors.white70, fontSize: 13)),
                const Text('Sasan Gir 🌿',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                      'Explore the Land of Asiatic Lions',
                      style: TextStyle(
                          color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(
              builder: (_) => const EmergencyScreen())),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 14, 16, 4),
        padding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.09),
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: Colors.red.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.emergency,
                  color: Colors.red, size: 18),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Emergency contacts & forest first-aid guide →',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 12, color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildForestStatusCard(BuildContext context) {
    final now = DateTime.now();
    final currentMonth = seasonalCalendar
        .firstWhere((m) => m.monthIndex == now.month);

    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(
              builder: (_) => const SeasonalScreen())),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 6, 16, 4),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color:
              currentMonth.statusColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: currentMonth.statusColor
                  .withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.forest,
                color: currentMonth.statusColor,
                size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    '${currentMonth.month}: ${currentMonth.forestStatus}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: currentMonth.statusColor,
                        fontSize: 13),
                  ),
                  Text(
                    currentMonth.wildlifeActivity,
                    style: const TextStyle(
                        color: AppTheme.primaryBrown,
                        fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                size: 12,
                color: currentMonth.statusColor),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickFacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
            title: 'Quick Facts', icon: Icons.info_outline),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding:
                const EdgeInsets.symmetric(horizontal: 16),
            itemCount: quickFacts.length,
            itemBuilder: (_, i) {
              final f = quickFacts[i];
              return Container(
                width: 110,
                margin: const EdgeInsets.only(right: 10),
                child: QuickFactChip(
                    icon: f.icon,
                    label: f.label,
                    value: f.value,
                    color: f.color),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    final items = [
      _Feat('Safari Info', 'Timings & fees',
          Icons.directions_car,
          [const Color(0xFF2E7D32), const Color(0xFF1B5E20)],
          () => _push(context, const SafariScreen())),
      _Feat('Stay', 'Hotels & resorts',
          Icons.hotel,
          [const Color(0xFF5D4037), const Color(0xFF3E2723)],
          () => _push(context, const StayScreen())),
      _Feat('Food & Culture', 'Local cuisine',
          Icons.restaurant_menu,
          [const Color(0xFFE65100), const Color(0xFFBF360C)],
          () => _push(context, const FoodCultureScreen())),
      _Feat('Offline Map', 'Interactive pins',
          Icons.map,
          [const Color(0xFF0277BD), const Color(0xFF01579B)],
          () => _push(context, const MapScreen())),
      _Feat('How to Reach', 'Bus, train & car',
          Icons.directions_bus,
          [const Color(0xFF6A1B9A), const Color(0xFF4A148C)],
          () => _push(context, const TransportScreen())),
      _Feat('Seasonal Guide', 'Best time to visit',
          Icons.wb_sunny_outlined,
          [const Color(0xFFFF8F00), const Color(0xFFE65100)],
          () => _push(context, const SeasonalScreen())),
      _Feat('Nearby Places', 'Somnath & more',
          Icons.place,
          [const Color(0xFF00695C), const Color(0xFF004D40)],
          () => _push(context, const NearbyPlacesScreen())),
      _Feat('Itinerary', '1 & 2-Day plans',
          Icons.calendar_month,
          [const Color(0xFF558B2F), const Color(0xFF33691E)],
          () => _push(context, const ItineraryScreen())),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.4,
        ),
        itemCount: items.length,
        itemBuilder: (_, i) =>
            _FeatureCard(feat: items[i]),
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
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
                horizontal: 16),
            itemCount: wildlifeFacts.length,
            itemBuilder: (_, i) {
              final f = wildlifeFacts[i];
              return Container(
                width: 260,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: f.color.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: f.color.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(f.emoji,
                            style: const TextStyle(
                                fontSize: 22)),
                        const SizedBox(width: 8),
                        Text(f.animal,
                            style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                color: f.color,
                                fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(f.fact,
                          style: const TextStyle(
                              color: AppTheme.primaryBrown,
                              fontSize: 11,
                              height: 1.4),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis),
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
        margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color:
                  AppTheme.primaryGreen.withOpacity(0.25)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen
                    .withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.eco,
                  color: AppTheme.primaryGreen, size: 22),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text('Be an Eco-Conscious Tourist!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryGreen,
                          fontSize: 13)),
                  SizedBox(height: 2),
                  Text('Tap to see green travel tips 🌿',
                      style: TextStyle(
                          color: AppTheme.lightBrown,
                          fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 13,
                color: AppTheme.primaryGreen),
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
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(24)),
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
                    Icon(Icons.eco,
                        color: AppTheme.primaryGreen),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 8),
                  itemCount: ecoTips.length,
                  itemBuilder: (_, i) =>
                      EcoTipCard(tip: ecoTips[i], index: i),
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
// Drawer widget
// ─────────────────────────────────────────────────────────────────────────────
class _GirDrawer extends StatelessWidget {
  final void Function(Widget) onNavigate;
  const _GirDrawer({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final state = AppStateProvider.of(context);

    void go(Widget screen) {
      Navigator.pop(context);
      onNavigate(screen);
    }

    return Drawer(
      backgroundColor: AppTheme.warmWhite,
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 20,
                right: 20,
                bottom: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('🦁',
                    style: TextStyle(fontSize: 44)),
                const SizedBox(height: 8),
                const Text('Gir Yatra',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                Text('ગિર યાત્રા · Offline Guide',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12)),
              ],
            ),
          ),

          // Menu
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _tile(Icons.home, 'Home',
                    () => Navigator.pop(context)),
                _tile(Icons.directions_car, 'Safari Info',
                    () => go(const SafariScreen())),
                _tile(Icons.hotel, 'Stay & Accommodation',
                    () => go(const StayScreen())),
                _tile(Icons.restaurant_menu, 'Food & Culture',
                    () => go(const FoodCultureScreen())),
                _tile(Icons.map, 'Offline Map',
                    () => go(const MapScreen())),
                _tile(Icons.place, 'Nearby Places',
                    () => go(const NearbyPlacesScreen())),
                _tile(Icons.calendar_month, 'Itinerary',
                    () => go(const ItineraryScreen())),
                const Divider(height: 1),
                _tile(Icons.directions_bus, 'How to Reach',
                    () => go(const TransportScreen())),
                _tile(Icons.wb_sunny_outlined, 'Seasonal Guide',
                    () => go(const SeasonalScreen())),
                _tile(Icons.checklist, 'Packing Checklist',
                    () => go(const ChecklistScreen())),
                const Divider(height: 1),
                _tile(Icons.emergency, 'Emergency & Safety',
                    () => go(const EmergencyScreen()),
                    color: Colors.red),
                _tile(Icons.search, 'Search Everything',
                    () => go(const SearchScreen())),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(
                      state.data.isDarkMode
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      color: AppTheme.primaryGreen),
                  title: Text(
                      state.data.isDarkMode
                          ? 'Light Mode'
                          : 'Dark Mode',
                      style: const TextStyle(
                          color: AppTheme.primaryBrown,
                          fontSize: 14)),
                  trailing: Switch(
                    value: state.data.isDarkMode,
                    onChanged: (_) => state.toggleDarkMode(),
                    activeThumbColor: AppTheme.primaryGreen,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Text('Gir Yatra v2.0 · 100% Offline\nNo internet required',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppTheme.lightBrown.withOpacity(0.55),
                    fontSize: 11)),
          ),
        ],
      ),
    );
  }

  Widget _tile(IconData icon, String title, VoidCallback onTap,
      {Color color = AppTheme.primaryGreen}) {
    return ListTile(
      leading: Icon(icon, color: color, size: 22),
      title: Text(title,
          style: const TextStyle(
              color: AppTheme.primaryBrown, fontSize: 14)),
      onTap: onTap,
      horizontalTitleGap: 8,
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

class _FeatureCard extends StatelessWidget {
  final _Feat feat;
  const _FeatureCard({required this.feat});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: feat.onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: feat.colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: feat.colors.first.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -8,
              bottom: -8,
              child: Icon(feat.icon,
                  size: 60,
                  color: Colors.white.withOpacity(0.1)),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius:
                            BorderRadius.circular(10)),
                    child: Icon(feat.icon,
                        color: Colors.white, size: 20),
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(feat.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      Text(feat.subtitle,
                          style: TextStyle(
                              color: Colors.white
                                  .withOpacity(0.8),
                              fontSize: 10),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
