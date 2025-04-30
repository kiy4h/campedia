import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

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
          
          // Pengaturan Profil
          _buildSectionTitle('Profil'),
          _buildSettingsItem(
            'Informasi Pribadi',
            'Perbarui nama, bio, foto profil',
            Icons.person,
            onTap: () {},
          ),
          _buildSettingsItem(
            'Kontak',
            'Email, telepon, dan lokasi',
            Icons.contact_mail,
            onTap: () {},
          ),
          
          const Divider(height: 32),
          
          // Pengaturan Aplikasi
          _buildSectionTitle('Aplikasi'),
          
          // Toggle Notifikasi
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
          
          // Pilihan Bahasa
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
          
          // Lainnya
          _buildSectionTitle('Lainnya'),
          _buildSettingsItem(
            'Bantuan',
            'Pusat bantuan dan FAQ',
            Icons.help,
            onTap: () {},
          ),
          _buildSettingsItem(
            'Tentang',
            'Informasi dan versi aplikasi',
            Icons.info,
            onTap: () {},
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
                // Implementasi logout
                Navigator.pop(context);
                Navigator.pop(context);
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