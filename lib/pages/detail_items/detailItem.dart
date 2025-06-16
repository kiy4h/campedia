/**
 * File         : detailItem.dart
 * Dibuat oleh  : Izzuddin Azzam, Al Ghifari
 * Tanggal      : 16-06-2025
 * Deskripsi    : File ini berisi implementasi halaman detail barang yang menampilkan
 * informasi lengkap tentang suatu barang, seperti galeri gambar, deskripsi, harga, dan ulasan.
 * Ketergantungan (Dependencies) : 
 * - flutter/material.dart
 * - navbar.dart (komponen navigasi bawah)
 */

import 'package:flutter/material.dart';
import '../components/navbar.dart';

// Fungsi main untuk menjalankan aplikasi sebagai contoh standalone.
void main() => runApp(const MyApp());

/** Widget MyApp
 * * Deskripsi:
 * - Widget root untuk aplikasi demo, hanya digunakan saat file ini dijalankan secara terpisah.
 * - Menyediakan tema dan pengaturan dasar untuk halaman DetailItem.
 * - Merupakan StatelessWidget karena hanya berfungsi sebagai container dan tidak menyimpan state.
 */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /* Fungsi ini membangun widget root untuk aplikasi demo.
   * * Parameter:
   * - context: Konteks build dari framework Flutter.
   * * Return: Widget MaterialApp yang merupakan root dari aplikasi.
   */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Sembunyikan banner debug
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF8E1), // Background krem muda
      ),
      home: const DetailItem(), // Menampilkan halaman DetailItem
    );
  }
}

/** Widget DetailItem
 * * Deskripsi:
 * - Widget utama yang menampilkan halaman detail lengkap sebuah barang.
 * - Menampilkan carousel gambar, informasi produk, tab deskripsi/ulasan, dan opsi pembelian.
 * - Merupakan StatefulWidget karena perlu mengelola state seperti jumlah barang, halaman carousel, dan status favorit.
 */
class DetailItem extends StatefulWidget {
  const DetailItem({super.key});

  @override
  State<DetailItem> createState() => _DetailItemState();
}

/** State untuk widget DetailItem
 * * Deskripsi:
 * - Mengelola semua state dan logika interaktif untuk halaman detail barang.
 * - Menggunakan `SingleTickerProviderStateMixin` untuk menyediakan Ticker yang dibutuhkan oleh `TabController` untuk animasi perpindahan tab.
 */
class _DetailItemState extends State<DetailItem> with SingleTickerProviderStateMixin {
  // Controller untuk mengelola state dan animasi TabBar.
  late TabController _tabController;
  // Controller untuk mengelola state PageView (carousel gambar).
  late PageController _pageController;
  // State untuk menyimpan jumlah barang yang akan dipesan.
  int _quantity = 1;
  // State untuk menyimpan status favorit (disukai) dari barang.
  bool _isFavorite = true;
  // State untuk melacak indeks gambar yang sedang ditampilkan di carousel.
  int _currentImage = 0;

  // Daftar path gambar untuk carousel.
  final List<String> _images = [
    'images/assets_OnBoarding0/tenda_bg.png',
    'images/assets_ItemDetails/tenda_bg2.png',
    'images/assets_ItemDetails/tenda_bg3.png',
  ];

  /* Fungsi ini dijalankan sekali saat state pertama kali dibuat.
   * * Menginisialisasi semua controller yang dibutuhkan.
   */
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Inisialisasi TabController untuk 3 tab.
    _pageController = PageController(initialPage: _currentImage); // Inisialisasi PageController.
  }

  /* Fungsi ini dijalankan saat widget dihapus dari widget tree.
   * * Membersihkan resource dengan membuang controller untuk mencegah kebocoran memori (memory leak).
   */
  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  /* Fungsi ini membangun seluruh UI untuk halaman detail item.
   * * Parameter:
   * - context: Konteks build dari Flutter.
   * * Return: Widget Scaffold yang berisi seluruh tata letak halaman.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Memungkinkan body (gambar) untuk berada di belakang AppBar.
      extendBodyBehindAppBar: true,
      // AppBar dibuat transparan agar menyatu dengan gambar di belakangnya.
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
      // Body utama halaman.
      body: Column(
        children: [
          // Expanded agar NestedScrollView mengisi ruang yang tersedia.
          Expanded(
            // NestedScrollView digunakan untuk membuat efek scrolling yang kompleks,
            // di mana bagian header (gambar, info, tab) dapat scroll bersama dengan konten tab.
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bagian carousel gambar produk.
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        // PageView.builder untuk membuat carousel yang efisien.
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: _images.length,
                          onPageChanged: (index) => setState(() => _currentImage = index),
                          itemBuilder: (context, index) {
                            // Menampilkan gambar dari aset.
                            return Image.asset(_images[index], fit: BoxFit.contain, width: double.infinity);
                          },
                        ),
                      ),
                      // Indikator halaman (titik-titik) untuk carousel gambar.
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Membuat titik-titik indikator secara dinamis.
                          children: List.generate(
                            _images.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                              // Lebar indikator aktif lebih panjang.
                              width: index == _currentImage ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                // Warna indikator aktif lebih terang.
                                color: index == _currentImage ? Colors.white : Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Bagian informasi produk (nama, harga, rating).
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
                            // Row untuk rating dan tombol favorit.
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 20),
                                const SizedBox(width: 4),
                                const Text('4.5', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                const Text(' (128 reviews)', style: TextStyle(fontSize: 14, color: Colors.black54)),
                                const Spacer(), // Mendorong tombol favorit ke kanan.
                                // Tombol favorit yang mengubah state _isFavorite saat ditekan.
                                IconButton(
                                  icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red, size: 28),
                                  onPressed: () => setState(() => _isFavorite = !_isFavorite),
                                ),
                              ],
                            ),
                            // Row untuk menampilkan status ketersediaan barang.
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

                      // Widget TabBar untuk navigasi antara deskripsi, review, dan diskusi.
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
              // Body dari NestedScrollView berisi konten dari setiap tab.
              body: TabBarView(
                controller: _tabController,
                children: [
                  // Konten tab "Description".
                  const SingleChildScrollView(padding: EdgeInsets.all(20), child: Text('Naturehike Cloud Up 2 adalah tenda dome ringan dan praktis yang cocok untuk dua orang. Dibuat dari material berkualitas tinggi dan tahan air, tenda ini siap menemani petualangan kamu di alam terbuka — baik di gunung, pantai, maupun hutan.', style: TextStyle(fontSize: 15, height: 1.5))),
                  // Konten tab "Review".
                  SingleChildScrollView(padding: const EdgeInsets.all(20), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const CircleAvatar(backgroundImage: AssetImage('images/assets_Reviews/user1.png'), radius: 20), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Mira A. - Bandung', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), SizedBox(height: 4), Text('Tenda ringan banget dan gampang dipasang! Saya pakai untuk camping di Ranca Upas, hujan semalaman tetap kering. Recommended banget buat yang suka camping.', style: TextStyle(fontSize: 15, height: 1.5))]))])),
                  // Konten tab "Discussion".
                  const SingleChildScrollView(padding: EdgeInsets.all(20), child: Text('Belum ada diskusi untuk produk ini.')),
                ],
              ),
            ),
          ),

          // Bagian bawah halaman untuk kuantitas dan tombol "Add to Cart".
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
            child: Row(
              children: [
                const Text('QTY', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(width: 10),
                // Widget untuk menambah dan mengurangi kuantitas (stepper).
                Container(
                  decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      IconButton(icon: const Icon(Icons.remove), onPressed: () { if (_quantity > 1) setState(() => _quantity--); }, padding: EdgeInsets.zero, constraints: const BoxConstraints(), iconSize: 20),
                      SizedBox(width: 30, child: Center(child: Text('$_quantity', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)))),
                      IconButton(icon: const Icon(Icons.add), onPressed: () => setState(() => _quantity++), padding: EdgeInsets.zero, constraints: const BoxConstraints(), iconSize: 20),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                // Tombol "ADD TO CART".
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
      // Menampilkan Bottom Navigation Bar. `currentIndex` diatur ke 5 (di luar rentang) agar tidak ada yang aktif.
      bottomNavigationBar: buildBottomNavBar(context, currentIndex: 5),
    );
  }
}