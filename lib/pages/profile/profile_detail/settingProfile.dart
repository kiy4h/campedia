/**
 * File        : settings_page.dart
 * Dibuat oleh  : Izzuddin Azzam
 * Tanggal      : 16-06-2025
 * Deskripsi    : Halaman ini menyediakan berbagai opsi pengaturan untuk pengguna aplikasi Campedia.
 * Pengguna dapat mengelola informasi profil, preferensi aplikasi (notifikasi, bahasa),
 * mengakses bantuan, melihat informasi tentang aplikasi, dan keluar dari akun mereka.
 * Dependencies :
 * - flutter/material.dart: Pustaka dasar Flutter untuk membangun UI.
 */

import 'package:flutter/material.dart';

/** Widget [SettingsPage]
 *
 * Deskripsi:
 * - Halaman ini berfungsi sebagai antarmuka pengguna untuk mengatur preferensi dan informasi akun.
 * - Merupakan bagian penting dari pengalaman pengguna untuk personalisasi aplikasi.
 * - Ini adalah StatefulWidget karena memiliki state yang berubah (misalnya, status notifikasi, pilihan bahasa)
 * yang perlu diperbarui dan dirender ulang di UI.
 */
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

/** State [ _SettingsPageState]
 *
 * Deskripsi:
 * - Mengelola state internal untuk [SettingsPage].
 * - Menyimpan status _notifications (on/off) dan _selectedLanguage.
 * - Membangun UI halaman pengaturan berdasarkan state ini.
 */
class _SettingsPageState extends State<SettingsPage> {
  // Variabel untuk mengontrol status switch notifikasi. Defaultnya aktif.
  bool _notifications = true;
  // Variabel untuk menyimpan bahasa yang dipilih. Defaultnya "Bahasa Indonesia".
  String _selectedLanguage = 'Bahasa Indonesia';

  /* Fungsi ini membangun seluruh struktur UI dari halaman pengaturan.
   *
   * Parameter:
   * - [context]: BuildContext dari widget.
   *
   * Return: Sebuah widget [Scaffold] yang berisi AppBar dan body halaman.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** Widget [AppBar]
       * * Deskripsi:
       * - Bilah aplikasi di bagian atas halaman pengaturan.
       * - Menampilkan judul halaman dan tombol kembali.
       */
      appBar: AppBar(
        backgroundColor: Colors.green.shade800, // Warna latar belakang AppBar.
        /** Widget [Text]
         * * Deskripsi:
         * - Judul halaman "Pengaturan Profil".
         * - Gaya teks dengan warna putih.
         */
        title: const Text(
          'Pengaturan Profil',
          style: TextStyle(color: Colors.white),
        ),
        /** Widget [IconButton]
         * * Deskripsi:
         * - Tombol ikon di sisi kiri AppBar untuk kembali ke halaman sebelumnya.
         */
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Ikon panah kembali berwarna putih.
          onPressed: () => Navigator.pop(context), // Aksi untuk kembali ke halaman sebelumnya.
        ),
      ),
      /** Widget [ListView]
       * * Deskripsi:
       * - Tampilan daftar yang dapat digulir untuk menampilkan berbagai opsi pengaturan.
       */
      body: ListView(
        children: [
          const SizedBox(height: 16), // Spasi vertikal di awal daftar.

          // --- Bagian Profil ---
          _buildSectionTitle('Profil'), // Judul bagian "Profil".
          _buildSettingsItem(
            'Informasi Pribadi', // Judul item pengaturan.
            'Perbarui nama, bio, foto profil', // Subtitle item.
            Icons.person, // Ikon item.
            onTap: () {
              // TODO: Logika navigasi ke halaman informasi pribadi akan ditambahkan di sini.
            },
          ),
          _buildSettingsItem(
            'Kontak', // Judul item pengaturan.
            'Email, telepon, dan lokasi', // Subtitle item.
            Icons.contact_mail, // Ikon item.
            onTap: () {
              // TODO: Logika navigasi ke halaman kontak akan ditambahkan di sini.
            },
          ),

          const Divider(height: 32), // Pembatas antar bagian.

          // --- Bagian Aplikasi ---
          _buildSectionTitle('Aplikasi'), // Judul bagian "Aplikasi".

          // --- Switch Notifikasi ---
          /** Widget [SwitchListTile]
           * * Deskripsi:
           * - Widget daftar yang berisi switch untuk mengaktifkan atau menonaktifkan notifikasi.
           * - Mengubah state `_notifications` ketika switch diubah.
           */
          SwitchListTile(
            value: _notifications, // Nilai switch saat ini (aktif/tidak aktif).
            onChanged: (value) {
              setState(() {
                _notifications = value; // Memperbarui status notifikasi.
              });
            },
            /** Widget [Text]
             * * Deskripsi:
             * - Judul opsi notifikasi.
             */
            title: const Text('Notifikasi'),
            /** Widget [Text]
             * * Deskripsi:
             * - Subtitle yang menjelaskan fungsi notifikasi.
             */
            subtitle: const Text('Aktifkan notifikasi'),
            /** Widget [Icon]
             * * Deskripsi:
             * - Ikon notifikasi yang ditampilkan di sebelah kiri.
             */
            secondary: Icon(
              Icons.notifications,
              color: Colors.green.shade800, // Warna ikon.
            ),
          ),

          // --- Pilihan Bahasa ---
          /** Widget [ListTile]
           * * Deskripsi:
           * - Widget daftar untuk memilih bahasa aplikasi.
           * - Menampilkan bahasa yang saat ini dipilih.
           */
          ListTile(
            /** Widget [Icon]
             * * Deskripsi:
             * - Ikon bahasa yang ditampilkan di sebelah kiri.
             */
            leading: Icon(
              Icons.language,
              color: Colors.green.shade800, // Warna ikon.
            ),
            /** Widget [Text]
             * * Deskripsi:
             * - Judul opsi bahasa.
             */
            title: const Text('Bahasa'),
            /** Widget [Text]
             * * Deskripsi:
             * - Subtitle yang menampilkan **bahasa yang saat ini dipilih** (`_selectedLanguage`).
             * - Data dinamis yang diperbarui oleh `_showLanguageDialog`.
             */
            subtitle: Text(_selectedLanguage),
            /** Widget [Icon]
             * * Deskripsi:
             * - Ikon panah maju di sisi kanan.
             */
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _showLanguageDialog(); // Menampilkan dialog pemilihan bahasa saat ditekan.
            },
          ),

          const Divider(height: 32), // Pembatas antar bagian.

          // --- Bagian Lainnya ---
          _buildSectionTitle('Lainnya'), // Judul bagian "Lainnya".
          _buildSettingsItem(
            'Bantuan', // Judul item pengaturan.
            'Pusat bantuan dan FAQ', // Subtitle item.
            Icons.help, // Ikon item.
            onTap: () {
              // TODO: Logika navigasi ke halaman bantuan akan ditambahkan di sini.
            },
          ),
          _buildSettingsItem(
            'Tentang', // Judul item pengaturan.
            'Informasi dan versi aplikasi', // Subtitle item.
            Icons.info, // Ikon item.
            onTap: () {
              // TODO: Logika navigasi ke halaman tentang aplikasi akan ditambahkan di sini.
            },
          ),
          _buildSettingsItem(
            'Keluar', // Judul item pengaturan.
            'Keluar dari akun Anda', // Subtitle item.
            Icons.logout, // Ikon item.
            textColor: Colors.red, // Warna teks merah untuk opsi logout.
            onTap: () {
              _showLogoutDialog(); // Menampilkan dialog konfirmasi logout saat ditekan.
            },
          ),

          const SizedBox(height: 24), // Spasi vertikal di akhir daftar.
        ],
      ),
    );
  }

  /* Fungsi ini membangun widget judul untuk setiap bagian pengaturan.
   *
   * Parameter:
   * - [title]: Teks judul bagian.
   *
   * Return: Widget [Padding] yang berisi teks judul.
   */
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding di sekitar judul.
      /** Widget [Text]
       * * Deskripsi:
       * - Teks judul bagian (misalnya "Profil", "Aplikasi").
       * - Gaya teks dengan ukuran 16, tebal, dan warna hijau gelap.
       */
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.green.shade800,
        ),
      ),
    );
  }

  /* Fungsi ini membangun satu item pengaturan yang dapat diklik (ListTile).
   *
   * Parameter:
   * - [title]: Judul utama item pengaturan.
   * - [subtitle]: Deskripsi singkat item pengaturan.
   * - [icon]: Ikon yang akan ditampilkan di sebelah kiri judul.
   * - [onTap]: Fungsi callback yang akan dipanggil saat item ditekan.
   * - [textColor]: Warna opsional untuk teks judul dan ikon (defaultnya hitam/hijau gelap).
   *
   * Return: Widget [ListTile] yang merepresentasikan satu opsi pengaturan.
   */
  Widget _buildSettingsItem(
      String title,
      String subtitle,
      IconData icon, {
        required VoidCallback onTap,
        Color? textColor,
      }) {
    return ListTile(
      /** Widget [Icon]
       * * Deskripsi:
       * - Ikon yang merepresentasikan kategori pengaturan (misalnya person, contact_mail).
       * - Warna ikon bisa diatur secara opsional melalui `textColor`.
       */
      leading: Icon(
        icon,
        color: textColor ?? Colors.green.shade800, // Warna ikon default atau sesuai `textColor`.
      ),
      /** Widget [Text]
       * * Deskripsi:
       * - Judul **opsi pengaturan** (misalnya "Informasi Pribadi", "Kontak").
       * - Warna teks bisa diatur secara opsional melalui `textColor`.
       */
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.black, // Warna teks default atau sesuai `textColor`.
          fontWeight: textColor != null ? FontWeight.bold : FontWeight.normal, // Teks tebal jika warna diatur.
        ),
      ),
      /** Widget [Text]
       * * Deskripsi:
       * - Subtitle yang memberikan **deskripsi singkat** tentang opsi pengaturan.
       */
      subtitle: Text(subtitle),
      /** Widget [Icon]
       * * Deskripsi:
       * - Ikon panah maju di sisi kanan, menunjukkan item dapat diklik.
       */
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap, // Fungsi yang dipanggil saat item ditekan.
    );
  }

  /* Fungsi ini menampilkan dialog pemilihan bahasa kepada pengguna.
   *
   * Return: Tidak ada (void), fungsi ini hanya menampilkan dialog.
   */
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        /** Widget [SimpleDialog]
         * * Deskripsi:
         * - Dialog sederhana yang menampilkan daftar pilihan bahasa.
         */
        return SimpleDialog(
          /** Widget [Text]
           * * Deskripsi:
           * - Judul dialog pemilihan bahasa.
           */
          title: const Text('Pilih Bahasa'),
          children: [
            _buildLanguageOption('Bahasa Indonesia'), // Opsi bahasa "Bahasa Indonesia".
            _buildLanguageOption('English'), // Opsi bahasa "English".
          ],
        );
      },
    );
  }

  /* Fungsi ini membuat satu opsi bahasa dalam dialog pemilihan bahasa.
   *
   * Parameter:
   * - [language]: Nama bahasa yang akan ditampilkan.
   *
   * Return: Widget [SimpleDialogOption] yang merepresentasikan satu pilihan bahasa.
   */
  Widget _buildLanguageOption(String language) {
    return SimpleDialogOption(
      onPressed: () {
        setState(() {
          _selectedLanguage = language; // Memperbarui bahasa yang dipilih.
        });
        Navigator.pop(context); // Menutup dialog setelah pilihan dibuat.
      },
      /** Widget [Row]
       * * Deskripsi:
       * - Mengatur tata letak teks bahasa dan ikon cek (jika dipilih) secara horizontal.
       */
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menyebarkan elemen secara merata.
        children: [
          /** Widget [Text]
           * * Deskripsi:
           * - Teks **nama bahasa** (misalnya "Bahasa Indonesia", "English").
           * - Data dinamis dari parameter `language`.
           */
          Text(language),
          // Menampilkan ikon cek jika bahasa ini adalah bahasa yang sedang dipilih.
          if (_selectedLanguage == language)
            /** Widget [Icon]
             * * Deskripsi:
             * - Ikon cek yang muncul jika bahasa ini adalah bahasa yang aktif.
             */
            Icon(Icons.check, color: Colors.green.shade800),
        ],
      ),
    );
  }

  /* Fungsi ini menampilkan dialog konfirmasi kepada pengguna sebelum mereka keluar dari akun.
   *
   * Return: Tidak ada (void), fungsi ini hanya menampilkan dialog.
   */
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        /** Widget [AlertDialog]
         * * Deskripsi:
         * - Dialog peringatan yang meminta konfirmasi pengguna untuk logout.
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
          content: const Text('Apakah Anda yakin ingin keluar dari akun?'),
          actions: [
            /** Widget [TextButton]
             * * Deskripsi:
             * - Tombol "Batal" untuk menutup dialog tanpa logout.
             */
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Menutup dialog.
              },
              /** Widget [Text]
               * * Deskripsi:
               * - Teks pada tombol "Batal".
               */
              child: const Text('Batal'),
            ),
            /** Widget [TextButton]
             * * Deskripsi:
             * - Tombol "Keluar" untuk melanjutkan proses logout.
             */
            TextButton(
              onPressed: () {
                // TODO: Tambahkan logika logout di sini (misalnya, menghapus token sesi).
                Navigator.pop(context); // Menutup dialog konfirmasi.
                Navigator.pop(context); // Kembali ke halaman sebelumnya (misal: halaman login).
              },
              /** Widget [Text]
               * * Deskripsi:
               * - Teks pada tombol "Keluar".
               * - Gaya teks dengan warna merah gelap.
               */
              child: Text(
                'Keluar',
                style: TextStyle(color: Colors.red.shade700),
              ),
            ),
          ],
        );
      },
    );
  }
}