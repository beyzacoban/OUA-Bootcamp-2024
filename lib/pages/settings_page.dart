import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_register_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () {
              _signOut(); // Çıkış işlevini çağırın
            },
          ),
        ],
      ),
    );
  }

  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Oturum kapatma başarılı, kullanıcıyı giriş sayfasına yönlendirin.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginRegisterPage()),
      );
    } catch (e) {
      // Hata durumunda burada işlem yapabilirsiniz.
      print('Error signing out: $e');
    }
  }
}
