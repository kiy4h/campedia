/// File         : home.dart
/// Dibuat oleh  : Izzuddin Azzam, Al Ghifari
/// Tanggal      : 16-06-2025
/// Deskripsi    : File ini berisi implementasi halaman beranda (home) aplikasi Campedia
/// yang menampilkan salam pengguna, pencarian, slider fitur, kategori, dan daftar barang yang sedang tren.
/// Dependencies : flutter/material.dart, intl, google_fonts, provider
library;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tugas3provis/pages/all_items/allListItem.dart';
import '../all_items/category.dart';
import '../detail_items/detailItem.dart';
import 'recommendedGearTrip.dart';
import '../components/navbar.dart';
import '../components/product_card.dart';
import 'notification.dart';
import '../../providers/auth_provider.dart';
import '../../providers/barang_provider.dart';

// Fungsi main untuk menjalankan aplikasi sebagai contoh
void main() {
  runApp(const CampingApp());
}

/// Widget CampingApp
/// * Deskripsi:
/// - Widget utama yang menjadi root aplikasi untuk halaman beranda.
/// - Mengatur tema global, termasuk warna primer, warna latar, dan jenis font.
/// - Merupakan StatelessWidget karena hanya berfungsi sebagai container konfigurasi dan tidak mengelola state.
class CampingApp extends StatelessWidget {
  const CampingApp({super.key});

  /* Fungsi ini membangun widget root untuk aplikasi.
   * * Parameter:
   * - context: Konteks build dari framework Flutter.
   * * Return: Widget MaterialApp yang merupakan root dari aplikasi dengan tema yang telah dikonfigurasi.
   */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Konfigurasi tema aplikasi
      theme: ThemeData(
        primaryColor: const Color(0xFF2E7D32), // Warna primer hijau
        scaffoldBackgroundColor:
            const Color(0xFFF8F8F8), // Background abu-abu muda
        textTheme: GoogleFonts.poppinsTextTheme(), // Menggunakan font Poppins
      ),
      // Menetapkan HomePage sebagai halaman utama
      home: HomePage(),
      // Menyembunyikan banner debug
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Widget HomePage
/// * Deskripsi:
/// - Widget yang menampilkan seluruh konten halaman beranda.
/// - Menampilkan fitur utama seperti barang rekomendasi, kategori, dan daftar barang tren.
/// - Merupakan StatefulWidget karena perlu memuat data dari API saat halaman diinisialisasi.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

/// State untuk widget HomePage
/// * Deskripsi:
/// - Mengelola state, data, dan logika untuk halaman beranda.
/// - Memuat data barang dari API melalui provider saat state diinisialisasi.
/// - Berisi data statis sebagai fallback jika data dari API gagal dimuat.
class HomePageState extends State<HomePage> {
  /* Fungsi ini dijalankan saat state widget pertama kali dibuat.
   * * Menggunakan addPostFrameCallback untuk memastikan _loadData() dipanggil setelah frame pertama selesai dirender.
   */
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  /* Fungsi ini memicu pemuatan data barang dari API.
   * * Menggunakan AuthProvider untuk memeriksa status login dan BarangProvider untuk mengambil data barang beranda.
   */
  void _loadData() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final barangProvider = Provider.of<BarangProvider>(context, listen: false);

    // Jika pengguna sudah terautentikasi, ambil data dari API
    if (authProvider.isAuthenticated) {
      barangProvider.fetchBarangBeranda(authProvider.user!.userId);
    }
  }

  // Data statis untuk item tren sebagai fallback
  final List<Map<String, dynamic>> trendingItems = [
    {
      "name": "Tenda",
      "image": 'images/assets_ItemDetails/tenda1.png',
      "price": 500000,
      "rating": 4.3,
      "color": Color(0xFFFF9800),
    },
    {
      "name": "Kompor",
      "image": 'images/assets_ItemDetails/kompor1.png',
      "price": 200000,
      "rating": 4.3,
      "color": Color(0xFFE53935),
    },
    {
      "name": "Sepatu",
      "image": 'images/assets_ItemDetails/sepatu1.png',
      "price": 300000,
      "rating": 4.3,
      "color": Color(0xFF8D6E63),
    },
    {
      "name": "Tas Leather",
      "image": 'images/assets_ItemDetails/tas1.png',
      "price": 600000,
      "rating": 4.3,
      "color": Color(0xFF795548),
    },
  ];
  // Data statis untuk kategori - menggunakan endpoint API
  final List<Map<String, String>> categories = [
    {
      "icon": "http://localhost:8000/images/assets_Categories/cat_Kompor.png",
      "name": "Kompor"
    },
    {
      "icon": "http://localhost:8000/images/assets_Categories/cat_Tenda.png",
      "name": "Tenda"
    },
    {
      "icon": "http://localhost:8000/images/assets_Categories/cat_Sepatu.png",
      "name": "Sepatu"
    },
    {
      "icon": "http://localhost:8000/images/assets_Categories/cat_Tas.png",
      "name": "Tas"
    },
    {
      "icon": "http://localhost:8000/images/assets_Categories/cat_Senter.png",
      "name": "Senter"
    },
    {
      "icon": "http://localhost:8000/images/assets_Categories/cat_Jaket.png",
      "name": "Jaket"
    },
    {
      "icon":
          "http://localhost:8000/images/assets_Categories/cat_KeamananNavigasi.png",
      "name": "Keamanan"
    },
    {
      "icon":
          "http://localhost:8000/images/assets_Categories/cat_FasilitasTambahan.png",
      "name": "Lainnya"
    },
  ];
  // Data statis untuk slider fitur
  final List<Map<String, dynamic>> featuredSlides = [
    {
      "key": "1",
      "title": "Recommended\nGear Trip",
      "image":
          "http://localhost:8000/images/assets_DestinationCamp/gunung1.jpg",
      "color": Colors.black.withValues(alpha: 0.6),
    },
    {
      "key": "2",
      "title": "Fresh Trending\nGear",
      "image":
          "http://localhost:8000/images/assets_DestinationCamp/gunung2.jpg",
      "color": Colors.black.withValues(alpha: 0.6),
    },
  ];

  /* Fungsi ini membangun seluruh UI untuk halaman beranda.
   * * Parameter:
   * - context: Digunakan untuk navigasi dan mengakses provider.
   * * Return: Widget Scaffold yang berisi seluruh tata letak halaman beranda.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Consumer2 untuk mendengarkan perubahan pada AuthProvider dan BarangProvider
        child: Consumer2<AuthProvider, BarangProvider>(
          builder: (context, authProvider, barangProvider, child) {
            // ListView sebagai layout utama yang dapat di-scroll
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              children: [
                // Bagian header berisi search bar dan salam pengguna
                _buildHeader(context),
                const SizedBox(height: 20),
                // Bagian slider untuk fitur yang direkomendasikan
                _buildMountainSection(),
                const SizedBox(height: 24),
                // Bagian untuk menampilkan kategori produk
                _buildCategoriesSection(context),
                const SizedBox(height: 24),
                // Bagian untuk menampilkan produk yang sedang tren
                _buildTrendingDealsSection(barangProvider),
                const SizedBox(height: 24),
                // Tombol 'More' untuk melihat semua produk
                _buildMoreButton(context),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
      // Navigasi bawah halaman
      bottomNavigationBar: buildBottomNavBar(
        context,
        currentIndex: 0, // Menandakan halaman 'Home' sedang aktif
      ),
    );
  }

  /* Fungsi ini membangun bagian header halaman.
   * * Parameter:
   * - context: Dibutuhkan untuk navigasi.
   * * Return: Widget Column yang berisi search bar, salam, nama pengguna, dan ikon notifikasi.
   */
  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Widget Container untuk search bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 8),
              // Widget TextField untuk input pencarian
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Cari kebutuhan Kemah...',
                    border: InputBorder.none,
                  ),
                  // Navigasi ke halaman daftar semua item saat pencarian di-submit
                  onSubmitted: (value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllItemList(keyword: value)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Widget Text untuk salam pagi
        Text(
          'Selamat Datang',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Widget Text untuk menampilkan nama pengguna (saat ini statis)
            const Text(
              'Izzuddin Azzam', // Nama pengguna bisa dibuat dinamis dari AuthProvider
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            // Stack untuk ikon notifikasi dengan badge
            Stack(
              children: [
                // Ikon notifikasi yang dapat diklik
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationPage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.notifications_none,
                        size: 24, color: Colors.black87),
                  ),
                ),
                // Badge notifikasi (titik merah)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /* Fungsi ini membangun slider horizontal untuk fitur unggulan.
   * * Parameter:
   * - context: Dibutuhkan untuk navigasi.
   * * Return: Widget SizedBox berisi ListView horizontal.
   */
  Widget _buildMountainSection() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const GunungDestinationPage()),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[600]!, Colors.green[400]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.landscape, color: Colors.white, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Destinasi Gunung',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Jelajahi perlengkapan untuk pegunungan tertentu',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }

  /* Fungsi ini membangun bagian kategori.
   * * Parameter:
   * - context: Dibutuhkan untuk navigasi.
   * * Return: Widget Column yang berisi judul "Categories" dan daftar kategori horizontal.
   */
  Widget _buildCategoriesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Judul bagian
            const Text(
              'Kategori',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            // Tombol panah untuk melihat semua kategori
            IconButton(
              icon: const Icon(Icons.arrow_forward, size: 22),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CategoryPage()));
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        // ListView horizontal untuk item-item kategori
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return _buildCategoryItem(categories[index], context);
            },
          ),
        ),
      ],
    );
  }

  /* Fungsi ini membangun satu item kategori.
   * * Parameter:
   * - category: Map berisi data ikon dan nama kategori.
   * - context: Dibutuhkan untuk navigasi.
   * * Return: Widget GestureDetector yang berisi visual satu item kategori.
   */
  Widget _buildCategoryItem(
      Map<String, String> category, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman kategori saat item diklik
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CategoryPage()));
      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            // Container untuk ikon kategori
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                // Widget Image untuk menampilkan ikon dari network
                child: Image.network(category["icon"]!, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 10),
            // Widget Text untuk nama kategori
            Text(
              category["name"]!,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /* Fungsi ini membangun bagian "Trending Deals".
   * * Parameter:
   * - barangProvider: Provider untuk mendapatkan data barang dari API.
   * * Return: Widget Column yang menampilkan judul dan GridView berisi produk tren.
   */
  Widget _buildTrendingDealsSection(BarangProvider barangProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul bagian
        const Text(
          'Penawaran Terpopuler',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 16),
        // Logika kondisional untuk menampilkan UI berdasarkan state provider
        if (barangProvider.isLoading)
          // Tampilkan indikator loading jika data sedang dimuat
          const Center(child: CircularProgressIndicator())
        else if (barangProvider.error != null)
          // Tampilkan pesan error jika terjadi kesalahan
          Center(
            child: Column(
              children: [
                Text('Error: ${barangProvider.error}',
                    style: const TextStyle(color: Colors.red)),
                ElevatedButton(
                    onPressed: _loadData, child: const Text('Retry')),
              ],
            ),
          )
        else
          // Tampilkan GridView jika data berhasil dimuat atau jika ada data fallback
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            // Tentukan jumlah item: utamakan data dari API, jika kosong gunakan data statis
            itemCount: barangProvider.barangBeranda.isNotEmpty
                ? barangProvider.barangBeranda.length
                : trendingItems.length,
            itemBuilder: (context, index) {
              // Jika data API tersedia, gunakan ProductCard
              if (barangProvider.barangBeranda.isNotEmpty) {
                return ProductCard(barang: barangProvider.barangBeranda[index]);
              } else {
                // Jika tidak, gunakan data statis dengan _buildTrendingItem
                return _buildTrendingItem(trendingItems[index]);
              }
            },
          ),
      ],
    );
  }

  /* Fungsi ini membangun satu kartu produk dari data statis (fallback).
   * * Parameter:
   * - item: Map yang berisi data produk statis.
   * * Return: Widget Container yang merepresentasikan satu kartu produk.
   */
  Widget _buildTrendingItem(Map<String, dynamic> item) {
    // Implementasi kartu untuk data statis (fallback jika API tidak tersedia)
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail dengan ID default untuk item statis
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailItem(barangId: item['id'] ?? 1),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder untuk gambar
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  color: Colors.grey[200],
                ),
                child:
                    const Icon(Icons.camera_alt, size: 40, color: Colors.grey),
              ),
            ),
            // Placeholder untuk info produk
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] ?? 'Product Name',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      item['price'] != null
                          ? NumberFormat.currency(
                                  locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                              .format(item['price'])
                          : 'Rp 0',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
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

  /* Fungsi ini membangun tombol 'More' di bagian bawah halaman.
   * * Parameter:
   * - context: Dibutuhkan untuk navigasi.
   * * Return: Widget GestureDetector yang berisi tombol.
   */
  Widget _buildMoreButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman daftar semua item
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AllItemList()));
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF5D7052),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Center(
          child: Text(
            'Lihat Lainnya',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
