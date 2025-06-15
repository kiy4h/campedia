/*
* File : itemCategory.dart
* Deskripsi : Halaman yang menampilkan daftar item berdasarkan kategori dengan fitur filter
* Dependencies : 
*   - detailItem.dart: untuk navigasi ke halaman detail item
*   - navbar.dart: untuk komponen navigasi
*/

import 'package:flutter/material.dart';
import '../detail_items/detailItem.dart';
import '../components/navbar.dart';

void main() {
  runApp(const ItemCategoryApp());
}

/*
* Class : ItemCategoryApp
* Deskripsi : Widget aplikasi utama untuk halaman kategori item
* Bagian Layar : Root aplikasi untuk halaman kategori item
*/
class ItemCategoryApp extends StatelessWidget {
  const ItemCategoryApp({super.key});
  /*
  * Method : build
  * Deskripsi : Membangun widget aplikasi untuk kategori item
  * Parameter : context - BuildContext untuk akses ke fitur framework
  * Return : Widget MaterialApp yang berisi ItemCategory
  */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFA0B25E),
        scaffoldBackgroundColor: const Color(0xFFF8F8F8),
      ),
      home: const ItemCategory(),
    );
  }
}

/*
* Class : ItemCategory
* Deskripsi : Widget halaman kategori item, merupakan StatefulWidget
* Bagian Layar : Halaman utama kategori item dengan fitur filter
*/
class ItemCategory extends StatefulWidget {
  const ItemCategory({super.key});

  @override
  _ItemCategoryState createState() => _ItemCategoryState();
}

/*
* Class : _ItemCategoryState
* Deskripsi : State untuk widget ItemCategory
* Bagian Layar : Mengelola state dan tampilan halaman kategori item
*/
class _ItemCategoryState extends State<ItemCategory> {
  // Filter variables
  double minPrice = 0;
  double maxPrice = 500000;
  double minRating = 0;
  double maxRating = 5;

  // Data barang
  final List<Map<String, dynamic>> allItems = [
    {"name": "Tenda Camping", "price": 300000, "image": "images/assets_ItemDetails/tenda_bg1.png", "rating": 4.5},
    {"name": "Kompor Portable", "price": 150000, "image": "images/assets_ItemDetails/tenda_bg2.png", "rating": 4.3},
    {"name": "Sepatu Gunung", "price": 250000, "image": "images/assets_ItemDetails/tenda_bg3.png", "rating": 4.7},
    {"name": "Tas Gunung", "price": 350000, "image": "images/assets_ItemDetails/tenda_bg4.png", "rating": 4.0},
    {"name": "Senter LED", "price": 120000, "image": "images/assets_ItemDetails/tenda_bg5.png", "rating": 4.8},
    {"name": "Jaket Gunung", "price": 400000, "image": "images/assets_ItemDetails/tenda_bg6.png", "rating": 4.2},
  ];

  // Daftar barang yang difilter
  late List<Map<String, dynamic>> filteredItems;
  /*
  * Method : initState
  * Deskripsi : Inisialisasi state awal
  * Parameter : -
  * Return : void
  */
  @override
  void initState() {
    super.initState();
    filteredItems = List.from(allItems); // Initialize filtered items
  }

  /*
  * Method : _applyFilter
  * Deskripsi : Memfilter item berdasarkan harga dan rating yang dipilih
  * Parameter : -
  * Return : void
  */
  void _applyFilter() {
    setState(() {
      filteredItems = allItems.where((item) {
        return item['price'] >= minPrice &&
            item['price'] <= maxPrice &&
            item['rating'] >= minRating &&
            item['rating'] <= maxRating;
      }).toList();
    });
  }
  /*
  * Method : _showFilterDialog
  * Deskripsi : Menampilkan dialog untuk memfilter item berdasarkan harga dan rating
  * Parameter : -
  * Return : void
  */
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Price Range'),
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
                const Text('Rating Range'),
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
          actions: [
            TextButton(
              onPressed: () {
                _applyFilter();
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
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
  /*
  * Method : build
  * Deskripsi : Membangun UI untuk halaman kategori item
  * Parameter : context - BuildContext untuk akses ke fitur framework
  * Return : Widget Scaffold berisi konten halaman kategori item
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA0B25E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort, color: Colors.black),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  final isLiked = index == 3 || index == 6;
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
                            child: Icon(
                              Icons.favorite,
                              color: isLiked ? Colors.red : Colors.white,
                              size: 28,
                            ),
                          ),
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
                                  Text(
                                    item['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$${item['price']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${item['rating']}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
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
      bottomNavigationBar: buildBottomNavBar(
        context,
        currentIndex: 1,
      ),
    );
  }
}
