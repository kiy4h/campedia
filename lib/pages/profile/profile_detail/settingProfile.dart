/**
 * File         : settings_page.dart
 * Dibuat oleh  : Izzuddin Azzam
 * Tanggal      : 16-06-2025
 * Deskripsi    : Halaman pengaturan pengguna aplikasi Campedia.
 *                Berisi opsi untuk mengubah profil, notifikasi, bahasa,
 *                bantuan, info aplikasi, dan logout.
 */

import 'package:flutter/material.dart';

/// Halaman pengaturan akun pengguna
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;
  String _selectedLanguage = 'Bahasa Indonesia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: const Text(
          'Pengaturan Profil',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),

          // --- Bagian Profil ---
          _buildSectionTitle('Profil'),
          _buildSettingsItem(
            'Informasi Pribadi',
            'Perbarui nama, bio, foto profil',
            Icons.person,
            onTap: () {
              // TODO: Navigasi ke halaman informasi pribadi
            },
          ),
          _buildSettingsItem(
            'Kontak',
            'Email, telepon, dan lokasi',
            Icons.contact_mail,
            onTap: () {
              // TODO: Navigasi ke halaman kontak
            },
          ),

          const Divider(height: 32),

          // --- Bagian Aplikasi ---
          _buildSectionTitle('Aplikasi'),

          // Switch notifikasi
          SwitchListTile(
            value: _notifications,
            onChanged: (value) {
              setState(() {
                _notifications = value;
              });
            },
            title: const Text('Notifikasi'),
            subtitle: const Text('Aktifkan notifikasi'),
            secondary: Icon(
              Icons.notifications,
              color: Colors.green.shade800,
            ),
          ),

          // Pilihan bahasa
          ListTile(
            leading: Icon(
              Icons.language,
              color: Colors.green.shade800,
            ),
            title: const Text('Bahasa'),
            subtitle: Text(_selectedLanguage),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _showLanguageDialog();
            },
          ),

          const Divider(height: 32),

          // --- Bagian Lainnya ---
          _buildSectionTitle('Lainnya'),
          _buildSettingsItem(
            'Bantuan',
            'Pusat bantuan dan FAQ',
            Icons.help,
            onTap: () {
              // TODO: Navigasi ke halaman bantuan
            },
          ),
          _buildSettingsItem(
            'Tentang',
            'Informasi dan versi aplikasi',
            Icons.info,
            onTap: () {
              // TODO: Navigasi ke halaman tentang
            },
          ),
          _buildSettingsItem(
            'Keluar',
            'Keluar dari akun Anda',
            Icons.logout,
            textColor: Colors.red,
            onTap: () {
              _showLogoutDialog();
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  /// Membangun judul untuk tiap bagian pengaturan
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

  /// Membangun satu item pengaturan
  Widget _buildSettingsItem(
    String title,
    String subtitle,
    IconData icon, {
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: textColor ?? Colors.green.shade800,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.black,
          fontWeight: textColor != null ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  /// Menampilkan dialog pemilihan bahasa
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Pilih Bahasa'),
          children: [
            _buildLanguageOption('Bahasa Indonesia'),
            _buildLanguageOption('English'),
          ],
        );
      },
    );
  }

  /// Membuat satu opsi bahasa dalam dialog
  Widget _buildLanguageOption(String language) {
    return SimpleDialogOption(
      onPressed: () {
        setState(() {
          _selectedLanguage = language;
        });
        Navigator.pop(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(language),
          if (_selectedLanguage == language)
            Icon(Icons.check, color: Colors.green.shade800),
        ],
      ),
    );
  }

  /// Menampilkan dialog konfirmasi logout
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Keluar'),
          content: const Text('Apakah Anda yakin ingin keluar dari akun?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Tambahkan logika logout (e.g. clear session/token)
                Navigator.pop(context); // tutup dialog
                Navigator.pop(context); // kembali ke halaman sebelumnya
              },
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
