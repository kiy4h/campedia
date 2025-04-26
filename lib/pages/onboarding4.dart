import 'package:flutter/material.dart';
import 'register.dart';
import 'signin.dart';

void main() {
  runApp(Onboarding4());
}

class Onboarding4 extends StatelessWidget {
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
                      'images/onboarding3image.png',
                      height: 250,
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Efficient, In-Store Pickup for Your Camping Rentals',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Simply reserve online and pick up your equipment at our store at your convenience.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildDot(false),
                  buildDot(false),
                  buildDot(true),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A5A2A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'CREATE AN ACCOUNT',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Tambahan: pastikan teksnya kontras
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Aksi saat tombol ditekan
                    print('NEXT button pressed!');
                    // Contoh navigasi:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A5A2A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'LOGIN',
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
