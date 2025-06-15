/*
* File : itemCategory.dart
* Deskripsi : File ini berisi halaman yang menampilkan daftar produk dalam kategori tertentu dengan fitur filter harga dan rating
* Ketergantungan (Dependencies) : 
*   - detailItem.dart: digunakan untuk berpindah ke halaman detail produk saat item diklik
*   - navbar.dart: digunakan untuk menampilkan navigasi bawah pada halaman
*/

import 'package:flutter/material.dart';
import '../detail_items/detailItem.dart';
import '../components/navbar.dart';

void main() {
  runApp(const ItemCategoryApp());
}

/*
* Class : ItemCategoryApp
* Deskripsi : Kelas ini adalah widget utama yang berfungsi sebagai pembungkus aplikasi untuk halaman kategori item
* Jenis Widget : StatelessWidget karena tidak memerlukan perubahan status internal
* Bagian Layar : Mengatur keseluruhan tema dan pengaturan aplikasi untuk halaman kategori item
*/
class ItemCategoryApp extends StatelessWidget {
  const ItemCategoryApp({super.key});  /*
  * Method : build
  * Deskripsi : Metode ini mengatur tampilan dasar aplikasi dengan tema dan warna untuk halaman kategori item
  * Parameter : 
  *   - context: menyediakan informasi dasar tentang lokasi widget dalam struktur aplikasi
  * Nilai yang dihasilkan : 
  *   - Menghasilkan widget MaterialApp dengan pengaturan tema dan ItemCategory sebagai halaman utama
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
* Deskripsi : Kelas ini adalah widget halaman utama yang menampilkan daftar produk dalam kategori tenda dengan fitur filter
* Jenis Widget : StatefulWidget karena perlu menyimpan dan mengubah status filter harga dan rating
* Bagian Layar : Widget ini menampilkan seluruh konten halaman kategori item termasuk pencarian, filter, dan grid produk
*/
class ItemCategory extends StatefulWidget {
  const ItemCategory({super.key});

  @override
  _ItemCategoryState createState() => _ItemCategoryState();
}

/*
* Class : _ItemCategoryState
* Deskripsi : Kelas ini mengatur status dan logika untuk halaman kategori item, termasuk filter dan tampilan produk
* Jenis Widget : State dari StatefulWidget yang mengelola status filter harga dan rating
* Bagian Layar : Mengimplementasikan logika filter dan tampilan untuk item-item dalam kategori
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
  late List<Map<String, dynamic>> filteredItems;  /*
  * Method : initState
  * Deskripsi : Metode ini melakukan inisialisasi daftar item yang difilter saat halaman pertama kali dibuat
  * Parameter : 
  *   - (Tidak ada parameter)
  * Nilai yang dihasilkan : 
  *   - (Tidak mengembalikan nilai) Hanya mengatur nilai awal filteredItems dari daftar allItems 
  */
  @override
  void initState() {
    super.initState();
    filteredItems = List.from(allItems); // Initialize filtered items
  }
  /*
  * Method : _applyFilter
  * Deskripsi : Metode ini menerapkan filter pada daftar item berdasarkan rentang harga dan rating yang telah dipilih pengguna
  * Parameter : 
  *   - (Tidak ada parameter)
  * Nilai yang dihasilkan : 
  *   - (Tidak mengembalikan nilai) Memperbarui daftar filteredItems sesuai kriteria filter
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
  }  /*
  * Method : _showFilterDialog
  * Deskripsi : Metode ini menampilkan jendela popup dengan slider untuk memilih rentang harga dan rating produk
  * Parameter : 
  *   - (Tidak ada parameter)
  * Nilai yang dihasilkan : 
  *   - (Tidak mengembalikan nilai) Menampilkan dialog dengan slider filter dan tombol Apply/Reset
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
  }  /*
  * Method : build
  * Deskripsi : Metode ini membuat seluruh tampilan halaman kategori termasuk AppBar, judul kategori, kotak pencarian, dan grid item
  * Parameter : 
  *   - context: digunakan untuk navigasi dan akses ke tema aplikasi
  * Nilai yang dihasilkan : 
  *   - Menghasilkan widget Scaffold lengkap dengan daftar item dalam bentuk grid yang sudah difilter
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
