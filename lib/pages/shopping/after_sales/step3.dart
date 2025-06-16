/*
* File : step3.dart
* Deskripsi : Halaman langkah ketiga untuk proses pengembalian barang, 
*             berisi konfirmasi bahwa barang telah dikembalikan dan ajakan memberi ulasan.
* Dependencies : 
*   - flutter_map: (tidak digunakan langsung tapi mungkin digunakan di halaman lain)
*   - step1.dart: untuk keperluan navigasi sebelumnya
*   - review.dart: untuk navigasi ke halaman ReviewPage setelah pengguna mengembalikan barang
*/

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Meskipun tidak dipakai langsung, mungkin digunakan di halaman sebelumnya
import 'step1.dart';
import 'review.dart'; // Halaman untuk memberikan ulasan setelah pengembalian barang

/*
* Class : Step3Page
* Deskripsi : StatelessWidget untuk menampilkan konfirmasi pengembalian barang (langkah 3)
* Struktur Halaman : 
*   - AppBar dengan tombol kembali
*   - Konten konfirmasi pengembalian
*   - Stepper visual (step 1, 2 selesai; step 3 aktif)
*   - Tombol menuju ke halaman review
*/
class Step3Page extends StatelessWidget {
  const Step3Page({super.key});

  /*
  * Method : build
  * Deskripsi : Membangun tampilan halaman dengan struktur dan komponen UI
  * Return : Widget Scaffold
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bagian atas layar: AppBar
      appBar: AppBar(
        title: const Text(
          'Pengembalian Barang',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          // Tombol kembali (ikon silang dalam lingkaran hijau)
          icon: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF627D2C),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, color: Colors.white, size: 18),
          ),
          onPressed: () => Navigator.pop(context), // Navigasi kembali
        ),
      ),

      // Bagian utama layar: isi halaman
      body: Column(
        children: [
          // === Bagian konfirmasi visual dan teks ===
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              children: [
                // Box dengan ikon centang
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
                // Teks ajakan memberikan ulasan
                const Text(
                  'Terima kasih! Barang telah dikembalikan.\nSilakan berikan ulasan untuk pengalaman sewa kamu.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),

          // === Bagian Stepper Visual ===
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
              child: Column(
                children: [
                  // --- STEP 1: Selesai ---
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Indikator bulat hijau + garis bawah
                        SizedBox(
                          width: 50,
                          child: Column(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF9BAE76), // Hijau lembut
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 3,
                                  color: Colors.grey[300], // Garis vertikal abu-abu
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Label step
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

                  // --- STEP 2: Selesai ---
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Indikator bulat hijau + garis bawah
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
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'step 2',
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

                  // --- STEP 3: Aktif (current step) ---
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Lingkaran besar dengan border hijau (tanda aktif)
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
                              // Tidak ada garis bawah karena ini langkah terakhir
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Label dan deskripsi step 3
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'step 3',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Kembalikan barang ke toko sesuai waktu. Setelah itu, beri ulasan untuk pengalaman sewa kamu.',
                                style: TextStyle(fontSize: 16, color: Colors.black87),
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

          // === Tombol Aksi: Submit Review ===
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman ulasan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReviewPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF627D2C), // Warna hijau tua
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'SUBMIT REVIEW',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
