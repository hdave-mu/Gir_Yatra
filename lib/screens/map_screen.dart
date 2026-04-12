// lib/screens/map_screen.dart
// Offline Map Screen — custom-painted canvas with interactive location pins.
//
// KEY FIX: LayoutBuilder wraps the entire canvas so that each pin's Positioned
// widget receives real pixel coordinates (mapW × relX, mapH × relY) instead of
// unbounded constraints.  The old code returned a Positioned from inside a
// LayoutBuilder that was a direct child of Stack, which causes a FlutterError:
//   "Positioned widgets must be placed directly inside Stack widgets."

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/static_data.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapLocation? _selectedLocation;
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.beige,
      appBar: AppBar(
        title: const Text('🗺️ Offline Map'),
        backgroundColor: AppTheme.skyBlue,
        actions: [
          IconButton(
            onPressed: () => setState(() {
              _scale = 1.0;
              _selectedLocation = null;
            }),
            icon: const Icon(Icons.refresh, color: Colors.white),
            tooltip: 'Reset view',
          ),
        ],
      ),
      body: Column(
        children: [
          // Map canvas — 60% of available height
          Expanded(flex: 3, child: _buildMapCanvas()),

          // Detail panel — animates open when a pin is tapped
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            height: _selectedLocation != null ? 160 : 0,
            child: ClipRect(
              child: _selectedLocation != null
                  ? _buildLocationDetail(_selectedLocation!)
                  : const SizedBox.shrink(),
            ),
          ),

          // Horizontal location list — 40% of available height
          Expanded(flex: 2, child: _buildLocationList()),
        ],
      ),
    );
  }

  // ── Map Canvas ─────────────────────────────────────────────────────────────
  Widget _buildMapCanvas() {
    // LayoutBuilder gives us finite mapW / mapH from the Expanded parent.
    // These values are passed to every pin so that Positioned receives
    // real pixel left/top values — never unbounded constraints.
    return LayoutBuilder(
      builder: (context, constraints) {
        final mapW = constraints.maxWidth;
        final mapH = constraints.maxHeight;

        return GestureDetector(
          // onScaleStart must be present when onScaleUpdate is used
          onScaleStart: (_) {},
          onScaleUpdate: (details) => setState(
            () => _scale = (_scale * details.scale).clamp(0.8, 3.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.2,
                colors: [
                  const Color(0xFF81C784).withOpacity(0.4),
                  const Color(0xFF66BB6A).withOpacity(0.3),
                  const Color(0xFF4CAF50).withOpacity(0.2),
                ],
              ),
              border: Border(
                bottom: BorderSide(
                    color: AppTheme.primaryBrown.withOpacity(0.2)),
              ),
            ),
            child: Stack(
              children: [
                // ── Static background (terrain / sea / hills) ─────────
                Positioned.fill(
                  child: CustomPaint(painter: _MapBackgroundPainter()),
                ),

                // ── Zoomable layer (roads + pins) ─────────────────────
                // Positioned.fill ensures the inner Stack is exactly the
                // same size as the outer canvas, so Positioned pins work.
                Positioned.fill(
                  child: Transform.scale(
                    scale: _scale,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(painter: _RoadPainter()),
                        ),
                        // Each pin is a proper Positioned inside this Stack
                        ...mapLocations.map(
                            (loc) => _buildPin(loc, mapW, mapH)),
                      ],
                    ),
                  ),
                ),

                // ── Fixed overlays (not zoomed) ────────────────────────
                Positioned(top: 10, left: 16, child: _mapTitleWidget()),
                Positioned(top: 10, right: 10, child: _northIndicator()),
                Positioned(bottom: 10, right: 10, child: _scaleWidget()),
                Positioned(bottom: 10, left: 16, child: _hintWidget()),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── Pin widget ─────────────────────────────────────────────────────────────
  // Takes explicit pixel dimensions — NO LayoutBuilder inside Stack.
  Widget _buildPin(MapLocation loc, double mapW, double mapH) {
    final x = loc.relX * mapW;
    final y = loc.relY * mapH;
    final isSelected = _selectedLocation?.name == loc.name;

    return Positioned(
      left: x - 20,
      top: y - 48,
      child: GestureDetector(
        onTap: () => setState(() {
          _selectedLocation =
              _selectedLocation?.name == loc.name ? null : loc;
        }),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Floating label — only when selected
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: loc.color,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4),
                  ],
                ),
                child: Text(
                  loc.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            // Pin circle — animates size on selection
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? 42 : 34,
              height: isSelected ? 42 : 34,
              decoration: BoxDecoration(
                color: loc.color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.5),
                boxShadow: [
                  BoxShadow(
                    color: loc.color.withOpacity(isSelected ? 0.6 : 0.35),
                    blurRadius: isSelected ? 12 : 5,
                    spreadRadius: isSelected ? 3 : 0,
                  ),
                ],
              ),
              child: Icon(loc.icon, color: Colors.white, size: 17),
            ),

            // Pin tail
            Container(width: 2, height: 6, color: loc.color),
          ],
        ),
      ),
    );
  }

  // ── Location detail panel ──────────────────────────────────────────────────
  Widget _buildLocationDetail(MapLocation loc) {
    return Container(
      color: AppTheme.warmWhite,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: loc.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(loc.icon, color: loc.color, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        loc.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.primaryBrown,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: loc.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        loc.distance,
                        style: TextStyle(
                          color: loc.color,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  loc.category,
                  style: TextStyle(
                      color: loc.color,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  loc.shortInfo,
                  style: const TextStyle(
                      color: AppTheme.primaryBrown,
                      fontSize: 13,
                      height: 1.3),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _selectedLocation = null),
            child: const Icon(Icons.close,
                color: AppTheme.lightBrown, size: 20),
          ),
        ],
      ),
    );
  }

  // ── Horizontal location list ───────────────────────────────────────────────
  Widget _buildLocationList() {
    return Container(
      color: AppTheme.warmWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 4),
            child: Text(
              'All Locations',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBrown,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              itemCount: mapLocations.length,
              itemBuilder: (context, index) {
                final loc = mapLocations[index];
                final isSelected = _selectedLocation?.name == loc.name;
                return GestureDetector(
                  onTap: () => setState(() {
                    _selectedLocation = isSelected ? null : loc;
                  }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? loc.color.withOpacity(0.15)
                          : AppTheme.beige,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected ? loc.color : AppTheme.beige,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(loc.icon, color: loc.color, size: 22),
                        const SizedBox(height: 4),
                        Text(
                          loc.name,
                          style: TextStyle(
                            fontSize: 10,
                            color: loc.color,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          loc.distance,
                          style: const TextStyle(
                              fontSize: 9, color: AppTheme.lightBrown),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── Overlay helpers ────────────────────────────────────────────────────────
  Widget _mapTitleWidget() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1), blurRadius: 4)
          ],
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Sasan Gir Region',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppTheme.primaryGreen)),
            Text('Gujarat, India',
                style: TextStyle(
                    fontSize: 10, color: AppTheme.lightBrown)),
          ],
        ),
      );

  Widget _northIndicator() => Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1), blurRadius: 4)
          ],
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_upward, size: 14, color: Colors.red),
            Text('N',
                style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryBrown)),
          ],
        ),
      );

  Widget _scaleWidget() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          '${(_scale * 100).round()}%',
          style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryBrown),
        ),
      );

  Widget _hintWidget() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.pinch, size: 12, color: Colors.white70),
            SizedBox(width: 4),
            Text('Pinch to zoom · Tap pin for info',
                style: TextStyle(color: Colors.white70, fontSize: 9)),
          ],
        ),
      );
}

// ── Custom Painters ────────────────────────────────────────────────────────────

class _MapBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Forest area
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.15, size.height * 0.25)
        ..lineTo(size.width * 0.65, size.height * 0.20)
        ..lineTo(size.width * 0.70, size.height * 0.60)
        ..lineTo(size.width * 0.55, size.height * 0.65)
        ..lineTo(size.width * 0.20, size.height * 0.60)
        ..close(),
      Paint()
        ..color = const Color(0xFF4CAF50).withOpacity(0.25)
        ..style = PaintingStyle.fill,
    );

    // Arabian Sea
    final seaPath = Path()..moveTo(0, size.height * 0.85);
    seaPath.quadraticBezierTo(size.width * 0.3, size.height * 0.78,
        size.width * 0.5, size.height * 0.82);
    seaPath.quadraticBezierTo(size.width * 0.7, size.height * 0.88,
        size.width, size.height * 0.80);
    seaPath
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      seaPath,
      Paint()
        ..color = const Color(0xFF29B6F6).withOpacity(0.35)
        ..style = PaintingStyle.fill,
    );

    // Sea label
    (TextPainter(
      text: const TextSpan(
        text: 'Arabian Sea',
        style: TextStyle(
          color: Color(0xFF0277BD),
          fontSize: 11,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout())
        .paint(canvas, Offset(size.width * 0.35, size.height * 0.88));

    // Hill silhouette (top-right = Girnar)
    final hillPath = Path()
      ..moveTo(size.width * 0.50, size.height * 0.18);
    hillPath.quadraticBezierTo(size.width * 0.60, size.height * 0.05,
        size.width * 0.75, size.height * 0.15);
    hillPath.quadraticBezierTo(size.width * 0.85, size.height * 0.05,
        size.width * 0.95, size.height * 0.18);
    hillPath
      ..lineTo(size.width * 0.95, size.height * 0.25)
      ..lineTo(size.width * 0.50, size.height * 0.25)
      ..close();
    canvas.drawPath(
      hillPath,
      Paint()
        ..color = const Color(0xFF8D6E63).withOpacity(0.2)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final solid = Paint()
      ..color = const Color(0xFFBCAAA4).withOpacity(0.6)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final dashed = Paint()
      ..color = const Color(0xFFBCAAA4).withOpacity(0.4)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Sasan → Somnath (main highway)
    final mainRoad = Path()
      ..moveTo(size.width * 0.45, size.height * 0.42);
    mainRoad.quadraticBezierTo(size.width * 0.42, size.height * 0.60,
        size.width * 0.40, size.height * 0.72);
    canvas.drawPath(mainRoad, solid);

    // Sasan → Junagarh
    final toJunagarh = Path()
      ..moveTo(size.width * 0.45, size.height * 0.42);
    toJunagarh.quadraticBezierTo(size.width * 0.50, size.height * 0.35,
        size.width * 0.55, size.height * 0.28);
    canvas.drawPath(toJunagarh, dashed);

    // Sasan → Devalia
    canvas.drawLine(
      Offset(size.width * 0.45, size.height * 0.42),
      Offset(size.width * 0.38, size.height * 0.36),
      dashed,
    );

    // Sasan → Tulsi Shyam
    final toTulsi = Path()
      ..moveTo(size.width * 0.45, size.height * 0.42);
    toTulsi.quadraticBezierTo(size.width * 0.36, size.height * 0.44,
        size.width * 0.30, size.height * 0.48);
    canvas.drawPath(toTulsi, dashed);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
