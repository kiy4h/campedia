import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON conversion

class RecommendedGear {
  final String name;
  final String imagePath;
  final double price;

  RecommendedGear({
    required this.name,
    required this.imagePath,
    required this.price,
  });

  factory RecommendedGear.fromJson(Map<String, dynamic> json) {
    return RecommendedGear(
      name: json['name'] ?? '',
      imagePath: json['imagePath'] ?? '',
      price: json['price'] != null ? (json['price'] is double ? json['price'] : double.parse(json['price'].toString())) : 0.0,
    );
  }
}

class CampingDestination {
  final String name;
  final String imagePath;
  final String location;
  final List<RecommendedGear> gears;
  final String description;

  CampingDestination({
    required this.name,
    required this.imagePath,
    required this.location,
    required this.gears,
    this.description = '',
  });

  factory CampingDestination.fromJson(Map<String, dynamic> json) {
    List<RecommendedGear> gearsList = [];
    
    if (json['gears'] != null && json['gears'] is List) {
      gearsList = (json['gears'] as List)
          .map((i) => RecommendedGear.fromJson(i is Map<String, dynamic> ? i : {}))
          .toList();
    }

    return CampingDestination(
      name: json['name'] ?? '',
      imagePath: json['imagePath'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      gears: gearsList,
    );
  }
}

class RecommendedGearTripPage extends StatefulWidget {
  const RecommendedGearTripPage({super.key});

  @override
  State<RecommendedGearTripPage> createState() => _RecommendedGearTripPageState();
}

class _RecommendedGearTripPageState extends State<RecommendedGearTripPage> {
  final TextEditingController searchController = TextEditingController();
  List<CampingDestination> filteredDestinations = [];
  bool isLoading = false;

  // Placeholder image URLs that actually work

  // Hardcoded data
  late List<CampingDestination> hardcodedDestinations;

  // Function to fetch data
  Future<void> fetchDestinations(String query) async {
    if (!mounted) return;
    
    setState(() {
      isLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate delay for hardcoded example

      if (!mounted) return;
      
      setState(() {
        filteredDestinations = hardcodedDestinations
            .where((destination) =>
                destination.name.toLowerCase().indexOf(query.toLowerCase()) >= 0 ||
                destination.location.toLowerCase().indexOf(query.toLowerCase()) >= 0)
            .toList();
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        filteredDestinations = [];
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    
    // Initialize hardcoded destinations with valid placeholder images
    hardcodedDestinations = [
      CampingDestination(
        name: "Mount Fuji",
        imagePath: "images/assets_DestinationCamp/gunung1.jpg",
        location: "Japan",
        description: "A beautiful mountain for hiking and camping.",
        gears: [
          RecommendedGear(name: "Tent", imagePath: "images/assets_Categories/cat_Jaket.png", price: 100),
          RecommendedGear(name: "Sleeping Bag", imagePath: "images/assets_Categories/cat_Sepatu.png", price: 50),
        ],
      ),
      CampingDestination(
        name: "Banff National Park",
        imagePath: "images/assets_DestinationCamp/gunung2.jpg",
        location: "Canada",
        description: "Stunning lakes and mountainous terrain.",
        gears: [
          RecommendedGear(name: "Hiking Boots", imagePath: "images/assets_Categories/cat_Tenda.png", price: 120),
          RecommendedGear(name: "Camping Stove", imagePath: "images/assets_Categories/cat_Tas.png", price: 60),
        ],
      ),
      CampingDestination(
        name: "Mount Fuji",
        imagePath: "images/assets_DestinationCamp/gunung3.jpg",
        location: "Japan",
        description: "A beautiful mountain for hiking and camping.",
        gears: [
          RecommendedGear(name: "Tent", imagePath: "images/assets_Categories/cat_Jaket.png", price: 100),
          RecommendedGear(name: "Sleeping Bag", imagePath: "images/assets_Categories/cat_Sepatu.png", price: 50),
        ],
      ),
      CampingDestination(
        name: "Banff National Park",
        imagePath: "images/assets_DestinationCamp/gunung4.jpg",
        location: "Canada",
        description: "Stunning lakes and mountainous terrain.",
        gears: [
          RecommendedGear(name: "Hiking Boots", imagePath: "images/assets_Categories/cat_Tenda.png", price: 120),
          RecommendedGear(name: "Camping Stove", imagePath: "images/assets_Categories/cat_Tas.png", price: 60),
        ],
      ),
    ];
    
    // Fetch initial data
    fetchDestinations('');
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Destinasi Camping",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: (query) {
                  fetchDestinations(query); // Call filter when there's a change
                },
                decoration: const InputDecoration(
                  hintText: 'Cari destinasi...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator()) // Show loading indicator
              : Expanded(
                  child: filteredDestinations.isEmpty
                      ? const Center(
                          child: Text(
                            "Tidak ada destinasi yang ditemukan",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredDestinations.length,
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            final destination = filteredDestinations[index];

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
                                  child: ExpansionTile(
                                    tilePadding:
                                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    childrenPadding: EdgeInsets.zero,
                                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Header Image
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.network(
                                            destination.imagePath,
                                            width: double.infinity,
                                            height: 150,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Container(
                                                height: 150,
                                                color: Colors.grey[300],
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.image_not_supported,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              );
                                            },
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
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                                                      child: Image.network(
                                                        gear.imagePath,
                                                        fit: BoxFit.contain,
                                                        errorBuilder: (context, error, stackTrace) {
                                                          return const Icon(
                                                            Icons.image_not_supported,
                                                            color: Colors.grey,
                                                          );
                                                        },
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
                                                                Icons.attach_money,
                                                                size: 16,
                                                                color: Colors.green[700],
                                                              ),
                                                              const SizedBox(width: 4),
                                                              Text(
                                                                gear.price.toStringAsFixed(2),
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors.grey.shade700,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
        ],
      ),
    );
  }
}