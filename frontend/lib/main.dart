import 'package:flutter/material.dart';
import 'home.dart';
import 'rosters.dart';
import 'matchups.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blue-Gold League',
      theme: ThemeData(
        brightness: Brightness.dark, // dark mode
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.dark(
          primary: Colors.blue,
          secondary: Colors.amber,
          surface: Color(0xFF1E1E1E), 
        ),
        scaffoldBackgroundColor: Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, 
            foregroundColor: Colors.white, // button text color
          ),
        ),
        cardColor: const Color(0xFF1E1E1E),
      ),
      home: const HomePage(),
      routes: {
        '/rosters': (context) => const RostersPage(),
        '/matchups': (context) => const MatchupsPage(),
      },
    );
  }
}