import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_register_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isLoggedIn = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _isLoggedIn = user != null;
      });
    });
  }

  Future<void> createUser() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      setState(() {
        emailController.clear();
        passwordController.clear();
        errorMessage = null;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginRegisterPage()),
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: <Widget>[
          if (_isLoggedIn)
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Invite Friends'),
              onTap: () {
                _navigateToInviteScreen(context);
              },
            ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () {
              _navigateToHelpScreen(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () {
              _showSignOutDialog(context);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _signOut();
              },
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToHelpScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HelpScreen(),
      ),
    );
  }

  void _navigateToInviteScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const InviteScreen(),
      ),
    );
  }
}

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '• ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent,
                    ),
                  ),
                  Text(
                    'Help Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'TeamHub application is an application where you can experience a project'
                ' as a team by adding your new friends or friends you know.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    '• ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent,
                    ),
                  ),
                  Text(
                    'Getting Started',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'First, you can easily register by creating a password with your'
                ' e-mail address, and then log in again with your user information.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                'Afterwards, you can upload your current project to the application and see'
                ' the projects of your friends or people you do not know in Explore.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                'You can participate in the project that interests you and do many projects'
                ' by having a pleasant time with your friends!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    '• ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent,
                    ),
                  ),
                  Text(
                    'Additional features',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'You can chat as you wish with the artificial intelligence called teamchat,'
                ' which is connected to our application, and ask questions about where you are stuck.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                'If you want to stay in constant communication with your friends, you can chat unlimitedly and at any time.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    '• ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent,
                    ),
                  ),
                  Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'If you have any questions, you can contact us via this e-mail and get all kinds of support teamhub@teamhubsupport.com.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InviteScreen extends StatefulWidget {
  const InviteScreen({Key? key}) : super(key: key);

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;

  Future<void> createUser() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      setState(() {
        emailController.clear();
        passwordController.clear();
        errorMessage = null;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget buildRegisterForm() {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.2),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.2),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        if (errorMessage != null)
          Text(
            errorMessage!,
            style: const TextStyle(color: Colors.red),
          ),
        ElevatedButton(
          onPressed: createUser,
          child: const Text('Register'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invite Friends'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Invite Screen!',
              style: TextStyle(fontSize: 24),
            ),
            buildRegisterForm(),
          ],
        ),
      ),
    );
  }
}
