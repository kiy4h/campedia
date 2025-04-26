import 'package:flutter/material.dart';
import 'onboarding2.dart';

class Onboarding extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Onboarding2()), // Ganti dengan halaman selanjutnya
      );
    });

    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9D5), // Warna latar belakang krem kekuningan
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gambar logo
            Image.asset(
              'images/logoCampedia.png', // Pastikan file kamu di folder ini
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            // Judul Campedia
            const Text(
              'Campedia',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF475A3A), // Warna hijau tua
              ),
            ),
            const SizedBox(height: 8),
            // Tagline
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
