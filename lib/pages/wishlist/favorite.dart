/**
 * File         : favorite.dart
 * Dibuat oleh  : Izzuddin Azzam
 * Tanggal      : 15-06-2025
 * Deskripsi    : File ini berisi implementasi halaman favorit/wishlist yang menampilkan
 *                daftar barang yang telah ditandai sebagai favorit oleh pengguna
 * Dependencies : flutter/material.dart, font_awesome_flutter, detailItem, navbar
 */

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../detail_items/detailItem.dart';
import '../components/navbar.dart';

void main() {
  runApp(const FavoritePage());
}

/** Widget FavoritePage
 * 
 * Deskripsi:
 * - Widget root untuk halaman favorit/wishlist
 * - Menjadi entry point ketika halaman favorit diakses langsung
 * - Merupakan StatelessWidget karena hanya berfungsi sebagai container dan tidak menyimpan state
 */
class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  /* Fungsi ini membangun widget root untuk halaman favorit
   * 
   * Parameter:
   * - context: Konteks build dari framework Flutter
   * 
   * Return: Widget MaterialApp yang menampilkan halaman daftar favorit
   */
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,        // Sembunyikan banner debug
      theme: ThemeData(
        primaryColor: const Color(0xFFA0B25E),  // Warna primer hijau muda
        scaffoldBackgroundColor: const Color(0xFFF8F8F8), // Background abu-abu muda
      ),
      home: ItemCategory(),                     // Menampilkan halaman kategori item favorit
    );
  }
}

/** Widget ItemCategory
 * 
 * Deskripsi:
 * - Widget utama yang menampilkan daftar barang favorit pengguna
 * - Menampilkan barang beserta informasi harga, rating, dan tombol aksi
 * - Merupakan StatefulWidget karena perlu mengelola state seperti daftar favorit
 *   dan aksi penghapusan favorit
 */
class ItemCategory extends StatefulWidget {
  ItemCategory({Key? key}) : super(key: key);

  @override
  _ItemCategoryState createState() => _ItemCategoryState();
}

/** State untuk widget ItemCategory
 * 
 * Deskripsi:
 * - Mengelola state dan data untuk halaman daftar barang favorit
 * - Menyimpan data dummy barang-barang favorit
 */
class _ItemCategoryState extends State<ItemCategory> {
  // Daftar barang favorit (dummy data)
  final List<Map<String, dynamic>> trendingItems = [
    {
      "name": "Tenda Camping",               // Nama barang
      "price": 300000,                       // Harga barang
      "image": "images/assets_ItemDetails/tenda_bg1.png", // Path gambar
      "rating": 4.5,                         // Rating barang
      "isFavorite": true                     // Status favorit
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

  List<String> selectedCategories = [];
  RangeValues priceRange = const RangeValues(0, 1000000);
  List<int> selectedRatings = [];
  List<String> selectedLocations = [];
  List<String> selectedBrands = [];

  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
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
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavBar(context, currentIndex: 3),
    );
  }

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

  Widget _buildTrendingItem(Map<String, dynamic> item, BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DetailItem()),
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
        // Categories
        FilterSection(
          title: "Categories",
          items: ["Tenda", "Alat Masak", "Sepatu", "Tas", "Aksesoris", "Pakaian"],
          selectedItems: selectedCategories,
          onSelected: (item) {
            selectedCategories.add(item);
          },
        ),
        // Price
        FilterSection(
          title: "Price",
          items: [
            'Rp. 100.000 - Rp. 500.000',
            'Rp. 500.000 - Rp. 1.000.000',
            'Rp. 1.000.000 - Rp. 2.000.000',
          ],
          selectedItems: [],
          onSelected: (item) {
            // Handle Price Filter
          },
        ),
      ],
    );
  }
}

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