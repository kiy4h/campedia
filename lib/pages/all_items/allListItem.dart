/// File         : allListItem.dart
/// Dibuat oleh  : Izzuddin Azzam, Al Ghifari
/// Tanggal      : 15-06-2025
/// Deskripsi    : File ini berisi implementasi halaman daftar semua barang camping yang tersedia untuk disewa
/// dengan fitur filter berdasarkan kategori, harga, dan rating.
/// Dependencies : flutter/material.dart, font_awesome_flutter, provider, intl
library;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
import '../components/navbar.dart';
import '../components/product_card.dart';
import '../../providers/auth_provider.dart';
import '../../providers/barang_provider.dart';
import '../../providers/brand_provider.dart';
import '../../models/models.dart';

// Fungsi main untuk menjalankan aplikasi sebagai contoh
void main() {
  runApp(const AllItemList());
}

/// Widget AllItemList
/// * Deskripsi:
/// - Widget utama yang mengatur root dari halaman daftar semua barang.
/// - Menyediakan konfigurasi tema dan styling untuk halaman.
/// - Merupakan StatelessWidget karena hanya berfungsi sebagai container dan tidak menyimpan state.
class AllItemList extends StatelessWidget {
  final String? keyword;
  final String? kategori;
  const AllItemList({super.key, this.keyword, this.kategori});

  @override
  /* Fungsi ini membangun widget root untuk aplikasi
   * * Parameter:
   * - context: Konteks build dari framework Flutter.
   * * Return: Widget MaterialApp yang merupakan root dari aplikasi.
   */
  Widget build(BuildContext context) {
    return MaterialApp(
      // Menyembunyikan banner debug di kanan atas aplikasi
      debugShowCheckedModeBanner: false,

      // Konfigurasi tema aplikasi dengan warna utama hijau
      theme: ThemeData(
        primaryColor: const Color(0xFF445018), // Warna primer hijau gelap
        scaffoldBackgroundColor:
            const Color(0xFFF8F8F8), // Background abu-abu muda
      ),

      // Menampilkan halaman kategori item sebagai halaman utama
      home: ItemCategory(
        keyword: keyword,
        kategori: kategori,
      ),
    );
  }
}

/// Widget ItemCategory
/// * Deskripsi:
/// - Widget utama yang menampilkan daftar barang dan opsi filter.
/// - Bagian dari halaman katalog barang camping.
/// - Merupakan StatefulWidget karena perlu menyimpan dan memperbarui status seperti
/// kategori terpilih, filter harga, dan data barang.
class ItemCategory extends StatefulWidget {
  final String? keyword; // Tambahkan ini
  final String? kategori; // Tambahkan ini
  const ItemCategory({super.key, this.keyword, this.kategori});

  @override
  /* Fungsi ini membuat state yang digunakan oleh widget ini.   * * Return: Instance dari ItemCategoryState.
   */
  ItemCategoryState createState() => ItemCategoryState();
}

/// State untuk widget ItemCategory
/// * Deskripsi:
/// - Menyimpan semua data dan status yang berubah untuk halaman daftar barang.
/// - Mengelola proses pengambilan data, pemfilteran, dan UI interaktif.
class ItemCategoryState extends State<ItemCategory> {
  // Variabel untuk menyimpan data barang
  List<Barang> allItems = []; // Semua barang dari API
  List<Barang> filteredItems = []; // Barang yang sudah difilter
  bool _isLoading = false; // Status loading
  String? _error; // Pesan error jika ada

  // Data untuk dropdown filter
  List<Brand> availableBrands = []; // Brand yang tersedia dari database

  // Daftar kategori barang yang tersedia
  final List<String> categories = [
    "Semua", // Semua kategori
    "Tenda", // Kategori 1
    "Alat Masak", // Kategori 2
    "Sepatu", // Kategori 3
    "Tas", // Kategori 4
    "Aksesoris", // Kategori 5
    "Pakaian" // Kategori 6
  ]; // Variabel untuk menyimpan status filter
  List<String> selectedCategories = []; // Kategori yang dipilih
  int? minPrice; // Harga minimum
  int? maxPrice; // Harga maksimum
  List<int> selectedRatings = []; // Rating yang dipilih
  List<String> selectedLocations = []; // Lokasi yang dipilih
  List<int> selectedBrands = []; // Brand ID yang dipilih
  // Controller untuk input rentang harga
  TextEditingController minPriceController =
      TextEditingController(); // Harga minimum
  TextEditingController maxPriceController =
      TextEditingController(); // Harga maksimum

  // Controller untuk search
  TextEditingController searchController = TextEditingController();

  // Current sort option
  String? currentSortBy;
  String? currentOrder;
  @override
  /* Fungsi ini dijalankan saat widget pertama kali dibuat.
   * * Melakukan inisialisasi state awal dan memuat data barang dari API.
   */
  void initState() {
    super.initState();
    // Jika kategori tidak null, masukkan ke selectedCategories
    if (widget.kategori != null && widget.kategori!.isNotEmpty) {
      selectedCategories.add(widget.kategori!);
    }
    // Jika keyword tidak null, masukkan ke searchController.text
    if (widget.keyword != null && widget.keyword!.isNotEmpty) {
      debugPrint("Keyword: ${widget.keyword}");
      searchController.text = widget.keyword!;
    }

    // Add listeners to price controllers
    minPriceController.addListener(() {
      final value = minPriceController.text;
      minPrice = value.isEmpty ? null : int.tryParse(value);
    });

    maxPriceController.addListener(() {
      final value = maxPriceController.text;
      maxPrice = value.isEmpty ? null : int.tryParse(value);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadBrandData(); // Memuat data brand dari database
      _loadAllItems(); // Memuat semua data barang
    });
  }

  @override
  /* Fungsi ini dijalankan saat widget dihapus dari widget tree.
   * * Melakukan pembersihan resource dengan membuang controller yang tidak digunakan lagi
   * untuk mencegah memory leak.
   */
  void dispose() {
    minPriceController.dispose(); // Membuang controller harga minimum
    maxPriceController.dispose(); // Membuang controller harga maksimum
    searchController.dispose(); // Membuang controller search
    super.dispose();
  }

  /* Fungsi ini mengambil data barang dari API melalui provider dengan filter, sort, dan search.
   * * Menggunakan AuthProvider untuk mendapatkan ID pengguna dan
   * BarangProvider untuk mendapatkan daftar barang dengan parameter filter.
   */
  Future<void> _loadAllItems() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final barangProvider = Provider.of<BarangProvider>(context, listen: false);

    // Cek apakah pengguna sudah login
    if (authProvider.isAuthenticated) {
      // Ubah state untuk menunjukkan loading
      setState(() {
        _isLoading = true;
        _error = null;
      });

      // Prepare filter parameters
      List<int>? categoryIds;
      if (selectedCategories.isNotEmpty &&
          !selectedCategories.contains("All")) {
        categoryIds = selectedCategories
            .map((catName) {
              // Convert category name to ID
              switch (catName) {
                case "Tenda":
                  return 1;
                case "Tas":
                  return 2;
                case "Peralatan Tidur":
                  return 3;
                case "Peralatan Masak":
                  return 4;
                case "Pencahayaan":
                  return 5;
                case "Pakaian":
                  return 6;
                case "Aksesoris":
                  return 7;
                default:
                  return 0;
              }
            })
            .where((id) => id > 0)
            .toList();
      } // Ambil data dari API dengan filter
      await barangProvider.fetchBarangWithFilter(
        userId: authProvider.user!.userId,
        categoryIds: categoryIds,
        brandIds: selectedBrands.isNotEmpty ? selectedBrands : null,
        hargaMin: minPrice,
        hargaMax: maxPrice,
        minRating: selectedRatings.isNotEmpty
            ? selectedRatings.first.toDouble()
            : null,
        keyword:
            searchController.text.isNotEmpty ? searchController.text : null,
        sortBy: currentSortBy,
        order: currentOrder,
      );

      // Update state dengan data yang didapat
      setState(() {
        _isLoading = false;
        allItems = List.from(barangProvider.allBarang); // Salin semua barang
        filteredItems = List.from(allItems); // Tampilkan semua barang
        _error = barangProvider.error; // Catat error jika ada
      });
    }
  } /* Fungsi ini menerapkan semua filter yang dipilih pengguna.
   * * Memanggil API dengan parameter filter yang sesuai.
   */

  void _applyFilters() {
    _loadAllItems(); // Reload data with current filters
  }

  @override
  /* Fungsi ini membangun UI untuk halaman daftar item.
   * * Parameter:
   * - context: Konteks build dari framework Flutter.
   * * Return: Widget Scaffold dengan struktur halaman daftar item.
   */
  Widget build(BuildContext context) {
    // Scaffold sebagai kerangka utama halaman
    return Scaffold(
      // Menggunakan CustomScrollView untuk membuat layout scrollable yang lebih kompleks
      body: CustomScrollView(
        slivers: [
          // Header area dengan judul dan kotak pencarian
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Widget Text untuk menampilkan judul halaman
                  const Text(
                    'Jelajahi Katalog Barang',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Widget Container untuk kotak pencarian dengan shadow
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ), // Widget TextField untuk input pencarian
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Cari di sini...',
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        suffixIcon: searchController.text.isNotEmpty
                            ? IconButton(
                                icon:
                                    const Icon(Icons.clear, color: Colors.grey),
                                onPressed: () {
                                  searchController.clear();
                                  _applyFilters();
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onSubmitted: (value) {
                        _applyFilters(); // Apply search when user submits
                      },
                      onChanged: (value) {
                        setState(() {}); // Update UI to show/hide clear button
                        // Optional: Apply search on every character change
                        // Uncomment the next line for real-time search
                        // _applyFilters();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Spacer
          SliverToBoxAdapter(
            child: SizedBox(height: 8),
          ),
          // Baris untuk filter kategori, tombol sort, dan filter
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // ListView horizontal untuk menampilkan daftar kategori
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        // Tombol untuk setiap kategori
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedCategories
                                  .contains(categories[index])) {
                                selectedCategories.remove(categories[index]);
                              } else {
                                selectedCategories.add(categories[index]);
                              }
                              _applyFilters(); // Terapkan filter saat kategori berubah
                            });
                          },
                          // Container sebagai chip kategori
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color:
                                  selectedCategories.contains(categories[index])
                                      ? const Color(0xFFA0B25E)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: const Color(0xFFA0B25E)),
                            ),
                            // Teks nama kategori
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                color: selectedCategories
                                        .contains(categories[index])
                                    ? Colors.white
                                    : const Color(0xFFA0B25E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Tombol untuk membuka bottom sheet 'Sort'
                  GestureDetector(
                    onTap: () {
                      _showSortBottomSheet(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFA0B25E)),
                      ),
                      child: const Icon(Icons.sort,
                          size: 18, color: Color(0xFFA0B25E)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Tombol untuk membuka bottom sheet 'Filter'
                  GestureDetector(
                    onTap: () {
                      _showFilterBottomSheet(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFA0B25E)),
                      ),
                      child: const Icon(FontAwesomeIcons.filter,
                          size: 18, color: Color(0xFFA0B25E)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Padding untuk Grid daftar barang
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            // Menampilkan widget berdasarkan state: loading, error, empty, atau berisi data
            sliver: _isLoading
                ? SliverToBoxAdapter(
                    // Tampilan loading indicator
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: CircularProgressIndicator(
                          color: Color(0xFFA0B25E),
                        ),
                      ),
                    ),
                  )
                : _error != null
                    ? SliverToBoxAdapter(
                        // Tampilan jika terjadi error saat fetch data
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(50),
                            child: Column(
                              children: [
                                Text(
                                  'Error loading items: $_error',
                                  style: TextStyle(color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: _loadAllItems,
                                  child: Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : filteredItems.isEmpty
                        ? SliverToBoxAdapter(
                            // Tampilan jika tidak ada barang yang ditemukan
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(50),
                                child: Text(
                                  'No items found',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SliverGrid(
                            // Tampilan grid untuk daftar barang
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                // Membangun setiap item barang dengan ProductCard
                                return ProductCard(
                                    barang: filteredItems[index]);
                              },
                              childCount: filteredItems.length,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // 2 kolom
                              childAspectRatio: 0.75, // Rasio aspek item
                              crossAxisSpacing: 10, // Jarak horizontal
                              mainAxisSpacing: 10, // Jarak vertikal
                            ),
                          ),
          ),
        ],
      ),
      // Bottom Navigation Bar kustom
      bottomNavigationBar: buildBottomNavBar(context, currentIndex: 1),
    );
  }

  /* Fungsi ini menampilkan modal bottom sheet untuk opsi pengurutan (sort).
   * * Parameter:
   * - context: Konteks build dari Flutter.
   */
  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Judul Bottom Sheet
                      const Text(
                        'Urutkan Berdasarkan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Tombol Close
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const Divider(),
                  // Pilihan-pilihan untuk sorting
                  _buildSortOption(context, 'Terbaru', Icons.access_time),
                  _buildSortOption(
                      context, 'Harga Tertinggi', Icons.arrow_upward),
                  _buildSortOption(
                      context, 'Harga Terendah', Icons.arrow_downward),
                  _buildSortOption(context, 'Rating Tertinggi', Icons.star),
                  const SizedBox(height: 20),
                  // Tombol reset
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // Reset sorting to default (no sorting)
                          currentSortBy = null;
                          currentOrder = null;
                        });
                        _applyFilters(); // Apply reset sorting
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[600],
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Atur Ulang',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /* Fungsi ini membangun satu baris opsi pengurutan di dalam bottom sheet.
   * * Parameter:
   * - context: Konteks build dari Flutter.
   * - title: Judul opsi sorting.
   * - icon: Ikon untuk opsi sorting.
   * * Return: Widget yang menampilkan satu opsi sorting.
   */
  Widget _buildSortOption(BuildContext context, String title, IconData icon) {
    return InkWell(
      onTap: () {
        setState(() {
          switch (title) {
            case 'Terbaru':
              currentSortBy = 'newest';
              currentOrder = 'desc';
              break;
            case 'Harga Tertinggi':
              currentSortBy = 'harga';
              currentOrder = 'desc';
              break;
            case 'Harga Terendah':
              currentSortBy = 'harga';
              currentOrder = 'asc';
              break;
            case 'Rating Tertinggi':
              currentSortBy = 'rating';
              currentOrder = 'desc';
              break;
          }
        });
        // Apply sorting immediately and close modal
        _applyFilters();
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFA0B25E)),
            const SizedBox(width: 15),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            if (_isCurrentSortOption(title))
              const Icon(Icons.check, color: Color(0xFFA0B25E)),
          ],
        ),
      ),
    );
  }

  /* Fungsi helper untuk mengecek apakah opsi sort sedang aktif */
  bool _isCurrentSortOption(String title) {
    switch (title) {
      case 'Terbaru':
        return currentSortBy == 'newest' && currentOrder == 'desc';
      case 'Harga Tertinggi':
        return currentSortBy == 'harga' && currentOrder == 'desc';
      case 'Harga Terendah':
        return currentSortBy == 'harga' && currentOrder == 'asc';
      case 'Rating Tertinggi':
        return currentSortBy == 'rating' && currentOrder == 'desc';
      default:
        return false;
    }
  }

  /* Fungsi ini menampilkan modal bottom sheet untuk opsi filter.
   * * Parameter:
   * - context: Konteks build dari Flutter.
   */
  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header bottom sheet filter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Apply filters when close button is pressed
                          _applyFilters();
                          Navigator.pop(context);
                          // Refresh state untuk menampilkan perubahan di halaman utama
                          setState(() {});
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const Divider(),
                  // Konten filter yang bisa di-scroll
                  Expanded(
                    child: ListView(
                      children: [
                        // Filter Section: Kategori
                        _buildFilterSection(
                          context,
                          "Kategori",
                          [
                            "Tenda",
                            "Alat Masak",
                            "Sepatu",
                            "Tas",
                            "Aksesoris",
                            "Pakaian"
                          ],
                          selectedCategories,
                          (category, isSelected) {
                            setModalState(() {
                              if (isSelected) {
                                selectedCategories.remove(category);
                              } else {
                                selectedCategories.add(category);
                              }
                            });
                            // Auto-apply filter when category changes
                            _applyFilters();
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                            height: 15), // Filter Section: Rentang Harga
                        const Text(
                          "Rentang Harga",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [                            // Input harga minimum
                            Expanded(
                              child: TextField(
                                controller: minPriceController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(                                  labelText: "Minimum",
                                  labelStyle: const TextStyle(color: Color(0xFF627D2C)),
                                  prefixText: "Rp. ",
                                  hintText: "0",
                                  focusColor: const Color(0xFF627D2C), // Warna saat fokus
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color(0xFF627D2C)), // Warna border saat fokus
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {
                                  setModalState(() {
                                    minPrice = value.isEmpty
                                        ? null
                                        : int.tryParse(value);
                                  });
                                  // Auto-apply filter when price changes
                                  _applyFilters();
                                  setState(() {});
                                },
                              ),
                            ),
                            const SizedBox(width: 10),                            // Input harga maksimum
                            Expanded(
                              child: TextField(
                                controller: maxPriceController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(                                  labelText: "Maksimum",
                                  labelStyle: const TextStyle(color: Color(0xFF627D2C)),
                                  prefixText: "Rp. ",
                                  hintText: "-",
                                  focusColor: const Color(0xFF627D2C), // Warna saat fokus
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Color(0xFF627D2C)), // Warna border saat fokus
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {
                                  setModalState(() {
                                    maxPrice = value.isEmpty
                                        ? null
                                        : int.tryParse(value);
                                  });
                                  // Auto-apply filter when price changes
                                  _applyFilters();
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Filter Section: Rating
                        const Text(
                          "Penilaian",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(5, (index) {
                            final rating = index + 1;
                            final isSelected = selectedRatings.contains(rating);
                            return InkWell(
                              onTap: () {
                                setModalState(() {
                                  if (isSelected) {
                                    selectedRatings.remove(rating);
                                  } else {
                                    selectedRatings.add(rating);
                                  }
                                });
                                // Auto-apply filter when rating changes
                                _applyFilters();
                                setState(() {});
                              },
                              // Tombol pilihan rating
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFFA0B25E)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: const Color(0xFFA0B25E)),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.amber,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "$rating",
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 15), // Filter Section: Brand
                        _buildBrandFilterSection(context, setModalState),
                      ],
                    ),
                  ), // Tombol Aksi: Reset
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          setModalState(() {
                            selectedCategories.clear();
                            selectedRatings.clear();
                            selectedLocations.clear();
                            selectedBrands.clear();
                            minPrice = null;
                            maxPrice = null;
                            minPriceController.clear();
                            maxPriceController.clear();
                          });
                          // Auto-apply reset filter
                          _applyFilters();
                          setState(() {});
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFA0B25E)),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Atur Ulang Filter',
                          style: TextStyle(
                            color: Color(0xFFA0B25E),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /* Fungsi ini membangun bagian filter brand dengan data dari database.
   * * Parameter:
   * - context: Konteks build dari Flutter.
   * - setModalState: Fungsi untuk mengupdate state modal.
   * * Return: Widget Column yang berisi bagian filter brand.
   */
  Widget _buildBrandFilterSection(
      BuildContext context, StateSetter setModalState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul bagian filter
        const Text(
          "Brand",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        // Daftar pilihan filter brand yang bisa wrap ke baris baru
        Wrap(
          spacing: 10, // Jarak horizontal antar pilihan
          runSpacing: 10, // Jarak vertikal antar baris
          children: availableBrands.map((brand) {
            // Cek apakah brand ini sedang dipilih
            final isSelected =
                selectedBrands.contains(brand.id); // Buat widget pilihan filter
            return GestureDetector(
              onTap: () {
                setModalState(() {
                  if (isSelected) {
                    selectedBrands.remove(brand.id);
                  } else {
                    selectedBrands.add(brand.id);
                  }
                });
                // Auto-apply filter when brand changes
                _applyFilters();
                setState(() {});
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  // Warna berbeda untuk item yang dipilih dan tidak dipilih
                  color: isSelected ? const Color(0xFFA0B25E) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: const Color.fromARGB(255, 69, 79, 31)),
                ),
                child: Text(
                  brand.namaBrand,
                  style: TextStyle(
                    // Warna teks berbeda untuk item yang dipilih dan tidak dipilih
                    color: isSelected
                        ? Colors.white
                        : const Color.fromARGB(255, 67, 77, 29),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /* Fungsi ini membangun bagian filter dengan judul dan pilihan filter.
   * * Parameter:
   * - context: Konteks build dari Flutter.
   * - title: Judul bagian filter.
   * - items: Daftar pilihan filter yang tersedia.
   * - selectedItems: Daftar pilihan filter yang sudah dipilih.
   * - onToggle: Fungsi callback saat pilihan filter dipilih/dibatalkan.
   * * Return: Widget Column yang berisi bagian filter.
   */
  Widget _buildFilterSection(
    BuildContext context,
    String title,
    List<String> items,
    List<String> selectedItems,
    Function(String, bool) onToggle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul bagian filter
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        // Daftar pilihan filter yang bisa wrap ke baris baru
        Wrap(
          spacing: 10, // Jarak horizontal antar pilihan
          runSpacing: 10, // Jarak vertikal antar baris
          children: items.map((item) {
            // Cek apakah item ini sedang dipilih
            final isSelected = selectedItems.contains(item);

            // Buat widget pilihan filter
            return GestureDetector(
              onTap: () =>
                  onToggle(item, isSelected), // Panggil onToggle saat diklik
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  // Warna berbeda untuk item yang dipilih dan tidak dipilih
                  color: isSelected ? const Color(0xFFA0B25E) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: const Color.fromARGB(255, 69, 79, 31)),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    // Warna teks berbeda untuk item yang dipilih dan tidak dipilih
                    color: isSelected
                        ? Colors.white
                        : const Color.fromARGB(255, 67, 77, 29),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /* Fungsi ini mengambil data brand dari API melalui provider.
   * * Menggunakan BrandProvider untuk mendapatkan daftar brand yang tersedia.
   */
  Future<void> _loadBrandData() async {
    final brandProvider = Provider.of<BrandProvider>(context, listen: false);

    // Fetch brand data from API
    await brandProvider
        .fetchBrand(); // Update state dengan data brand yang didapat
    setState(() {
      availableBrands = List.from(brandProvider.brandList);
    });
  }
}
