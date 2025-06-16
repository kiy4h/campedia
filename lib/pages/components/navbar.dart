/**
 * File         : navbar.dart
 * Dibuat oleh  : Izzuddin Azzam, Al Ghifari
 * Tanggal      : 16-06-2025
 * Deskripsi    : File ini berisi serangkaian fungsi untuk membangun sebuah widget navigasi bawah 
 * (Bottom Navigation Bar) yang dapat digunakan kembali di berbagai halaman aplikasi.
 * Ketergantungan (Dependencies) : 
 * - home.dart, shoping.dart, favorite.dart, profile.dart, allListItem.dart: Halaman-halaman tujuan navigasi.
 */

import 'package:flutter/material.dart';
import '../beranda/home.dart';
import '../shopping/cart/shoping.dart';
import '../wishlist/favorite.dart';
import '../profile/profile_detail/profile.dart';
import '../all_items/allListItem.dart';

/* Fungsi ini membangun seluruh widget Bottom Navigation Bar.
 * * Deskripsi:
 * - Fungsi utama yang dipanggil untuk membuat navigasi bawah.
 * - Mengatur tampilan kontainer utama, termasuk warna, bayangan, dan sudut melengkung.
 * - Menyusun semua item navigasi secara horizontal menggunakan widget Row.
 * * Parameter:
 * - context: BuildContext dari widget pemanggil.
 * - currentIndex: Indeks halaman yang sedang aktif untuk menyorot ikon yang sesuai.
 * * Return: Sebuah Widget (Container) yang berfungsi sebagai Bottom Navigation Bar.
 */
Widget buildBottomNavBar(
  BuildContext context, {
  required int currentIndex,
}) {
  // Container utama sebagai latar belakang navigation bar.
  return Container(
    height: 70,
    decoration: BoxDecoration(
      color: Colors.white,
      // Sudut melengkung hanya di bagian atas.
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      // Efek bayangan (shadow) untuk memberikan kesan terangkat.
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, -5),
        ),
      ],
    ),
    // Row untuk menyusun item-item navigasi secara merata.
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNavItem(context, Icons.home, 0, currentIndex),
        _buildNavItem(context, Icons.swap_horiz, 1, currentIndex),
        _buildNavItem(context, Icons.shopping_cart_outlined, 2, currentIndex,
            hasNotification: true), // Item dengan notifikasi.
        _buildNavItem(context, Icons.favorite_border, 3, currentIndex),
        _buildProfileNavItem(context, 4, currentIndex), // Item khusus untuk profil.
      ],
    ),
  );
}

/* Fungsi helper untuk membangun satu item navigasi standar dengan ikon.
 * * Deskripsi:
 * - Fungsi pribadi (_), hanya untuk digunakan di dalam file ini.
 * - Membuat ikon yang dapat diklik, yang warnanya berubah jika sedang aktif.
 * - Dapat menampilkan badge notifikasi (titik kuning).
 * * Parameter:
 * - context: BuildContext untuk navigasi.
 * - icon: Ikon yang akan ditampilkan.
 * - index: Indeks dari item ini.
 * - currentIndex: Indeks halaman yang sedang aktif.
 * - hasNotification: Opsional, untuk menampilkan badge notifikasi.
 * * Return: Widget GestureDetector yang berisi item navigasi.
 */
Widget _buildNavItem(
  BuildContext context,
  IconData icon,
  int index,
  int currentIndex, {
  bool hasNotification = false,
}) {
  // Menentukan apakah item ini sedang dipilih/aktif.
  bool isSelected = currentIndex == index;
  return GestureDetector(
    onTap: () {
      // Mencegah navigasi ke halaman yang sama jika item yang aktif diklik lagi.
      if (currentIndex != index) {
        _navigateToPage(context, index);
      }
    },
    // Stack memungkinkan penumpukan widget, digunakan untuk badge notifikasi.
    child: Stack(
      children: [
        // Container untuk latar belakang ikon saat aktif.
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEAEAEA) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          // Widget Icon.
          child: Icon(
            icon,
            size: 28,
            // Warna ikon berubah berdasarkan status 'isSelected'.
            color: isSelected ? Colors.black87 : Colors.grey,
          ),
        ),
        // Menampilkan badge notifikasi jika hasNotification bernilai true.
        if (hasNotification)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    ),
  );
}

/* Fungsi helper khusus untuk membangun item navigasi profil dengan gambar.
 * * Deskripsi:
 * - Fungsi pribadi (_) yang dikhususkan untuk membuat item navigasi profil.
 * - Menggunakan gambar profil pengguna sebagai ganti ikon.
 * - Memberikan border yang lebih tebal saat item ini aktif.
 * * Parameter:
 * - context: BuildContext untuk navigasi.
 * - index: Indeks dari item profil ini.
 * - currentIndex: Indeks halaman yang sedang aktif.
 * * Return: Widget GestureDetector yang berisi item profil.
 */
Widget _buildProfileNavItem(BuildContext context, int index, int currentIndex) {
  bool isSelected = currentIndex == index;
  return GestureDetector(
    onTap: () {
      if (currentIndex != index) {
        _navigateToPage(context, index);
      }
    },
    // Container untuk menampilkan gambar profil dalam bentuk lingkaran.
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // Border berubah warna jika item profil sedang aktif.
        border: Border.all(
          color: isSelected ? Colors.black87 : Colors.grey.shade300,
          width: 2,
        ),
        // Menampilkan gambar profil dari assets.
        image: const DecorationImage(
          image: AssetImage('images/assets_Profile/profile_placeholder.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

/* Fungsi helper untuk menangani logika navigasi.
 * * Deskripsi:
 * - Fungsi pribadi (_) yang memusatkan semua logika perpindahan halaman.
 * - Menggunakan switch statement untuk menentukan halaman tujuan berdasarkan indeks yang diklik.
 * * Parameter:
 * - context: BuildContext untuk mengakses Navigator.
 * - index: Indeks halaman tujuan.
 */
void _navigateToPage(BuildContext context, int index) {
  // Switch untuk memilih halaman tujuan berdasarkan indeks.
  switch (index) {
    case 0: // Halaman Beranda
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      break;
    case 1: // Halaman Semua Item/Katalog
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AllItemList()));
      break;
    case 2: // Halaman Keranjang Belanja
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Shoping()));
      break;
    case 3: // Halaman Wishlist/Favorit
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const FavoritePage()));
      break;
    case 4: // Halaman Profil
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ProfilePage()));
      break;
  }
}