/**
 * File         : notification.dart
 * Dibuat oleh  : Izzuddin Azzam, Al Ghifari
 * Tanggal      : 16-06-2025
 * Deskripsi    : File ini berisi halaman yang menampilkan berbagai notifikasi sistem seperti promo, 
 * ketersediaan barang, dan informasi pembayaran denda.
 * Dependencies : 
 * - checkout2.dart: digunakan untuk berpindah ke halaman pembayaran denda.
 */

import 'package:flutter/material.dart';
import 'package:tugas3provis/pages/shopping/payment_data/checkout2.dart';

/** Widget NotificationPage
 * * Deskripsi:
 * - Menampilkan daftar notifikasi dalam bentuk kartu yang informatif.
 * - Setiap kartu notifikasi berisi ikon, judul, deskripsi, dan waktu.
 * - Merupakan StatelessWidget karena hanya menampilkan daftar notifikasi statis tanpa perlu mengelola perubahan state.
 */
class NotificationPage extends StatelessWidget {
  // Data statis yang berisi daftar notifikasi untuk ditampilkan.
  final List<Map<String, String>> notifications = [
    {
      "title": "Diskon Spesial untuk Gear Baru!",
      "subtitle": "Dapatkan hingga 50% untuk tenda & kompor.",
      "time": "2 jam lalu",
    },
    {
      "title": "Barang Favoritmu Tersedia Lagi",
      "subtitle": "Tas carrier 65L kini tersedia kembali.",
      "time": "1 hari lalu",
    },
    {
      "title": "Pemesanan Berhasil",
      "subtitle": "Pesananmu telah dikonfirmasi.",
      "time": "3 hari lalu",
    },
    {
      "title": "Bayar Denda Terlambat",
      "subtitle": "Kamu dikenakan denda Rp10.000 karena terlambat mengembalikan perlengkapan.",
      "time": "5 jam lalu",
    },
  ];

  NotificationPage({super.key});

  /* Fungsi ini membangun seluruh UI untuk halaman notifikasi.
   * * Parameter:
   * - context: Digunakan untuk mengakses tema, navigasi, dan menampilkan SnackBar.
   * * Return: Menghasilkan widget Scaffold lengkap dengan AppBar dan ListView yang berisi kartu-kartu notifikasi.
   */
  @override
  Widget build(BuildContext context) {
    // Scaffold sebagai kerangka utama halaman.
    return Scaffold(
      // AppBar halaman notifikasi.
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      // Body utama menggunakan ListView.builder untuk membuat daftar notifikasi secara dinamis.
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          // GestureDetector untuk membuat setiap kartu notifikasi dapat diklik.
          return GestureDetector(
            onTap: () {
              // Menampilkan SnackBar saat notifikasi diklik.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Kamu membuka: ${item['title']}")),
              );
            },
            // Container sebagai visual dari kartu notifikasi.
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              // Column untuk menyusun konten di dalam kartu.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Widget Icon yang berubah berdasarkan jenis notifikasi.
                      Icon(
                        // Menggunakan ikon 'money_off' untuk denda, dan 'notifications_none' untuk lainnya.
                        item["title"] == "Bayar Denda Terlambat"
                            ? Icons.money_off
                            : Icons.notifications_none,
                        size: 28,
                        // Warna ikon juga berubah: merah untuk denda, hijau untuk lainnya.
                        color: item["title"] == "Bayar Denda Terlambat"
                            ? Colors.red
                            : Colors.green,
                      ),
                      const SizedBox(width: 12),
                      // Expanded agar teks mengisi sisa ruang.
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Widget Text untuk menampilkan judul notifikasi.
                            Text(
                              item["title"]!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            // Widget Text untuk menampilkan subjudul atau deskripsi notifikasi.
                            Text(
                              item["subtitle"]!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 6),
                            // Widget Text untuk menampilkan waktu notifikasi.
                            Text(
                              item["time"]!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Menampilkan tombol "Bayar Denda" hanya jika notifikasi adalah tentang denda.
                  if (item["title"] == "Bayar Denda Terlambat")
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Align(
                        alignment: Alignment.centerRight,
                        // Widget ElevatedButton sebagai tombol aksi untuk membayar denda.
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigasi ke halaman pembayaran denda (Checkout2).
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Checkout2(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Bayar Denda Sekarang"),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}