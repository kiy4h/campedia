/// File        : pickup_tracking_page.dart
/// Dibuat oleh  : Izzuddin Azzam
/// Tanggal      : 16-06-2025
/// Deskripsi    : Halaman ini menampilkan proses pelacakan pengambilan dan pengembalian barang sewaan
/// dalam tiga tahapan: Ambil Barang, Waktu Pengembalian, dan Selesai.
/// Dependencies : flutter/material.dart, flutter_countdown_timer
library;

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

/// Widget [PickupTrackingPage]
/// * Deskripsi:
/// - Widget ini berfungsi sebagai halaman utama untuk melacak status pengambilan dan pengembalian barang.
/// - Merupakan bagian dari alur peminjaman barang.
/// - Ini adalah widget stateful karena mengelola state [_currentStep] untuk navigasi antar tahapan
/// dan [endTime] untuk timer countdown.
class PickupTrackingPage extends StatefulWidget {
  const PickupTrackingPage({super.key});

  @override
  PickupTrackingPageState createState() => PickupTrackingPageState();
}

class PickupTrackingPageState extends State<PickupTrackingPage> {
  // Menyimpan tahapan proses pengambilan: 0 = Ambil, 1 = Countdown, 2 = Selesai
  int _currentStep = 0;

  // Menentukan waktu akhir countdown (2 hari dari sekarang)
  // Waktu dihitung dalam milidetik sejak epoch.
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60 * 48;

  /* Fungsi ini memajukan tahapan proses pelacakan.
   * * Parameter:
   * - Tidak ada.
   * * Return: Tidak ada.
   */
  void nextStep() {
    // Memeriksa apakah tahapan saat ini belum mencapai tahapan terakhir (Selesai).
    if (_currentStep < 2) {
      // Memperbarui state untuk memajukan tahapan.
      setState(() {
        _currentStep++;
      });
    } else {
      // Jika sudah di tahapan terakhir, tampilkan dialog konfirmasi selesai.
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          // Judul dialog yang menginformasikan proses selesai.
          title: const Text('Selesai!'),
          // Konten dialog yang berisi pesan terima kasih dan ajakan untuk memberi ulasan.
          content: const Text('Terima kasih! Jangan lupa beri ulasan ya.'),
          actions: [
            // Tombol 'OK' untuk menutup dialog.
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  /* Fungsi ini membangun konten utama yang ditampilkan berdasarkan tahapan saat ini.
   * * Parameter:
   * - Tidak ada.
   * * Return: Widget yang sesuai dengan tahapan saat ini.
   */
  Widget buildContent() {
    // Menampilkan konten berdasarkan nilai [_currentStep].
    if (_currentStep == 0) {
      // === Tahap 1: Ambil Barang di Toko ===
      return Column(
        children: [
          // Container sebagai placeholder untuk tampilan peta.
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade300,
            ),
            // Teks placeholder 'MAPS'.
            child: const Center(
              child: Text('MAPS', style: TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: 16),
          // Deskripsi instruksi untuk pengambilan barang.
          const Text(
            'Ambil perlengkapan sewa langsung di toko.\nLokasi bisa dilihat melalui Google Maps yang tersedia.',
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else if (_currentStep == 1) {
      // === Tahap 2: Countdown batas waktu pengembalian ===
      return Column(
        children: [
          const SizedBox(height: 16),
          // Widget CountdownTimer untuk menampilkan sisa waktu.
          // Saat countdown berakhir, _currentStep akan diatur ke 2.
          CountdownTimer(
            endTime: endTime,
            textStyle:
                const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            onEnd: () {
              setState(() {
                _currentStep = 2;
              });
            },
          ),
          const SizedBox(height: 16),
          // Deskripsi instruksi terkait batas waktu pengembalian.
          const Text(
            'Lihat waktu tersisa hingga batas pengembalian barang.\nPastikan barang dikembalikan tepat waktu.',
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      // === Tahap 3: Barang Dikembalikan ===
      return Column(
        children: [
          const SizedBox(height: 16),
          // Container yang menunjukkan barang sudah dikembalikan dengan ikon centang.
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.green.shade100,
            ),
            // Icon centang sebagai indikator sukses.
            child: const Center(
              child: Icon(Icons.check_circle_outline,
                  size: 80, color: Colors.green),
            ),
          ),
          const SizedBox(height: 16),
          // Deskripsi instruksi setelah pengembalian barang.
          const Text(
            'Kembalikan barang ke toko sesuai waktu.\nSetelah itu, beri ulasan untuk pengalaman sewa kamu.',
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }

  /* Fungsi ini membangun indikator langkah vertikal (stepper) di sisi kiri.
   * * Parameter:
   * - Tidak ada.
   * * Return: Widget Column yang berisi indikator langkah.
   */
  Widget buildStepIndicator() {
    return Column(
      // Membuat daftar indikator langkah berdasarkan jumlah tahapan (3).
      children: List.generate(3, (index) {
        return Column(
          children: [
            // Baris yang berisi lingkaran indikator dan teks 'Step X'.
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Lingkaran indikator step, warnanya berubah berdasarkan tahapan aktif.
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index <= _currentStep
                        ? const Color(0xFF627D2C) // Warna aktif
                        : Colors.grey, // Warna belum aktif
                  ),
                ),
                const SizedBox(width: 8),
                // Teks yang menunjukkan nomor step.
                Text(
                  'Step ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            // Garis vertikal antar step, tidak ditampilkan setelah step terakhir.
            if (index != 2)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 11),
                height: 40,
                width: 2,
                color: Colors.grey,
              ),
          ],
        );
      }),
    );
  }

  /// Widget [Scaffold]
  /// * Deskripsi:
  /// - Scaffold ini menyediakan struktur dasar visual untuk halaman.
  /// - Berisi AppBar, body, dan tombol navigasi di bagian bawah.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** Widget [AppBar]
       * * Deskripsi:
       * - Bilah aplikasi di bagian atas halaman.
       * - Berisi tombol "Close" dan judul halaman.
       */
      appBar: AppBar(
        // Tombol kembali (Close) di sisi kiri AppBar.
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Judul halaman "Pengambilan Barang".
        title: const Text('Pengambilan Barang',
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      /** Widget [Padding]
       * * Deskripsi:
       * - Memberikan padding pada konten utama halaman.
       */
      body: Padding(
        padding: const EdgeInsets.all(16),
        /** Widget [Column]
         * * Deskripsi:
         * - Mengatur tata letak widget secara vertikal.
         * - Berisi konten utama dan tombol "NEXT STEP"/"SUBMIT REVIEW".
         */
        child: Column(
          children: [
            /** Widget [Expanded]
             * * Deskripsi:
             * - Memungkinkan konten utama (indikator step dan buildContent)
             * mengambil semua ruang vertikal yang tersedia.
             */
            Expanded(
              /** Widget [Row]
               * * Deskripsi:
               * - Mengatur tata letak widget secara horizontal.
               * - Berisi indikator langkah di kiri dan konten dinamis di kanan.
               */
              child: Row(
                children: [
                  // Memanggil widget indikator langkah yang dibangun oleh buildStepIndicator().
                  buildStepIndicator(),
                  const SizedBox(width: 16),
                  /** Widget [Expanded]
                   * * Deskripsi:
                   * - Memungkinkan konten dinamis (buildContent) mengambil
                   * semua ruang horizontal yang tersedia.
                   */
                  Expanded(
                    // Memanggil widget konten yang dibangun oleh buildContent() berdasarkan _currentStep.
                    child: buildContent(),
                  ),
                ],
              ),
            ),
            /** Widget [ElevatedButton]
             * * Deskripsi:
             * - Tombol utama di bagian bawah halaman untuk memajukan langkah
             * atau menyelesaikan proses.
             */
            ElevatedButton(
              // Aksi yang dipanggil saat tombol ditekan, yaitu fungsi nextStep().
              onPressed: nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF627D2C), // Warna latar belakang tombol.
                minimumSize: const Size(double.infinity,
                    50), // Ukuran minimum tombol (lebar penuh).
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)), // Bentuk tombol.
              ),
              // Teks pada tombol, berubah menjadi 'SUBMIT REVIEW' pada langkah terakhir.
              child: Text(
                _currentStep < 2 ? 'NEXT STEP' : 'SUBMIT REVIEW',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
