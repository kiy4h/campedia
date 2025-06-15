/**
 * File         : profile.dart
 * Dibuat oleh  : Izzuddin Azzam
 * Tanggal      : 15-06-2025
 * Deskripsi    : File ini berisi tampilan halaman profil pengguna yang menampilkan foto profil,
 *                informasi akun dan ringkasan riwayat penyewaan
 * Dependencies : 
 *   - google_fonts: untuk mengatur font Poppins pada teks
 *   - navbar.dart: untuk menampilkan menu navigasi bawah
 *   - notification.dart: untuk membuka halaman notifikasi pengguna
 *   - historyPenyewaan.dart: untuk membuka halaman detail riwayat penyewaan
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas3provis/pages/components/navbar.dart';
import 'package:tugas3provis/pages/beranda/notification.dart';
import '../transaction/historyPenyewaan.dart';

void main() {
  runApp(CampingApp());
}

/** Widget CampingApp
 * 
 * Deskripsi:
 * - Widget utama yang menjalankan aplikasi profil pengguna
 * - Mengatur tema warna dan font untuk halaman profil
 * - Menggunakan StatelessWidget karena tidak perlu menyimpan perubahan state
 */
class CampingApp extends StatelessWidget {
  const CampingApp({super.key});
    /** Method build
   * 
   * Deskripsi: Metode ini membangun dan mengatur tampilan aplikasi profil
   * Parameter: context - Konteks untuk mengakses tema, lokalisasi, dll
   * Return: MaterialApp dengan tema yang sudah diatur
   */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF2E7D32),
        scaffoldBackgroundColor: Color(0xFFF8F8F8),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: ProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/** Widget ProfilePage
 * 
 * Deskripsi:
 * - Widget yang menampilkan halaman utama profil pengguna
 * - Menampilkan foto profil, info akun, dan ringkasan riwayat
 * - Menggunakan StatelessWidget karena hanya menampilkan data tanpa perubahan state
 */
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  /** Method build
   * 
   * Deskripsi: Metode ini menyusun tata letak halaman profil pengguna
   * Parameter: context - Konteks yang memberikan akses ke tema dan navigasi
   * Return: Scaffold dengan AppBar, daftar informasi profil dan menu navigasi
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black87),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          children: [
            _buildHeader(context),
            SizedBox(height: 24),
            _buildProfileDetails(context),
            SizedBox(height: 24),
            _buildHistorySection(context),
            SizedBox(height: 32),
            _buildSettingsButton(context),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(
        context,
        currentIndex: 4, // Bisa disesuaikan jika profil ada di index ke-3
      ),
    );
  }
  /** Method _buildHeader
   * 
   * Deskripsi: Membuat bagian atas profil yang berisi foto dan nama pengguna
   * Parameter: context - Konteks untuk mengakses tema dan navigasi
   * Return: Widget baris dengan foto profil, salam, dan nama pengguna
   */
  Widget _buildHeader(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage:
                  AssetImage('images/assets_Profile/profile_placeholder.jpg'),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello,',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                Text(
                  'Izzuddin Azzam',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            // Tambahkan navigasi ke halaman edit profile jika ada
            // Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfilePage()));
          },
          child: Icon(Icons.edit, color: Colors.black87),
        ),
      ],
    );
  }
  /** Method _buildProfileDetails
   * 
   * Deskripsi: Membuat bagian yang menampilkan detail informasi akun pengguna
   * Parameter: context - Konteks untuk mengakses tema
   * Return: Kolom berisi judul "Informasi Akun" dan kartu dengan data pengguna
   */
  Widget _buildProfileDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informasi Akun',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12),
        _buildCard([
          _buildProfileRow('Email', 'izzuddin@example.com'),
          _buildProfileRow('Telepon', '+62 812 3456 7890'),
          _buildProfileRow('Lokasi', 'Jakarta, Indonesia'),
        ]),
      ],
    );
  }
  /** Method _buildProfileRow
   * 
   * Deskripsi: Membuat satu baris informasi dengan label dan nilainya
   * Parameter: 
   *   - label - Judul informasi (misal: Email, Telepon)
   *   - value - Nilai informasi (misal: example@mail.com)
   * Return: Widget baris dengan label di kiri dan nilainya di kanan
   */
  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
  /** Method _buildHistorySection
   * 
   * Deskripsi: Membuat bagian yang menampilkan ringkasan riwayat aktivitas pengguna
   * Parameter: context - Konteks untuk navigasi ke halaman riwayat lengkap
   * Return: Kolom dengan judul "Riwayat" dan kartu ringkasan aktivitas
   */
  Widget _buildHistorySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Riwayat',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        SizedBox(height: 12),
        _buildCard([
          _buildHistoryRow('Pembelian', '3 Items'),
          _buildHistoryRow('Penyewaan', '2 Rentals'),
          _buildHistoryRow('Status Pembayaran', 'Lunas'),
        ]),
        SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ModernTransactionPage()));
            },
            child: Text('Lihat Semua', style: TextStyle(color: Colors.blue)),
          ),
        ),
      ],
    );
  }
  /** Method _buildHistoryRow
   * 
   * Deskripsi: Membuat satu baris untuk menampilkan informasi riwayat aktivitas
   * Parameter: 
   *   - label - Jenis aktivitas (misal: Pembelian, Penyewaan)
   *   - value - Informasi jumlah atau status (misal: 3 Items)
   * Return: Widget baris dengan jenis aktivitas di kiri dan informasinya di kanan
   */
  Widget _buildHistoryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
  /** Method _buildCard
   * 
   * Deskripsi: Membuat kartu dengan bayangan untuk mengelompokkan informasi terkait
   * Parameter: children - Daftar widget yang akan ditampilkan di dalam kartu
   * Return: Container berbentuk kartu dengan bayangan dan sudut membulat
   */
  Widget _buildCard(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
  /** Method _buildSettingsButton
   * 
   * Deskripsi: Membuat tombol besar untuk navigasi ke halaman pengaturan profil
   * Parameter: context - Konteks untuk navigasi ke halaman edit profil
   * Return: Tombol hijau dengan ikon pengaturan dan tulisan "Edit Profile"
   */
  Widget _buildSettingsButton(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF2E7D32),
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: () {
        // Tambahkan aksi edit profil
      },
      icon: Icon(Icons.settings, color: Colors.white),
      label: Text('Edit Profile',
          style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}
