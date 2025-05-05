import 'dart:async';
import 'package:flutter/material.dart';
import '../Login/register.dart';
import '../Login/signin.dart';
import 'onboarding.dart';

// Separate Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to onboarding after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnboardingScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9D5), // Cream yellowish background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo image
            Image.asset(
              'images/assets_OnBoarding0/logoCampedia.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            // Campedia title
            const Text(
              'Campedia',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF475A3A), // Dark green color
              ),
            ),
            const SizedBox(height: 8),
            // Tagline
            const Text(
              '#CampingAjaDulu',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF475A3A), // Dark green color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
