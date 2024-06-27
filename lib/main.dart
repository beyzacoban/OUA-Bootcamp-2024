import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart'; // WelcomeScreen'i import edin

void main() {
  runApp(const MyApp());
}

String a = "a";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Onboarding',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          const WelcomeScreen(), // WelcomeScreen'i başlangıç ekranı olarak ayarlayın
    );
  }
}
