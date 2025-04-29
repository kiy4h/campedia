import 'package:flutter/material.dart';
import '../components/navbar.dart';

class RecommendedGear {
  final String name;
  final String imagePath;
  final double price;

  RecommendedGear({
    required this.name,
    required this.imagePath,
    required this.price,
  });
}

class CampingDestination {
  final String name;
  final String imagePath;
  final String location;
  final List<RecommendedGear> gears;
  final String description;  // Added description field

  CampingDestination({
    required this.name,
    required this.imagePath,
    required this.location,
    required this.gears,
    this.description = '',  // Default empty description
  });
}

// --- Dummy Data with added descriptions ---
final List<CampingDestination> destinations = [
  CampingDestination(
    name: "Gunung Papandayan",
    imagePath: "images/destinations/papandayan.jpg",
    location: "Garut, Jawa Barat",
    description: "Gunung Papandayan menawarkan pemandangan alam yang menakjubkan dengan kawah aktif dan hamparan bunga edelweis.",
    gears: [
      RecommendedGear(name: "Tenda 2 Orang", imagePath: "images/assets_ItemDetails/tenda1.png", price: 50),
      RecommendedGear(name: "Kompor Portable", imagePath: "images/assets_ItemDetails/kompor1.png", price: 20),
      RecommendedGear(name: "Sleeping Bag", imagePath: "images/assets_ItemDetails/tas1.png", price: 25),
    ],
  ),
  CampingDestination(
    name: "Ranu Kumbolo",
    imagePath: "images/destinations/ranukumbolo.jpg",
    location: "Lumajang, Jawa Timur",
    description: "Danau alami yang terletak di ketinggian 2.400 mdpl, merupakan salah satu spot camping favorit di Gunung Semeru.",
    gears: [
      RecommendedGear(name: "Tenda 4 Orang", imagePath: "images/assets_ItemDetails/tenda1.png", price: 80),
      RecommendedGear(name: "Jas Hujan", imagePath: "images/assets_ItemDetails/jas1.png", price: 15),
    ],
  ),
];

// --- Halaman Utama dengan UI yang Ditingkatkan ---
class RecommendedGearTripPage extends StatelessWidget {
  const RecommendedGearTripPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Destinasi Camping", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      body: ListView.builder(
        itemCount: destinations.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final destination = destinations[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Material(
                color: Colors.white,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    childrenPadding: EdgeInsets.zero,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    leading: null, // Removed leading for full-width design
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            destination.imagePath,
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Destination Info
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    destination.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold, 
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        destination.location,
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12, 
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 16,
                                    color: Colors.green[700],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${destination.gears.length} Items",
                                    style: TextStyle(
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Description
                        Text(
                          destination.description,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    subtitle: null, // Using custom layout instead
                    trailing: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.green[700],
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Perlengkapan yang Direkomendasikan",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            ...destination.gears.map((gear) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Image.asset(
                                        gear.imagePath,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            gear.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 16,
                                                color: Colors.amber[700],
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                "4.8",
                                                style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontSize: 12,
                                                ),
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
                                                "Tersedia",
                                                style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        "Rp ${gear.price.toStringAsFixed(0)}k",
                                        style: TextStyle(
                                          color: Colors.green[700],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[700],
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                minimumSize: const Size(double.infinity, 48),
                              ),
                              child: const Text(
                                "Lihat Semua Perlengkapan",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: buildBottomNavBar(
        context,
        currentIndex: 0, // Set the current index based on the selected tab
      ),
    );
  }
}