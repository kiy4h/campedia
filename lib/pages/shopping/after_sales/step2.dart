/*
* File : step2.dart
* Deskripsi : Halaman langkah kedua untuk proses pengambilan barang dengan tampilan countdown timer
* Dependencies : 
*   - dart:async: untuk Timer countdown
*   - step3.dart: untuk navigasi ke langkah berikutnya
*/

import 'package:flutter/material.dart';
import 'dart:async';
import 'step3.dart';

/*
* Class : Step2Page
* Deskripsi : Widget halaman penggunaan barang (langkah 2), merupakan StatefulWidget
* Bagian Layar : Halaman penggunaan barang dengan tampilan countdown timer
*/
class Step2Page extends StatefulWidget {
  const Step2Page({super.key});

  @override
  State<Step2Page> createState() => _Step2PageState();
}

/*
* Class : _Step2PageState
* Deskripsi : State untuk widget Step2Page dengan pengelolaan countdown timer
* Bagian Layar : Mengelola state dan tampilan halaman penggunaan barang
*/
class _Step2PageState extends State<Step2Page> {
  // Timer untuk 2 hari (48 jam)
  late DateTime endTime;
  late Timer _timer;
  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  /*
  * Method : initState
  * Deskripsi : Inisialisasi timer dan waktu akhir penggunaan
  * Parameter : -
  * Return : void
  */
  @override
  void initState() {
    super.initState();
    // Set end time to 2 days from now
    endTime = DateTime.now().add(const Duration(days: 2));
    _calculateTimeLeft();
    
    // Update timer setiap detik
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _calculateTimeLeft();
    });
  }
  /*
  * Method : dispose
  * Deskripsi : Membersihkan resource timer saat widget dihapus
  * Parameter : -
  * Return : void
  */
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  /*
  * Method : _calculateTimeLeft
  * Deskripsi : Menghitung waktu tersisa pada countdown timer
  * Parameter : -
  * Return : void
  */
  void _calculateTimeLeft() {
    final now = DateTime.now();
    final difference = endTime.difference(now);
    
    if (difference.isNegative) {
      // Waktu sudah habis
      setState(() {
        days = 0;
        hours = 0;
        minutes = 0;
        seconds = 0;
      });
    } else {
      setState(() {
        days = difference.inDays;
        hours = difference.inHours.remainder(24);
        minutes = difference.inMinutes.remainder(60);
        seconds = difference.inSeconds.remainder(60);
      });
    }
  }
  /*
  * Method : build
  * Deskripsi : Membangun UI untuk halaman penggunaan barang dengan timer countdown
  * Parameter : context - BuildContext untuk akses ke fitur framework
  * Return : Widget Scaffold berisi timer countdown dan informasi penggunaan
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengambilan Barang',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF627D2C),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, color: Colors.white, size: 18),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Countdown Timer
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hari
                _buildTimeBox(days.toString().padLeft(2, '0'), "HARI"),
                const SizedBox(width: 8),
                
                // Jam
                _buildTimeBox(hours.toString().padLeft(2, '0'), "JAM"),
                const SizedBox(width: 8),
                
                // Menit
                _buildTimeBox(minutes.toString().padLeft(2, '0'), "MENIT"),
                const SizedBox(width: 8),
                
                // Detik
                _buildTimeBox(seconds.toString().padLeft(2, '0'), "DETIK"),
              ],
            ),
          ),
          
          // Stepper Content - Mengisi ruang kosong
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                children: [
                  // Stepper - First Step - Completed
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stepper Line & Circle
                        SizedBox(
                          width: 50,
                          child: Column(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF9BAE76),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 3,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Step Content
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'step 1',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Stepper - Second Step - Active
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stepper Line & Circle
                        SizedBox(
                          width: 50,
                          child: Column(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF9BAE76),
                                    width: 6,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 3,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Step Content - Tetap dengan konten asli
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'step 2',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Lihat waktu tersisa hingga batas pengembalian barang. Pastikan barang dikembalikan tepat waktu.',
                                style: TextStyle(fontSize: 16, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Stepper - Third Step - Inactive
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stepper Circle only (no line)
                        SizedBox(
                          width: 50,
                          child: Column(
                            children: [
                              const SizedBox(height: 8),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              // Tidak perlu garis di step terakhir
                            ],
                          ),
                        ),
                        
                        // Step Content - Tetap dengan konten asli
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'step 3',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Next Step Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Step3Page()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF627D2C),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              child: const Text(
                'NEXT STEP',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          
          // Bottom Navigation
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.home, color: Colors.grey[600]),
                Icon(Icons.swap_horiz, color: Colors.grey[600]),
                Stack(
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.grey[600]),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.favorite_border, color: Colors.grey[600]),
                const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Widget untuk membuat kotak timer dengan angka dan label
  Widget _buildTimeBox(String number, String label) {
    return Column(
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}