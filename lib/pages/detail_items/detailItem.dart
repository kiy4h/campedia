/**
 * File         : detailItem.dart
 * Dibuat oleh  : Izzuddin Azzam
 * Tanggal      : 15-06-2025
 * Deskripsi    : File ini berisi implementasi halaman detail barang yang menampilkan
 *                informasi lengkap tentang suatu barang, seperti gambar, deskripsi, dan harga
 * Dependencies : flutter/material.dart, navbar component
 */

import 'package:flutter/material.dart';
import '../components/navbar.dart';

void main() => runApp(const MyApp());

/** Widget MyApp
 * 
 * Deskripsi:
 * - Widget root untuk aplikasi ketika file dijalankan langsung (bukan sebagai bagian dari aplikasi utama)
 * - Menyediakan tema dan pengaturan dasar untuk halaman DetailItem
 * - Merupakan StatelessWidget karena hanya berfungsi sebagai container dan tidak menyimpan state
 */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  /* Fungsi ini membangun widget root untuk aplikasi
   * 
   * Parameter:
   * - context: Konteks build dari framework Flutter
   * 
   * Return: Widget MaterialApp yang merupakan root dari aplikasi
   */
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,         // Sembunyikan banner debug
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF8E1),  // Background krem muda
      ),
      home: const DetailItem(),                  // Menampilkan halaman DetailItem
    );
  }
}

/** Widget DetailItem
 * 
 * Deskripsi:
 * - Widget utama yang menampilkan detail lengkap sebuah barang
 * - Menampilkan carousel gambar, deskripsi, dan opsi pembelian barang
 * - Merupakan StatefulWidget karena perlu mengelola state seperti jumlah barang,
 *   halaman carousel, dan status favorit
 */
class DetailItem extends StatefulWidget {
  const DetailItem({super.key});

  @override
  State<DetailItem> createState() => _DetailItemState();
}

/** State untuk widget DetailItem
 * 
 * Deskripsi:
 * - Mengelola state dan data untuk halaman detail barang
 * - Menggunakan SingleTickerProviderStateMixin untuk animasi TabController
 */
class _DetailItemState extends State<DetailItem> with SingleTickerProviderStateMixin {
  late TabController _tabController;   // Controller untuk tab deskripsi dan review
  late PageController _pageController;  // Controller untuk carousel gambar
  int _quantity = 1;                    // Jumlah barang yang akan dibeli
  bool _isFavorite = true;              // Status favorit barang
  int _currentImage = 0;                // Indeks gambar saat ini dalam carousel

  // Paths ke aset gambar tenda
  final List<String> _images = [
    'images/assets_OnBoarding0/tenda_bg.png',
    'images/assets_ItemDetails/tenda_bg2.png',
    'images/assets_ItemDetails/tenda_bg3.png',
  ];

  @override
  /* Fungsi ini dijalankan saat widget pertama kali dibuat
   *
   * Menginisialisasi controller untuk tab dan page view
   */
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);  // Controller untuk 3 tab
    _pageController = PageController(initialPage: _currentImage);  // Controller untuk carousel gambar
  }

  @override
  /* Fungsi ini dijalankan saat widget dihapus dari widget tree
   *
   * Membersihkan resource dengan membuang controller
   * untuk mencegah memory leak
   */
  void dispose() {
    _tabController.dispose();  // Membuang TabController
    _pageController.dispose(); // Membuang PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.share, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Scrollable content: header image, info, tabs, and tab views
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Carousel Image section
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: _images.length,
                          onPageChanged: (index) => setState(() => _currentImage = index),
                          itemBuilder: (context, index) {
                            return Image.asset(
                              _images[index],
                              fit: BoxFit.contain,
                              width: double.infinity,
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _images.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                              width: index == _currentImage ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: index == _currentImage
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Info section
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('TENT', style: TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            const Text('Tenda Dome Naturehike', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            const Text('Rp 45.000 / hari', style: TextStyle(fontSize: 18, color: Colors.amber, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 20),
                                const SizedBox(width: 4),
                                const Text('4.5', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                const Text(' (128 reviews)', style: TextStyle(fontSize: 14, color: Colors.black54)),
                                const Spacer(),
                                IconButton(
                                  icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red, size: 28),
                                  onPressed: () => setState(() => _isFavorite = !_isFavorite),
                                ),
                              ],
                            ),
                            const Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.green, size: 18),
                                SizedBox(width: 4),
                                Text('Available · 3 items', style: TextStyle(fontSize: 14, color: Colors.black54)),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Tab bar
                      TabBar(
                        controller: _tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black45,
                        indicatorColor: Colors.amber,
                        indicatorWeight: 3,
                        tabs: const [
                          Tab(text: 'Description'),
                          Tab(text: 'Review'),
                          Tab(text: 'Discussion'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
              body: TabBarView(
                controller: _tabController,
                children: [
                  // Description
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      'Naturehike Cloud Up 2 adalah tenda dome ringan dan praktis yang cocok untuk dua orang. Dibuat dari material berkualitas tinggi dan tahan air, tenda ini siap menemani petualangan kamu di alam terbuka — baik di gunung, pantai, maupun hutan.',
                      style: TextStyle(fontSize: 15, height: 1.5),
                    ),
                  ),
                  // Review
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(backgroundImage: AssetImage('images/assets_Reviews/user1.png'), radius: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Mira A. - Bandung', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              SizedBox(height: 4),
                              Text('Tenda ringan banget dan gampang dipasang! Saya pakai untuk camping di Ranca Upas, hujan semalaman tetap kering. Recommended banget buat yang suka camping.', style: TextStyle(fontSize: 15, height: 1.5)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Discussion
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: const Text('Belum ada diskusi untuk produk ini.'),
                  ),
                ],
              ),
            ),
          ),

          // Bottom quantity and Add to Cart
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5)),
              ],
            ),
            child: Row(
              children: [
                const Text('QTY', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      IconButton(icon: const Icon(Icons.remove), onPressed: () { if (_quantity>1) setState(()=>_quantity--); }, padding: EdgeInsets.zero, constraints: const BoxConstraints(), iconSize: 20),
                      SizedBox(width: 30, child: Center(child: Text('$_quantity', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)))),
                      IconButton(icon: const Icon(Icons.add), onPressed: ()=> setState(()=>_quantity++), padding: EdgeInsets.zero, constraints: const BoxConstraints(), iconSize: 20),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: const Text('ADD TO CART', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavBar(context, currentIndex: 5),

    );
  }
}
