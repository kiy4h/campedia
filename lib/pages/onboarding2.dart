import 'package:flutter/material.dart';
import 'onboarding3.dart';

void main() {
  runApp(Onboarding2());
}

class Onboarding2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.arrow_back, color: Colors.black),
              ),
              Expanded( // Biar bagian kompas + tulisan bisa "didorong" ke tengah
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/kompas_bg.png',
                      height: 250,
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Welcome to Campedia',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Your Ultimate Camping Companion',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Sewa perlengkapan kemah terbaik, dari tenda hingga kompor. Berkemah jadi mudah dan seru bersama Campedia',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildDot(true),
                  buildDot(false),
                  buildDot(false),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi saat tombol ditekan
                    print('NEXT button pressed!');
                    // Contoh navigasi:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Onboarding3()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A5A2A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Tambahan: pastikan teksnya kontras
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            ],
          ),

        ),
      ),
    );
  }

  Widget buildDot(bool isActive) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: isActive ? 20 : 12, // Lebar lebih besar
    height: 8, // Tinggi tetap kecil biar agak pipih
    decoration: BoxDecoration(
      color: isActive ? const Color(0xFF4A5A2A) : Colors.grey[300],
      borderRadius: BorderRadius.circular(20), // Biar bentuknya oval, bukan bulet
    ),
  );
}

}
