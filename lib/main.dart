// lib/main.dart — Gir Yatra entry point
// Light-only app: dark mode has been permanently removed.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'state/app_state.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e, st) {
    debugPrint('Firebase init failed: $e\n$st');
  }

  // Performance optimizations
  // Pre-cache images at high resolution for Retina/2x density
  ImageCache().maximumSize = 150; // up to 150 images
  ImageCache().maximumSizeBytes =
      256 * 1024 * 1024; // 256 MB cache (safe on modern devices)

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
    // Wrap entire tree so every screen can access AppStateProvider.of(context).
    return AppStateProvider(
      notifier: _notifier,
      child: MaterialApp(
        title: 'Gir Yatra',
        debugShowCheckedModeBanner: false,
        // Hard-locked to light theme — no dark mode.
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        locale: const Locale('en', 'IN'),
        home: const SplashScreen(),
      ),
    );
  }
}
