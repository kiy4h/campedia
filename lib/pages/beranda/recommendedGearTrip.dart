import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/gunung_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/models.dart';
import '../detail_items/detailItem.dart';
import '../components/navbar.dart';

class GunungDestinationPage extends StatefulWidget {
  const GunungDestinationPage({super.key});

  @override
  State<GunungDestinationPage> createState() => GunungDestinationPageState();
}

class GunungDestinationPageState extends State<GunungDestinationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadGunung();
    });
  }

  void _loadGunung() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final gunungProvider = Provider.of<GunungProvider>(context, listen: false);

    if (authProvider.isAuthenticated) {
      gunungProvider.fetchAllGunung(authProvider.user!.userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mountain Destinations'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Consumer<GunungProvider>(
        builder: (context, gunungProvider, child) {
          if (gunungProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (gunungProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${gunungProvider.error}'),
                  ElevatedButton(
                    onPressed: _loadGunung,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (gunungProvider.gunungList.isEmpty) {
            return const Center(
              child: Text('No mountains available'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: gunungProvider.gunungList.length,
            itemBuilder: (context, index) {
              final gunung = gunungProvider.gunungList[index];
              return _buildGunungCard(gunung);
            },
          );
        },
      ),
      bottomNavigationBar: buildBottomNavBar(context, currentIndex: 0),
    );
  }

  Widget _buildGunungCard(Gunung gunung) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mountain Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              gunung.foto.isNotEmpty
                  ? gunung.foto
                  : 'https://via.placeholder.com/400x200',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported, size: 50),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mountain Name
                Text(
                  gunung.namaGunung,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                // Location
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      gunung.lokasi,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  gunung.deskripsi,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 12),

                // Items count badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shopping_bag_outlined,
                          size: 16, color: Colors.green[700]),
                      const SizedBox(width: 4),
                      Text(
                        "${gunung.barangList.length} Items Available",
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Available Items Grid
                if (gunung.barangList.isNotEmpty) ...[
                  const Text(
                    'Available Gear:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: gunung.barangList.length,
                      itemBuilder: (context, itemIndex) {
                        final barang = gunung.barangList[itemIndex];
                        return _buildBarangItem(barang);
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarangItem(Barang barang) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailItem(barangId: barang.id),
          ),
        );
      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[50],
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Image
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.network(
                  barang.foto ?? 'https://via.placeholder.com/100x60',
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 30),
                    );
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    barang.namaBarang,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Rp ${barang.hargaPerhari}/day',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
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
