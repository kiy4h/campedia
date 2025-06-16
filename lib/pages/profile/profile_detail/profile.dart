/**
 * File         : profile.dart
 * Dibuat oleh  : Izzuddin Azzam
 * Tanggal      : 15-06-2025
 * Deskripsi    : Halaman profil pengguna Campedia, menampilkan foto, info akun,
 *                dan ringkasan riwayat penyewaan.
 * 
 * Dependencies :
 *   - google_fonts: untuk menerapkan font Poppins
 *   - navbar.dart: untuk menampilkan navigasi bawah
 *   - notification.dart: halaman notifikasi pengguna
 *   - historyPenyewaan.dart: halaman riwayat penyewaan
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas3provis/pages/components/navbar.dart';
import 'package:tugas3provis/pages/beranda/notification.dart';
import '../transaction/historyPenyewaan.dart';

void main() {
  runApp(const CampingApp());
}

/// Widget utama untuk menjalankan halaman profil
class CampingApp extends StatelessWidget {
  const CampingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF2E7D32),
        scaffoldBackgroundColor: const Color(0xFFF8F8F8),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const ProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Halaman profil pengguna
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black87),
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
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildProfileDetails(),
            const SizedBox(height: 24),
            _buildHistorySection(context),
            const SizedBox(height: 32),
            _buildSettingsButton(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context, currentIndex: 4),
    );
  }

  /// Bagian atas halaman: foto, salam, dan nama pengguna
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('images/assets_Profile/profile_placeholder.jpg'),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Hello,', style: TextStyle(color: Colors.grey, fontSize: 14)),
                Text('Izzuddin Azzam', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            // TODO: Tambahkan navigasi ke EditProfilePage
          },
          child: const Icon(Icons.edit, color: Colors.black87),
        ),
      ],
    );
  }

  /// Informasi akun pengguna
  Widget _buildProfileDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Informasi Akun', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        _buildCard([
          _buildProfileRow('Email', 'izzuddin@example.com'),
          _buildProfileRow('Telepon', '+62 812 3456 7890'),
          _buildProfileRow('Lokasi', 'Jakarta, Indonesia'),
        ]),
      ],
    );
  }

  /// Satu baris informasi akun
  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  /// Ringkasan riwayat penyewaan
  Widget _buildHistorySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Riwayat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        _buildCard([
          _buildHistoryRow('Pembelian', '3 Items'),
          _buildHistoryRow('Penyewaan', '2 Rentals'),
          _buildHistoryRow('Status Pembayaran', 'Lunas'),
        ]),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ModernTransactionPage()),
              );
            },
            child: const Text('Lihat Semua', style: TextStyle(color: Colors.blue)),
          ),
        ),
      ],
    );
  }

  /// Satu baris ringkasan aktivitas
  Widget _buildHistoryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  /// Kartu pembungkus informasi
  Widget _buildCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(children: children),
    );
  }

  /// Tombol navigasi ke halaman pengaturan profil
  Widget _buildSettingsButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2E7D32),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: () {
        // TODO: Tambahkan navigasi atau aksi edit profil
      },
      icon: const Icon(Icons.settings, color: Colors.white),
      label: const Text('Edit Profile', style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}
