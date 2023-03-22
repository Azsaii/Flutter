import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            // Text color1
            color: Color(0xFF232B55),
          ),
        ),
        // Text color2
        cardColor: const Color(0xFFF4EDDB),
        // Background color
        scaffoldBackgroundColor: const Color(0xFFE7626C),
      ),
      home: const HomeScreen(),
    );
  }
}
