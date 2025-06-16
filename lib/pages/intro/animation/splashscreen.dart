/**
 * File         : splashscreen.dart
 * Dibuat oleh  : Izzuddin Azzam
 * Tanggal      : 15-06-2025
 * Deskripsi    : Menampilkan splash screen Campedia saat aplikasi pertama kali dibuka,
 *                lalu otomatis navigasi ke halaman onboarding.
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding.dart';

/// Widget splash screen Campedia
/// 
/// Menampilkan logo, nama aplikasi, dan tagline sebelum masuk ke onboarding.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigasi otomatis ke onboarding setelah 2 detik
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9D5), // Latar belakang krem kekuningan
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Campedia
            Image.asset(
              'images/assets_OnBoarding0/logoCampedia.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),

            // Judul aplikasi
            const Text(
              'Campedia',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF475A3A), // Hijau tua
              ),
            ),
            const SizedBox(height: 8),

            // Tagline aplikasi
            const Text(
              '#CampingAjaDulu',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF475A3A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
