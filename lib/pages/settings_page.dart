import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_register_page.dart';

class SettingsPage extends StatefulWidget {
  // Constructor for the SettingsPage widget
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // State variables
  bool _isLoggedIn = false; // Tracks user login status
  final TextEditingController emailController =
      TextEditingController(); // Controller for email input
  final TextEditingController passwordController =
      TextEditingController(); // Controller for password input
  String? errorMessage; // Stores potential error messages during authentication

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Check if a user is already logged in
  }

  void _checkLoginStatus() {
    // Listen for changes in user authentication state
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _isLoggedIn = user != null;
      });
    });
  }

  // Function to create a new user
  Future<void> createUser() async {
    try {
      // Attempt to create a new user with Firebase Authentication
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Clear input fields and reset error messages
      setState(() {
        emailController.clear();
        passwordController.clear();
        errorMessage = null;
      });
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  // Function to sign the user out
  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out from Firebase
      // Navigate back to the login/register page after signing out
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginRegisterPage()),
      );
    } catch (e) {
      print('Error signing out: $e'); // Print any errors
    }
  }

  void _deleteAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete(); // Firebase'dan kullanıcıyı sil
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginRegisterPage()),
        );
      }
    } catch (e) {
      print('Error deleting account: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Top app bar with title
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF37474F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Conditionally show options if the user is logged in
            if (_isLoggedIn)
              ListTile(
                // Tile for "Invite Friends" option
                leading: const Icon(Icons.person_add, color: Color(0xFF546E7A)),
                title: const Text('Invite Friends'),
                onTap: () {
                  _navigateToInviteScreen(context);
                },
              ),
            ListTile(
              leading: const Icon(Icons.help, color: Color(0xFF546E7A)),
              title: const Text('Help'),
              onTap: () {
                _navigateToHelpScreen(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFF546E7A)),
              title: const Text('Log out'),
              onTap: () {
                _showSignOutDialog(context);
              },
            ),
            if (_isLoggedIn)
              ListTile(
                leading: const Icon(Icons.delete_forever,
                    color: Colors.red), // Updated icon
                title: const Text('Delete Account',
                    style: TextStyle(color: Colors.red)),
                onTap: () {
                  _showDeleteAccountDialog(context);
                },
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

// Function to show a sign-out confirmation dialog
  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context, // The context in which to display the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            TextButton(
              // Cancel button
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              // Sign Out button
              onPressed: () {
                Navigator.of(context).pop();
                _signOut(); // Call the sign out function to log the user out
              },
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete Account'),
          content: const Text(
              'Are you sure you want to delete your account? This action cannot be undone.'),
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
                _deleteAccount();
              },
              child: const Text('Delete Account',
                  style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

// Function to navigate to the HelpScreen
  void _navigateToHelpScreen(BuildContext context) {
    Navigator.of(context).push(
      // Push the HelpScreen route onto the navigation stack
      MaterialPageRoute(
        builder: (context) =>
            const HelpScreen(), // The HelpScreen widget to build
      ),
    );
  }

// Function to navigate to the InviteScreen
  void _navigateToInviteScreen(BuildContext context) {
    Navigator.of(context).push(
      // Push the InviteScreen route onto the navigation stack
      MaterialPageRoute(
        builder: (context) =>
            const InviteScreen(), // The InviteScreen widget to build
      ),
    );
  }
}
// Help Screen Class

// Class for the HelpScreen, a static page with information about the app
class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main structure of the screen
      appBar: AppBar(
        title: const Text('Help', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF37474F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Allow scrolling if content overflows
          child: Card(
            // Card to visually group the help information
            elevation: 4, // Give the card a subtle shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.help_outline,
                        size: 20,
                        color: Color(0xFF546E7A),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Help Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF546E7A),
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
                      Icon(
                        Icons.start,
                        size: 20,
                        color: Color(0xFF546E7A),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Getting Started',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF546E7A),
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
                      Icon(
                        Icons.add,
                        size: 20,
                        color: Color(0xFF546E7A),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Additional features',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF546E7A),
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
                      Icon(
                        Icons.contact_mail,
                        size: 20,
                        color: Color(0xFF546E7A),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF546E7A),
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
        ),
      ),
    );
  }
}
// Invite Screen Class

// Class for the InviteScreen, allowing users to invite friends via email
class InviteScreen extends StatefulWidget {
  const InviteScreen({Key? key}) : super(key: key);

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  final TextEditingController emailController = TextEditingController();
  String? successMessage;

  void inviteFriend() {
    setState(() {
      if (emailController.text.isNotEmpty) {
        successMessage = "Invitation sent";
      }
    });
  }

  Widget buildInviteForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'E-Mail',
          style: TextStyle(
            color: Color(0xFF546E7A),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Enter your friend\'s e-mail',
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: inviteFriend,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF546E7A),
          ),
          child: const Text('Invite'),
        ),
        if (successMessage != null) ...[
          const SizedBox(height: 16.0),
          Text(
            successMessage!,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Invite Friends', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF37474F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 4,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: buildInviteForm(),
            ),
          ),
        ),
      ),
    );
  }
}
