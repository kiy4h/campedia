import 'package:flutter/material.dart';

void main() {
  runApp(Onboarding3());
}

class Onboarding3 extends StatelessWidget {
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
                      'images/tenda_bg.png',
                      height: 250,
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Quality camping gear for every adventure',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  
                    SizedBox(height: 16),
                    Text(
                      'Planning your next camping trip? We\'ve got the gear you need — tents, cook sets, lights, and more!',
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
                  buildDot(false),
                  buildDot(true),
                  buildDot(false),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4A5A2A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // Next page action
                  },
                  child: Text(
                    'NEXT',
                    style: TextStyle(fontSize: 16),
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
