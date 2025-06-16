/**
 * File        : transaction_detail_page.dart
 * Dibuat oleh  : Tim Provis
 * Tanggal      : 16-06-2025
 * Deskripsi    : Halaman ini menampilkan daftar detail barang yang termasuk dalam satu transaksi.
 * Dilengkapi dengan informasi produk, tanggal transaksi, dan status review.
 * Pengguna dapat memberikan review untuk barang yang belum direview melalui tombol yang tersedia.
 * Dependencies :
 * - flutter/material.dart: Pustaka dasar Flutter untuk membangun UI.
 * - reviewItem.dart: Mengimpor halaman ProductReviewPage untuk navigasi ke halaman review produk.
 */

import 'package:flutter/material.dart';
import 'reviewItem.dart'; // Import halaman ProductReviewPage

/** Widget [TransactionDetailPage]
 *
 * Deskripsi:
 * - Halaman ini berfungsi untuk menampilkan detail item-item yang ada dalam sebuah transaksi.
 * - Ini adalah bagian dari alur riwayat transaksi pengguna, memungkinkan mereka melihat status review.
 * - Merupakan StatelessWidget karena data transaksi yang ditampilkan bersifat statis dan tidak berubah di dalam widget ini.
 */
class TransactionDetailPage extends StatelessWidget {
  TransactionDetailPage({super.key});

  /// Data transaksi dummy untuk tujuan demonstrasi.
  /// Dalam aplikasi nyata, data ini akan diambil dari sumber data (misalnya API, database).
  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Tenda Camping Eiger',
      'date': '4 Mei 2025',
      'image': 'https://via.placeholder.com/300x150.png?text=Tenda+Camping+Eiger',
      'status': 'Belum direview',
    },
    {
      'title': 'Carrier 40L Eiger',
      'date': '28 Apr 2025',
      'image': 'https://via.placeholder.com/300x150.png?text=Carrier+40L+Eiger',
      'status': 'Belum direview',
    },
    {
      'title': 'Sepatu Hiking Merrell',
      'date': '13 Apr 2025',
      'image': 'https://via.placeholder.com/300x150.png?text=Sepatu+Hiking+Merrell',
      'status': 'Selesai',
    },
  ];

  /* Fungsi ini mengembalikan warna yang sesuai berdasarkan status review barang.
   *
   * Parameter:
   * - [status]: String yang menunjukkan status review barang ('Selesai', 'Belum direview').
   *
   * Return: Objek [Color] yang merepresentasikan warna status.
   */
  Color getStatusColor(String status) {
    switch (status) {
      case 'Selesai':
        return Colors.blue; // Warna biru untuk status 'Selesai'.
      case 'Belum direview':
        return Colors.orange; // Warna oranye untuk status 'Belum direview'.
      default:
        return Colors.grey; // Warna abu-abu untuk status lainnya (default).
    }
  }

  /* Fungsi ini membangun widget chip kecil.
   * Ini adalah placeholder untuk filter tambahan yang mungkin akan dikembangkan di masa depan.
   *
   * Parameter:
   * - [label]: Teks yang akan ditampilkan pada chip.
   *
   * Return: Widget [Chip] dengan teks dan gaya tertentu.
   */
  Widget buildChip(String label) {
    return Chip(
      /** Widget [Text]
       * * Deskripsi:
       * - Teks label pada chip filter, misalnya "Semua Status".
       * - Ukuran font diatur menjadi 12.
       */
      label: Text(label, style: const TextStyle(fontSize: 12)),
      backgroundColor: Colors.grey[200], // Warna latar belakang chip.
      padding: const EdgeInsets.symmetric(horizontal: 10), // Padding horizontal chip.
      shape: const StadiumBorder(), // Bentuk chip seperti stadion.
    );
  }

  /* Fungsi ini membangun seluruh struktur UI dari halaman detail transaksi.
   *
   * Parameter:
   * - [context]: BuildContext dari widget.
   *
   * Return: Sebuah widget [Scaffold] yang berisi AppBar dan body halaman.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Mengatur warna latar belakang halaman.
      /** Widget [AppBar]
       * * Deskripsi:
       * - Bilah aplikasi di bagian atas halaman, berfungsi sebagai header.
       * - Berisi kolom pencarian untuk mencari barang dalam transaksi.
       */
      appBar: AppBar(
        backgroundColor: Colors.white, // Warna latar belakang AppBar.
        elevation: 0, // Menghilangkan bayangan di bawah AppBar.
        /** Widget [TextField]
         * * Deskripsi:
         * - Kolom input untuk mencari barang dalam transaksi.
         * - Memiliki ikon pencarian di depan dan ikon filter di belakang.
         */
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Cari barang dalam transaksi', // Placeholder teks.
            hintStyle: TextStyle(color: Colors.grey[600]), // Gaya teks placeholder.
            prefixIcon: const Icon(Icons.search), // Ikon pencarian di awal.
            suffixIcon: const Icon(Icons.filter_list), // Ikon filter di akhir.
            filled: true, // Mengisi latar belakang TextField.
            fillColor: Colors.grey[200], // Warna latar belakang TextField.
            contentPadding: const EdgeInsets.symmetric(vertical: 0), // Padding internal.
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30), // Border melingkar.
              borderSide: BorderSide.none, // Tanpa border sisi.
            ),
          ),
        ),
      ),
      /** Widget [ListView]
       * * Deskripsi:
       * - Tampilan daftar yang dapat digulir untuk menampilkan elemen-elemen transaksi.
       * - Memberikan padding keseluruhan pada daftar.
       */
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- Baris Filter Horizontal ---
          /** Widget [SizedBox]
           * * Deskripsi:
           * - Membatasi tinggi untuk baris filter horizontal.
           */
          SizedBox(
            height: 36,
            /** Widget [ListView]
             * * Deskripsi:
             * - Daftar horizontal yang dapat digulir untuk menampilkan chip filter.
             */
            child: ListView(
              scrollDirection: Axis.horizontal, // Arah gulir horizontal.
              children: [
                buildChip('Semua Status'), // Chip filter "Semua Status".
                const SizedBox(width: 8), // Spasi antar chip.
                buildChip('Nama Produk'), // Chip filter "Nama Produk".
                const SizedBox(width: 8), // Spasi antar chip.
                buildChip('Tanggal'), // Chip filter "Tanggal".
              ],
            ),
          ),
          const SizedBox(height: 16), // Spasi vertikal.

          // --- Daftar Barang Transaksi ---
          // Menggunakan operator spread (...) untuk menambahkan setiap kartu transaksi.
          ...transactions
              .map((item) => buildTransactionCard(item, context)) // Membangun kartu transaksi untuk setiap item.
              .toList(), // Mengubah iterasi menjadi daftar widget.
        ],
      ),
    );
  }

  /* Fungsi ini membangun widget kartu untuk setiap item transaksi.
   *
   * Parameter:
   * - [item]: Map<String, dynamic> yang berisi data detail item transaksi (judul, tanggal, gambar, status).
   * - [context]: BuildContext dari widget.
   *
   * Return: Widget [Container] yang merepresentasikan kartu transaksi.
   */
  Widget buildTransactionCard(Map<String, dynamic> item, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16), // Margin bawah untuk setiap kartu.
      padding: const EdgeInsets.all(12), // Padding internal kartu.
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang kartu.
        borderRadius: BorderRadius.circular(12), // Sudut kartu membulat.
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)], // Bayangan kartu.
      ),
      /** Widget [Column]
       * * Deskripsi:
       * - Mengatur tata letak elemen-elemen di dalam kartu transaksi secara vertikal.
       */
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Penataan ke kiri.
        children: [
          // --- Gambar Produk ---
          /** Widget [ClipRRect]
           * * Deskripsi:
           * - Memastikan gambar produk dipotong sesuai dengan border radius.
           */
          ClipRRect(
            borderRadius: BorderRadius.circular(8), // Sudut gambar membulat.
            /** Widget [Image.network]
             * * Deskripsi:
             * - Menampilkan **gambar produk** dari URL.
             * - `item['image']` adalah data dinamis yang berisi URL gambar.
             * - Menyertakan `errorBuilder` untuk menangani jika gambar gagal dimuat.
             */
            child: Image.network(
              item['image'],
              height: 150, // Tinggi gambar.
              width: double.infinity, // Lebar gambar memenuhi container.
              fit: BoxFit.cover, // Gambar akan menutupi area yang tersedia.
              errorBuilder: (context, error, stackTrace) => const SizedBox(
                height: 150,
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
              ),
            ),
          ),
          const SizedBox(height: 12), // Spasi vertikal.

          // --- Judul dan Tanggal ---
          /** Widget [Text]
           * * Deskripsi:
           * - Menampilkan **judul produk** (`item['title']`).
           * - Data dinamis dari item transaksi.
           * - Gaya teks dengan font tebal dan ukuran 16.
           */
          Text(item['title'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4), // Spasi vertikal kecil.

          /** Widget [Text]
           * * Deskripsi:
           * - Menampilkan **tanggal pemesanan** produk (`item['date']`).
           * - Data dinamis dari item transaksi.
           * - Gaya teks dengan warna abu-abu dan ukuran 13.
           */
          Text('Dipesan pada ${item['date']}',
              style: TextStyle(color: Colors.grey[600], fontSize: 13)),

          const SizedBox(height: 12), // Spasi vertikal.

          // --- Tombol Aksi Sesuai Status ---
          // Menampilkan tombol "Review Barang" jika statusnya "Belum direview".
          if (item['status'] == 'Belum direview')
            /** Widget [Align]
             * * Deskripsi:
             * - Menyelaraskan tombol ke kanan bawah kartu.
             */
            Align(
              alignment: Alignment.centerRight,
              /** Widget [ElevatedButton]
               * * Deskripsi:
               * - Tombol untuk menavigasi ke halaman review produk.
               * - Hanya muncul jika status barang adalah "Belum direview".
               */
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman ProductReviewPage dengan membawa data gambar dan nama produk.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductReviewPage(
                        productImage: item['image'], // Meneruskan URL gambar produk.
                        productName: item['title'], // Meneruskan nama produk.
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Warna latar belakang tombol.
                  foregroundColor: Colors.white, // Warna teks tombol.
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)), // Sudut tombol membulat.
                ),
                /** Widget [Text]
                 * * Deskripsi:
                 * - Teks pada tombol "Review Barang".
                 */
                child: const Text("Review Barang"),
              ),
            ),
          // Menampilkan chip "Sudah Direview" jika statusnya "Selesai".
          if (item['status'] == 'Selesai')
            /** Widget [Align]
             * * Deskripsi:
             * - Menyelaraskan chip status ke kanan bawah kartu.
             */
            Align(
              alignment: Alignment.centerRight,
              /** Widget [Chip]
               * * Deskripsi:
               * - Chip yang menunjukkan bahwa barang sudah direview.
               * - Hanya muncul jika status barang adalah "Selesai".
               */
              child: Chip(
                /** Widget [Text]
                 * * Deskripsi:
                 * - Teks pada chip "Sudah Direview".
                 */
                label: const Text("Sudah Direview"),
                backgroundColor: Colors.green[100], // Warna latar belakang chip hijau muda.
                labelStyle: const TextStyle(color: Colors.green), // Gaya teks chip berwarna hijau.
              ),
            ),
        ],
      ),
    );
  }
}