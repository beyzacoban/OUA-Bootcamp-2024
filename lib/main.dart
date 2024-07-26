import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv kütüphanesini ekleyin
import 'firebase_options.dart';
import 'pages/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // .env dosyasını yükleyin
  try {
    await dotenv.load();
    print('Dotenv loaded successfully');
  } catch (e) {
    print('Error loading .env file: $e');
    return; // Hata varsa uygulamayı durdur
  }

  // Firebase'i başlatın
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
    return; // Hata varsa uygulamayı durdur
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Onboarding',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 64, 58, 183),
        ),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}
