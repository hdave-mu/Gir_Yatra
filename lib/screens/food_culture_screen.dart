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
        title: const Text('🍛 Food & Culture'),
        backgroundColor: AppTheme.safariOrange,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE65100), Color(0xFFFF8F00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Text('🍛', style: TextStyle(fontSize: 50)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kathiyawadi Cuisine',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bold, rustic and deeply satisfying — the food of Saurashtra region',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEatingGuide() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.tips_and_updates, color: AppTheme.goldenAmber),
                SizedBox(width: 8),
                Text(
                  'Eating Tips',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppTheme.primaryBrown,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _tipRow('Most restaurants are pure vegetarian in Sasan Gir'),
            _tipRow('Always ask for "thali" — best value for money'),
            _tipRow('Try Gir buffalo milk chai at least once!'),
            _tipRow('Kesar mango season is May–July — don\'t miss it'),
            _tipRow('Carry cash — many small dhabas don\'t accept cards'),
          ],
        ),
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
              style: const TextStyle(fontSize: 13, color: AppTheme.primaryBrown, height: 1.4),
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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.safariOrange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(dish.icon, color: AppTheme.safariOrange, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dish.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppTheme.primaryBrown,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.circle, size: 8, color: AppTheme.primaryGreen),
                            SizedBox(width: 4),
                            Text(
                              'Pure Veg',
                              style: TextStyle(color: AppTheme.primaryGreen, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Description
            Text(
              dish.description,
              style: const TextStyle(
                color: AppTheme.primaryBrown,
                fontSize: 13,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 8),

            // Best found at
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.beige,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.place_outlined, size: 14, color: AppTheme.lightBrown),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      dish.bestFoundAt,
                      style: const TextStyle(
                        color: AppTheme.lightBrown,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
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

        ...cultureTraditions.map((tradition) => _CultureCard(tradition: tradition)),

        _buildLifestyleNote(),
      ],
    );
  }

  Widget _buildCultureBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4A148C), Color(0xFF6A1B9A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Text('🎭', style: TextStyle(fontSize: 50)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gir\'s Living Culture',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Where tribal wisdom meets vibrant Gujarati heritage',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifestyleNote() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.goldenAmber.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.goldenAmber.withOpacity(0.3)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.favorite, color: AppTheme.goldenAmber, size: 18),
              SizedBox(width: 8),
              Text(
                'Respect Local Culture',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.goldenAmber,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '• Dress modestly when visiting temples and villages\n'
            '• Always ask permission before photographing locals\n'
            '• Learn a greeting in Gujarati: "Kem cho?" (How are you?)\n'
            '• Respect the Maldhari way of life — don\'t rush them\n'
            '• Supporting local handicraft artisans directly is appreciated',
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

class _CultureCard extends StatelessWidget {
  final CultureTradition tradition;
  const _CultureCard({required this.tradition});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
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
                    color: AppTheme.primaryBrown.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(tradition.icon, color: AppTheme.primaryBrown, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    tradition.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppTheme.primaryBrown,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              tradition.description,
              style: const TextStyle(
                color: AppTheme.primaryBrown,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
