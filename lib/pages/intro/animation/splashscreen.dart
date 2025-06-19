/// File        : splashscreen.dart
/// Dibuat oleh  : Izzuddin Azzam
/// Tanggal      : 15-06-2025
/// Deskripsi    : File ini bertanggung jawab untuk menampilkan splash screen saat aplikasi Campedia
/// pertama kali diluncurkan. Setelah durasi tertentu, aplikasi akan secara otomatis
/// menavigasi pengguna ke halaman onboarding untuk pengenalan fitur.
/// Dependencies :
/// - dart:async: Diperlukan untuk menggunakan Future.delayed guna mengatur penundaan navigasi.
/// - flutter/material.dart: Pustaka dasar Flutter untuk membangun antarmuka pengguna.
/// - onboarding.dart: Halaman tujuan navigasi setelah splash screen selesai.
library;

import 'dart:async'; // Mengimpor pustaka 'dart:async' untuk fungsi Future.delayed.
import 'package:flutter/material.dart'; // Mengimpor pustaka dasar Flutter untuk UI.
import 'onboarding.dart'; // Mengimpor halaman OnboardingScreen.

/// Widget [SplashScreen]
///
/// Deskripsi:
/// - Widget ini berfungsi sebagai tampilan pembuka aplikasi Campedia.
/// - Menampilkan logo, nama aplikasi, dan tagline.
/// - Ini adalah StatefulWidget karena memiliki state yang mengelola waktu penundaan
/// sebelum navigasi otomatis ke halaman onboarding. State tersebut akan diinisialisasi
/// sekali saat widget pertama kali dibuat.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

/// State [ _SplashScreenState]
///
/// Deskripsi:
/// - Mengelola state internal untuk [SplashScreen].
/// - Bertanggung jawab untuk memicu navigasi otomatis setelah durasi tertentu
/// saat widget pertama kali dibuat.
class SplashScreenState extends State<SplashScreen> {
  /* Fungsi ini diinisialisasi saat State objek dibuat.
   *
   * Deskripsi:
   * - Menjalankan penundaan selama 2 detik sebelum melakukan navigasi.
   * - Setelah penundaan, aplikasi akan menavigasi ke [OnboardingScreen]
   * menggunakan `Navigator.pushReplacement` agar pengguna tidak bisa kembali ke splash screen.
   *
   * Parameter: Tidak ada.
   * Return: Tidak ada (void).
   */
  @override
  void initState() {
    super.initState();

    // Navigasi otomatis ke onboarding setelah 2 detik.
    Future.delayed(const Duration(seconds: 2), () {
      // Memastikan widget masih aktif (mounted) sebelum melakukan navigasi
      // untuk mencegah error jika widget sudah tidak ada di pohon widget.
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    });
  }

  /* Fungsi ini membangun seluruh struktur UI dari splash screen.
   *
   * Parameter:
   * - [context]: BuildContext dari widget.
   *
   * Return: Sebuah widget [Scaffold] yang berisi tampilan splash screen.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFFFF9D5), // Warna latar belakang krem kekuningan.
      /** Widget [Center]
       * * Deskripsi:
       * - Memusatkan konten di tengah layar.
       */
      body: Center(
        /** Widget [Column]
         * * Deskripsi:
         * - Mengatur tata letak elemen-elemen UI (logo, judul, tagline) secara vertikal.
         * - Memusatkan elemen-elemen tersebut di tengah kolom.
         */
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Memusatkan konten secara vertikal.
          children: [
            // --- Logo Campedia ---
            /** Widget [Image.asset]
             * * Deskripsi:
             * - Menampilkan **logo aplikasi Campedia** dari aset lokal.
             * - Mengatur lebar, tinggi, dan mode fit gambar.
             */
            Image.asset(
              'images/assets_OnBoarding0/logoCampedia.png', // Path ke aset gambar logo.
              width: 200, // Lebar gambar.
              height: 200, // Tinggi gambar.
              fit: BoxFit
                  .contain, // Gambar akan diukur untuk masuk ke dalam kotak sumber.
            ),
            const SizedBox(height: 20), // Spasi vertikal antara logo dan judul.

            // --- Judul Aplikasi ---
            /** Widget [Text]
             * * Deskripsi:
             * - Menampilkan **nama aplikasi "Campedia"**.
             * - Gaya teks dengan ukuran besar, tebal, dan warna hijau tua.
             */
            const Text(
              'Campedia',
              style: TextStyle(
                fontSize: 32, // Ukuran font.
                fontWeight: FontWeight.bold, // Ketebalan font.
                color: Color(0xFF475A3A), // Warna teks hijau tua.
              ),
            ),
            const SizedBox(
                height: 8), // Spasi vertikal antara judul dan tagline.

            // --- Tagline Aplikasi ---
            /** Widget [Text]
             * * Deskripsi:
             * - Menampilkan **tagline aplikasi "#CampingAjaDulu"**.
             * - Gaya teks dengan ukuran sedang dan warna hijau tua.
             */
            const Text(
              '#CampingAjaDulu',
              style: TextStyle(
                fontSize: 16, // Ukuran font.
                color: Color(0xFF475A3A), // Warna teks hijau tua.
              ),
            ),
          ],
        ),
      ),
    );
  }
}
