import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_page.dart';
import 'package:flutter_application_1/screens/signup_page.dart';
import 'screens/login_page.dart'; // Giriş sayfası için gerekli
import 'screens/signup_page.dart'; // Üye olma sayfası için gerekli

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white, // Arka plan rengi (isteğe bağlı)
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
                const SizedBox(height: 50), // Butonlar ve metin arasında boşluk
                Container(
                  width: 400, // Resim genişliği
                  height: 300, // Resim yüksekliği
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(
                          'lib/assets/images/teamwork.jpeg'), // Arka plan resmi
                      fit: BoxFit.cover, // Resmi tamamen kapsar
                    ),
                    borderRadius:
                        BorderRadius.circular(20), // Köşeleri yuvarlatma
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Gölge rengi
                        spreadRadius: 5, // Gölge yayılma genişliği
                        blurRadius: 7, // Gölge bulanıklık yarıçapı
                        offset:
                            Offset(0, 3), // Gölgenin x ve y ekseninde kayması
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50), // Resim ve butonlar arasında boşluk
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white, // Metin rengini beyaz yapar
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 18),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: const Text('Giriş Yap'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white, // Metin rengini beyaz yapar
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 18),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: const Text('Üye Ol'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
