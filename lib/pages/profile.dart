import 'package:flutter/material.dart';
import '../components/navbar.dart';
import 'settingProfile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  final String profileImageUrl = 'https://via.placeholder.com/150';
  final String userName = 'Ahmad Izzuddin Azzam';
  final String userBio = 'Penyewa Alat Kemah dan Pengelola Peralatan Outdoor.';
  final String userEmail = 'Azzam@example.com';
  final String userPhone = '+62 812 3456 7890';
  final String location = 'Bandung, Indonesia';
  
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header Profile
          _buildProfileHeader(),
          
          // Tab Bar
          TabBar(
            controller: _tabController,
            labelColor: Colors.green.shade800,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.green.shade800,
            tabs: const [
              Tab(text: 'Info'),
              Tab(text: 'Aktivitas'),
            ],
          ),
          
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildInfoTab(),
                _buildActivityTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavBar(context, currentIndex: 5),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsPage()),
          );
        },
        backgroundColor: Colors.green.shade800,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
  
  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.green.shade800, Colors.green.shade600],
        ),
      ),
      child: Column(
        children: [
          // Profile Image
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profileImageUrl),
            ),
          ),
          const SizedBox(height: 16),
          
          // Name
          Text(
            userName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          
          // Bio
          Text(
            userBio,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildInfoCard(),
        const SizedBox(height: 16),
        _buildRentalHistorySection(),
        const SizedBox(height: 16),
        _buildStatsCard(),
      ],
    );
  }
  
  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informasi Kontak',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
            const Divider(height: 24),
            _buildContactItem(Icons.email, userEmail),
            const SizedBox(height: 12),
            _buildContactItem(Icons.phone, userPhone),
            const SizedBox(height: 12),
            _buildContactItem(Icons.location_on, location),
          ],
        ),
      ),
    );
  }
  
  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.green.shade800, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
  
  Widget _buildStatsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistik',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('32', 'Peralatan'),
                _buildStatItem('128', 'Penyewaan'),
                _buildStatItem('96%', 'Rating'),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
  
  Widget _buildRentalHistorySection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Riwayat Penyewaan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
            const Divider(height: 24),
            _buildRentalItem('Tenda 4 Orang', '12 April 2023'),
            _buildRentalItem('Sleeping Bag', '25 Maret 2023'),
            _buildRentalItem('Matras Camping', '15 Februari 2023'),
          ],
        ),
      ),
    );
  }
  
  Widget _buildRentalItem(String itemName, String rentalDate) {
    return Row(
      children: [
        Icon(Icons.event, color: Colors.green.shade800, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                rentalDate,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildActivityTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildActivityItem(
          'Menambah alat baru: Tenda 4 Orang',
          '2 hari yang lalu',
          Icons.add_circle,
          Colors.blue,
        ),
        _buildActivityItem(
          'Melakukan peminjaman alat kemah',
          '1 minggu yang lalu',
          Icons.campaign,
          Colors.green,
        ),
        _buildActivityItem(
          'Mengupdate harga sewa',
          '2 minggu yang lalu',
          Icons.edit,
          Colors.orange,
        ),
      ],
    );
  }
  
  Widget _buildActivityItem(String title, String time, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
