/// File        : detail_denda_page.dart
/// Dibuat oleh  : Izzuddin Azzam
/// Tanggal      : 16-06-2025
/// Deskripsi    : Halaman ini menampilkan detail informasi mengenai denda kerusakan atau pelanggaran
/// pada barang yang disewa. Detail mencakup nama barang, deskripsi kerusakan, jenis pelanggaran,
/// nominal denda, dan catatan tambahan, serta dilengkapi dengan tombol untuk melanjutkan pembayaran denda.
/// Dependencies :
/// - flutter/material.dart: Pustaka dasar Flutter untuk membangun UI.
library;

import 'package:flutter/material.dart';

/// Widget [DetailDendaPage]
///
/// Deskripsi:
/// - Halaman ini berfungsi untuk menampilkan rincian denda yang dikenakan pada penyewaan barang.
/// - Ini adalah bagian dari alur penanganan insiden atau pengembalian barang yang bermasalah.
/// - Merupakan StatelessWidget karena data denda yang ditampilkan bersifat statis (untuk contoh ini)
/// dan tidak ada interaksi yang mengubah state di halaman ini. Dalam implementasi nyata,
/// data denda mungkin akan diterima sebagai parameter atau dari provider state management.
class DetailDendaPage extends StatelessWidget {
  const DetailDendaPage({super.key});

  /* Fungsi ini membangun seluruh struktur UI dari halaman detail denda.
   *
   * Parameter:
   * - [context]: BuildContext dari widget.
   *
   * Return: Sebuah widget [Scaffold] yang berisi AppBar dan body halaman.
   */
  @override
  Widget build(BuildContext context) {
    // Dummy data untuk detail denda.
    // Dalam aplikasi sesungguhnya, data ini akan diterima melalui konstruktor
    // atau state management (misalnya Provider, BLoC, Riverpod).
    final namaBarang = 'Kabel HDMI';
    final deskripsi = 'Kabel rusak pada bagian ujung konektor.';
    final jenisPelanggaran = 'Kerusakan Barang';
    final nominal = 'Rp 50.000';
    final catatan = 'Harap dikembalikan meskipun rusak.';

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAF4), // Warna latar belakang halaman.
      /** Widget [AppBar]
       * * Deskripsi:
       * - Bilah aplikasi di bagian atas halaman, menampilkan judul dan tombol kembali.
       */
      appBar: AppBar(
        /** Widget [Text]
         * * Deskripsi:
         * - Judul halaman "Pembayaran Denda".
         * - Gaya teks dengan warna hitam.
         */
        title: const Text(
          'Pembayaran Denda',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true, // Memusatkan judul.
        backgroundColor: Colors.transparent, // Latar belakang transparan.
        elevation: 0, // Menghilangkan bayangan di bawah AppBar.
        /** Widget [BackButton]
         * * Deskripsi:
         * - Tombol navigasi kembali ke halaman sebelumnya.
         */
        leading: const BackButton(
            color: Colors.black), // Tombol kembali berwarna hitam.
      ),
      /** Widget [Padding]
       * * Deskripsi:
       * - Memberikan padding di sekitar konten utama halaman.
       */
      body: Padding(
        padding: const EdgeInsets.all(16),
        /** Widget [Column]
         * * Deskripsi:
         * - Mengatur tata letak elemen-elemen UI secara vertikal.
         * - Elemen-elemen disusun dari atas ke bawah.
         */
        child: Column(
          children: [
            /** Widget [Icon]
             * * Deskripsi:
             * - Ikon peringatan visual yang menarik perhatian.
             */
            const Icon(Icons.report_gmailerrorred_rounded,
                size: 60, color: Color(0xFF627D2C)),
            const SizedBox(height: 12), // Spasi vertikal.

            /** Widget [Text]
             * * Deskripsi:
             * - Judul utama bagian detail denda.
             * - Gaya teks tebal dengan ukuran 20.
             */
            const Text(
              'Detail Denda',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // Spasi vertikal.

            // --- Daftar Detail dalam ListView ---
            /** Widget [Expanded]
             * * Deskripsi:
             * - Memungkinkan [ListView] untuk mengambil sisa ruang vertikal yang tersedia.
             */
            Expanded(
              /** Widget [ListView]
               * * Deskripsi:
               * - Menampilkan daftar detail denda yang dapat digulir.
               * - Setiap detail ditampilkan dalam kartu terpisah.
               */
              child: ListView(
                children: [
                  _buildDetailCard(
                      'Nama Barang', namaBarang), // Kartu untuk nama barang.
                  _buildImageCard(
                      'https://via.placeholder.com/300x180.png?text=Gambar+Barang'), // Kartu untuk gambar barang.
                  _buildDetailCard(
                      'Deskripsi Barang', deskripsi), // Kartu untuk deskripsi.
                  _buildDetailCard('Jenis Pelanggaran',
                      jenisPelanggaran), // Kartu untuk jenis pelanggaran.
                  _buildDetailCard(
                      'Nominal Denda', nominal), // Kartu untuk nominal denda.
                  _buildDetailCard('Catatan Tambahan',
                      catatan), // Kartu untuk catatan tambahan.
                ],
              ),
            ),
            const SizedBox(height: 16), // Spasi vertikal.

            // --- Tombol Lanjut ke Pembayaran ---
            /** Widget [SizedBox]
             * * Deskripsi:
             * - Menetapkan lebar penuh dan tinggi tetap untuk tombol pembayaran.
             */
            SizedBox(
              width: double.infinity, // Lebar tombol memenuhi lebar layar.
              height: 50, // Tinggi tombol.
              /** Widget [ElevatedButton.icon]
               * * Deskripsi:
               * - Tombol utama untuk melanjutkan ke halaman pembayaran denda.
               * - Memiliki ikon pembayaran dan teks "LANJUT BAYAR".
               */
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Logika navigasi ke halaman metode pembayaran akan ditambahkan di sini.
                },
                /** Widget [Icon]
                 * * Deskripsi:
                 * - Ikon pembayaran di sebelah kiri teks tombol.
                 */
                icon: const Icon(Icons.payment, color: Colors.white),
                /** Widget [Text]
                 * * Deskripsi:
                 * - Teks pada tombol "LANJUT BAYAR".
                 * - Gaya teks dengan ukuran 16, spasi antar huruf, dan warna putih.
                 */
                label: const Text(
                  'LANJUT BAYAR',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1.2,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                      0xFF627D2C), // Warna latar belakang tombol (hijau zaitun).
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30), // Sudut tombol membulat.
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* Fungsi ini membangun widget kartu untuk menampilkan detail dengan label dan nilai.
   *
   * Parameter:
   * - [label]: Teks label untuk detail (misal: "Nama Barang").
   * - [value]: Nilai detail yang akan ditampilkan (misal: "Kabel HDMI").
   *
   * Return: Widget [Card] yang berisi label dan nilai detail.
   */
  Widget _buildDetailCard(String label, String value) {
    return Card(
      elevation: 2, // Ketinggian bayangan kartu.
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16)), // Bentuk kartu dengan sudut membulat.
      margin:
          const EdgeInsets.only(bottom: 16), // Margin bawah untuk setiap kartu.
      child: Padding(
        padding: const EdgeInsets.all(16), // Padding internal kartu.
        /** Widget [Column]
         * * Deskripsi:
         * - Mengatur tata letak label dan nilai secara vertikal di dalam kartu detail.
         */
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Penataan ke kiri.
          children: [
            /** Widget [Text]
             * * Deskripsi:
             * - Menampilkan **label detail** (misalnya "Nama Barang").
             * - Gaya teks dengan ukuran 14 dan warna abu-abu.
             */
            Text(label,
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 6), // Spasi vertikal.
            /** Widget [Text]
             * * Deskripsi:
             * - Menampilkan **nilai detail** (misalnya "Kabel HDMI").
             * - Gaya teks dengan ukuran 16 dan font semi-bold.
             */
            Text(value,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  /* Fungsi ini membangun widget kartu khusus untuk menampilkan gambar barang.
   *
   * Parameter:
   * - [imageUrl]: URL gambar yang akan ditampilkan.
   *
   * Return: Widget [Card] yang berisi gambar barang.
   */
  Widget _buildImageCard(String imageUrl) {
    return Card(
      elevation: 2, // Ketinggian bayangan kartu.
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16)), // Bentuk kartu dengan sudut membulat.
      margin:
          const EdgeInsets.only(bottom: 16), // Margin bawah untuk setiap kartu.
      /** Widget [ClipRRect]
       * * Deskripsi:
       * - Memastikan gambar produk dipotong sesuai dengan border radius kartu.
       */
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16), // Sudut gambar membulat.
        /** Widget [Image.network]
         * * Deskripsi:
         * - Menampilkan **gambar barang** dari URL.
         * - `imageUrl` adalah data dinamis yang berisi URL gambar.
         * - Menyertakan `errorBuilder` untuk menangani jika gambar gagal dimuat.
         */
        child: Image.network(
          imageUrl,
          height: 180, // Tinggi gambar.
          width: double.infinity, // Lebar gambar memenuhi container.
          fit: BoxFit.cover, // Gambar akan menutupi area yang tersedia.
          errorBuilder: (context, error, stackTrace) {
            /** Widget [SizedBox]
             * * Deskripsi:
             * - Memberikan ukuran tetap untuk placeholder error gambar.
             */
            return const SizedBox(
              height: 180,
              /** Widget [Center]
               * * Deskripsi:
               * - Memusatkan teks error jika gambar gagal dimuat.
               */
              child: Center(
                /** Widget [Text]
                 * * Deskripsi:
                 * - Pesan error jika gambar tidak dapat dimuat.
                 */
                child: Text('Gagal memuat gambar'),
              ),
            );
          },
        ),
      ),
    );
  }
}
