// ============================
// IMPORT LIBRARY YANG DIPERLUKAN
// ============================

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../detail_items/detailItem.dart';
import '../components/navbar.dart';


// ============================
// ENTRY POINT APLIKASI
// ============================

void main() {
  runApp(const FavoritePage()); // Jalankan aplikasi dengan halaman FavoritePage sebagai root
}


// ============================
// HALAMAN FAVORITE (ROOT WIDGET)
// ============================

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hilangkan label debug
      theme: ThemeData(
        primaryColor: const Color(0xFFA0B25E), // Warna utama aplikasi
        scaffoldBackgroundColor: const Color(0xFFF8F8F8), // Warna latar belakang
      ),
      home: ItemCategory(), // Tampilkan halaman daftar barang favorit
    );
  }
}


// ============================
// WIDGET DAFTAR BARANG FAVORIT
// ============================

class ItemCategory extends StatefulWidget {
  ItemCategory({Key? key}) : super(key: key);

  @override
  _ItemCategoryState createState() => _ItemCategoryState();
}

class _ItemCategoryState extends State<ItemCategory> {
  // Data dummy barang-barang favorit
  final List<Map<String, dynamic>> trendingItems = [
    {
      "name": "Tenda Camping",
      "price": 300000,
      "image": "images/assets_ItemDetails/tenda_bg1.png",
      "rating": 4.5,
      "isFavorite": true
    },
    {
      "name": "Kompor Portable",
      "price": 150000,
      "image": "images/assets_ItemDetails/tenda_bg2.png",
      "rating": 4.3,
      "isFavorite": true
    },
    {
      "name": "Sepatu Gunung",
      "price": 250000,
      "image": "images/assets_ItemDetails/tenda_bg3.png",
      "rating": 4.7,
      "isFavorite": true
    },
    {
      "name": "Tas Gunung",
      "price": 350000,
      "image": "images/assets_ItemDetails/tenda_bg4.png",
      "rating": 4.0,
      "isFavorite": true
    },
    {
      "name": "Senter LED",
      "price": 120000,
      "image": "images/assets_ItemDetails/tenda_bg5.png",
      "rating": 4.8,
      "isFavorite": true
    },
    {
      "name": "Jaket Gunung",
      "price": 400000,
      "image": "images/assets_ItemDetails/tenda_bg6.png",
      "rating": 4.2,
      "isFavorite": true
    },
  ];

  // State untuk filtering
  List<String> selectedCategories = [];
  RangeValues priceRange = const RangeValues(0, 1000000);
  List<int> selectedRatings = [];
  List<String> selectedLocations = [];
  List<String> selectedBrands = [];

  // Controller untuk input harga manual
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Konten halaman utama
      body: CustomScrollView(
        slivers: [
          // Header teks judul
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Barang-Barang Favorit Kamu',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Grid daftar barang favorit
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildTrendingItem(trendingItems[index], context, index);
                },
                childCount: trendingItems.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Jumlah kolom
                childAspectRatio: 0.75, // Rasio lebar/tinggi
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          ),
        ],
      ),
      // Bottom navigation bar
      bottomNavigationBar: buildBottomNavBar(context, currentIndex: 3),
    );
  }

  // ============================
  // FUNGSI: Tampilkan Bottom Sheet Filter
  // ============================

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return FilterBottomSheet(
              scrollController: scrollController,
              selectedCategories: selectedCategories,
              selectedRatings: selectedRatings,
              selectedLocations: selectedLocations,
              selectedBrands: selectedBrands,
              priceRange: priceRange,
              minPriceController: minPriceController,
              maxPriceController: maxPriceController,
            );
          },
        );
      },
    );
  }

  // ============================
  // WIDGET: Kartu Barang Favorit
  // ============================

  Widget _buildTrendingItem(Map<String, dynamic> item, BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DetailItem()), // Navigasi ke halaman detail
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(item['image']),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Tombol favorite (ikon hati)
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    trendingItems[index]['isFavorite'] = !trendingItems[index]['isFavorite'];
                  });
                },
                child: Icon(
                  trendingItems[index]['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                  size: 28,
                ),
              ),
            ),
            // Overlay detail barang (nama, harga, rating)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Rp. ${item['price']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 5),
                        Text(
                          item['rating'].toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ============================
// WIDGET: Bottom Sheet Filter
// ============================

class FilterBottomSheet extends StatelessWidget {
  final ScrollController scrollController;
  final List<String> selectedCategories;
  final List<int> selectedRatings;
  final List<String> selectedLocations;
  final List<String> selectedBrands;
  final RangeValues priceRange;
  final TextEditingController minPriceController;
  final TextEditingController maxPriceController;

  const FilterBottomSheet({
    Key? key,
    required this.scrollController,
    required this.selectedCategories,
    required this.selectedRatings,
    required this.selectedLocations,
    required this.selectedBrands,
    required this.priceRange,
    required this.minPriceController,
    required this.maxPriceController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      children: [
        // Filter kategori
        FilterSection(
          title: "Categories",
          items: ["Tenda", "Alat Masak", "Sepatu", "Tas", "Aksesoris", "Pakaian"],
          selectedItems: selectedCategories,
          onSelected: (item) {
            selectedCategories.add(item);
          },
        ),
        // Filter harga
        FilterSection(
          title: "Price",
          items: [
            'Rp. 100.000 - Rp. 500.000',
            'Rp. 500.000 - Rp. 1.000.000',
            'Rp. 1.000.000 - Rp. 2.000.000',
          ],
          selectedItems: [],
          onSelected: (item) {
            // Placeholder: aksi filter harga
          },
        ),
      ],
    );
  }
}


// ============================
// WIDGET: Section Filter Chip
// ============================

class FilterSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final List<String> selectedItems;
  final ValueChanged<String> onSelected;

  const FilterSection({
    Key? key,
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            children: items.map((item) {
              final isSelected = selectedItems.contains(item);
              return GestureDetector(
                onTap: () {
                  if (isSelected) {
                    selectedItems.remove(item);
                  } else {
                    onSelected(item);
                  }
                },
                child: Chip(
                  label: Text(item),
                  backgroundColor: isSelected ? const Color(0xFFA0B25E) : Colors.grey[300],
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
