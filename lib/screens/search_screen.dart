// lib/screens/search_screen.dart
// Universal search across places, hotels, dishes, traditions, safari info

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/static_data.dart';
import '../data/extra_data.dart';
import '../animations/page_transitions.dart';
import 'nearby_places_screen.dart';
import 'stay_screen.dart';
import 'food_culture_screen.dart';
import 'transport_screen.dart';
import 'safari_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';
  Future<List<_SearchResult>>? _searchFuture;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<_SearchResult> _computeResults() {
    if (_query.trim().isEmpty) return [];
    final q = _query.toLowerCase();
    final results = <_SearchResult>[];

    // Search nearby places
    for (final place in nearbyPlaces) {
      if (place.name.toLowerCase().contains(q) ||
          place.shortDescription.toLowerCase().contains(q) ||
          place.fullDescription.toLowerCase().contains(q)) {
        results.add(_SearchResult(
          title: place.name,
          subtitle: place.shortDescription,
          category: 'Nearby Place',
          icon: place.icon,
          color: place.color,
          onTap: (ctx) => Navigator.push(
              ctx,
              SlidePageRoute(page: PlaceDetailScreen(place: place))),
        ));
      }
    }

    // Search hotels
    for (final hotel in hotels) {
      if (hotel.name.toLowerCase().contains(q) ||
          hotel.location.toLowerCase().contains(q) ||
          hotel.type.toLowerCase().contains(q) ||
          hotel.description.toLowerCase().contains(q)) {
        results.add(_SearchResult(
          title: hotel.name,
          subtitle: '${hotel.type} · ${hotel.priceRange}',
          category: 'Hotel / Stay',
          icon: hotel.icon,
          color: AppTheme.primaryBrown,
          onTap: (ctx) => showHotelDetail(ctx, hotel),
        ));
      }
    }

    // Search dishes
    for (final dish in localDishes) {
      if (dish.name.toLowerCase().contains(q) ||
          dish.description.toLowerCase().contains(q)) {
        results.add(_SearchResult(
          title: dish.name,
          subtitle: dish.bestFoundAt,
          category: 'Local Food',
          icon: dish.icon,
          color: AppTheme.safariOrange,
          onTap: (ctx) => _showInfoSheet(
            ctx,
            title: dish.name,
            icon: dish.icon,
            color: AppTheme.safariOrange,
            rows: {
              'Best at': dish.bestFoundAt,
              'About': dish.description,
            },
            openLabel: 'Open Food & Culture',
            onOpen: () => Navigator.push(
                ctx, SlidePageRoute(page: const FoodCultureScreen())),
          ),
        ));
      }
    }

    // Search culture
    for (final c in cultureTraditions) {
      if (c.title.toLowerCase().contains(q) ||
          c.description.toLowerCase().contains(q)) {
        results.add(_SearchResult(
          title: c.title,
          subtitle:
              c.description.substring(0, c.description.length.clamp(0, 80)),
          category: 'Culture',
          icon: c.icon,
          color: AppTheme.primaryBrown,
          onTap: (ctx) => _showInfoSheet(
            ctx,
            title: c.title,
            icon: c.icon,
            color: AppTheme.primaryBrown,
            rows: {'About': c.description},
            openLabel: 'Open Food & Culture',
            onOpen: () => Navigator.push(
                ctx, SlidePageRoute(page: const FoodCultureScreen())),
          ),
        ));
      }
    }

    // Search transport
    for (final t in transportOptions) {
      if (t.mode.toLowerCase().contains(q) ||
          t.from.toLowerCase().contains(q) ||
          t.tips.toLowerCase().contains(q)) {
        results.add(_SearchResult(
          title: t.mode,
          subtitle: 'From ${t.from} · ${t.duration}',
          category: 'Transport',
          icon: t.icon,
          color: t.color,
          onTap: (ctx) => _showInfoSheet(
            ctx,
            title: t.mode,
            icon: t.icon,
            color: t.color,
            rows: {
              'From': t.from,
              'Duration': t.duration,
              'Tips': t.tips,
            },
            openLabel: 'Open Transport',
            onOpen: () => Navigator.push(
                ctx, SlidePageRoute(page: const TransportScreen())),
          ),
        ));
      }
    }

    // Search safari rules
    for (final rule in safariRules) {
      if (rule.toLowerCase().contains(q)) {
        results.add(_SearchResult(
          title: 'Safari Rule',
          subtitle: rule,
          category: 'Safari',
          icon: Icons.directions_car,
          color: AppTheme.primaryGreen,
          onTap: (ctx) => _showInfoSheet(
            ctx,
            title: 'Safari Rule',
            icon: Icons.directions_car,
            color: AppTheme.primaryGreen,
            rows: {'Rule': rule},
            openLabel: 'Open Safari',
            onOpen: () => Navigator.push(
                ctx, SlidePageRoute(page: const SafariScreen())),
          ),
        ));
      }
    }

    // Search eco tips
    for (final tip in ecoTips) {
      if (tip.toLowerCase().contains(q)) {
        results.add(_SearchResult(
          title: 'Eco Tip',
          subtitle: tip,
          category: 'Eco',
          icon: Icons.eco,
          color: AppTheme.primaryGreen,
          onTap: (ctx) => _showInfoSheet(
            ctx,
            title: 'Eco Tip',
            icon: Icons.eco,
            color: AppTheme.primaryGreen,
            rows: {'Tip': tip},
            openLabel: 'Open Safari',
            onOpen: () => Navigator.push(
                ctx, SlidePageRoute(page: const SafariScreen())),
          ),
        ));
      }
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.beige,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryGreen,
        elevation: 0,
        shadowColor: Colors.transparent,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _controller,
              autofocus: true,
              style: const TextStyle(
                color: AppTheme.primaryBrown,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              cursorColor: AppTheme.primaryGreen,
              decoration: InputDecoration(
                hintText: 'Search places, hotels, food...',
                hintStyle: TextStyle(
                  color: AppTheme.lightBrown.withValues(alpha: 0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(Icons.search,
                    color: AppTheme.primaryGreen.withValues(alpha: 0.7), size: 20),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onChanged: (v) {
                setState(() => _query = v);
                if (v.trim().isNotEmpty) {
                  _searchFuture = Future(() => _computeResults());
                }
              },
            ),
          ),
        ),
        actions: [
          if (_query.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.white),
              onPressed: () {
                _controller.clear();
                setState(() => _query = '');
              },
            )
          else
            const SizedBox(width: 8),
        ],
      ),
      body: _query.trim().isEmpty
          ? _buildEmptyState()
          : FutureBuilder<List<_SearchResult>>(
              future: _searchFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(
                                AppTheme.primaryGreen,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Searching...',
                            style: TextStyle(
                              color: AppTheme.primaryBrown.withValues(alpha: 0.6),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                final results = snapshot.data ?? [];
                return results.isEmpty
                    ? _buildNoResults()
                    : _buildResults(results);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search,
              size: 64, color: AppTheme.primaryBrown.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          const Text('Search Gir Yatra',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryBrown)),
          const SizedBox(height: 8),
          Text(
            'Places · Hotels · Food · Transport\nCulture · Safari · Eco Tips',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppTheme.lightBrown.withValues(alpha: 0.7), fontSize: 13),
          ),
          const SizedBox(height: 24),
          // Suggestion chips
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: ['lion', 'hotel', 'safari', 'somnath', 'thali', 'train']
                .map((s) => ActionChip(
                      label: Text(s),
                      onPressed: () {
                        _controller.text = s;
                        setState(() => _query = s);
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🔍', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text('No results for "$_query"',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryBrown)),
          const SizedBox(height: 6),
          const Text('Try different keywords',
              style: TextStyle(color: AppTheme.lightBrown)),
        ],
      ),
    );
  }

  Widget _buildResults(List<_SearchResult> results) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Text(
              '${results.length} result${results.length > 1 ? 's' : ''}',
              style: const TextStyle(color: AppTheme.lightBrown, fontSize: 13)),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 24),
            itemCount: results.length,
            itemBuilder: (ctx, i) =>
                _ResultTile(result: results[i], query: _query),
          ),
        ),
      ],
    );
  }
}

void _showInfoSheet(
  BuildContext context, {
  required String title,
  required IconData icon,
  required Color color,
  required Map<String, String> rows,
  required String openLabel,
  required VoidCallback onOpen,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetCtx) => DraggableScrollableSheet(
      initialChildSize: 0.55,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      expand: false,
      builder: (_, ctrl) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.warmWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ListView(
          controller: ctrl,
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 26),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: AppTheme.primaryBrown,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            ...rows.entries.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.key.toUpperCase(),
                        style: const TextStyle(
                          color: AppTheme.lightBrown,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        e.value,
                        style: const TextStyle(
                          color: AppTheme.primaryBrown,
                          fontSize: 14,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(sheetCtx);
                  onOpen();
                },
                icon: const Icon(Icons.arrow_forward, size: 18),
                label: Text(
                  openLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _SearchResult {
  final String title;
  final String subtitle;
  final String category;
  final IconData icon;
  final Color color;
  final void Function(BuildContext) onTap;

  const _SearchResult({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class _ResultTile extends StatelessWidget {
  final _SearchResult result;
  final String query;

  const _ResultTile({required this.result, required this.query});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => result.onTap(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              result.color.withValues(alpha: 0.08),
              result.color.withValues(alpha: 0.02),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: result.color.withValues(alpha: 0.2),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: result.color.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: result.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: result.color.withValues(alpha: 0.25),
                    width: 1,
                  ),
                ),
                child: Icon(result.icon, color: result.color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _HighlightedText(
                              text: result.title,
                              query: query,
                              baseStyle: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                color: AppTheme.primaryBrown,
                              )),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: result.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: result.color.withValues(alpha: 0.25),
                              width: 0.8,
                            ),
                          ),
                          child: Text(result.category,
                              style: TextStyle(
                                color: result.color,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(result.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppTheme.primaryBrown.withValues(alpha: 0.7),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )),
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

// Simple highlighted text widget
class _HighlightedText extends StatelessWidget {
  final String text;
  final String query;
  final TextStyle baseStyle;

  const _HighlightedText(
      {required this.text, required this.query, required this.baseStyle});

  @override
  Widget build(BuildContext context) {
    final q = query.toLowerCase();
    final t = text.toLowerCase();
    final idx = t.indexOf(q);
    if (idx < 0 || q.isEmpty) return Text(text, style: baseStyle);

    return RichText(
      text: TextSpan(children: [
        TextSpan(text: text.substring(0, idx), style: baseStyle),
        TextSpan(
          text: text.substring(idx, idx + q.length),
          style: baseStyle.copyWith(
              backgroundColor: AppTheme.goldenAmber.withValues(alpha: 0.3),
              color: AppTheme.primaryBrown),
        ),
        TextSpan(text: text.substring(idx + q.length), style: baseStyle),
      ]),
    );
  }
}
