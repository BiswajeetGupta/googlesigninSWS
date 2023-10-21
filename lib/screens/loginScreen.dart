import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:googles/repo/authService.dart';
import 'package:googles/screens/BottomNav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 159, 212, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/bubble-gum-verification.gif',
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                authService.GooSignIn()
                    .then((value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BottomNav(),
                          ),
                        ));
              },
              icon: const FaIcon(FontAwesomeIcons.google),
              label: const Text('Login with Google'),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                authService
                    .signInWithApple()
                    .then((value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BottomNav(),
                          ),
                        ));
              },
              icon: const FaIcon(
                FontAwesomeIcons.apple,
                color: Colors.black,
              ),
              label: const Text(
                'Login with Apple',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
