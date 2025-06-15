/*
* File : profile.dart
* Deskripsi : Halaman profil pengguna yang menampilkan informasi akun dan riwayat
* Dependencies : 
*   - google_fonts: untuk styling text dengan font Poppins
*   - navbar.dart: untuk komponen navigasi
*   - notification.dart: untuk navigasi ke halaman notifikasi
*   - historyPenyewaan.dart: untuk navigasi ke halaman riwayat penyewaan
*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas3provis/pages/components/navbar.dart';
import 'package:tugas3provis/pages/beranda/notification.dart';
import '../transaction/historyPenyewaan.dart';

void main() {
  runApp(CampingApp());
}

/*
* Class : CampingApp
* Deskripsi : Widget aplikasi utama untuk halaman profil
* Bagian Layar : Root aplikasi untuk halaman profil
*/
class CampingApp extends StatelessWidget {
  const CampingApp({super.key});
  /*
  * Method : build
  * Deskripsi : Membangun widget MaterialApp untuk halaman profil
  * Parameter : context - BuildContext untuk akses ke fitur framework
  * Return : Widget MaterialApp yang berisi ProfilePage
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

/*
* Class : ProfilePage
* Deskripsi : Widget halaman profil pengguna, merupakan StatelessWidget
* Bagian Layar : Halaman profil pengguna
*/
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  /*
  * Method : build
  * Deskripsi : Membangun tampilan UI untuk halaman profil
  * Parameter : context - BuildContext untuk akses ke fitur framework
  * Return : Widget Scaffold berisi konten halaman profil
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

  /*
  * Method : _buildHeader
  * Deskripsi : Membuat bagian header profil dengan foto dan nama pengguna
  * Parameter : context - BuildContext untuk akses ke fitur framework
  * Return : Widget Row yang berisi header profil
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

  /*
  * Method : _buildProfileDetails
  * Deskripsi : Membuat bagian detail informasi akun pengguna
  * Parameter : context - BuildContext untuk akses ke fitur framework
  * Return : Widget Column berisi informasi akun
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

  /*
  * Method : _buildProfileRow
  * Deskripsi : Membuat baris untuk menampilkan label dan nilai informasi profil
  * Parameter : 
  *   - label - String label untuk informasi profil
  *   - value - String nilai informasi profil
  * Return : Widget Padding berisi Row untuk satu baris informasi
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

  /*
  * Method : _buildHistorySection
  * Deskripsi : Membuat bagian riwayat aktivitas pengguna
  * Parameter : context - BuildContext untuk navigasi ke halaman riwayat
  * Return : Widget Column berisi informasi riwayat
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

  /*
  * Method : _buildHistoryRow
  * Deskripsi : Membuat baris untuk menampilkan label dan nilai informasi riwayat
  * Parameter : 
  *   - label - String label untuk informasi riwayat
  *   - value - String nilai informasi riwayat
  * Return : Widget Padding berisi Row untuk satu baris riwayat
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

  /*
  * Method : _buildCard
  * Deskripsi : Membuat widget card dengan shadow untuk menampung konten
  * Parameter : children - List<Widget> daftar widget yang akan ditampilkan dalam card
  * Return : Widget Container berupa card dengan styling
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

  /*
  * Method : _buildSettingsButton
  * Deskripsi : Membuat tombol untuk mengedit profil
  * Parameter : context - BuildContext untuk navigasi
  * Return : Widget ElevatedButton untuk navigasi ke halaman edit profil
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
