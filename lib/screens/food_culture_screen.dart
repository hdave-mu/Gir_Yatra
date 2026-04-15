// lib/screens/food_culture_screen.dart
// Food & Culture Screen with local dishes and traditions

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/static_data.dart';
import '../widgets/custom_card.dart';

class FoodCultureScreen extends StatefulWidget {
  const FoodCultureScreen({super.key});

  @override
  State<FoodCultureScreen> createState() => _FoodCultureScreenState();
}

class _FoodCultureScreenState extends State<FoodCultureScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.beige,
      appBar: AppBar(
        title: const Text('🍛 Food & Culture',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              letterSpacing: 0.3,
            )),
        backgroundColor: AppTheme.safariOrange,
        elevation: 0,
        shadowColor: Colors.transparent,
        centerTitle: false,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
          tabs: const [
            Tab(icon: Icon(Icons.restaurant_menu), text: 'Local Food'),
            Tab(icon: Icon(Icons.people), text: 'Culture'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _FoodTab(),
          _CultureTab(),
        ],
      ),
    );
  }
}

// ── Food Tab ──────────────────────────────────────────────────
class _FoodTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        // Intro banner
        _buildFoodBanner(),

        // Dishes
        const SectionHeader(
          title: 'Must-Try Dishes',
          subtitle: 'Authentic Kathiyawadi cuisine',
          icon: Icons.restaurant,
          iconColor: AppTheme.safariOrange,
        ),

        ...localDishes.map((dish) => _DishCard(dish: dish)),

        // Eating guide
        _buildEatingGuide(),
      ],
    );
  }

  Widget _buildFoodBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE65100), Color(0xFFFF8F00), Color(0xFFFFB300)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE65100).withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: const Color(0xFFE65100).withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -15,
            top: -15,
            child: Opacity(
              opacity: 0.1,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Text('🍛', style: TextStyle(fontSize: 40)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kathiyawadi Cuisine',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Bold, rustic and deeply satisfying — the food of Saurashtra region',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
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
        ],
      ),
    );
  }

  Widget _buildEatingGuide() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.goldenAmber.withOpacity(0.12),
            AppTheme.goldenAmber.withOpacity(0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.goldenAmber.withOpacity(0.25),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.goldenAmber.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.goldenAmber.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.goldenAmber.withOpacity(0.25),
                    width: 1,
                  ),
                ),
                child: const Icon(Icons.tips_and_updates,
                    color: AppTheme.goldenAmber, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Eating Tips',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: AppTheme.primaryBrown,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _tipRow('Most restaurants are pure vegetarian in Sasan Gir'),
          _tipRow('Always ask for "thali" — best value for money'),
          _tipRow('Try Gir buffalo milk chai at least once!'),
          _tipRow('Kesar mango season is May–July — don\'t miss it'),
          _tipRow('Carry cash — many small dhabas don\'t accept cards'),
        ],
      ),
    );
  }

  Widget _tipRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 6, color: AppTheme.safariOrange),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 13, color: AppTheme.primaryBrown, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _DishCard extends StatelessWidget {
  final LocalDish dish;
  const _DishCard({required this.dish});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.safariOrange.withOpacity(0.1),
            AppTheme.safariOrange.withOpacity(0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.safariOrange.withOpacity(0.2),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.safariOrange.withOpacity(0.14),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.safariOrange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.safariOrange.withOpacity(0.25),
                      width: 1,
                    ),
                  ),
                  child:
                      Icon(dish.icon, color: AppTheme.safariOrange, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dish.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: AppTheme.primaryBrown,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGreen.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppTheme.primaryGreen.withOpacity(0.2),
                            width: 0.8,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.eco,
                                size: 10, color: AppTheme.primaryGreen),
                            SizedBox(width: 4),
                            Text(
                              'Pure Veg',
                              style: TextStyle(
                                color: AppTheme.primaryGreen,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              dish.description,
              style: TextStyle(
                color: AppTheme.primaryBrown.withOpacity(0.8),
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 10),

            // Best found at
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppTheme.primaryGreen.withOpacity(0.15),
                  width: 0.8,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined,
                      size: 14, color: AppTheme.primaryGreen),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      dish.bestFoundAt,
                      style: TextStyle(
                        color: AppTheme.primaryGreen.withOpacity(0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
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
}

// ── Culture Tab ───────────────────────────────────────────────
class _CultureTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        _buildCultureBanner(),
        const SectionHeader(
          title: 'People & Traditions',
          subtitle: 'Rich cultural heritage of Saurashtra',
          icon: Icons.people,
          iconColor: AppTheme.primaryBrown,
        ),
        ...cultureTraditions
            .map((tradition) => _CultureCard(tradition: tradition)),
        _buildLifestyleNote(),
      ],
    );
  }

  Widget _buildCultureBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4A148C), Color(0xFF6A1B9A), Color(0xFF7B1FA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6A1B9A).withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: const Color(0xFF6A1B9A).withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: -15,
            bottom: -15,
            child: Opacity(
              opacity: 0.1,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Text('🎭', style: TextStyle(fontSize: 40)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gir\'s Living Culture',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Where tribal wisdom meets vibrant Gujarati heritage',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
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
        ],
      ),
    );
  }

  Widget _buildLifestyleNote() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.goldenAmber.withOpacity(0.12),
            AppTheme.goldenAmber.withOpacity(0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.goldenAmber.withOpacity(0.25),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.goldenAmber.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.goldenAmber.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.goldenAmber.withOpacity(0.25),
                    width: 1,
                  ),
                ),
                child: const Icon(Icons.favorite,
                    color: AppTheme.goldenAmber, size: 18),
              ),
              const SizedBox(width: 12),
              const Text(
                'Respect Local Culture',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppTheme.goldenAmber,
                  fontSize: 15,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            '• Dress modestly when visiting temples and villages\n'
            '• Always ask permission before photographing locals\n'
            '• Learn a greeting in Gujarati: "Kem cho?" (How are you?)\n'
            '• Respect the Maldhari way of life — don\'t rush them\n'
            '• Supporting local handicraft artisans directly is appreciated',
            style: TextStyle(
              color: AppTheme.primaryBrown.withOpacity(0.8),
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}

class _CultureCard extends StatelessWidget {
  final CultureTradition tradition;
  const _CultureCard({required this.tradition});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryBrown.withOpacity(0.08),
            AppTheme.primaryBrown.withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.primaryBrown.withOpacity(0.15),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBrown.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBrown.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.primaryBrown.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Icon(tradition.icon,
                      color: AppTheme.primaryBrown, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    tradition.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: AppTheme.primaryBrown,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              tradition.description,
              style: TextStyle(
                color: AppTheme.primaryBrown.withOpacity(0.8),
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
