/**
 * File        : modern_transaction_page.dart
 * Dibuat oleh  : Tim Provis
 * Tanggal      : 16-06-2025
 * Deskripsi    : Halaman ini menampilkan riwayat transaksi penyewaan pengguna.
 * Setiap transaksi mencakup informasi seperti ID, tanggal, status, dan daftar item yang disewa.
 * Pengguna juga dapat melakukan tindakan seperti melihat detail review atau melanjutkan pembayaran
 * berdasarkan status transaksi.
 * Dependencies :
 * - flutter/material.dart: Pustaka dasar Flutter untuk membangun UI.
 * - historyPenyewaanDetailBarang.dart: Mengimpor halaman detail barang yang direview (TransactionDetailPage).
 * - ../../shopping/after_sales/step1.dart: Mengimpor halaman langkah pertama setelah penjualan (pembayaran/pengambilan).
 */

import 'package:flutter/material.dart';
import 'historyPenyewaanDetailBarang.dart'; // Halaman detail review transaksi (TransactionDetailPage)
import '../../shopping/after_sales/step1.dart'; // Halaman langkah pertama setelah penjualan (misal: pembayaran)

/** Widget [ModernTransactionPage]
 *
 * Deskripsi:
 * - Halaman ini berfungsi sebagai tampilan riwayat transaksi penyewaan untuk pengguna.
 * - Merupakan bagian dari fitur riwayat atau profil pengguna yang menunjukkan semua transaksi mereka.
 * - Ini adalah StatelessWidget karena data transaksi dummy bersifat statis di dalam widget ini,
 * meskipun dalam aplikasi nyata data ini akan dinamis dari sumber eksternal.
 */
class ModernTransactionPage extends StatelessWidget {
  ModernTransactionPage({super.key});

  /// Data transaksi dummy untuk simulasi.
  /// Dalam implementasi nyata, data ini akan diambil dari API atau database.
  final List<Map<String, dynamic>> transactions = [
    {
      'id': 'TX001',
      'date': '4 Mei 2025',
      'status': 'Belum Bayar',
      'items': [
        {
          'title': 'Tenda Camping Eiger',
          'image': 'assets/images/assets_ItemDetails/tenda_bg6.png',
        },
        {
          'title': 'Sleeping Bag',
          'image': 'assets/images/assets_ItemDetails/jaket1.png',
        }
      ]
    },
    {
      'id': 'TX002',
      'date': '28 Apr 2025',
      'status': 'Sudah Dikembalikan',
      'items': [
        {
          'title': 'Carrier 40L Eiger',
          'image': 'assets/images/assets_ItemDetails/jaket1.png',
        },
      ]
    },
    {
      'id': 'TX003',
      'date': '13 Apr 2025',
      'status': 'Selesai',
      'items': [
        {
          'title': 'Sepatu Hiking Merrell',
          'image': 'assets/images/assets_ItemDetails/tas2.png',
        },
      ]
    },
  ];

  /* Fungsi ini mengembalikan warna yang sesuai berdasarkan status transaksi.
   *
   * Parameter:
   * - [status]: String yang menunjukkan status transaksi (misalnya 'Belum Bayar', 'Sudah Dikembalikan', 'Selesai').
   *
   * Return: Objek [Color] yang merepresentasikan warna status.
   */
  Color getStatusColor(String status) {
    switch (status) {
      case 'Berhasil':
        return const Color(0xFF4CAF50); // Hijau untuk status 'Berhasil'.
      case 'Selesai':
        return Colors.blue; // Biru untuk status 'Selesai'.
      case 'Diproses':
        return Colors.orange; // Oranye untuk status 'Diproses'.
      case 'Belum Bayar':
        return Colors.red; // Merah untuk status 'Belum Bayar'.
      case 'Sudah Dikembalikan':
        return Colors.green; // Hijau terang untuk status 'Sudah Dikembalikan'.
      default:
        return Colors.grey; // Abu-abu untuk status lainnya (default).
    }
  }

  /* Fungsi ini membangun widget chip kecil yang digunakan sebagai filter.
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
       * - Label teks pada chip filter, misalnya "Semua Status".
       * - Gaya teks dengan ukuran 12.
       */
      label: Text(label, style: const TextStyle(fontSize: 12)),
      backgroundColor: Colors.grey[200], // Warna latar belakang chip.
      padding: const EdgeInsets.symmetric(horizontal: 10), // Padding horizontal chip.
      shape: const StadiumBorder(), // Bentuk chip seperti stadion.
    );
  }

  /* Fungsi ini membangun seluruh struktur UI dari halaman riwayat transaksi.
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
       * - Bilah aplikasi di bagian atas halaman, berisi kolom pencarian.
       */
      appBar: AppBar(
        backgroundColor: Colors.white, // Warna latar belakang AppBar.
        elevation: 0, // Menghilangkan bayangan di bawah AppBar.
        /** Widget [TextField]
         * * Deskripsi:
         * - Kolom input untuk mencari transaksi.
         * - Memiliki ikon pencarian di depan dan ikon filter di belakang.
         */
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Cari transaksi', // Placeholder teks.
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
                buildChip('Semua Produk'), // Chip filter "Semua Produk".
                const SizedBox(width: 8), // Spasi antar chip.
                buildChip('Semua Tanggal'), // Chip filter "Semua Tanggal".
              ],
            ),
          ),
          const SizedBox(height: 16), // Spasi vertikal.

          // --- Daftar Kartu Transaksi ---
          // Menggunakan operator spread (...) untuk menambahkan setiap kartu transaksi.
          ...transactions
              .map((item) => buildTransactionCard(item, context)) // Membangun kartu transaksi untuk setiap item.
              .toList(), // Mengubah iterasi menjadi daftar widget.
        ],
      ),
    );
  }

  /* Fungsi ini membangun widget kartu untuk setiap transaksi individu.
   * Kartu ini menampilkan detail ringkasan transaksi dan tombol tindakan berdasarkan status.
   *
   * Parameter:
   * - [item]: Map<String, dynamic> yang berisi data detail transaksi (id, tanggal, status, items).
   * - [context]: BuildContext dari widget.
   *
   * Return: Widget [InkWell] yang membungkus kartu transaksi, membuatnya dapat ditekan.
   */
  Widget buildTransactionCard(Map<String, dynamic> item, BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Navigasi ke detail lengkap transaksi jika diperlukan.
      },
      /** Widget [Container]
       * * Deskripsi:
       * - Kontainer yang membentuk kartu transaksi individual.
       * - Memiliki margin, padding, warna latar belakang putih, sudut membulat, dan bayangan.
       */
      child: Container(
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
            /** Widget [Text]
             * * Deskripsi:
             * - Menampilkan **ID transaksi** (`item['id']`).
             * - Data dinamis dari item transaksi.
             * - Gaya teks tebal.
             */
            Text('ID: ${item['id']}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4), // Spasi vertikal kecil.

            /** Widget [Text]
             * * Deskripsi:
             * - Menampilkan **tanggal transaksi** (`item['date']`).
             * - Data dinamis dari item transaksi.
             */
            Text('Tanggal: ${item['date']}'),
            const SizedBox(height: 4), // Spasi vertikal kecil.

            /** Widget [Text]
             * * Deskripsi:
             * - Menampilkan **status transaksi** (`item['status']`).
             * - Data dinamis dari item transaksi.
             * - Warna teks berubah berdasarkan status menggunakan `getStatusColor`.
             */
            Text('Status: ${item['status']}',
                style: TextStyle(color: getStatusColor(item['status']))),
            const SizedBox(height: 4), // Spasi vertikal kecil.

            /** Widget [Text]
             * * Deskripsi:
             * - Menampilkan **jumlah barang** dalam transaksi (`item['items'].length`).
             * - Data dinamis dari item transaksi.
             */
            Text('Jumlah Barang: ${item['items'].length}'),
            const SizedBox(height: 8), // Spasi vertikal.

            // --- Tindakan Berdasarkan Status ---
            // Menampilkan tombol "Review Sekarang" jika statusnya "Sudah Dikembalikan".
            if (item['status'] == 'Sudah Dikembalikan')
              /** Widget [ElevatedButton]
               * * Deskripsi:
               * - Tombol untuk menavigasi ke halaman detail review barang.
               * - Hanya muncul jika status transaksi adalah "Sudah Dikembalikan".
               */
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke TransactionDetailPage untuk mereview barang.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TransactionDetailPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Warna latar belakang tombol.
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)), // Sudut tombol membulat.
                ),
                /** Widget [Text]
                 * * Deskripsi:
                 * - Teks pada tombol "Review Sekarang".
                 */
                child: const Text('Review Sekarang'),
              )
            // Menampilkan tombol "Ambil Sekarang" jika statusnya "Belum Bayar".
            else if (item['status'] == 'Belum Bayar')
              /** Widget [ElevatedButton]
               * * Deskripsi:
               * - Tombol untuk melanjutkan ke proses pengambilan barang atau pembayaran.
               * - Hanya muncul jika status transaksi adalah "Belum Bayar".
               */
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman Step1Page (misal: halaman pembayaran/pengambilan).
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Step1Page()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Warna latar belakang tombol.
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)), // Sudut tombol membulat.
                ),
                /** Widget [Text]
                 * * Deskripsi:
                 * - Teks pada tombol "Ambil Sekarang".
                 */
                child: const Text('Ambil Sekarang'),
              ),
          ],
        ),
      ),
    );
  }
}