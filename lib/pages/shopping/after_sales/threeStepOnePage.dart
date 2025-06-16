// Import package Flutter utama untuk UI
import 'package:flutter/material.dart';

// Import package countdown timer untuk menampilkan waktu mundur
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

// ====================
// Halaman Pelacakan Pengambilan Barang
// Terdiri dari 3 tahap: Ambil Barang → Waktu Pengembalian → Selesai
// ====================

class PickupTrackingPage extends StatefulWidget {
  const PickupTrackingPage({super.key});

  @override
  _PickupTrackingPageState createState() => _PickupTrackingPageState();
}

class _PickupTrackingPageState extends State<PickupTrackingPage> {
  // Menyimpan tahapan proses pengambilan: 0 = Ambil, 1 = Countdown, 2 = Selesai
  int _currentStep = 0;

  // Menentukan waktu akhir countdown (2 hari dari sekarang)
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60 * 48;

  // ====================
  // Fungsi untuk lanjut ke step berikutnya
  // Jika sudah sampai step 2, tampilkan dialog konfirmasi
  // ====================
  void nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Dialog selesai setelah step terakhir
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Selesai!'),
          content: const Text('Terima kasih! Jangan lupa beri ulasan ya.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  // ====================
  // Widget yang menampilkan isi konten berdasarkan tahapan
  // ====================
  Widget buildContent() {
    if (_currentStep == 0) {
      // === Tahap 1: Ambil Barang di Toko ===
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade300,
            ),
            child: const Center(
              child: Text('MAPS', style: TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: 16),
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
          CountdownTimer(
            endTime: endTime,
            textStyle: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            onEnd: () {
              setState(() {
                _currentStep = 2;
              });
            },
          ),
          const SizedBox(height: 16),
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
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.green.shade100,
            ),
            child: const Center(
              child: Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Kembalikan barang ke toko sesuai waktu.\nSetelah itu, beri ulasan untuk pengalaman sewa kamu.',
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }

  // ====================
  // Widget indikator vertikal langkah (stepper) di sisi kiri
  // ====================
  Widget buildStepIndicator() {
    return Column(
      children: List.generate(3, (index) {
        return Column(
          children: [
            // Lingkaran indikator step
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                Text(
                  'Step ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            // Garis vertikal antar step
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

  // ====================
  // Build utama halaman
  // ====================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Tombol kembali (Close)
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Pengambilan Barang', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // === Konten Utama ===
            Expanded(
              child: Row(
                children: [
                  buildStepIndicator(), // Step indikator di kiri
                  const SizedBox(width: 16),
                  Expanded(child: buildContent()), // Konten berdasarkan step
                ],
              ),
            ),

            // === Tombol NEXT / Submit ===
            ElevatedButton(
              onPressed: nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF627D2C),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
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
