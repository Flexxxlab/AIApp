
import 'package:flutter/material.dart';
import 'package:myapp/home.dart';

void main() {
  runApp(const MyAIApp());
}

class MyAIApp extends StatelessWidget {
  const MyAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduMentor',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 10, 22, 81),
        scaffoldBackgroundColor: const Color.fromRGBO(6, 42, 68, 0.976),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 131, 185, 255),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 5, 87, 195),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const AIChatScreen(),
    );
  }
}