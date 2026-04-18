// lib/main.dart — Gir Yatra entry point
// Light-only app: dark mode has been permanently removed.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'theme/app_theme.dart';
import 'state/app_state.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Performance optimizations for 120fps smooth rendering
  debugRepaintRainbowEnabled = false;
  debugPaintLayerBordersEnabled = false;
  debugPaintSizeEnabled = false;

  // Ultra-aggressive image caching for instant image loading
  ImageCache().maximumSize = 500; // Max cached image count
  ImageCache().maximumSizeBytes = 750 * 1024 * 1024; // 750MB GPU memory

  // Light theme — status bar icons are dark so they're visible on light bg.
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const GirYatraApp());
}

class GirYatraApp extends StatefulWidget {
  const GirYatraApp({super.key});
  @override
  State<GirYatraApp> createState() => _GirYatraAppState();
}

class _GirYatraAppState extends State<GirYatraApp> {
  final _notifier = AppStateNotifier();

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppStateProvider(
      notifier: _notifier,
      child: MaterialApp(
        title: 'Gir Yatra',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        locale: const Locale('en', 'IN'),
        home: const SplashScreen(),
        // Performance: Optimized scroll physics for smooth 120fps
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          scrollbars: false,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
