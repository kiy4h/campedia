/// File         : category.dart
/// Dibuat oleh  : Izzuddin Azzam, Al Ghifari
/// Tanggal      : 16-06-2025
/// Deskripsi    : File ini berisi halaman yang menampilkan berbagai kategori produk camping dalam bentuk grid dengan gambar dan jumlah item.
/// Dependencies :
/// - google_fonts: digunakan untuk mengatur font Poppins pada tampilan teks.
/// - allListItem.dart: digunakan untuk berpindah ke halaman daftar semua barang.
/// - navbar.dart: digunakan untuk menampilkan navigasi bawah layar.
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/navbar.dart';
import 'allListItem.dart';

// Fungsi main untuk menjalankan aplikasi sebagai contoh
void main() {
  runApp(const CategoryPage());
}

/// Widget CategoryPage
/// * Deskripsi:
/// - Widget ini adalah root untuk halaman kategori produk.
/// - Mengatur konfigurasi global seperti tema, warna, dan font untuk halaman ini.
/// - Merupakan StatelessWidget karena tidak perlu mengelola state internal yang berubah.
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  /* Fungsi ini membangun widget root untuk halaman kategori
   * * Parameter:
   * - context: Menyediakan informasi tentang lokasi widget dalam struktur widget dan akses ke fitur-fitur Flutter.
   * * Return: Widget MaterialApp yang menampung CategoriesPage sebagai halaman utama dengan tema yang telah dikonfigurasi.
   */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Konfigurasi tema aplikasi
      theme: ThemeData(
        primaryColor: const Color(0xFF5D7052),
        scaffoldBackgroundColor: const Color(0xFFF8F8F8),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      // Menetapkan CategoriesPage sebagai halaman utama
      home: CategoriesPage(),
      // Menyembunyikan banner debug
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Widget CategoriesPage
/// * Deskripsi:
/// - Widget ini menampilkan halaman utama yang berisi daftar kategori produk.
/// - Tampilan utama menggunakan layout GridView untuk menyusun kartu-kartu kategori.
/// - Merupakan StatelessWidget karena konten kategori bersifat statis dan tidak ada perubahan state di dalam widget ini.
class CategoriesPage extends StatelessWidget {
  // Variabel final untuk menyimpan data kategori. Setiap kategori adalah Map yang berisi nama, path icon, dan jumlah item.
  final List<Map<String, dynamic>> categories = [
    {
      "name": "Alat Masak",
      "icon": "http://localhost:8000/images/assets_Categories/cat_Kompor.png",
      "items": 87
    },
    {
      "name": "Tenda",
      "icon": "http://localhost:8000/images/assets_Categories/cat_Tenda.png",
      "items": 87
    },
    {
      "name": "Sepatu",
      "icon": "http://localhost:8000/images/assets_Categories/cat_Sepatu.png",
      "items": 87
    },
    {
      "name": "Tas Gunung",
      "icon": "http://localhost:8000/images/assets_Categories/cat_Tas.png",
      "items": 27
    },
    {
      "name": "Senter",
      "icon": "http://localhost:8000/images/assets_Categories/cat_Senter.png",
      "items": 87
    },
    {
      "name": "Jaket Gunung",
      "icon": "http://localhost:8000/images/assets_Categories/cat_Jaket.png",
      "items": 87
    },
    {
      "name": "Alat Pendukung",
      "icon":
          "http://localhost:8000/images/assets_Categories/cat_KeamananNavigasi.png",
      "items": 87
    },
    {
      "name": "Fasilitas Tambahan",
      "icon":
          "http://localhost:8000/images/assets_Categories/cat_FasilitasTambahan.png",
      "items": 120
    },
  ];

  CategoriesPage({super.key});

  /* Fungsi ini membangun UI untuk halaman daftar kategori.
   * * Parameter:
   * - context: Digunakan untuk mengakses informasi tentang lokasi widget dan untuk navigasi antar halaman.
   * * Return: Widget Scaffold yang menyusun AppBar, body dengan GridView, dan Bottom Navigation Bar.
   */
  @override
  Widget build(BuildContext context) {
    // Scaffold sebagai kerangka utama halaman
    return Scaffold(
      // AppBar yang dibuat secara dinamis oleh fungsi buildAppBar
      appBar: buildAppBar(context: context, currentIndex: 1),
      // Body utama dengan padding
      body: Padding(
        padding: const EdgeInsets.all(16),
        // GridView untuk menampilkan kategori secara dinamis
        child: GridView.builder(
          // Pengaturan layout grid: jumlah kolom, rasio aspek, dan jarak antar item
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 kolom
            childAspectRatio: 1.1, // Rasio lebar-tinggi setiap item
            crossAxisSpacing: 16, // Jarak horizontal antar item
            mainAxisSpacing: 16, // Jarak vertikal antar item
          ),
          // Jumlah total item dalam grid, diambil dari panjang list categories
          itemCount: categories.length,
          // Fungsi yang dipanggil untuk membangun setiap kartu kategori dalam grid
          itemBuilder: (context, index) {
            return _buildCategoryCard(categories[index], context);
          },
        ),
      ),
      // Navigasi bawah yang dibuat oleh fungsi buildBottomNavBar
      bottomNavigationBar: buildBottomNavBar(
        context,
        currentIndex: 1, // Menandakan halaman 'Category' sedang aktif
      ),
    );
  }

  /* Fungsi ini membangun satu kartu kategori.
   * * Parameter:
   * - category: Sebuah Map yang berisi data untuk satu kategori (nama, ikon, jumlah item).
   * - context: Diperlukan untuk menangani navigasi saat kartu diklik.
   * * Return: Widget GestureDetector yang berisi Container (kartu) yang dapat diklik.
   */
  Widget _buildCategoryCard(
      Map<String, dynamic> category, BuildContext context) {
    // GestureDetector untuk membuat seluruh kartu dapat diklik
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman AllItemList saat kartu kategori ditekan
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AllItemList()),
        );
      },
      // Container sebagai visual dari kartu kategori
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        // Column untuk menyusun ikon dan teks secara vertikal
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container untuk menampung gambar ikon kategori
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(
                  8), // Widget Image untuk menampilkan ikon kategori dari network
              child: Image.network(
                category['icon'], // Mengambil path gambar dari data Map
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_not_supported,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Widget Text untuk menampilkan nama kategori
            Text(
              category['name'], // Mengambil nama dari data Map
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5D7052),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            // Widget Text untuk menampilkan jumlah item dalam kategori
            Text(
              "${category['items']} Items", // Mengambil jumlah item dari data Map
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* Fungsi ini membangun AppBar yang dapat disesuaikan berdasarkan halaman aktif.
 * * Parameter:
 * - context: Digunakan untuk menampilkan elemen UI seperti SnackBar.
 * - currentIndex: Indeks integer yang menentukan konten AppBar (judul dan tombol aksi) yang akan ditampilkan.
 * * Return: Widget PreferredSizeWidget (AppBar) yang sudah dikonfigurasi.
 */
PreferredSizeWidget buildAppBar({
  required BuildContext context,
  required int currentIndex,
}) {
  String title;
  List<Widget> actions;

  // Switch case untuk menentukan judul dan actions berdasarkan halaman yang aktif
  switch (currentIndex) {
    case 0:
      title = 'Home';
      actions = [
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black)),
      ];
      break;
    case 1:
      // Konfigurasi AppBar untuk halaman Kategori
      title = 'Category';
      actions = []; // Tidak ada tombol aksi di halaman kategori
      break;
    case 2:
      title = 'Shopping Cart';
      actions = [
        TextButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order placed!')),
          ),
          style: TextButton.styleFrom(
            foregroundColor: Colors.amber,
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          child: const Text('Place Order'),
        ),
      ];
      break;
    case 3:
      title = 'Favorite';
      actions = [
        TextButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order placed!')),
          ),
          style: TextButton.styleFrom(
            foregroundColor: Colors.amber,
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          child: const Text('Place Order'),
        ),
      ];
      break;
    case 4:
      title = 'Profile';
      actions = [
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.black)),
      ];
      break;
    default:
      title = 'App';
      actions = [];
  }

  // Mengembalikan widget AppBar yang telah dikonfigurasi
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    // Widget Text untuk judul AppBar
    title: Text(title,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
    // Daftar widget untuk tombol aksi di sebelah kanan AppBar
    actions: actions,
  );
}
