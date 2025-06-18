/// File        : profile.dart
/// Dibuat oleh  : Izzuddin Azzam
/// Tanggal      : 15-06-2025
/// Deskripsi    : Halaman ini merupakan tampilan profil pengguna aplikasi Campedia.
/// Menampilkan informasi dasar pengguna seperti foto profil, nama, detail kontak,
/// serta ringkasan riwayat transaksi penyewaan. Halaman ini juga menyediakan
/// navigasi ke halaman notifikasi, riwayat penyewaan lengkap, dan pengaturan profil.
/// Dependencies :
/// - google_fonts: Untuk mengaplikasikan font Poppins secara konsisten di seluruh aplikasi.
/// - navbar.dart: Komponen untuk bilah navigasi bawah aplikasi.
/// - notification.dart: Halaman terpisah untuk menampilkan notifikasi pengguna.
/// - historyPenyewaan.dart: Halaman terpisah untuk melihat riwayat transaksi penyewaan secara detail.
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas3provis/pages/components/navbar.dart'; // Import komponen navbar bawah
import 'package:tugas3provis/pages/beranda/notification.dart'; // Import halaman notifikasi
import '../transaction/historyPenyewaan.dart'; // Import halaman riwayat penyewaan

/* Fungsi utama untuk menjalankan aplikasi Flutter yang menampilkan halaman profil.
 *
 * Return: Tidak ada (void), fungsi ini hanya menjalankan aplikasi.
 */
void main() {
  runApp(const CampingApp());
}

/// Widget [CampingApp]
///
/// Deskripsi:
/// - Ini adalah widget root aplikasi yang mengatur tema global dan halaman awal.
/// - Berfungsi sebagai titik masuk utama untuk demonstrasi halaman profil.
/// - Ini adalah StatelessWidget karena hanya mengatur konfigurasi awal aplikasi dan tidak memiliki state internal yang berubah.
class CampingApp extends StatelessWidget {
  const CampingApp({super.key});

  /* Fungsi ini membangun tema aplikasi dan menetapkan [ProfilePage] sebagai halaman awal.
   *
   * Parameter:
   * - [context]: BuildContext dari widget.
   *
   * Return: Sebuah widget [MaterialApp] yang mengkonfigurasi aplikasi.
   */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF2E7D32), // Warna primer aplikasi.
        scaffoldBackgroundColor:
            const Color(0xFFF8F8F8), // Warna latar belakang default scaffold.
        textTheme: GoogleFonts
            .poppinsTextTheme(), // Menggunakan font Poppins untuk seluruh teks.
      ),
      home: const ProfilePage(), // Menetapkan ProfilePage sebagai halaman awal.
      debugShowCheckedModeBanner:
          false, // Menghilangkan banner debug di pojok kanan atas.
    );
  }
}

/// Widget [ProfilePage]
///
/// Deskripsi:
/// - Halaman ini berfungsi sebagai tampilan profil utama pengguna dalam aplikasi Campedia.
/// - Menampilkan foto profil, nama pengguna, informasi kontak, ringkasan riwayat transaksi,
/// dan tombol untuk navigasi ke pengaturan lebih lanjut.
/// - Ini adalah StatelessWidget karena semua data yang ditampilkan (nama, email, dll.)
/// bersifat statis dalam contoh ini dan tidak ada interaksi langsung yang mengubah state di halaman ini.
/// Perubahan data akan ditangani oleh halaman terpisah (misal: Edit Profile Page).
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  /* Fungsi ini membangun seluruh struktur UI dari halaman profil.
   *
   * Parameter:
   * - [context]: BuildContext dari widget.
   *
   * Return: Sebuah widget [Scaffold] yang berisi AppBar, body, dan BottomNavigationBar.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** Widget [AppBar]
       * * Deskripsi:
       * - Bilah aplikasi di bagian atas halaman profil.
       * - Menampilkan judul "Profil" dan ikon notifikasi.
       */
      appBar: AppBar(
        /** Widget [Text]
         * * Deskripsi:
         * - Judul halaman "Profil".
         * - Gaya teks tebal.
         */
        title:
            const Text("Profil", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true, // Memusatkan judul.
        backgroundColor: Colors.white, // Warna latar belakang AppBar.
        elevation: 0, // Menghilangkan bayangan di bawah AppBar.
        actions: [
          /** Widget [IconButton]
           * * Deskripsi:
           * - Tombol ikon di sisi kanan AppBar untuk menavigasi ke halaman notifikasi.
           */
          IconButton(
            icon: const Icon(Icons.notifications_none,
                color: Colors.black87), // Ikon notifikasi.
            onPressed: () {
              // Navigasi ke halaman Notifikasi.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
        ],
      ),
      /** Widget [SafeArea]
       * * Deskripsi:
       * - Memastikan konten UI tidak tumpang tindih dengan area sistem seperti status bar.
       */
      body: SafeArea(
        /** Widget [ListView]
         * * Deskripsi:
         * - Tampilan daftar yang dapat digulir untuk menampung semua bagian profil.
         * - Memungkinkan pengguna untuk menggulir jika konten melebihi tinggi layar.
         */
        child: ListView(
          padding: const EdgeInsets.symmetric(
              vertical: 16, horizontal: 20), // Padding di sekitar konten.
          children: [
            _buildHeader(
                context), // Bagian header profil (foto, nama, tombol edit).
            const SizedBox(height: 24), // Spasi vertikal.
            _buildProfileDetails(), // Bagian detail informasi akun.
            const SizedBox(height: 24), // Spasi vertikal.
            _buildHistorySection(
                context), // Bagian ringkasan riwayat penyewaan/pembelian.
            const SizedBox(height: 32), // Spasi vertikal.
            _buildSettingsButton(), // Tombol untuk navigasi ke pengaturan profil.
          ],
        ),
      ),
      /** Widget [buildBottomNavBar]
       * * Deskripsi:
       * - Bilah navigasi bawah aplikasi.
       * - Komponen eksternal yang diimpor dari `navbar.dart`.
       * - `currentIndex: 4` menunjukkan bahwa ikon profil sedang aktif.
       */
      bottomNavigationBar: buildBottomNavBar(context,
          currentIndex: 4), // Menampilkan navigasi bawah.
    );
  }

  /* Fungsi ini membangun bagian header halaman profil, termasuk foto, salam, nama, dan tombol edit.
   *
   * Parameter:
   * - [context]: BuildContext dari widget, digunakan untuk navigasi.
   *
   * Return: Widget [Row] yang berisi elemen-elemen header.
   */
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // Menempatkan elemen di kedua ujung.
      children: [
        Row(
          children: [
            /** Widget [CircleAvatar]
             * * Deskripsi:
             * - Menampilkan foto profil pengguna dalam bentuk lingkaran.
             * - Menggunakan gambar placeholder dari aset lokal.
             */
            const CircleAvatar(
              radius: 30, // Ukuran radius avatar.
              backgroundImage: AssetImage(
                  'images/assets_Profile/profile_placeholder.jpg'), // Gambar profil.
            ),
            const SizedBox(width: 12), // Spasi horizontal.
            /** Widget [Column]
             * * Deskripsi:
             * - Mengatur teks salam dan nama pengguna secara vertikal.
             */
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Penataan teks ke kiri.
              children: const [
                /** Widget [Text]
                 * * Deskripsi:
                 * - Teks sapaan "Hello,".
                 * - Gaya teks kecil dan berwarna abu-abu.
                 */
                Text('Hello,',
                    style: TextStyle(color: Colors.grey, fontSize: 14)),
                /** Widget [Text]
                 * * Deskripsi:
                 * - Menampilkan **nama pengguna** "Izzuddin Azzam".
                 * - Data dinamis dari placeholder.
                 * - Gaya teks besar dan tebal.
                 */
                Text('Izzuddin Azzam',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
        /** Widget [GestureDetector]
         * * Deskripsi:
         * - Memungkinkan ikon edit untuk dapat ditekan.
         */
        GestureDetector(
          onTap: () {
            // TODO: Logika navigasi ke halaman EditProfilePage akan ditambahkan di sini.
          },
          /** Widget [Icon]
           * * Deskripsi:
           * - Ikon edit di sisi kanan header, untuk mengedit profil.
           */
          child: const Icon(Icons.edit, color: Colors.black87),
        ),
      ],
    );
  }

  /* Fungsi ini membangun bagian detail informasi akun pengguna.
   *
   * Return: Widget [Column] yang berisi judul bagian dan kartu informasi.
   */
  Widget _buildProfileDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Penataan ke kiri.
      children: [
        /** Widget [Text]
         * * Deskripsi:
         * - Judul bagian "Informasi Akun".
         * - Gaya teks semi-bold dengan ukuran 18.
         */
        const Text('Informasi Akun',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12), // Spasi vertikal.
        _buildCard([
          _buildProfileRow(
              'Email', 'izzuddin@example.com'), // Baris detail email.
          _buildProfileRow(
              'Telepon', '+62 812 3456 7890'), // Baris detail telepon.
          _buildProfileRow(
              'Lokasi', 'Jakarta, Indonesia'), // Baris detail lokasi.
        ]),
      ],
    );
  }

  /* Fungsi ini membangun satu baris untuk menampilkan label dan nilai informasi profil.
   *
   * Parameter:
   * - [label]: Label informasi (misal: "Email").
   * - [value]: Nilai informasi (misal: "izzuddin@example.com").
   *
   * Return: Widget [Padding] yang berisi satu baris informasi.
   */
  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 6.0), // Padding vertikal untuk setiap baris.
      /** Widget [Row]
       * * Deskripsi:
       * - Mengatur label dan nilai informasi secara horizontal dengan spasi di tengah.
       */
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Menyebarkan elemen ke ujung.
        children: [
          /** Widget [Text]
           * * Deskripsi:
           * - Menampilkan **label informasi** (misalnya "Email", "Telepon").
           * - Data dinamis dari parameter `label`.
           * - Gaya teks semi-bold.
           */
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          /** Widget [Text]
           * * Deskripsi:
           * - Menampilkan **nilai informasi** (misalnya "izzuddin@example.com").
           * - Data dinamis dari parameter `value`.
           * - Gaya teks berwarna abu-abu.
           */
          Text(value, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  /* Fungsi ini membangun bagian ringkasan riwayat penyewaan/pembelian pengguna.
   *
   * Parameter:
   * - [context]: BuildContext dari widget, digunakan untuk navigasi.
   *
   * Return: Widget [Column] yang berisi judul bagian, kartu ringkasan, dan tombol "Lihat Semua".
   */
  Widget _buildHistorySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Penataan ke kiri.
      children: [
        /** Widget [Text]
         * * Deskripsi:
         * - Judul bagian "Riwayat".
         * - Gaya teks semi-bold dengan ukuran 18.
         */
        const Text('Riwayat',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12), // Spasi vertikal.
        _buildCard([
          _buildHistoryRow(
              'Pembelian', '3 Items'), // Baris ringkasan jumlah pembelian.
          _buildHistoryRow(
              'Penyewaan', '2 Rentals'), // Baris ringkasan jumlah penyewaan.
          _buildHistoryRow('Status Pembayaran',
              'Lunas'), // Baris ringkasan status pembayaran.
        ]),
        const SizedBox(height: 12), // Spasi vertikal.
        /** Widget [Align]
         * * Deskripsi:
         * - Menempatkan tombol "Lihat Semua" di sisi kanan.
         */
        Align(
          alignment: Alignment.centerRight, // Penataan ke kanan.
          /** Widget [TextButton]
           * * Deskripsi:
           * - Tombol untuk menavigasi ke halaman riwayat penyewaan yang lebih detail.
           */
          child: TextButton(
            onPressed: () {
              // Navigasi ke halaman ModernTransactionPage.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ModernTransactionPage()),
              );
            },
            /** Widget [Text]
             * * Deskripsi:
             * - Teks tombol "Lihat Semua".
             * - Gaya teks berwarna biru.
             */
            child:
                const Text('Lihat Semua', style: TextStyle(color: Colors.blue)),
          ),
        ),
      ],
    );
  }

  /* Fungsi ini membangun satu baris untuk menampilkan label dan nilai ringkasan aktivitas.
   *
   * Parameter:
   * - [label]: Label aktivitas (misal: "Pembelian").
   * - [value]: Nilai aktivitas (misal: "3 Items").
   *
   * Return: Widget [Padding] yang berisi satu baris aktivitas.
   */
  Widget _buildHistoryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 6.0), // Padding vertikal untuk setiap baris.
      /** Widget [Row]
       * * Deskripsi:
       * - Mengatur label dan nilai aktivitas secara horizontal dengan spasi di tengah.
       */
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Menyebarkan elemen ke ujung.
        children: [
          /** Widget [Text]
           * * Deskripsi:
           * - Menampilkan **label aktivitas** (misalnya "Pembelian", "Penyewaan").
           * - Data dinamis dari parameter `label`.
           * - Gaya teks semi-bold.
           */
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          /** Widget [Text]
           * * Deskripsi:
           * - Menampilkan **nilai aktivitas** (misalnya "3 Items", "2 Rentals").
           * - Data dinamis dari parameter `value`.
           * - Gaya teks berwarna abu-abu.
           */
          Text(value, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  /* Fungsi ini membangun widget container berbentuk kartu dengan bayangan.
   * Digunakan sebagai pembungkus untuk informasi profil dan riwayat.
   *
   * Parameter:
   * - [children]: Daftar widget yang akan ditempatkan di dalam kartu.
   *
   * Return: Widget [Container] yang berfungsi sebagai kartu.
   */
  Widget _buildCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16), // Padding internal kartu.
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang kartu.
        borderRadius: BorderRadius.circular(16), // Sudut kartu membulat.
        boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2)), // Bayangan kartu.
        ],
      ),
      /** Widget [Column]
       * * Deskripsi:
       * - Menata semua widget `children` secara vertikal di dalam kartu.
       */
      child: Column(children: children),
    );
  }

  /* Fungsi ini membangun tombol "Edit Profile" yang navigasi ke halaman pengaturan.
   *
   * Return: Widget [ElevatedButton.icon] untuk mengedit profil.
   */
  Widget _buildSettingsButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(
            0xFF2E7D32), // Warna latar belakang tombol (hijau gelap).
        padding: const EdgeInsets.symmetric(
            vertical: 16), // Padding vertikal tombol.
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)), // Sudut tombol membulat.
      ),
      onPressed: () {
        // TODO: Logika navigasi ke halaman pengaturan atau edit profil akan ditambahkan di sini.
        // Misalnya: Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
      },
      /** Widget [Icon]
       * * Deskripsi:
       * - Ikon pengaturan di sebelah kiri teks tombol.
       */
      icon: const Icon(Icons.settings, color: Colors.white),
      /** Widget [Text]
       * * Deskripsi:
       * - Teks tombol "Edit Profile".
       * - Gaya teks dengan warna putih dan ukuran 16.
       */
      label: const Text('Edit Profile',
          style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}
