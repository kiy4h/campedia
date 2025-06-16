// File: step2.dart
// Deskripsi: Halaman langkah ke-2 dalam proses peminjaman barang, berisi countdown timer untuk menunjukkan sisa waktu pengembalian

import 'package:flutter/material.dart';
import 'dart:async';
import 'step3.dart'; // Untuk navigasi ke halaman langkah ke-3

// Widget utama halaman Step2
class Step2Page extends StatefulWidget {
  const Step2Page({super.key});

  @override
  State<Step2Page> createState() => _Step2PageState();
}

// State dari Step2Page, berisi logika pengelolaan countdown timer
class _Step2PageState extends State<Step2Page> {
  // Waktu akhir peminjaman (48 jam dari waktu saat ini)
  late DateTime endTime;

  // Timer yang berjalan setiap detik
  late Timer _timer;

  // Variabel untuk menampilkan sisa waktu
  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    super.initState();

    // Hitung waktu akhir 2 hari ke depan dari saat ini
    endTime = DateTime.now().add(const Duration(days: 2));
    
    // Hitung waktu tersisa saat halaman pertama kali dimuat
    _calculateTimeLeft();

    // Buat timer yang memanggil _calculateTimeLeft setiap detik
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _calculateTimeLeft();
    });
  }

  @override
  void dispose() {
    // Hentikan timer agar tidak terus berjalan saat halaman sudah tidak aktif
    _timer.cancel();
    super.dispose();
  }

  // Menghitung sisa waktu dari sekarang hingga endTime
  void _calculateTimeLeft() {
    final now = DateTime.now();
    final difference = endTime.difference(now);

    if (difference.isNegative) {
      // Jika waktu telah habis, tampilkan 0 semua
      setState(() {
        days = 0;
        hours = 0;
        minutes = 0;
        seconds = 0;
      });
    } else {
      // Update sisa waktu sesuai perhitungan
      setState(() {
        days = difference.inDays;
        hours = difference.inHours.remainder(24);
        minutes = difference.inMinutes.remainder(60);
        seconds = difference.inSeconds.remainder(60);
      });
    }
  }

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
          onPressed: () => Navigator.pop(context), // Kembali ke halaman sebelumnya
        ),
      ),

      // Konten halaman utama
      body: Column(
        children: [
          // Tampilan countdown timer
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTimeBox(days.toString().padLeft(2, '0'), "HARI"),
                const SizedBox(width: 8),
                _buildTimeBox(hours.toString().padLeft(2, '0'), "JAM"),
                const SizedBox(width: 8),
                _buildTimeBox(minutes.toString().padLeft(2, '0'), "MENIT"),
                const SizedBox(width: 8),
                _buildTimeBox(seconds.toString().padLeft(2, '0'), "DETIK"),
              ],
            ),
          ),

          // Stepper Progress
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                children: [
                  // Step 1 - Selesai
                  Expanded(
                    child: Row(
                      children: [
                        // Indikator Step 1 (lingkaran hijau dan garis ke bawah)
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
                        // Label dan deskripsi step 1
                        const Expanded(
                          child: Text(
                            'step 1',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Step 2 - Aktif
                  Expanded(
                    child: Row(
                      children: [
                        // Indikator Step 2 (lingkaran besar border hijau)
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
                        // Label dan deskripsi step 2
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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

                  // Step 3 - Belum aktif
                  Expanded(
                    child: Row(
                      children: [
                        // Indikator Step 3 (lingkaran abu)
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
                            ],
                          ),
                        ),
                        // Label step 3
                        const Expanded(
                          child: Text(
                            'step 3',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tombol menuju langkah berikutnya
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

          // Bottom Navigation Bar (ikon statis)
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
                const CircleAvatar(radius: 12, backgroundColor: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Membuat kotak tampilan untuk setiap unit waktu (hari/jam/menit/detik)
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
