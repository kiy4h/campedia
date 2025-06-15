/**
 * File         : splashscreen.dart
 * Dibuat oleh  : Izzuddin Azzam
 * Tanggal      : 15-06-2025
 * Deskripsi    : File ini berisi implementasi layar splash screen yang ditampilkan saat aplikasi pertama kali dibuka
 * Dependencies : dart:async, flutter/material.dart, file halaman onboarding
 */

import 'dart:async';
import 'package:flutter/material.dart';
import '../account/register.dart';
import '../account/signin.dart';
import 'onboarding.dart';

/** Widget SplashScreen
 * 
 * Deskripsi:
 * - Widget untuk menampilkan splash screen aplikasi Campedia
 * - Bagian dari alur intro aplikasi yang muncul pertama kali saat aplikasi dibuka
 * - Merupakan StatefulWidget karena perlu mengelola timer untuk navigasi otomatis
 */
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/** State untuk widget SplashScreen
 * 
 * Deskripsi:
 * - Mengelola tampilan dan logika splash screen
 * - Mengatur timer untuk navigasi otomatis ke halaman onboarding
 */
class _SplashScreenState extends State<SplashScreen> {
  @override
  /* Fungsi ini dijalankan saat widget pertama kali dibuat
   * 
   * Menginisialisasi timer untuk navigasi otomatis ke halaman onboarding
   * setelah 2 detik
   */
  void initState() {
    super.initState();

    // Navigasi ke halaman onboarding setelah 2 detik
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnboardingScreen()));
      }
    });
  }
  @override
  /* Fungsi ini membangun UI untuk splash screen
   * 
   * Parameter:
   * - context: Konteks build dari framework Flutter
   * 
   * Return: Widget Scaffold dengan tampilan splash screen
   */
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9D5), // Latar belakang berwarna krem kekuningan
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gambar logo aplikasi
            Image.asset(
              'images/assets_OnBoarding0/logoCampedia.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            // Judul aplikasi Campedia
            const Text(
              'Campedia',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF475A3A), // Warna hijau tua
              ),
            ),
            const SizedBox(height: 8),
            // Tagline aplikasi
            const Text(
              '#CampingAjaDulu',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF475A3A), // Warna hijau tua
              ),
            ),
          ],
        ),
      ),
    );
  }
}
