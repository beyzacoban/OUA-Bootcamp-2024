import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login_register_page.dart';
import 'login_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'ProjMatch',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Projelerinizi hayata geçirin, birlikte çalışmanın gücünü keşfedin!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.redAccent),
                ),
                const SizedBox(height: 50),
                Container(
                  width: 400,
                  height: 300,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('lib/assets/images/teamwork.jpeg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginRegisterPage()),
                    );
                  },
                  style: buttonStyle,
                  child: const Text('Giriş Yap'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginRegisterPage()),
                    );
                  },
                  style: buttonStyle,
                  child: const Text('Üye Ol'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.redAccent,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
    textStyle: const TextStyle(fontSize: 20),
  );
}
