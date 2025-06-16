/**
 * File        : step1.dart
 * Dibuat oleh  : Izzuddin Azzam
 * Tanggal      : 16-06-2025
 * Deskripsi    : Halaman langkah pertama dalam proses peminjaman barang,
 * menampilkan tampilan peta lokasi pengambilan dan progress stepper.
 * Dependencies :
 * - flutter_map: ^ untuk menampilkan peta lokasi interaktif.
 * - latlong2: ^ untuk mengelola koordinat lintang dan bujur.
 * - step2.dart: Untuk navigasi ke halaman langkah kedua.
 */

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Mengimpor pustaka flutter_map untuk peta
import 'package:latlong2/latlong.dart'; // Mengimpor pustaka latlong2 untuk koordinat geografis
import 'step2.dart'; // Mengimpor halaman Step2Page untuk navigasi selanjutnya

/** Widget [Step1Page]
 *
 * Deskripsi:
 * - Ini adalah widget utama untuk halaman langkah pertama dalam proses pengambilan barang.
 * - Halaman ini menampilkan peta lokasi pengambilan barang dan visualisasi langkah-langkah (stepper) dari proses tersebut.
 * - Ini adalah widget Stateless karena tidak memiliki state internal yang berubah seiring waktu;
 * semua datanya bersifat statis atau diterima dari parent widget.
 */
class Step1Page extends StatelessWidget {
  const Step1Page({super.key});

  /* Fungsi ini membangun tampilan halaman dengan struktur dan komponen UI.
   *
   * Parameter:
   * - [context]: BuildContext dari widget.
   *
   * Return: Sebuah widget Scaffold yang berisi seluruh struktur UI halaman.
   */
  @override
  Widget build(BuildContext context) {
    // Lokasi pusat peta, diatur ke koordinat Jakarta.
    final LatLng jakartaLocation = LatLng(-6.2088, 106.8456);

    return Scaffold(
      /** Widget [AppBar]
       * * Deskripsi:
       * - Bilah aplikasi di bagian atas halaman yang menampilkan judul dan tombol navigasi.
       */
      appBar: AppBar(
        /** Widget [Text]
         * * Deskripsi:
         * - Menampilkan judul "Pengambilan Barang" di tengah AppBar.
         * - Diberi gaya font **bold** dan warna hitam.
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
      /** Widget [Column]
       * * Deskripsi:
       * - Mengatur tata letak widget anak secara vertikal.
       * - Berisi tampilan peta, stepper visual, tombol navigasi, dan bottom navigation bar.
       */
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- PETA LOKASI ---
          /** Widget [Container]
           * * Deskripsi:
           * - Kotak yang menampung peta lokasi.
           * - Memiliki tinggi tetap, margin, dan border radius untuk tampilan yang rapi.
           */
          Container(
            height: 180,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            /** Widget [ClipRRect]
             * * Deskripsi:
             * - Memotong konten anak (peta) agar sesuai dengan border radius container.
             */
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              /** Widget [FlutterMap]
               * * Deskripsi:
               * - Widget peta interaktif yang menampilkan lokasi.
               */
              child: FlutterMap(
                options: MapOptions(
                  // Lokasi pusat peta. Data dinamis bisa diatur di sini.
                  center: jakartaLocation,
                  zoom: 12.0, // Level zoom peta
                ),
                children: [
                  /** Widget [TileLayer]
                   * * Deskripsi:
                   * - Menambahkan lapisan peta dari OpenStreetMap.
                   * - Menampilkan data peta visual.
                   */
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                ],
              ),
            ),
          ),

          // --- LANGKAH-LANGKAH (STEPPER) ---
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
                  // Langkah 1 - Aktif
                  /** Widget [Expanded]
                   * * Deskripsi:
                   * - Mengalokasikan ruang yang sama untuk setiap langkah stepper.
                   * - `flex: 1` memastikan pembagian ruang yang adil.
                   */
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                               * - Lingkaran besar dengan border hijau lembut sebagai indikator langkah **aktif**.
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
                                  color: Colors.grey[300], // Garis vertikal abu-abu
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8), // Spasi horizontal
                        /** Widget [Expanded]
                         * * Deskripsi:
                         * - Memungkinkan label dan deskripsi 'step 1' mengambil sisa ruang horizontal.
                         */
                        const Expanded(
                          /** Widget [Column]
                           * * Deskripsi:
                           * - Mengatur label 'step 1' dan deskripsi di bawahnya secara vertikal.
                           */
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /** Widget [Text]
                               * * Deskripsi:
                               * - Menampilkan label 'step 1' dengan gaya font **bold** dan warna hitam (**aktif**).
                               */
                              Text(
                                'step 1',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8), // Spasi vertikal
                              /** Widget [Text]
                               * * Deskripsi:
                               * - Deskripsi detail untuk langkah 1, menjelaskan proses pengambilan barang.
                               */
                              Text(
                                'Ambil perlengkapan sewa langsung di toko. Lokasi bisa dilihat melalui Google Maps yang telah disediakan.',
                                style: TextStyle(fontSize: 16, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Langkah 2 - Ditandai sebagai selesai (bulat hijau)
                  /** Widget [Expanded]
                   * * Deskripsi:
                   * - Mengalokasikan ruang yang sama untuk setiap langkah stepper.
                   * - `flex: 1` memastikan pembagian ruang yang adil.
                   */
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                               * - Lingkaran kecil berwarna hijau lembut sebagai indikator langkah yang telah **selesai**.
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
                           * - Menampilkan label 'step 2' dengan gaya font **bold** dan warna abu-abu (telah selesai/belum aktif).
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
                  // Langkah 3 - Belum aktif (bulat abu-abu)
                  /** Widget [Expanded]
                   * * Deskripsi:
                   * - Mengalokasikan ruang yang sama untuk setiap langkah stepper.
                   * - `flex: 1` memastikan pembagian ruang yang adil.
                   */
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                               * - Lingkaran kecil berwarna abu-abu sebagai indikator langkah yang **belum aktif**.
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
                        const SizedBox(width: 8), // Spasi horizontal
                        /** Widget [Expanded]
                         * * Deskripsi:
                         * - Memungkinkan teks label 'step 3' mengambil sisa ruang horizontal.
                         */
                        const Expanded(
                          /** Widget [Text]
                           * * Deskripsi:
                           * - Menampilkan label 'step 3' dengan gaya font **bold** dan warna abu-abu (belum aktif).
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

          // --- TOMBOL NEXT ---
          /** Widget [Padding]
           * * Deskripsi:
           * - Memberikan padding di sekitar tombol "NEXT STEP".
           */
          Padding(
            padding: const EdgeInsets.all(16.0),
            /** Widget [ElevatedButton]
             * * Deskripsi:
             * - Tombol utama di bagian bawah halaman untuk menavigasi ke halaman langkah berikutnya (**Step2Page**).
             */
            child: ElevatedButton(
              // Aksi saat tombol ditekan: navigasi ke Step2Page.
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Step2Page()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF627D2C), // Warna hijau tua
                minimumSize: const Size(double.infinity, 50), // Lebar penuh, tinggi 50
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), // Sudut tombol membulat
              ),
              /** Widget [Text]
               * * Deskripsi:
               * - Teks pada tombol "**NEXT STEP**".
               * - Diberi gaya font **bold**, ukuran 16, dan warna putih.
               */
              child: const Text(
                'NEXT STEP',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),

          // --- NAVIGASI BAWAH (Ikon) ---
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
}