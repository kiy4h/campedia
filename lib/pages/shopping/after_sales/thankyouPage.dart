/// File        : thank_you_page.dart
/// Dibuat oleh  : Izzuddin Azzam
/// Tanggal      : 16-06-2025
/// Deskripsi    : Halaman ini menampilkan ucapan terima kasih setelah pesanan berhasil dibuat.
/// Dilengkapi dengan konfirmasi pesanan, informasi Order ID, tanggal pesanan,
/// ilustrasi, dan tombol untuk melacak pesanan.
/// Dependencies : flutter/material.dart, step1.dart
library;

import 'package:flutter/material.dart';
import 'order_tracking.dart';

/// Widget [ThankYouPage]
/// * Deskripsi:
/// - Widget ini berfungsi sebagai tampilan konfirmasi keberhasilan pesanan.
/// - Ini adalah halaman setelah pengguna menyelesaikan proses pemesanan.
/// - Ini adalah widget stateless karena tampilannya statis dan tidak ada data
/// yang berubah secara internal di dalam widget ini.
class ThankYouPage extends StatelessWidget {
  const ThankYouPage({super.key});

  /* Fungsi ini membangun antarmuka pengguna untuk halaman ThankYouPage.
   * * Parameter:
   * - [context]: BuildContext dari widget.
   * * Return: Sebuah widget Scaffold yang berisi struktur UI halaman.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F4), // Warna latar belakang halaman.
      /** Widget [SafeArea]
       * * Deskripsi:
       * - Mengamankan tampilan konten agar tidak tumpang tindih dengan
       * area sistem operasi seperti status bar atau notch.
       */
      body: SafeArea(
        /** Widget [Column]
         * * Deskripsi:
         * - Mengatur tata letak widget anak secara vertikal.
         * - Digunakan untuk menumpuk header, konten utama, dan tombol pelacakan.
         */
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // === Header dengan judul "Pesanan Berhasil!" ===
            /** Widget [Container]
             * * Deskripsi:
             * - Wadah untuk judul halaman "Pesanan Berhasil!".
             * - Memiliki padding, dekorasi latar belakang putih, dan shadow.
             */
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              /** Widget [Center]
               * * Deskripsi:
               * - Menempatkan widget anak (Text) di tengah secara horizontal dan vertikal.
               */
              child: const Center(
                /** Widget [Text]
                 * * Deskripsi:
                 * - Menampilkan judul halaman "Pesanan Berhasil!".
                 * - Diberi gaya font bold dan warna hijau kustom.
                 */
                child: Text(
                  "Pesanan Berhasil!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF627D2C),
                  ),
                ),
              ),
            ),

            // === Bagian utama isi halaman ===
            /** Widget [Expanded]
             * * Deskripsi:
             * - Memungkinkan widget anak (Padding) untuk mengisi sisa ruang vertikal yang tersedia.
             */
            Expanded(
              /** Widget [Padding]
               * * Deskripsi:
               * - Memberikan padding horizontal pada konten utama halaman.
               */
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                /** Widget [Column]
                 * * Deskripsi:
                 * - Mengatur tata letak ikon sukses, teks ucapan terima kasih,
                 * informasi pesanan, ilustrasi, dan teks pengingat secara vertikal.
                 * - mainAxisAlignment.spaceEvenly digunakan untuk mendistribusikan ruang kosong secara merata.
                 */
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // --- Ikon sukses (ikon centang dalam lingkaran) ---
                    /** Widget [Container]
                     * * Deskripsi:
                     * - Wadah melingkar untuk ikon centang, dengan latar belakang hijau muda.
                     */
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8F0DD),
                        shape: BoxShape.circle,
                      ),
                      /** Widget [Icon]
                       * * Deskripsi:
                       * - Menampilkan ikon centang melingkar sebagai indikasi sukses.
                       * - Diberi warna hijau kustom dan ukuran yang besar.
                       */
                      child: const Icon(
                        Icons.check_circle,
                        color: Color(0xFF627D2C),
                        size: 50,
                      ),
                    ),

                    // --- Teks ucapan terima kasih dan konfirmasi ---
                    /** Widget [Column]
                     * * Deskripsi:
                     * - Mengatur teks ucapan terima kasih dan konfirmasi pesanan secara vertikal.
                     */
                    Column(
                      children: const [
                        /** Widget [Text]
                         * * Deskripsi:
                         * - Menampilkan pesan utama "Terima Kasih!".
                         * - Diberi gaya font bold, ukuran besar, dan warna hijau kustom.
                         */
                        Text(
                          "Terima Kasih!",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF627D2C),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        /** Widget [Text]
                         * * Deskripsi:
                         * - Menampilkan pesan konfirmasi bahwa pesanan telah dikonfirmasi.
                         * - Diberi gaya font dan warna abu-abu kustom.
                         */
                        Text(
                          "Pesanan Anda telah dikonfirmasi",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF8A8A8A),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    // --- Informasi Pesanan: Order ID dan Tanggal ---
                    /** Widget [Container]
                     * * Deskripsi:
                     * - Wadah informasi detail pesanan (Order ID dan Tanggal).
                     * - Memiliki padding, latar belakang putih, border radius, dan shadow.
                     */
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      /** Widget [Column]
                       * * Deskripsi:
                       * - Mengatur informasi Order ID dan Tanggal secara vertikal.
                       */
                      child: Column(
                        children: [
                          // Baris: Order ID
                          /** Widget [Row]
                           * * Deskripsi:
                           * - Menampilkan label "Order ID" dan nilai ID pesanan.
                           * - Menggunakan `mainAxisAlignment.spaceBetween` untuk meratakan teks di kiri dan kanan.
                           */
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              /** Widget [Text]
                               * * Deskripsi:
                               * - Label "Order ID".
                               */
                              Text(
                                "Order ID",
                                style: TextStyle(
                                  color: Color(0xFF8A8A8A),
                                ),
                              ),
                              /** Widget [Text]
                               * * Deskripsi:
                               * - Menampilkan nilai Order ID secara dinamis.
                               * - Diberi gaya font bold.
                               */
                              Text(
                                "#PLT2505-001",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24), // Pembatas antar baris.
                          // Baris: Tanggal Pesanan
                          /** Widget [Row]
                           * * Deskripsi:
                           * - Menampilkan label "Tanggal" dan nilai tanggal pesanan.
                           * - Menggunakan `mainAxisAlignment.spaceBetween` untuk meratakan teks di kiri dan kanan.
                           */
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              /** Widget [Text]
                               * * Deskripsi:
                               * - Label "Tanggal".
                               */
                              Text(
                                "Tanggal",
                                style: TextStyle(
                                  color: Color(0xFF8A8A8A),
                                ),
                              ),
                              /** Widget [Text]
                               * * Deskripsi:
                               * - Menampilkan nilai tanggal pesanan secara dinamis.
                               * - Diberi gaya font bold.
                               */
                              Text(
                                "1 Mei 2025",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // --- Gambar Ilustrasi dengan Aspect Ratio 16:9 ---
                    /** Widget [AspectRatio]
                     * * Deskripsi:
                     * - Memastikan gambar ilustrasi mempertahankan rasio aspek 16:9.
                     */
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      /** Widget [Container]
                       * * Deskripsi:
                       * - Wadah untuk gambar ilustrasi.
                       * - Memiliki border radius dan shadow.
                       */
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        /** Widget [ClipRRect]
                         * * Deskripsi:
                         * - Memotong gambar agar sesuai dengan border radius container.
                         */
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          /** Widget [Image.asset]
                           * * Deskripsi:
                           * - Menampilkan gambar ilustrasi dari aset lokal.
                           * - `fit: BoxFit.cover` memastikan gambar memenuhi area tanpa distorsi.
                           */
                          child: Image.asset(
                            'images/assets_OnBoarding0/onboarding4image.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    // --- Teks pengingat untuk pengguna ---
                    /** Widget [Text]
                     * * Deskripsi:
                     * - Menampilkan pesan pengingat penting kepada pengguna.
                     * - Diberi gaya font dan warna abu-abu gelap kustom.
                     */
                    const Text(
                      "Pastikan untuk memeriksa daftar peralatan saat pengambilan.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // === Tombol untuk melacak pesanan ===
            /** Widget [Container]
             * * Deskripsi:
             * - Wadah untuk tombol "LACAK PESANAN ANDA".
             * - Memiliki padding, latar belakang putih, dan shadow di bagian atas.
             */
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, -2),
                    blurRadius: 4,
                  ),
                ],
              ),
              /** Widget [SizedBox]
               * * Deskripsi:
               * - Memberikan ukuran tetap pada tombol (lebar penuh, tinggi 54).
               */
              child: SizedBox(
                width: double.infinity,
                height: 54,
                /** Widget [ElevatedButton]
                 * * Deskripsi:
                 * - Tombol interaktif untuk menavigasi ke halaman pelacakan pesanan.
                 */
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF627D2C), // Warna latar belakang tombol.
                    elevation: 0, // Tanpa elevasi (shadow) tambahan.
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Bentuk tombol bulat.
                    ),
                  ), // Fungsi yang dijalankan saat tombol ditekan.
                  onPressed: () {
                    // Navigasi ke halaman order_tracking menggunakan MaterialPageRoute.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderTrackingPage(
                          transactionId: 2505001,
                          currentStatus: OrderStatus.pickup,
                        ),
                      ),
                    );
                  },
                  /** Widget [Text]
                   * * Deskripsi:
                   * - Teks pada tombol "LACAK PESANAN ANDA".
                   * - Diberi gaya font bold, ukuran besar, spasi antar huruf, dan warna putih.
                   */
                  child: const Text(
                    "LACAK PESANAN ANDA",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
