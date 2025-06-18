/// File         : detailItem.dart
/// Dibuat oleh  : Izzuddin Azzam, Al Ghifari
/// Tanggal      : 16-06-2025
/// Deskripsi    : File ini berisi implementasi halaman detail barang yang menampilkan
/// informasi lengkap tentang suatu barang, seperti galeri gambar, deskripsi, harga, dan ulasan.
/// Ketergantungan (Dependencies) :
/// - flutter/material.dart
/// - navbar.dart (komponen navigasi bawah)
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../components/navbar.dart';
import '../../providers/detail_barang_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../models/models.dart';

// Fungsi main untuk menjalankan aplikasi sebagai contoh standalone.
void main() => runApp(const MyApp());

/// Widget MyApp
/// * Deskripsi:
/// - Widget root untuk aplikasi demo, hanya digunakan saat file ini dijalankan secara terpisah.
/// - Menyediakan tema dan pengaturan dasar untuk halaman DetailItem.
/// - Merupakan StatelessWidget karena hanya berfungsi sebagai container dan tidak menyimpan state.
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
        scaffoldBackgroundColor:
            const Color(0xFFFFF8E1), // Background krem muda
      ),
      home: const DetailItem(
          barangId: 1), // Menampilkan halaman DetailItem dengan example ID
    );
  }
}

/// Widget DetailItem
/// * Deskripsi:
/// - Widget utama yang menampilkan halaman detail lengkap sebuah barang.
/// - Menampilkan carousel gambar, informasi produk, tab deskripsi/ulasan, dan opsi pembelian.
/// - Merupakan StatefulWidget karena perlu mengelola state seperti jumlah barang, halaman carousel, dan status favorit.
class DetailItem extends StatefulWidget {
  final int barangId;

  const DetailItem({super.key, required this.barangId});

  @override
  State<DetailItem> createState() => _DetailItemState();
}

/// State untuk widget DetailItem
/// * Deskripsi:
/// - Mengelola semua state dan logika interaktif untuk halaman detail barang.
/// - Menggunakan `SingleTickerProviderStateMixin` untuk menyediakan Ticker yang dibutuhkan oleh `TabController` untuk animasi perpindahan tab.
class _DetailItemState extends State<DetailItem>
    with SingleTickerProviderStateMixin {
  // Controller untuk mengelola state dan animasi TabBar.
  late TabController _tabController;
  // Controller untuk mengelola state PageView (carousel gambar).
  late PageController _pageController;
  // State untuk menyimpan jumlah barang yang akan dipesan.
  int _quantity = 1;
  // State untuk menyimpan status favorit (disukai) dari barang.
  bool _isFavorite = false;
  // State untuk melacak indeks gambar yang sedang ditampilkan di carousel.
  int _currentImage = 0;

  /* Fungsi ini dijalankan sekali saat state pertama kali dibuat.
   * * Menginisialisasi semua controller yang dibutuhkan dan memuat data barang.
   */
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3, vsync: this); // Inisialisasi TabController untuk 3 tab.
    _pageController = PageController(
        initialPage: _currentImage); // Inisialisasi PageController.
    _loadItemDetail();
  }

  /* Fungsi ini memuat detail barang dari API.
   */
  void _loadItemDetail() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final detailProvider =
        Provider.of<DetailBarangProvider>(context, listen: false);

    if (authProvider.isAuthenticated) {
      detailProvider.fetchDetailBarang(
          widget.barangId, authProvider.user!.userId);
    }
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
          IconButton(
              icon: const Icon(Icons.share, color: Colors.white),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {}),
        ],
      ),
      // Body utama halaman dengan Consumer untuk DetailBarangProvider
      body: Consumer<DetailBarangProvider>(
        builder: (context, detailProvider, child) {
          if (detailProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          }

          if (detailProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${detailProvider.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadItemDetail,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final DetailBarang? barang = detailProvider.detailBarang;
          if (barang == null) {
            return const Center(
              child: Text('No item data available'),
            );
          }

          // Update favorite status from API data
          _isFavorite = barang.isWishlist ?? false;

          // Get images from API or use default placeholder
          final List<String> images =
              barang.fotoList?.map((foto) => foto.foto).toList() ??
                  (barang.foto != null ? [barang.foto!] : []);

          return Column(
            children: [
              // Expanded agar NestedScrollView mengisi ruang yang tersedia.
              Expanded(
                // NestedScrollView digunakan untuk membuat efek scrolling yang kompleks
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Bagian carousel gambar produk.
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: images.isNotEmpty
                                ? PageView.builder(
                                    controller: _pageController,
                                    itemCount: images.length,
                                    onPageChanged: (index) =>
                                        setState(() => _currentImage = index),
                                    itemBuilder: (context, index) {
                                      return Image.network(
                                        images[index],
                                        fit: BoxFit.contain,
                                        width: double.infinity,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey[200],
                                            child: const Icon(
                                              Icons.image_not_supported,
                                              size: 64,
                                              color: Colors.grey,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )
                                : Container(
                                    color: Colors.grey[200],
                                    child: const Icon(
                                      Icons.image_not_supported,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                  ),
                          ),
                          // Indikator halaman (titik-titik) untuk carousel gambar.
                          if (images.isNotEmpty)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  images.length,
                                  (index) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 8),
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
                          // Bagian informasi produk (nama, harga, rating).
                          _buildProductInfo(barang),
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
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          barang.deskripsi.isNotEmpty
                              ? barang.deskripsi
                              : 'No description available.',
                          style: const TextStyle(fontSize: 15, height: 1.5),
                        ),
                      ),
                      // Konten tab "Review".
                      _buildReviewTab(barang),
                      // Konten tab "Discussion".
                      const SingleChildScrollView(
                        padding: EdgeInsets.all(20),
                        child: Text('Belum ada diskusi untuk produk ini.'),
                      ),
                    ],
                  ),
                ),
              ),
              // Bagian bawah halaman untuk kuantitas dan tombol "Add to Cart".
              _buildBottomSection(barang),
            ],
          );
        },
      ),
      // Menampilkan Bottom Navigation Bar.
      bottomNavigationBar: buildBottomNavBar(context, currentIndex: 5),
    );
  }

  /* Fungsi ini membangun bagian informasi produk.
   */
  Widget _buildProductInfo(DetailBarang barang) {
    // Get category name helper function
    String getCategoryName(int categoryId) {
      Map<int, String> categoryMap = {
        1: "TENT",
        2: "COOKING",
        3: "SHOES",
        4: "BAG",
        5: "ACCESSORIES",
        6: "CLOTHING",
      };
      return categoryMap[categoryId] ?? "OTHER";
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getCategoryName(barang.kategoriId),
            style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            barang.namaBarang,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            '${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(barang.hargaPerhari)} / hari',
            style: const TextStyle(
                fontSize: 18, color: Colors.amber, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // Row untuk rating dan tombol favorit.
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(
                barang.meanReview.toStringAsFixed(1),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                ' (${barang.totalReview} reviews)',
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const Spacer(),
              // Tombol favorit
              IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                  size: 28,
                ),
                onPressed: () => setState(() => _isFavorite = !_isFavorite),
              ),
            ],
          ),
          // Row untuk menampilkan status ketersediaan barang.
          Row(
            children: [
              Icon(
                barang.stok > 0 ? Icons.check_circle : Icons.cancel,
                color: barang.stok > 0 ? Colors.green : Colors.red,
                size: 18,
              ),
              const SizedBox(width: 4),
              Text(
                barang.stok > 0
                    ? 'Available · ${barang.stok} items'
                    : 'Out of stock',
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /* Fungsi ini membangun tab review.
   */
  Widget _buildReviewTab(DetailBarang barang) {
    if (barang.reviews == null || barang.reviews!.isEmpty) {
      return const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Text('Belum ada review untuk produk ini.'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: barang.reviews!.map((review) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 20,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${review.namaUser} - ${review.waktuPembuatan}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < review.rating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        review.ulasan,
                        style: const TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  /* Fungsi ini membangun bagian bawah halaman.
   */
  Widget _buildBottomSection(DetailBarang barang) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text('QTY',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(width: 10),
          // Widget untuk menambah dan mengurangi kuantitas (stepper).
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (_quantity > 1) setState(() => _quantity--);
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  iconSize: 20,
                ),
                SizedBox(
                  width: 30,
                  child: Center(
                    child: Text(
                      '$_quantity',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => _quantity++),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  iconSize: 20,
                ),
              ],
            ),
          ),
          const SizedBox(width: 20), // Tombol "ADD TO CART".
          Expanded(
            child: ElevatedButton(
              onPressed: barang.stok > 0
                  ? () async {
                      final authProvider =
                          Provider.of<AuthProvider>(context, listen: false);
                      final cartProvider =
                          Provider.of<CartProvider>(context, listen: false);

                      if (!authProvider.isAuthenticated ||
                          authProvider.user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please login first to add items to cart'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      final success = await cartProvider.addToCart(
                        authProvider.user!.userId,
                        widget.barangId,
                        _quantity,
                      );

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Added $_quantity ${barang.namaBarang} to cart!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                cartProvider.error ?? 'Failed to add to cart'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                'ADD TO CART',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
