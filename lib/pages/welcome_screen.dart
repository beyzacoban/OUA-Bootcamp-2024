import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login_register_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'lib/assets/images/teamwork.jpeg',
            fit: BoxFit.fill,
            color: Colors.black.withOpacity(0.6),
            colorBlendMode: BlendMode.darken,
          ),

          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Color.fromARGB(150, 0, 0, 0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Content with Button at Bottom
          Column(
            mainAxisAlignment: MainAxisAlignment.start, // Align to top
            children: <Widget>[
              // Top Content
              const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Text(
                  'TeamHub',
                  style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const Spacer(), // Push bottom content down

              // Bottom Section (Slogan and Button)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Bringing Ideas to Life, Together!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginRegisterPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 60),
                        textStyle: const TextStyle(fontSize: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Get Started'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
