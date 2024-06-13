import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:jakepalanca/components/loading_widget.dart';
import 'package:jakepalanca/pages/homepage/home_page_widget.dart';
import 'package:jakepalanca/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Simulate some loading time
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jake Palanca\'s Portfolio',
      theme: appTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system, // Use system theme mode
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        // Add other supported locales here
      ],
      home: _isInitialized ? const HomePageWidget() : const LoadingScreen(),
    );
  }
}
