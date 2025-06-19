/// File         : itemCategory.dart
/// Dibuat oleh  : Izzuddin Azzam, Al Ghifari
/// Tanggal      : 16-06-2025
/// Deskripsi    : File ini berisi halaman yang menampilkan daftar produk dalam kategori tertentu dengan fitur filter harga dan rating.
/// Dependencies :
/// - detailItem.dart: digunakan untuk berpindah ke halaman detail produk saat item diklik.
/// - navbar.dart: digunakan untuk menampilkan navigasi bawah pada halaman.
library;

import 'package:flutter/material.dart';
import '../detail_items/detailItem.dart';
import '../components/navbar.dart';

void main() {
  runApp(const ItemCategoryApp());
}

/// Widget ItemCategoryApp
/// * Deskripsi:
/// - Widget utama yang berfungsi sebagai root atau pembungkus aplikasi untuk halaman kategori item.
/// - Mengatur konfigurasi global seperti tema dan halaman awal untuk lingkup halaman ini.
/// - Merupakan StatelessWidget karena tidak memerlukan perubahan state internal.
class ItemCategoryApp extends StatelessWidget {
  const ItemCategoryApp({super.key});

  /* Fungsi ini membangun widget root untuk halaman kategori item.
   * * Parameter:
   * - context: Menyediakan informasi tentang lokasi widget dalam struktur aplikasi.
   * * Return: Menghasilkan widget MaterialApp dengan pengaturan tema dan ItemCategory sebagai halaman utama.
   */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Menyembunyikan banner debug
      debugShowCheckedModeBanner: false,
      // Konfigurasi tema
      theme: ThemeData(
        primaryColor: const Color(0xFFA0B25E),
        scaffoldBackgroundColor: const Color(0xFFF8F8F8),
      ),
      // Menetapkan ItemCategory sebagai halaman utama
      home: const ItemCategory(),
    );
  }
}

/// Widget ItemCategory
/// * Deskripsi:
/// - Widget yang menampilkan halaman daftar produk untuk kategori tertentu (contoh: "Tenda").
/// - Dilengkapi dengan fitur pencarian dan filter.
/// - Merupakan StatefulWidget karena perlu menyimpan dan mengelola state filter seperti rentang harga dan rating yang dapat diubah oleh pengguna.
class ItemCategory extends StatefulWidget {
  const ItemCategory({super.key});

  @override
  ItemCategoryState createState() => ItemCategoryState();
}

/// State untuk widget ItemCategory
/// * Deskripsi:
/// - Mengelola semua state dan logika untuk halaman ItemCategory.
/// - Menyimpan data produk, nilai filter, dan mengimplementasikan fungsi untuk menerapkan filter serta menampilkan dialog.
class ItemCategoryState extends State<ItemCategory> {
  // Variabel untuk menyimpan nilai filter
  double minPrice = 0;
  double maxPrice = 500000;
  double minRating = 0;
  double maxRating = 5;

  // Data dummy untuk semua item dalam kategori
  final List<Map<String, dynamic>> allItems = [
    {
      "name": "Tenda Camping",
      "price": 300000,
      "image": "images/assets_ItemDetails/tenda_bg1.png",
      "rating": 4.5
    },
    {
      "name": "Kompor Portable",
      "price": 150000,
      "image": "images/assets_ItemDetails/tenda_bg2.png",
      "rating": 4.3
    },
    {
      "name": "Sepatu Gunung",
      "price": 250000,
      "image": "images/assets_ItemDetails/tenda_bg3.png",
      "rating": 4.7
    },
    {
      "name": "Tas Gunung",
      "price": 350000,
      "image": "images/assets_ItemDetails/tenda_bg4.png",
      "rating": 4.0
    },
    {
      "name": "Senter LED",
      "price": 120000,
      "image": "images/assets_ItemDetails/tenda_bg5.png",
      "rating": 4.8
    },
    {
      "name": "Jaket Gunung",
      "price": 400000,
      "image": "images/assets_ItemDetails/tenda_bg6.png",
      "rating": 4.2
    },
  ];

  // List untuk menyimpan item yang telah difilter dan akan ditampilkan di UI
  late List<Map<String, dynamic>> filteredItems;

  /* Fungsi ini dijalankan sekali saat state pertama kali dibuat.
   * * Menginisialisasi filteredItems dengan semua data dari allItems.
   */
  @override
  void initState() {
    super.initState();
    // Inisialisasi daftar item yang akan ditampilkan dengan semua item
    filteredItems = List.from(allItems);
  }

  /* Fungsi ini menerapkan filter pada daftar item.
   * * Memperbarui state filteredItems berdasarkan kriteria rentang harga dan rating yang dipilih.
   */
  void _applyFilter() {
    setState(() {
      filteredItems = allItems.where((item) {
        final price = item['price'];
        final rating = item['rating'];
        // Kondisi untuk memfilter item
        return price >= minPrice &&
            price <= maxPrice &&
            rating >= minRating &&
            rating <= maxRating;
      }).toList();
    });
  }

  /* Fungsi ini menampilkan dialog (popup) untuk mengatur filter.
   * * Dialog ini berisi slider untuk rentang harga dan rating.
   */
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // AlertDialog sebagai container popup
        return AlertDialog(
          title: const Text('Filter'),
          // Konten dialog yang dapat di-scroll
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label untuk filter harga
                const Text('Price Range'),
                // Slider untuk memilih rentang harga
                RangeSlider(
                  values: RangeValues(minPrice, maxPrice),
                  min: 0,
                  max: 500000,
                  onChanged: (values) {
                    setState(() {
                      minPrice = values.start;
                      maxPrice = values.end;
                    });
                  },
                ),
                const SizedBox(height: 20),
                // Label untuk filter rating
                const Text('Rating Range'),
                // Slider untuk memilih rentang rating
                RangeSlider(
                  values: RangeValues(minRating, maxRating),
                  min: 0,
                  max: 5,
                  onChanged: (values) {
                    setState(() {
                      minRating = values.start;
                      maxRating = values.end;
                    });
                  },
                ),
              ],
            ),
          ),
          // Tombol aksi pada dialog
          actions: [
            // Tombol untuk menerapkan filter
            TextButton(
              onPressed: () {
                _applyFilter();
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
            // Tombol untuk mereset filter ke nilai default
            TextButton(
              onPressed: () {
                setState(() {
                  minPrice = 0;
                  maxPrice = 500000;
                  minRating = 0;
                  maxRating = 5;
                });
                _applyFilter();
                Navigator.pop(context);
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  /* Fungsi ini membangun seluruh UI halaman kategori item.
   * * Parameter:
   * - context: Digunakan untuk navigasi dan akses ke tema aplikasi.
   * * Return: Menghasilkan widget Scaffold lengkap dengan AppBar, body berisi daftar item, dan navigasi bawah.
   */
  @override
  Widget build(BuildContext context) {
    // Scaffold sebagai kerangka utama halaman
    return Scaffold(
      // AppBar halaman
      appBar: AppBar(
        backgroundColor: const Color(0xFFA0B25E),
        elevation: 0,
        // Tombol kembali
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        // Tombol aksi di AppBar untuk sort dan filter
        actions: [
          IconButton(
            icon: const Icon(Icons.sort, color: Colors.black),
            onPressed: _showFilterDialog, // Memanggil dialog filter
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: _showFilterDialog, // Memanggil dialog filter
          ),
        ],
      ),
      // Body halaman disusun dalam Column
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Widget Text untuk menampilkan nama kategori
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Tent Category',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // Widget Text untuk menampilkan jumlah item
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '87 Items',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Widget TextField untuk fungsionalitas pencarian
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search here',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Expanded agar GridView mengisi sisa ruang yang tersedia
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              // GridView untuk menampilkan item-item yang sudah difilter
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: filteredItems.length,
                // Membangun setiap kartu item
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  // Logika dummy untuk status 'liked'
                  final isLiked = index == 3 ||
                      index ==
                          6; // GestureDetector agar kartu dapat diklik untuk ke halaman detail
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailItem(barangId: item['id'] ?? 1),
                        ),
                      );
                    },
                    // Container sebagai kartu item dengan gambar latar
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(item['image']), // Gambar item
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Stack untuk menumpuk elemen di atas gambar
                      child: Stack(
                        children: [
                          // Ikon 'favorite' di pojok kanan atas
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Icon(
                              Icons.favorite,
                              color: isLiked ? Colors.red : Colors.white,
                              size: 28,
                            ),
                          ),
                          // Informasi item di bagian bawah
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Widget Text untuk menampilkan nama item
                                  Text(
                                    item['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Widget Text untuk menampilkan harga item
                                      Text(
                                        '\$${item['price']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      // Row untuk menampilkan rating
                                      Row(
                                        children: [
                                          const Icon(Icons.star,
                                              color: Colors.amber, size: 16),
                                          const SizedBox(width: 4),
                                          // Widget Text untuk menampilkan nilai rating
                                          Text(
                                            '${item['rating']}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
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
                },
              ),
            ),
          ),
        ],
      ),
      // Navigasi bawah halaman
      bottomNavigationBar: buildBottomNavBar(
        context,
        currentIndex: 1,
      ),
    );
  }
}
