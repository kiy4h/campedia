import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas3provis/components/navbar.dart';
import 'package:tugas3provis/pages/notification.dart';
import 'historyPenyewaan.dart';

void main() {
  runApp(CampingApp());
}

class CampingApp extends StatelessWidget {
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

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          children: [
            _buildHeader(context),
            SizedBox(height: 20),
            _buildProfileDetails(context),
            SizedBox(height: 24),
            _buildHistorySection(context),
            SizedBox(height: 24),
            _buildSettingsButton(context),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(
        context,
        currentIndex: 3, // Bisa disesuaikan jika profil ada di index ke-3
      ),
    );
  }

  Widget _buildHeader(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello,',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30, // Ukuran foto profil
                  backgroundImage: AssetImage('assets/profile_pic.jpg'), // Ganti dengan gambar yang sesuai
                ),
                SizedBox(width: 12),
                Text(
                  'Izzuddin Azzam', // Nama pengguna
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                // Arahkan ke halaman edit profil
                // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(Icons.edit, size: 24, color: Colors.black87),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildProfileRow('Email:', 'izzuddin@example.com'),
              SizedBox(height: 12),
              _buildProfileRow('Phone:', '+62 812 3456 7890'),
              SizedBox(height: 12),
              _buildProfileRow('Location:', 'Jakarta, Indonesia'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildHistorySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'History',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        _buildHistoryRow('Purchase History:', '3 Items'),
        SizedBox(height: 12),
        _buildHistoryRow('Rental History:', '2 Rentals'),
        SizedBox(height: 12),
        _buildHistoryRow('Payment Status:', 'Paid'),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            // Arahkan ke halaman riwayat pembelian lengkap
            Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseHistoryPage()));
          },
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              'See All',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Arahkan ke halaman pengaturan jika diperlukan
        // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Color(0xFF5D7052),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
