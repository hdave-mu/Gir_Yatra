// lib/screens/splash_screen.dart
// Cinematic splash — firefly particles, forest light, elastic logo, premium typography.
// OPTIMIZED FOR 120FPS: Reduced animations, particle count, timing

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../animations/firefly_painter.dart';
import '../animations/forest_light_painter.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Animation controllers
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _ringController;
  late AnimationController _fadeOutController;
  late AnimationController _fireflyController;
  late AnimationController _progressController;

  // Animations
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textSlide;
  late Animation<double> _textOpacity;
  late Animation<double> _ringScale;
  late Animation<double> _fadeOut;
  late Animation<double> _ringGlow;

  // Fireflies
  late List<Firefly> _fireflies;

  @override
  void initState() {
    super.initState();
    // OPTIMIZED: Reduced particle count from 18 to 12 for 120fps
    _fireflies = generateFireflies(count: 12);
    _setupAnimations();
    _startSplashSequence();
  }

  void _setupAnimations() {
    // Logo animation - faster bounce (900ms instead of 1100ms)
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoScale = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.7),
      ),
    );

    // Text slide + fade - faster (600ms instead of 800ms)
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _textSlide = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutQuad),
    );
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );

    // Pulsing ring with glow - faster pulse (1600ms instead of 2000ms)
    _ringController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
    _ringScale = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _ringController, curve: Curves.easeInOut),
    );
    _ringGlow = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _ringController, curve: Curves.easeInOut),
    );

    // Fade out before navigation - faster (400ms instead of 600ms)
    _fadeOutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeOutController, curve: Curves.easeIn),
    );

    // Firefly animation loop - faster cycle (5s instead of 6s) for smooth motion
    _fireflyController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: false);

    // Progress indicator - faster completion (1800ms instead of 2800ms)
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
  }

  Future<void> _startSplashSequence() async {
    // FAST SPLASH: Optimized timing for quick app startup
    // Total splash duration: 2.45 seconds (down from 3.8s - 36% faster)

    await Future.delayed(const Duration(milliseconds: 150));
    _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 500));
    _textController.forward();
    _progressController.forward();

    // Reduced wait: 1400ms instead of 2200ms (36% faster)
    await Future.delayed(const Duration(milliseconds: 1400));
    _fadeOutController.forward();
    await Future.delayed(const Duration(milliseconds: 400));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _ringController.dispose();
    _fadeOutController.dispose();
    _fireflyController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeOut,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0D3B1E), Color(0xFF1B5E20)],
            ),
          ),
          child: Stack(
            children: [
              // Forest light overlay (skip initial 500ms for performance)
              if (_logoController.value > 0.1)
                const Positioned.fill(
                  child: RepaintBoundary(child: ForestLightOverlay()),
                ),

              // Firefly particles (lazy load at 20% animation progress)
              if (_logoController.value > 0.2)
                Positioned.fill(
                  child: RepaintBoundary(
                    child: AnimatedBuilder(
                      animation: _fireflyController,
                      builder: (context, _) => CustomPaint(
                        isComplex: true,
                        willChange: true,
                        painter: FireflyPainter(
                          animationValue: _fireflyController.value,
                          fireflies: _fireflies,
                          glowColor: AppTheme.amberLight,
                        ),
                      ),
                    ),
                  ),
                ),

              // Subtle decorative elements
              ..._buildForestSilhouettes(),

              // Main content
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),

                    // Animated Logo with glow ring
                    AnimatedBuilder(
                      animation:
                          Listenable.merge([_logoController, _ringController]),
                      builder: (context, _) => Opacity(
                        opacity: _logoOpacity.value,
                        child: Transform.scale(
                          scale: _logoScale.value,
                          child: _buildLogoWidget(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Animated Title & Subtitle
                    AnimatedBuilder(
                      animation: _textController,
                      builder: (context, _) => Transform.translate(
                        offset: Offset(0, _textSlide.value),
                        child: Opacity(
                          opacity: _textOpacity.value,
                          child: _buildTitleSection(),
                        ),
                      ),
                    ),

                    const Spacer(flex: 3),

                    // Organic progress indicator
                    AnimatedBuilder(
                      animation: _textController,
                      builder: (context, _) => Opacity(
                        opacity: _textOpacity.value,
                        child: _buildProgressSection(),
                      ),
                    ),

                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoWidget() {
    return AnimatedBuilder(
      animation: _ringController,
      builder: (context, _) => Transform.scale(
        scale: _ringScale.value,
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.canopyGold.withValues(alpha: _ringGlow.value),
              width: 2.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 40,
                spreadRadius: 5,
              ),
              BoxShadow(
                color: AppTheme.canopyGold
                    .withValues(alpha: _ringGlow.value * 0.6),
                blurRadius: 30,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipOval(
            child: Container(
              margin: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1B5E20), Color(0xFF0D3B1E)],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: SvgPicture.asset(
                  'gir_yatra_icon.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      children: [
        // Decorative divider
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _glowLine(),
            const SizedBox(width: 12),
            Icon(Icons.eco,
                color: AppTheme.canopyGold.withValues(alpha: 0.7), size: 16),
            const SizedBox(width: 12),
            _glowLine(),
          ],
        ),
        const SizedBox(height: 16),

        // Gujarati name
        Text(
          'ગિર યાત્રા',
          style: GoogleFonts.josefinSans(
            color: AppTheme.canopyGold.withValues(alpha: 0.8),
            fontSize: 15,
            letterSpacing: 6,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 6),

        // App name — Playfair Display
        Text(
          'Gir Yatra',
          style: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
            shadows: [
              Shadow(
                offset: const Offset(0, 3),
                blurRadius: 12,
                color: Colors.black.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Tagline
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppTheme.canopyGold.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Text(
            'Explore the Land of Asiatic Lions',
            style: GoogleFonts.dmSans(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 13,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Powered by section
        Column(
          children: [
            Text(
              'Powered by',
              style: GoogleFonts.josefinSans(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 11,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            Image.asset(
              'Image/Marwadi Logo.png',
              height: 45,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ],
    );
  }

  Widget _glowLine() {
    return Container(
      height: 1,
      width: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            AppTheme.canopyGold.withValues(alpha: 0.4),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection() {
    return Column(
      children: [
        Text(
          'Loading offline guide...',
          style: GoogleFonts.josefinSans(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 11,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 14),
        // Organic progress bar
        AnimatedBuilder(
          animation: _progressController,
          builder: (context, _) => Container(
            width: 120,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.white.withValues(alpha: 0.1),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: _progressController.value.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.canopyGold.withValues(alpha: 0.6),
                        AppTheme.canopyGold,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.canopyGold.withValues(alpha: 0.4),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildForestSilhouettes() {
    return [];
  }
}
