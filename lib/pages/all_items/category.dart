/// File         : category.dart
/// Dibuat oleh  : Izzuddin Azzam, Al Ghifari
/// Tanggal      : 16-06-2025
/// Deskripsi    : File ini berisi halaman yang menampilkan berbagai kategori produk camping dalam bentuk grid dengan gambar dan jumlah item.
/// Dependencies :
/// - google_fonts: digunakan untuk mengatur font Poppins pada tampilan teks.
/// - allListItem.dart: digunakan untuk berpindah ke halaman daftar semua barang.
/// - navbar.dart: digunakan untuk menampilkan navigasi bawah layar.
/// - provider: untuk state management
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/navbar.dart';
import 'allListItem.dart';
import '../../providers/kategori_provider.dart';
import '../../models/models.dart';

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
      home: ChangeNotifierProvider(
        create: (_) => KategoriProvider(),
        child: CategoriesPage(),
      ),
      // Menyembunyikan banner debug
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Widget CategoriesPage
/// * Deskripsi:
/// - Widget ini menampilkan halaman utama yang berisi daftar kategori produk.
/// - Tampilan utama menggunakan layout GridView untuk menyusun kartu-kartu kategori.
/// - Sekarang menggunakan StatefulWidget untuk mengelola state loading dan data dari API.
class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => CategoriesPageState();
}

class CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    super.initState();
    // Load kategori saat widget diinisialisasi
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<KategoriProvider>(context, listen: false).fetchKategori();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar yang dibuat secara dinamis oleh fungsi buildAppBar
      appBar: buildAppBar(context: context, currentIndex: 1),
      // Body utama dengan padding
      body: Consumer<KategoriProvider>(
        builder: (context, kategoriProvider, child) {
          if (kategoriProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5D7052)),
              ),
            );
          }

          if (kategoriProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${kategoriProvider.error}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      kategoriProvider.fetchKategori();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5D7052),
                    ),
                    child: const Text('Retry',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }

          if (kategoriProvider.kategoriList.isEmpty) {
            return const Center(
              child: Text(
                'No categories available',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return Padding(
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
              // Jumlah total item dalam grid, diambil dari data API
              itemCount: kategoriProvider.kategoriList.length,
              // Fungsi yang dipanggil untuk membangun setiap kartu kategori dalam grid
              itemBuilder: (context, index) {
                return _buildCategoryCard(
                    kategoriProvider.kategoriList[index], context);
              },
            ),
          );
        },
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
   * - kategori: Objek Kategori yang berisi data untuk satu kategori.
   * - context: Diperlukan untuk menangani navigasi saat kartu diklik.
   * * Return: Widget GestureDetector yang berisi Container (kartu) yang dapat diklik.
   */
  Widget _buildCategoryCard(Kategori kategori, BuildContext context) {
    // GestureDetector untuk membuat seluruh kartu dapat diklik
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman AllItemList dengan kategori yang dipilih
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AllItemList(
              kategori: kategori.namaKategori, // Pass nama kategori
            ),
          ),
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
              padding: const EdgeInsets.all(8),
              // Widget Image untuk menampilkan ikon kategori dari network
              child: kategori.icon != null
                  ? Image.network(
                      kategori.icon!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ),
                    )
                  : const Icon(
                      Icons.category,
                      size: 50,
                      color: Color(0xFF5D7052),
                    ),
            ),
            const SizedBox(height: 10),
            // Widget Text untuk menampilkan nama kategori
            Text(
              kategori.namaKategori,
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
              "${kategori.totalBarang} Items",
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

// ...existing code for buildAppBar function...
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
