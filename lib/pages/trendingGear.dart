import 'package:flutter/material.dart';

class GearItem {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final int rentPrice;
  final bool isAvailable;

  const GearItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.rentPrice,
    required this.isAvailable,
  });
}

class TrendingGearPage extends StatelessWidget {
  const TrendingGearPage({Key? key}) : super(key: key);

  final List<GearItem> items = const [
    GearItem(
      id: '1',
      name: 'Kompor Portable',
      imageUrl: 'https://via.placeholder.com/150',
      rating: 4.8,
      rentPrice: 35000,
      isAvailable: true,
    ),
    GearItem(
      id: '2',
      name: 'Tenda 2 Person',
      imageUrl: 'https://via.placeholder.com/150',
      rating: 4.9,
      rentPrice: 75000,
      isAvailable: true,
    ),
    GearItem(
      id: '3',
      name: 'Sleeping Bag Ultra Light',
      imageUrl: 'https://via.placeholder.com/150',
      rating: 4.7,
      rentPrice: 40000,
      isAvailable: false,
    ),
    GearItem(
      id: '4',
      name: 'Carrier 50L',
      imageUrl: 'https://via.placeholder.com/150',
      rating: 4.6,
      rentPrice: 65000,
      isAvailable: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alat Camping Populer', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      body: ListView.builder(
        itemCount: items.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber[700]),
                          const SizedBox(width: 4),
                          Text(
                            item.rating.toStringAsFixed(1),
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 3,
                            height: 3,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item.isAvailable ? "Tersedia" : "Tidak tersedia",
                            style: TextStyle(
                              color: item.isAvailable ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Rp ${item.rentPrice ~/ 1000}k / hari",
                        style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
