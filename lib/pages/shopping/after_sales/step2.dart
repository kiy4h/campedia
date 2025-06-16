/**
 * File        : step2.dart
 * Dibuat oleh  : Izzuddin Azzam
 * Tanggal      : 16-06-2025
 * Deskripsi    : Halaman langkah ke-2 dalam proses peminjaman barang,
 * berisi countdown timer untuk menunjukkan sisa waktu pengembalian.
 * Dependencies :
 * - flutter/material.dart
 * - dart:async (untuk Timer)
 * - step3.dart (untuk navigasi ke halaman langkah ke-3)
 */

import 'package:flutter/material.dart';
import 'dart:async'; // Mengimpor pustaka async untuk menggunakan Timer
import 'step3.dart'; // Mengimpor halaman Step3Page untuk navigasi selanjutnya

/** Widget [Step2Page]
 *
 * Deskripsi:
 * - Ini adalah widget utama untuk halaman langkah kedua dalam proses peminjaman barang.
 * - Halaman ini menampilkan hitungan mundur (countdown timer) untuk menunjukkan sisa waktu pengembalian barang.
 * - Ini adalah widget Stateful karena memiliki state internal (waktu hitung mundur) yang dapat berubah seiring waktu
 * dan memerlukan pembaharuan UI secara periodik.
 */
class Step2Page extends StatefulWidget {
  const Step2Page({super.key});

  @override
  State<Step2Page> createState() => _Step2PageState();
}

/** Widget [_Step2PageState]
 *
 * Deskripsi:
 * - State dari widget Step2Page yang mengelola logika dan data untuk hitungan mundur.
 * - Bertanggung jawab untuk menghitung dan memperbarui sisa waktu pengembalian barang setiap detik.
 * - Merupakan bagian dari layar "Pengambilan Barang" yang menampilkan informasi waktu kritis.
 */
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

  /* Fungsi ini diinisialisasi saat widget pertama kali dibuat.
   *
   * Parameter:
   * - Tidak ada.
   *
   * Return: Tidak ada.
   */
  @override
  void initState() {
    super.initState();

    // Hitung waktu akhir 2 hari ke depan dari saat ini
    // Ini menentukan kapan hitungan mundur akan berakhir.
    endTime = DateTime.now().add(const Duration(days: 2));

    // Hitung waktu tersisa saat halaman pertama kali dimuat
    _calculateTimeLeft();

    // Buat timer yang memanggil _calculateTimeLeft setiap detik
    // Timer ini memastikan UI hitungan mundur diperbarui secara real-time.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _calculateTimeLeft();
    });
  }

  /* Fungsi ini dipanggil ketika widget dihapus dari pohon widget secara permanen.
   * Digunakan untuk membersihkan sumber daya seperti timer untuk mencegah kebocoran memori.
   *
   * Parameter:
   * - Tidak ada.
   *
   * Return: Tidak ada.
   */
  @override
  void dispose() {
    // Hentikan timer agar tidak terus berjalan saat halaman sudah tidak aktif.
    // Ini adalah praktik terbaik untuk manajemen sumber daya.
    _timer.cancel();
    super.dispose();
  }

  /* Fungsi ini menghitung sisa waktu dari sekarang hingga endTime.
   * Hasil perhitungan disimpan dalam variabel state (days, hours, minutes, seconds)
   * dan memicu pembaruan UI.
   *
   * Parameter:
   * - Tidak ada.
   *
   * Return: Tidak ada.
   */
  void _calculateTimeLeft() {
    final now = DateTime.now();
    final difference = endTime.difference(now);

    if (difference.isNegative) {
      // Jika waktu telah habis, tampilkan 0 untuk semua unit waktu
      setState(() {
        days = 0;
        hours = 0;
        minutes = 0;
        seconds = 0;
      });
    } else {
      // Update sisa waktu sesuai perhitungan
      // setState digunakan untuk memberi tahu Flutter bahwa state telah berubah
      // dan UI perlu dibangun ulang.
      setState(() {
        days = difference.inDays;
        hours = difference.inHours.remainder(24);
        minutes = difference.inMinutes.remainder(60);
        seconds = difference.inSeconds.remainder(60);
      });
    }
  }

  /* Fungsi ini membangun tampilan halaman dengan struktur dan komponen UI.
   *
   * Parameter:
   * - [context]: BuildContext dari widget.
   *
   * Return: Sebuah widget Scaffold yang berisi seluruh struktur UI halaman.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** Widget [AppBar]
       * * Deskripsi:
       * - Bilah aplikasi di bagian atas halaman yang menampilkan judul dan tombol navigasi.
       */
      appBar: AppBar(
        /** Widget [Text]
         * * Deskripsi:
         * - Menampilkan judul "Pengambilan Barang" di tengah AppBar.
         * - Diberi gaya font bold dan warna hitam.
         */
        title: const Text(
          'Pengambilan Barang',
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

      // Konten halaman utama
      /** Widget [Column]
       * * Deskripsi:
       * - Mengatur tata letak widget anak secara vertikal.
       * - Berisi tampilan countdown timer, stepper visual, tombol navigasi, dan bottom navigation bar.
       */
      body: Column(
        children: [
          // Tampilan countdown timer
          /** Widget [Padding]
           * * Deskripsi:
           * - Memberikan padding vertikal di sekitar tampilan hitungan mundur.
           */
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            /** Widget [Row]
             * * Deskripsi:
             * - Mengatur kotak-kotak waktu (hari, jam, menit, detik) secara horizontal di tengah.
             */
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Menampilkan kotak waktu untuk Hari
                _buildTimeBox(days.toString().padLeft(2, '0'), "HARI"),
                const SizedBox(width: 8), // Spasi antar kotak
                // Menampilkan kotak waktu untuk Jam
                _buildTimeBox(hours.toString().padLeft(2, '0'), "JAM"),
                const SizedBox(width: 8), // Spasi antar kotak
                // Menampilkan kotak waktu untuk Menit
                _buildTimeBox(minutes.toString().padLeft(2, '0'), "MENIT"),
                const SizedBox(width: 8), // Spasi antar kotak
                // Menampilkan kotak waktu untuk Detik
                _buildTimeBox(seconds.toString().padLeft(2, '0'), "DETIK"),
              ],
            ),
          ),

          // Stepper Progress
          /** Widget [Expanded]
           * * Deskripsi:
           * - Memungkinkan stepper visual mengambil sisa ruang vertikal yang tersedia.
           */
          Expanded(
            /** Widget [Padding]
             * * Deskripsi:
             * - Memberikan padding horizontal di sekitar stepper visual.
             */
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              /** Widget [Column]
               * * Deskripsi:
               * - Mengatur tampilan langkah-langkah proses (step 1, 2, 3) secara vertikal.
               */
              child: Column(
                children: [
                  // Step 1 - Selesai
                  /** Widget [Expanded]
                   * * Deskripsi:
                   * - Mengalokasikan ruang yang sama untuk setiap langkah stepper.
                   */
                  Expanded(
                    child: Row(
                      children: [
                        // Indikator Step 1 (lingkaran hijau dan garis ke bawah)
                        /** Widget [SizedBox]
                         * * Deskripsi:
                         * - Menetapkan lebar tetap untuk kolom indikator step.
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
                                  color: Color(0xFF9BAE76), // Warna hijau lembut
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
                                  color: Colors.grey[300], // Garis vertikal abu-abu
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Label dan deskripsi step 1
                        /** Widget [Expanded]
                         * * Deskripsi:
                         * - Memungkinkan teks label 'step 1' mengambil sisa ruang horizontal.
                         */
                        const Expanded(
                          /** Widget [Text]
                           * * Deskripsi:
                           * - Menampilkan label 'step 1' dengan gaya font bold dan warna abu-abu (selesai).
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

                  // Step 2 - Aktif
                  /** Widget [Expanded]
                   * * Deskripsi:
                   * - Mengalokasikan ruang yang sama untuk setiap langkah stepper.
                   */
                  Expanded(
                    child: Row(
                      children: [
                        // Indikator Step 2 (lingkaran besar border hijau)
                        /** Widget [SizedBox]
                         * * Deskripsi:
                         * - Menetapkan lebar tetap untuk kolom indikator step.
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
                               * - Lingkaran besar dengan border hijau lembut sebagai indikator langkah aktif.
                               */
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF9BAE76), // Warna hijau lembut
                                    width: 6,
                                  ),
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
                        // Label dan deskripsi step 2
                        /** Widget [Expanded]
                         * * Deskripsi:
                         * - Memungkinkan label dan deskripsi 'step 2' mengambil sisa ruang horizontal.
                         */
                        const Expanded(
                          /** Widget [Column]
                           * * Deskripsi:
                           * - Mengatur label 'step 2' dan deskripsi di bawahnya secara vertikal.
                           */
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /** Widget [Text]
                               * * Deskripsi:
                               * - Menampilkan label 'step 2' dengan gaya font bold dan warna hitam (aktif).
                               */
                              Text(
                                'step 2',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8), // Spasi vertikal
                              /** Widget [Text]
                               * * Deskripsi:
                               * - Deskripsi detail untuk langkah 2, mengenai melihat waktu tersisa dan memastikan pengembalian tepat waktu.
                               */
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
                  /** Widget [Expanded]
                   * * Deskripsi:
                   * - Mengalokasikan ruang yang sama untuk setiap langkah stepper.
                   */
                  Expanded(
                    child: Row(
                      children: [
                        // Indikator Step 3 (lingkaran abu)
                        /** Widget [SizedBox]
                         * * Deskripsi:
                         * - Menetapkan lebar tetap untuk kolom indikator step.
                         */
                        SizedBox(
                          width: 50,
                          /** Widget [Column]
                           * * Deskripsi:
                           * - Mengatur lingkaran indikator. Tidak ada garis di bawah karena ini langkah terakhir.
                           */
                          child: Column(
                            children: [
                              const SizedBox(height: 8), // Spasi vertikal
                              /** Widget [Container]
                               * * Deskripsi:
                               * - Lingkaran kecil berwarna abu-abu sebagai indikator langkah yang belum aktif.
                               */
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400], // Warna abu-abu
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Label step 3
                        /** Widget [Expanded]
                         * * Deskripsi:
                         * - Memungkinkan teks label 'step 3' mengambil sisa ruang horizontal.
                         */
                        const Expanded(
                          /** Widget [Text]
                           * * Deskripsi:
                           * - Menampilkan label 'step 3' dengan gaya font bold dan warna abu-abu (belum aktif).
                           */
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
          /** Widget [Padding]
           * * Deskripsi:
           * - Memberikan padding di sekitar tombol "NEXT STEP".
           */
          Padding(
            padding: const EdgeInsets.all(16.0),
            /** Widget [ElevatedButton]
             * * Deskripsi:
             * - Tombol utama di bagian bawah halaman untuk menavigasi ke halaman langkah berikutnya (Step3Page).
             */
            child: ElevatedButton(
              // Aksi saat tombol ditekan: navigasi ke Step3Page.
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Step3Page()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF627D2C), // Warna hijau tua
                minimumSize: const Size(double.infinity, 50), // Lebar penuh, tinggi 50
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), // Sudut tombol membulat
              ),
              /** Widget [Text]
               * * Deskripsi:
               * - Teks pada tombol "NEXT STEP".
               * - Diberi gaya font bold, ukuran 16, dan warna putih.
               */
              child: const Text(
                'NEXT STEP',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),

          // Bottom Navigation Bar (ikon statis)
          /** Widget [Container]
           * * Deskripsi:
           * - Bilah navigasi bawah yang berisi beberapa ikon navigasi statis.
           * - Memiliki bayangan di bagian atas untuk efek kedalaman.
           */
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
            /** Widget [Row]
             * * Deskripsi:
             * - Mengatur ikon-ikon navigasi secara horizontal dengan jarak yang sama.
             */
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /** Widget [Icon]
                 * * Deskripsi:
                 * - Ikon 'home' untuk navigasi ke halaman utama.
                 */
                Icon(Icons.home, color: Colors.grey[600]),
                /** Widget [Icon]
                 * * Deskripsi:
                 * - Ikon 'swap_horiz' untuk navigasi terkait transaksi atau pertukaran.
                 */
                Icon(Icons.swap_horiz, color: Colors.grey[600]),
                /** Widget [Stack]
                 * * Deskripsi:
                 * - Mengatur ikon 'shopping_cart' dengan indikator notifikasi di sudut kanan atas.
                 */
                Stack(
                  children: [
                    /** Widget [Icon]
                     * * Deskripsi:
                     * - Ikon keranjang belanja.
                     */
                    Icon(Icons.shopping_cart, color: Colors.grey[600]),
                    /** Widget [Positioned]
                     * * Deskripsi:
                     * - Menempatkan container notifikasi kecil di sudut kanan atas ikon keranjang.
                     */
                    Positioned(
                      right: 0,
                      top: 0,
                      /** Widget [Container]
                       * * Deskripsi:
                       * - Lingkaran kecil berwarna amber sebagai indikator notifikasi (misalnya, item di keranjang).
                       */
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.amber, // Warna kuning keemasan
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                /** Widget [Icon]
                 * * Deskripsi:
                 * - Ikon 'favorite_border' untuk navigasi ke daftar favorit.
                 */
                Icon(Icons.favorite_border, color: Colors.grey[600]),
                /** Widget [CircleAvatar]
                 * * Deskripsi:
                 * - Avatar lingkaran statis, mungkin untuk profil pengguna.
                 */
                const CircleAvatar(radius: 12, backgroundColor: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* Fungsi ini membuat kotak tampilan untuk setiap unit waktu (hari/jam/menit/detik)
   * dalam hitungan mundur.
   *
   * Parameter:
   * - [number]: String representasi angka waktu (misal: "01", "23").
   * - [label]: String label unit waktu (misal: "HARI", "JAM").
   *
   * Return: Sebuah widget Column yang berisi kotak angka dan labelnya.
   */
  Widget _buildTimeBox(String number, String label) {
    return Column(
      children: [
        /** Widget [Container]
         * * Deskripsi:
         * - Kotak hitam dengan sudut membulat untuk menampilkan angka waktu.
         */
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(4),
          ),
          /** Widget [Center]
           * * Deskripsi:
           * - Menempatkan teks angka di tengah kotak.
           */
          child: Center(
            /** Widget [Text]
             * * Deskripsi:
             * - Menampilkan angka waktu (hari, jam, menit, atau detik).
             * - Diberi gaya font besar, bold, dan warna putih.
             */
            child: Text(
              number, // Data dinamis: angka waktu
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4), // Spasi vertikal
        /** Widget [Text]
         * * Deskripsi:
         * - Menampilkan label unit waktu (misal: "HARI", "JAM") di bawah angka.
         */
        Text(
          label, // Data dinamis: label unit waktu
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