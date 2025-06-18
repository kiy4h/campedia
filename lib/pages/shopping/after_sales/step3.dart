/// File        : step3.dart
/// Dibuat oleh  : Izzuddin Azzam
/// Tanggal      : 16-06-2025
/// Deskripsi    : Halaman langkah ketiga untuk proses pengembalian barang,
/// berisi konfirmasi bahwa barang telah dikembalikan dan ajakan memberi ulasan.
/// Dependencies :
/// - flutter/material.dart
/// - flutter_map: (Tidak digunakan langsung di halaman ini, tetapi diimpor, mungkin untuk konteks aplikasi yang lebih besar)
/// - step1.dart: Untuk navigasi kembali ke halaman sebelumnya (misalnya, melacak status).
/// - review.dart: Untuk navigasi ke halaman ReviewPage setelah pengguna mengembalikan barang.
library;

import 'package:flutter/material.dart';
// Meskipun tidak dipakai langsung, mungkin digunakan di halaman sebelumnya
// import 'step1.dart'; // Halaman untuk navigasi kembali
import 'review.dart'; // Halaman untuk memberikan ulasan setelah pengembalian barang

/// Widget [Step3Page]
/// * Deskripsi:
/// - Widget ini menampilkan konfirmasi bahwa proses pengembalian barang telah selesai.
/// - Merupakan bagian dari alur pengembalian barang sewaan, yaitu langkah terakhir.
/// - Ini adalah widget stateless karena tampilannya statis dan tidak ada data
/// yang berubah secara internal di dalam widget ini.
class Step3Page extends StatelessWidget {
  const Step3Page({super.key});

  /* Fungsi ini membangun antarmuka pengguna untuk halaman Step3Page.
   * * Parameter:
   * - [context]: BuildContext dari widget.
   * * Return: Sebuah widget Scaffold yang berisi struktur UI halaman.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bagian atas layar: AppBar
      /** Widget [AppBar]
       * * Deskripsi:
       * - Bilah aplikasi di bagian atas halaman yang menampilkan judul dan tombol navigasi.
       */
      appBar: AppBar(
        /** Widget [Text]
         * * Deskripsi:
         * - Menampilkan judul "Pengembalian Barang" di tengah AppBar.
         * - Diberi gaya font bold dan warna hitam.
         */
        title: const Text(
          'Pengembalian Barang',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        /** Widget [IconButton]
         * * Deskripsi:
         * - Tombol di sisi kiri AppBar untuk kembali ke halaman sebelumnya.
         * - Ikon silang ditempatkan dalam lingkaran hijau sebagai latar belakang.
         */
        leading: IconButton(
          // Container untuk dekorasi lingkaran hijau pada ikon.
          icon: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF627D2C), // Warna hijau tua
              shape: BoxShape.circle,
            ),
            /** Widget [Icon]
             * * Deskripsi:
             * - Menampilkan ikon 'close' (silang) berwarna putih.
             */
            child: const Icon(Icons.close, color: Colors.white, size: 18),
          ),
          // Aksi ketika tombol ditekan: navigasi kembali ke halaman sebelumnya.
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // Bagian utama layar: isi halaman
      /** Widget [Column]
       * * Deskripsi:
       * - Mengatur tata letak widget anak secara vertikal.
       * - Berisi bagian konfirmasi, stepper visual, dan tombol aksi.
       */
      body: Column(
        children: [
          // === Bagian konfirmasi visual dan teks ===
          /** Widget [Padding]
           * * Deskripsi:
           * - Memberikan padding di sekitar konten konfirmasi.
           */
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            /** Widget [Column]
             * * Deskripsi:
             * - Mengatur ikon centang dan teks ajakan ulasan secara vertikal.
             */
            child: Column(
              children: [
                // Box dengan ikon centang
                /** Widget [Container]
                 * * Deskripsi:
                 * - Wadah persegi panjang dengan sudut membulat dan latar belakang hijau muda.
                 * - Berisi ikon centang sebagai indikasi keberhasilan pengembalian.
                 */
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.green.shade100, // Warna hijau muda
                  ),
                  /** Widget [Center]
                   * * Deskripsi:
                   * - Menempatkan ikon di tengah container.
                   */
                  child: const Center(
                    /** Widget [Icon]
                     * * Deskripsi:
                     * - Menampilkan ikon 'check_circle_outline' berwarna hijau.
                     * - Ukuran ikon besar.
                     */
                    child: Icon(Icons.check_circle_outline,
                        size: 80, color: Colors.green),
                  ),
                ),
                const SizedBox(height: 16), // Spasi vertikal
                // Teks ajakan memberikan ulasan
                /** Widget [Text]
                 * * Deskripsi:
                 * - Menampilkan pesan konfirmasi pengembalian barang dan ajakan untuk memberikan ulasan.
                 * - Teks rata tengah dengan ukuran font 16 dan warna hitam.
                 */
                const Text(
                  'Terima kasih! Barang telah dikembalikan.\nSilakan berikan ulasan untuk pengalaman sewa kamu.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),

          // === Bagian Stepper Visual ===
          /** Widget [Expanded]
           * * Deskripsi:
           * - Memungkinkan stepper visual mengambil sisa ruang vertikal yang tersedia.
           */
          Expanded(
            /** Widget [Padding]
             * * Deskripsi:
             * - Memberikan padding di sekitar stepper visual.
             */
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
              /** Widget [Column]
               * * Deskripsi:
               * - Mengatur tampilan langkah-langkah proses (step 1, 2, 3) secara vertikal.
               */
              child: Column(
                children: [
                  // --- STEP 1: Selesai ---
                  /** Widget [Expanded]
                   * * Deskripsi:
                   * - Mengalokasikan ruang yang sama untuk setiap langkah stepper.
                   */
                  Expanded(
                    flex: 1,
                    /** Widget [Row]
                     * * Deskripsi:
                     * - Mengatur indikator bulat, garis vertikal, dan label step secara horizontal.
                     */
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Indikator bulat hijau + garis bawah
                        /** Widget [SizedBox]
                         * * Deskripsi:
                         * - Menetapkan lebar tetap untuk kolom indikator.
                         */
                        SizedBox(
                          width: 50,
                          /** Widget [Column]
                           * * Deskripsi:
                           * - Mengatur lingkaran indikator dan garis vertikal di bawahnya.
                           */
                          child: Column(
                            children: [
                              /** Widget [Container]
                               * * Deskripsi:
                               * - Lingkaran kecil berwarna hijau lembut sebagai indikator langkah yang telah selesai.
                               */
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF9BAE76), // Hijau lembut
                                  shape: BoxShape.circle,
                                ),
                              ),
                              /** Widget [Expanded]
                               * * Deskripsi:
                               * - Garis vertikal tipis berwarna abu-abu yang menghubungkan antar langkah.
                               */
                              Expanded(
                                child: Container(
                                  width: 3,
                                  color: Colors
                                      .grey[300], // Garis vertikal abu-abu
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8), // Spasi horizontal
                        // Label step
                        /** Widget [Expanded]
                         * * Deskripsi:
                         * - Memungkinkan teks label 'step 1' mengambil sisa ruang horizontal.
                         */
                        const Expanded(
                          /** Widget [Text]
                           * * Deskripsi:
                           * - Menampilkan label 'step 1' dengan gaya font bold dan warna abu-abu.
                           */
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
                  /** Widget [Expanded]
                   * * Deskripsi:
                   * - Mengalokasikan ruang yang sama untuk setiap langkah stepper.
                   */
                  Expanded(
                    flex: 1,
                    /** Widget [Row]
                     * * Deskripsi:
                     * - Mengatur indikator bulat, garis vertikal, dan label step secara horizontal.
                     */
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Indikator bulat hijau + garis bawah
                        /** Widget [SizedBox]
                         * * Deskripsi:
                         * - Menetapkan lebar tetap untuk kolom indikator.
                         */
                        SizedBox(
                          width: 50,
                          /** Widget [Column]
                           * * Deskripsi:
                           * - Mengatur lingkaran indikator dan garis vertikal di bawahnya.
                           */
                          child: Column(
                            children: [
                              /** Widget [Container]
                               * * Deskripsi:
                               * - Lingkaran kecil berwarna hijau lembut sebagai indikator langkah yang telah selesai.
                               */
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF9BAE76),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              /** Widget [Expanded]
                               * * Deskripsi:
                               * - Garis vertikal tipis berwarna abu-abu yang menghubungkan antar langkah.
                               */
                              Expanded(
                                child: Container(
                                  width: 3,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8), // Spasi horizontal
                        /** Widget [Expanded]
                         * * Deskripsi:
                         * - Memungkinkan teks label 'step 2' mengambil sisa ruang horizontal.
                         */
                        const Expanded(
                          /** Widget [Text]
                           * * Deskripsi:
                           * - Menampilkan label 'step 2' dengan gaya font bold dan warna abu-abu.
                           */
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
                  /** Widget [Expanded]
                   * * Deskripsi:
                   * - Mengalokasikan ruang yang sama untuk setiap langkah stepper.
                   */
                  Expanded(
                    flex: 1,
                    /** Widget [Row]
                     * * Deskripsi:
                     * - Mengatur indikator bulat, garis vertikal, dan label step secara horizontal.
                     */
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Lingkaran besar dengan border hijau (tanda aktif)
                        /** Widget [SizedBox]
                         * * Deskripsi:
                         * - Menetapkan lebar tetap untuk kolom indikator.
                         */
                        SizedBox(
                          width: 50,
                          /** Widget [Column]
                           * * Deskripsi:
                           * - Mengatur lingkaran indikator. Tidak ada garis di bawah karena ini langkah terakhir.
                           */
                          child: Column(
                            children: [
                              /** Widget [Container]
                               * * Deskripsi:
                               * - Lingkaran besar dengan border hijau lembut sebagai indikator langkah aktif.
                               */
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        const Color(0xFF9BAE76), // Hijau lembut
                                    width: 6,
                                  ),
                                ),
                              ),
                              // Tidak ada garis bawah karena ini langkah terakhir
                            ],
                          ),
                        ),
                        const SizedBox(width: 8), // Spasi horizontal
                        // Label dan deskripsi step 3
                        /** Widget [Expanded]
                         * * Deskripsi:
                         * - Memungkinkan label dan deskripsi 'step 3' mengambil sisa ruang horizontal.
                         */
                        const Expanded(
                          /** Widget [Column]
                           * * Deskripsi:
                           * - Mengatur label 'step 3' dan deskripsi di bawahnya secara vertikal.
                           */
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /** Widget [Text]
                               * * Deskripsi:
                               * - Menampilkan label 'step 3' dengan gaya font bold dan warna hitam (aktif).
                               */
                              Text(
                                'step 3',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8), // Spasi vertikal
                              /** Widget [Text]
                               * * Deskripsi:
                               * - Deskripsi detail untuk langkah 3, yaitu pengembalian barang dan ajakan ulasan.
                               */
                              Text(
                                'Kembalikan barang ke toko sesuai waktu. Setelah itu, beri ulasan untuk pengalaman sewa kamu.',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black87),
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
          /** Widget [Padding]
           * * Deskripsi:
           * - Memberikan padding di sekitar tombol "SUBMIT REVIEW".
           */
          Padding(
            padding: const EdgeInsets.all(16.0),
            /** Widget [ElevatedButton]
             * * Deskripsi:
             * - Tombol utama di bagian bawah halaman untuk menavigasi ke halaman ulasan.
             */
            child: ElevatedButton(
              // Aksi saat tombol ditekan: navigasi ke ReviewPage.
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReviewPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF627D2C), // Warna hijau tua
                minimumSize:
                    const Size(double.infinity, 50), // Lebar penuh, tinggi 50
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(25), // Sudut tombol membulat
                ),
              ),
              /** Widget [Text]
               * * Deskripsi:
               * - Teks pada tombol "SUBMIT REVIEW".
               * - Diberi gaya font bold, ukuran 16, dan warna putih.
               */
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
