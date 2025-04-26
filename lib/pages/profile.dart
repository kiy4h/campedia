import 'package:flutter/material.dart';
import '../components/navbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String profileImageUrl = 'https://via.placeholder.com/150'; 
  final String userName = 'Vina Salima Mujahidah';
  final String userBio = 'Penyewa Alat Kemah dan Pengelola Peralatan Outdoor.';
  final String userEmail = 'vina@example.com';
  final String userPhone = '+62 812 3456 7890';
  final String location = 'Bandung, Indonesia';
  final String website = 'github.com/vinasalima';

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: _openSettings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(height: 1),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              color: Colors.white,
              child: Column(
                children: [
                  // Profile Image
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(profileImageUrl),
                  ),
                  const SizedBox(height: 16),
                  // User Name
                  Text(
                    userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // User Bio
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      userBio,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Edit Profile Button
                  ElevatedButton(
                    onPressed: () {
                      // Tambahkan fungsionalitas untuk mengedit profil
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _buildInfoSection('Informasi Kontak', [
              _buildInfoRow(Icons.email, userEmail),
              _buildInfoRow(Icons.phone, userPhone),
              _buildInfoRow(Icons.location_on, location),
              _buildInfoRow(Icons.language, website),
            ]),
            const SizedBox(height: 8),
            _buildInfoSection('Riwayat Penyewaan', [
              _buildEquipmentChip('Tenda'),
              _buildEquipmentChip('Sleeping Bag'),
              _buildEquipmentChip('Matras'),
              _buildEquipmentChip('Lampu Kemah'),
              _buildEquipmentChip('Peralatan Memasak'),
            ]),
            const SizedBox(height: 8),
            _buildActivitySection(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(
        context: context,
        currentIndex: 5, 
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> content) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.green[800],
            ),
          ),
          const SizedBox(height: 16),
          ...content,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.green[800],
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEquipmentChip(String label) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: Colors.green[800],
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    );
  }

  Widget _buildActivitySection() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aktivitas Terbaru',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.green[800],
            ),
          ),
          const SizedBox(height: 16),
          _buildActivityItem('Menambah alat baru: Tenda 4 Orang', '2 hari yang lalu'),
          const Divider(),
          _buildActivityItem('Melakukan peminjaman alat kemah', '1 minggu yang lalu'),
          const Divider(),
          _buildActivityItem('Mengupdate harga sewa', '2 minggu yang lalu'),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String activity, String timeAgo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: Colors.green[700]!.withOpacity(0.2),
            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  timeAgo,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// Settings Page
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;
  bool notifications = true;
  bool locationServices = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          // Account Settings Section
          _buildSectionHeader('Account Settings'),
          _buildSettingsItem(
            'Edit Profile',
            Icons.person,
            onTap: () {
              // Navigate to edit profile
            },
          ),
          _buildSettingsItem(
            'Change Password',
            Icons.lock,
            onTap: () {
              // Navigate to change password
            },
          ),
          _buildSettingsItem(
            'Privacy',
            Icons.visibility,
            onTap: () {
              // Navigate to privacy settings
            },
          ),
          // App Settings Section
          _buildSectionHeader('App Settings'),
          _buildSwitchItem(
            'Dark Mode',
            Icons.dark_mode,
            darkMode,
            (value) {
              setState(() {
                darkMode = value;
              });
            },
          ),
          _buildSwitchItem(
            'Notifications',
            Icons.notifications,
            notifications,
            (value) {
              setState(() {
                notifications = value;
              });
            },
          ),
          _buildSwitchItem(
            'Location Services',
            Icons.location_on,
            locationServices,
            (value) {
              setState(() {
                locationServices = value;
              });
            },
          ),
          // More Options Section
          _buildSectionHeader('More'),
          _buildSettingsItem(
            'Help & Support',
            Icons.help,
            onTap: () {
              // Navigate to help
            },
          ),
          _buildSettingsItem(
            'About',
            Icons.info,
            onTap: () {
              // Navigate to about
            },
          ),
          _buildSettingsItem(
            'Log Out',
            Icons.logout,
            textColor: Colors.red,
            onTap: () {
              // Handle logout
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Log Out'),
                  content: const Text('Are you sure you want to log out?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Perform logout action
                        Navigator.pop(context);
                      },
                      child: const Text('Log Out', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade800,
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    String title,
    IconData icon, {
    required Function() onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: textColor ?? Colors.black87,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildSwitchItem(
    String title,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue,
      ),
    );
  }
}