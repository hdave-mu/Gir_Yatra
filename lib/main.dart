// lib/main.dart — Gir Yatra v2 entry point
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'state/app_state.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
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
    // Wrap entire tree so every screen can access AppStateProvider.of(context)
    return AppStateProvider(
      notifier: _notifier,
      child: AnimatedBuilder(
        animation: _notifier,
        builder: (_, __) => MaterialApp(
          title: 'Gir Yatra',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _notifier.data.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          locale: const Locale('en', 'IN'),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
