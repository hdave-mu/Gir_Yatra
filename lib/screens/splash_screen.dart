// lib/screens/splash_screen.dart
// Splash screen with lion/forest theme and auto-navigate to Home

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';
import 'auth_screen.dart';

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

  // Animations
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textSlide;
  late Animation<double> _textOpacity;
  late Animation<double> _ringScale;
  late Animation<double> _fadeOut;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startSplashSequence();
  }

  void _setupAnimations() {
    // Logo bounce-in
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // Text slide up
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _textSlide = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );

    // Pulsing ring
    _ringController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _ringScale = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _ringController, curve: Curves.easeInOut),
    );

    // Fade out before navigation
    _fadeOutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeOutController, curve: Curves.easeIn),
    );
  }

  Future<void> _startSplashSequence() async {
    // Start logo animation
    await Future.delayed(const Duration(milliseconds: 200));
    _logoController.forward();

    // Start text animation
    await Future.delayed(const Duration(milliseconds: 600));
    _textController.forward();

    // Wait then fade out and navigate
    await Future.delayed(const Duration(milliseconds: 2000));
    _fadeOutController.forward();
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const AuthScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 400),
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeOut,
      builder: (context, child) => Opacity(
        opacity: _fadeOut.value,
        child: child,
      ),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1B5E20), // Deep forest green
                Color(0xFF2E7D32), // Primary green
                Color(0xFF388E3C), // Medium green
                Color(0xFF4A3728), // Earth brown-green at base
              ],
              stops: [0.0, 0.35, 0.65, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // Background decorative trees (silhouette shapes)
              ..._buildForestSilhouettes(),

              // Main content
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),

                    // Animated Logo
                    AnimatedBuilder(
                      animation: Listenable.merge([_logoController, _ringController]),
                      builder: (context, _) => Opacity(
                        opacity: _logoOpacity.value,
                        child: Transform.scale(
                          scale: _logoScale.value,
                          child: _buildLogoWidget(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 36),

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

                    // Loading dots
                    AnimatedBuilder(
                      animation: _textController,
                      builder: (context, _) => Opacity(
                        opacity: _textOpacity.value,
                        child: _buildLoadingDots(),
                      ),
                    ),

                    const SizedBox(height: 40),
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
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.25),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: 5,
              ),
              BoxShadow(
                color: AppTheme.goldenAmber.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipOval(
            child: Container(
              margin: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1A5C2A),
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
            Container(height: 1, width: 50, color: Colors.white.withOpacity(0.4)),
            const SizedBox(width: 10),
            Icon(Icons.eco, color: Colors.white.withOpacity(0.7), size: 16),
            const SizedBox(width: 10),
            Container(height: 1, width: 50, color: Colors.white.withOpacity(0.4)),
          ],
        ),
        const SizedBox(height: 14),

        // App Name
        const Text(
          'ગિર યાત્રા',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            letterSpacing: 4,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Gir Yatra',
          style: TextStyle(
            color: Colors.white,
            fontSize: 42,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            shadows: [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 8,
                color: Colors.black38,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Tagline
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: const Text(
            'Explore the Land of Asiatic Lions 🌿',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Sub-text
        Text(
          'Sasan Gir · Gujarat · India',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingDots() {
    return Column(
      children: [
        Text(
          'Loading offline guide...',
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        _PulsatingDots(),
      ],
    );
  }

  List<Widget> _buildForestSilhouettes() {
    // Simple decorative circles/shapes to simulate forest
    return [
      // Top-left cluster
      Positioned(
        top: -30,
        left: -20,
        child: _forestCircle(160, Colors.white.withOpacity(0.03)),
      ),
      Positioned(
        top: 20,
        right: -40,
        child: _forestCircle(120, Colors.white.withOpacity(0.03)),
      ),
      // Bottom decorative
      Positioned(
        bottom: -20,
        left: -30,
        child: _forestCircle(200, Colors.black.withOpacity(0.1)),
      ),
      Positioned(
        bottom: 30,
        right: -50,
        child: _forestCircle(150, Colors.black.withOpacity(0.08)),
      ),
      // Paw print decorations
      ..._pawPrints(),
    ];
  }

  Widget _forestCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  List<Widget> _pawPrints() {
    // Fixed absolute positions — safe across all screen sizes
    return [
      Positioned(top: 108, left: 30,   child: _pawPrint(0.07)),
      Positioned(top: 175, right: 40,  child: _pawPrint(0.05)),
      Positioned(top: 390, left: 50,   child: _pawPrint(0.06)),
      Positioned(top: 460, right: 25,  child: _pawPrint(0.04)),
    ];
  }

  Widget _pawPrint(double opacity) {
    return Opacity(
      opacity: opacity,
      child: const Text('🐾', style: TextStyle(fontSize: 28)),
    );
  }
}

// Pulsating dots loading indicator
class _PulsatingDots extends StatefulWidget {
  @override
  State<_PulsatingDots> createState() => _PulsatingDotsState();
}

class _PulsatingDotsState extends State<_PulsatingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            final delay = index * 0.33;
            final value = math.sin((_controller.value - delay) * math.pi * 2);
            final scale = 0.6 + (value.clamp(-1.0, 1.0) + 1) * 0.2;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              transform: Matrix4.identity()..scale(scale),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.6),
              ),
            );
          }),
        );
      },
    );
  }
}
