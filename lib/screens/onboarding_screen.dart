import 'package:flutter/material.dart';
import 'package:twitch_clone_tutorial/responsive/responsive.dart';
import 'package:twitch_clone_tutorial/screens/login_screen.dart';
import 'package:twitch_clone_tutorial/screens/signup_screen.dart';
import 'package:twitch_clone_tutorial/widgets/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: Color.fromRGBO(0, 0, 253, 1),
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: const Text(
                    'Welcome to \n CyberLive',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Image.asset('assets/animated.gif'),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: Color.fromRGBO(252, 254, 2, 1),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(0, 0, 253, 1),
                            minimumSize: const Size(200, 60),
                            side: BorderSide(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40))),
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(0, 0, 253, 1),
                            minimumSize: const Size(200, 60),
                            side: BorderSide(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40))),
                        onPressed: () {
                          Navigator.pushNamed(context, SignupScreen.routeName);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
