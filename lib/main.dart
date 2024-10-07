import 'package:flutter/material.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
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
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2374835714.
          ),
          titleLarge: TextStyle(
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            color: Colors.white,
          ),
          titleSmall: TextStyle(
            color: Colors.white,
          ),
          // Another default text style
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 5, 87, 195),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
        ),
      ),
      home: const AIChatScreen(),
    );
  }
}
