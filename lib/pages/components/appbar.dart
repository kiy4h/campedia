/**
 * File         : app_bar.dart
 * Dibuat oleh  : Izzuddin Azzam, Al Ghifari
 * Tanggal      : 16-06-2025
 * Deskripsi    : File ini berisi fungsi pembantu (helper function) yang dapat digunakan kembali 
 * untuk membuat widget AppBar yang disesuaikan untuk berbagai halaman dalam aplikasi.
 * Ketergantungan (Dependencies) : 
 * - flutter/material.dart: Digunakan untuk semua komponen UI dasar, termasuk AppBar.
 */

import 'package:flutter/material.dart';

/* Fungsi ini membangun dan mengembalikan sebuah AppBar yang disesuaikan.
 * * Deskripsi:
 * - Fungsi ini secara dinamis mengatur judul (title) dan tombol aksi (actions) dari AppBar 
 * berdasarkan nilai `currentIndex` yang diberikan, yang biasanya sesuai dengan indeks halaman
 * pada Bottom Navigation Bar.
 * * * Parameter:
 * - context: BuildContext yang diperlukan untuk operasi seperti menampilkan SnackBar.
 * - currentIndex: Sebuah integer yang menentukan konfigurasi AppBar yang akan digunakan 
 * (misalnya, 0 untuk Home, 1 untuk Keranjang Belanja, dst.).
 * * * Return: Sebuah widget PreferredSizeWidget, yang dalam kasus ini adalah AppBar yang sudah 
 * dikonfigurasi dan siap untuk digunakan di dalam sebuah Scaffold.
 */
PreferredSizeWidget buildAppBar({
  required BuildContext context,
  required int currentIndex,
}) {
  // Variabel lokal untuk menyimpan judul dan daftar widget aksi.
  String title = '';
  List<Widget> actions = [];

  // Blok switch untuk menentukan judul dan aksi berdasarkan halaman aktif (currentIndex).
  switch (currentIndex) {
    // Kasus untuk halaman Home (indeks 0).
    case 0:
      title = 'Home';
      actions = [
        // Tombol aksi untuk pencarian.
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, color: Colors.black),
        ),
      ];
      break;
    // Kasus untuk halaman Keranjang Belanja (indeks 1).
    case 1:
      title = 'Shopping Cart';
      actions = [
        // Tombol teks untuk melakukan pemesanan.
        TextButton(
          onPressed: () {
            // Menampilkan notifikasi singkat (SnackBar) saat tombol ditekan.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order placed!')),
            );
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.amber,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          child: const Text('Place Order'),
        ),
      ];
      break;
    // Kasus untuk halaman Profil (indeks 2).
    case 2:
      title = 'Profile';
      actions = [
        // Tombol aksi untuk pengaturan.
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings, color: Colors.black),
        ),
      ];
      break;
    // Kasus default jika indeks tidak cocok.
    default:
      title = 'App';
  }

  // Mengembalikan widget AppBar yang telah dikonfigurasi.
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0, // Menghilangkan bayangan di bawah AppBar.
    // Widget Text untuk menampilkan judul yang sudah ditentukan.
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    // Menetapkan daftar widget aksi yang sudah ditentukan.
    actions: actions,
  );
}