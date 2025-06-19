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
import 'package:provider/provider.dart';
import 'package:tugas3provis/pages/components/navbar.dart'; // Import komponen navbar bawah
import 'package:tugas3provis/pages/beranda/notification.dart'; // Import halaman notifikasi
import '../transaction/historyPenyewaan.dart'; // Import halaman riwayat penyewaan
import '../../../providers/auth_provider.dart'; // Import AuthProvider
import '../../../providers/profile_provider.dart'; // Import ProfileProvider
import '../../../models/models.dart'; // Import models
import '../../intro/animation/onboarding.dart'; // Import OnboardingScreen untuk navigasi logout

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
/// - Menampilkan foto profil, nama pengguna, informasi kontak, dan tombol untuk navigasi ke pengaturan.
/// - Ini adalah StatefulWidget karena menggunakan provider untuk mengambil data dinamis dari API.
/// Data profil akan diambil dari backend dan ditampilkan secara real-time.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Fetch user profile data when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserProfile();
    });
  }

  void _loadUserProfile() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    if (authProvider.user != null) {
      profileProvider.fetchUserProfile(authProvider.user!.userId);
    }
  }

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
        child: Consumer2<AuthProvider, ProfileProvider>(
          builder: (context, authProvider, profileProvider, child) {
            // Show loading indicator
            if (profileProvider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
                ),
              );
            }

            // Show error message
            if (profileProvider.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${profileProvider.error}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadUserProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                      ),
                      child: const Text(
                        'Coba Lagi',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            }

            // Show profile content
            return ListView(
              padding: const EdgeInsets.symmetric(
                  vertical: 16, horizontal: 20), // Padding di sekitar konten.
              children: [
                _buildHeader(context,
                    profileProvider.userProfile), // Header profil dinamis
                const SizedBox(height: 24), // Spasi vertikal.
                _buildProfileDetails(
                    profileProvider.userProfile), // Detail informasi dinamis
                const SizedBox(height: 24), // Spasi vertikal.
                _buildHistorySection(context), // Tombol riwayat transaksi
                const SizedBox(height: 24), // Spasi vertikal.
                _buildLogoutSection(context), // Tombol logout
                const SizedBox(height: 32), // Spasi vertikal.
              ],
            );
          },
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
   * - [context]: BuildContext dari widget, digunakan untuk navigasi.   *
   * Parameter:
   * - [context]: BuildContext dari widget, digunakan untuk navigasi.
   * - [user]: Data user dari API, nullable.
   *
   * Return: Widget [Row] yang berisi elemen-elemen header.
   */
  Widget _buildHeader(BuildContext context, User? user) {
    return Row(
      children: [
        /** Widget [CircleAvatar]
         * * Deskripsi:
         * - Menampilkan foto profil pengguna dalam bentuk lingkaran.
         * - Menggunakan gambar dari API atau placeholder jika tidak ada.
         */
        CircleAvatar(
          radius: 30, // Ukuran radius avatar.
          backgroundImage: user?.gambar != null && user!.gambar!.isNotEmpty
              ? NetworkImage(user.gambar!) // Gambar dari API
              : const AssetImage(
                      'images/assets_Profile/profile_placeholder.jpg')
                  as ImageProvider, // Placeholder
        ),
        const SizedBox(width: 12), // Spasi horizontal.        // Widget Column
        // Deskripsi: Mengatur nama pengguna secara vertikal.
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Penataan teks ke kiri.
          children: [
            // Widget Text
            // Deskripsi: Menampilkan nama pengguna dari API atau placeholder.
            // Data dinamis dari backend.
            // Gaya teks besar dan tebal.
            Text(user?.nama ?? 'Loading...',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  /* Fungsi ini membangun bagian detail informasi akun pengguna.
   *
   * Parameter:
   * - [user]: Data user dari API, nullable.
   *
   * Return: Widget [Column] yang berisi judul bagian dan kartu informasi.
   */
  Widget _buildProfileDetails(User? user) {
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
              'Email', user?.email ?? 'Loading...'), // Email dari API
          _buildProfileRow(
              'Telepon', user?.noHp ?? 'Loading...'), // Telepon dari API
          _buildProfileRow(
              'Lokasi',
              user != null
                  ? '${user.alamat ?? ''}, ${user.kota ?? ''}'
                  : 'Loading...'), // Alamat dari API
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

  /* Fungsi ini membangun tombol untuk melihat riwayat transaksi.
   *
   * Parameter:
   * - [context]: BuildContext dari widget, digunakan untuk navigasi.
   *
   * Return: Widget [ElevatedButton] untuk navigasi ke halaman riwayat transaksi.
   */
  Widget _buildHistorySection(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch, // Membuat tombol memenuhi lebar
      children: [
        /** Widget [ElevatedButton]
         * * Deskripsi:
         * - Tombol yang lebih signifikan untuk mengakses riwayat transaksi.
         */
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // Warna latar belakang putih
            foregroundColor:
                const Color(0xFF2E7D32), // Warna teks dan ikon hijau
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(
                  color: Color(0xFF2E7D32), width: 1.5), // Border hijau
            ),
            elevation: 2, // Sedikit bayangan
          ),
          onPressed: () {
            // Navigasi ke halaman ModernTransactionPage.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ModernTransactionPage()),
            );
          },
          /** Widget [Icon]
           * * Deskripsi:
           * - Ikon riwayat di sebelah kiri teks tombol.
           */
          icon: const Icon(Icons.history, size: 24),
          /** Widget [Text]
           * * Deskripsi:
           * - Teks tombol "Riwayat Transaksi".
           * - Gaya teks dengan ukuran 16 dan semi-bold.
           */
          label: const Text(
            'Riwayat Transaksi',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
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

  /* Fungsi ini membangun tombol logout dengan ikon dan konfirmasi.
   *
   * Parameter:
   * - [context]: BuildContext dari widget, digunakan untuk menampilkan dialog konfirmasi.
   *
   * Return: Widget [ElevatedButton] untuk logout.
   */
  Widget _buildLogoutSection(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch, // Membuat tombol memenuhi lebar
      children: [
        /** Widget [ElevatedButton]
         * * Deskripsi:
         * - Tombol logout dengan warna merah untuk menunjukkan aksi yang signifikan.
         */
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // Warna latar belakang putih
            foregroundColor: Colors.red[600], // Warna teks dan ikon merah
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                  color: Colors.red[600]!, width: 1.5), // Border merah
            ),
            elevation: 2, // Sedikit bayangan
          ),
          onPressed: () {
            _showLogoutDialog(context);
          },
          /** Widget [Icon]
           * * Deskripsi:
           * - Ikon logout di sebelah kiri teks tombol.
           */
          icon: const Icon(Icons.logout, size: 24),
          /** Widget [Text]
           * * Deskripsi:
           * - Teks tombol "Logout".
           * - Gaya teks dengan ukuran 16 dan semi-bold.
           */
          label: const Text(
            'Keluar',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  /* Fungsi ini menampilkan dialog konfirmasi logout.
   *
   * Parameter:
   * - [context]: BuildContext dari widget, digunakan untuk menampilkan dialog.
   *
   * Return: Tidak ada (void).
   */
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        /** Widget [AlertDialog]
         * * Deskripsi:
         * - Dialog konfirmasi logout.
         */
        return AlertDialog(
          /** Widget [Text]
           * * Deskripsi:
           * - Judul dialog konfirmasi logout.
           */
          title: const Text('Keluar'),
          /** Widget [Text]
           * * Deskripsi:
           * - Pesan konfirmasi yang menanyakan apakah pengguna yakin ingin keluar.
           */
          content:
              const Text('Apakah Anda yakin ingin keluar dari akun Anda?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Sudut dialog membulat
          ),
          actions: [
            /** Widget [TextButton]
             * * Deskripsi:
             * - Tombol "Cancel" untuk menutup dialog tanpa logout.
             */
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Menutup dialog.
              },
              child: const Text(
                'Batal',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            /** Widget [TextButton]
             * * Deskripsi:
             * - Tombol "Logout" untuk melanjutkan proses logout.
             */
            TextButton(
              onPressed: () async {
                // Ambil AuthProvider dan ProfileProvider untuk logout
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                final profileProvider =
                    Provider.of<ProfileProvider>(context, listen: false);

                // Lakukan logout
                await authProvider.logout();

                // Clear profile data
                profileProvider.clearProfile();

                // Tutup dialog
                Navigator.pop(context);

                // Navigasi ke OnboardingScreen dan hapus semua rute sebelumnya
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OnboardingScreen()),
                  (route) => false, // Menghapus semua rute sebelumnya
                );
              },
              child: Text(
                'Keluar',
                style: TextStyle(
                  color: Colors.red[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
