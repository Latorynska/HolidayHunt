import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:wisata_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/logo.png',
            width: 300,
          ),
        ],
      ),
      splashIconSize: 400,
      splashTransition: SplashTransition.fadeTransition,
      duration: 2000,
      backgroundColor: Colors.black,
      nextScreen: const HomeScreen(),
    );
  }
}
