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
import 'package:intl/intl.dart';
import '../detail_items/detailItem.dart';
import '../components/navbar.dart';
import '../../providers/auth_provider.dart';
import '../../providers/barang_provider.dart';
import '../../providers/wishlist_provider.dart';
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
  const AllItemList({super.key});

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
      home: ItemCategory(),
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
  const ItemCategory({super.key});

  @override
  /* Fungsi ini membuat state yang digunakan oleh widget ini.
   * * Return: Instance dari _ItemCategoryState.
   */
  _ItemCategoryState createState() => _ItemCategoryState();
}

/// State untuk widget ItemCategory
/// * Deskripsi:
/// - Menyimpan semua data dan status yang berubah untuk halaman daftar barang.
/// - Mengelola proses pengambilan data, pemfilteran, dan UI interaktif.
class _ItemCategoryState extends State<ItemCategory> {
  // Variabel untuk menyimpan data barang
  List<Barang> allItems = []; // Semua barang dari API
  List<Barang> filteredItems = []; // Barang yang sudah difilter
  bool _isLoading = false; // Status loading
  String? _error; // Pesan error jika ada

  // Daftar kategori barang yang tersedia
  final List<String> categories = [
    "All", // Semua kategori
    "Tenda", // Kategori 1
    "Alat Masak", // Kategori 2
    "Sepatu", // Kategori 3
    "Tas", // Kategori 4
    "Aksesoris", // Kategori 5
    "Pakaian" // Kategori 6
  ];

  // Variabel untuk menyimpan status filter
  List<String> selectedCategories = []; // Kategori yang dipilih
  RangeValues priceRange = const RangeValues(0, 1000000); // Rentang harga
  List<int> selectedRatings = []; // Rating yang dipilih
  List<String> selectedLocations = []; // Lokasi yang dipilih
  List<String> selectedBrands = []; // Brand yang dipilih

  // Controller untuk input rentang harga
  TextEditingController minPriceController =
      TextEditingController(text: "0"); // Harga minimum
  TextEditingController maxPriceController =
      TextEditingController(text: "1000000"); // Harga maksimum

  @override
  /* Fungsi ini dijalankan saat widget pertama kali dibuat.
   * * Melakukan inisialisasi state awal dan memuat data barang dari API.
   */
  void initState() {
    super.initState();
    _loadAllItems(); // Memuat semua data barang
  }

  @override
  /* Fungsi ini dijalankan saat widget dihapus dari widget tree.
   * * Melakukan pembersihan resource dengan membuang controller yang tidak digunakan lagi
   * untuk mencegah memory leak.
   */
  void dispose() {
    minPriceController.dispose(); // Membuang controller harga minimum
    maxPriceController.dispose(); // Membuang controller harga maksimum
    super.dispose();
  }

  /* Fungsi ini mengambil data barang dari API melalui provider.
   * * Menggunakan AuthProvider untuk mendapatkan ID pengguna dan
   * BarangProvider untuk mendapatkan daftar barang.
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

      // Ambil data dari API
      await barangProvider.fetchAllBarang(authProvider.user!.userId);

      // Update state dengan data yang didapat
      setState(() {
        _isLoading = false;
        allItems = List.from(barangProvider.allBarang); // Salin semua barang
        filteredItems = List.from(allItems); // Tampilkan semua barang
        _error = barangProvider.error; // Catat error jika ada
      });
    }
  }

  /* Fungsi ini menerapkan semua filter yang dipilih pengguna.
   * * Filter berdasarkan kategori, rentang harga, dan rating.
   */
  void _applyFilters() {
    setState(() {
      // Filter barang berdasarkan kriteria yang dipilih
      filteredItems = allItems.where((item) {
        // Filter berdasarkan kategori
        bool categoryMatch = selectedCategories.isEmpty ||
            selectedCategories.contains("All") ||
            _getCategoryName(item.kategoriId)
                .any((cat) => selectedCategories.contains(cat));

        // Filter berdasarkan harga
        bool priceMatch = item.hargaPerhari >= priceRange.start.round() &&
            item.hargaPerhari <= priceRange.end.round();

        // Filter berdasarkan rating
        bool ratingMatch = selectedRatings.isEmpty ||
            selectedRatings.any((rating) =>
                item.meanReview >= rating && item.meanReview < rating + 1);

        // Barang harus memenuhi semua kriteria filter
        return categoryMatch && priceMatch && ratingMatch;
      }).toList();
    });
  }

  /* Fungsi ini mengubah ID kategori menjadi nama kategori.
   * * Parameter:
   * - categoryId: ID kategori barang.
   * * Return: List string yang berisi nama kategori.
   */
  List<String> _getCategoryName(int categoryId) {
    // Pemetaan ID kategori ke nama kategori
    Map<int, String> categoryMap = {
      1: "Tenda", // Kategori 1: Tenda
      2: "Alat Masak", // Kategori 2: Alat Masak
      3: "Sepatu", // Kategori 3: Sepatu
      4: "Tas", // Kategori 4: Tas
      5: "Aksesoris", // Kategori 5: Aksesoris
      6: "Pakaian", // Kategori 6: Pakaian
    };
    // Kembalikan nama kategori dalam bentuk list, atau "Other" jika ID tidak ditemukan
    return [categoryMap[categoryId] ?? "Other"];
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
                    ),
                    // Widget TextField untuk input pencarian
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search here',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
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
                                // Membangun setiap item barang
                                return _buildBarangItem(
                                    filteredItems[index], context, index);
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
                  _buildSortOption(context, 'Paling Populer', Icons.favorite),
                  const SizedBox(height: 20),
                  // Tombol terapkan
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Logika untuk menerapkan sorting (belum diimplementasikan)
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA0B25E),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Terapkan',
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
        // Implementasi logika sort (belum ditambahkan)
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
          ],
        ),
      ),
    );
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
                        onPressed: () => Navigator.pop(context),
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
                          },
                        ),
                        const SizedBox(height: 15),

                        // Filter Section: Rentang Harga
                        const Text(
                          "Rentang Harga",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            // Input harga minimum
                            Expanded(
                              child: TextField(
                                controller: minPriceController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Min",
                                  prefixText: "Rp. ",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {
                                  double minValue = double.tryParse(value) ?? 0;
                                  setModalState(() {
                                    priceRange = RangeValues(
                                      minValue,
                                      priceRange.end,
                                    );
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Input harga maksimum
                            Expanded(
                              child: TextField(
                                controller: maxPriceController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Max",
                                  prefixText: "Rp. ",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {
                                  double maxValue =
                                      double.tryParse(value) ?? 1000000;
                                  setModalState(() {
                                    priceRange = RangeValues(
                                      priceRange.start,
                                      maxValue,
                                    );
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Slider untuk rentang harga
                        RangeSlider(
                          values: priceRange,
                          min: 0,
                          max: 1000000,
                          divisions: 10,
                          activeColor: const Color(0xFFA0B25E),
                          labels: RangeLabels(
                            "Rp.${priceRange.start.round()}",
                            "Rp.${priceRange.end.round()}",
                          ),
                          onChanged: (values) {
                            setModalState(() {
                              priceRange = values;
                              minPriceController.text =
                                  values.start.round().toString();
                              maxPriceController.text =
                                  values.end.round().toString();
                            });
                          },
                        ),
                        const SizedBox(height: 15),

                        // Filter Section: Rating
                        const Text(
                          "Rating",
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
                        const SizedBox(height: 15),

                        // Filter Section: Lokasi
                        _buildFilterSection(
                          context,
                          "Lokasi",
                          [
                            "Jakarta",
                            "Bandung",
                            "Surabaya",
                            "Yogyakarta",
                            "Bali",
                            "Medan"
                          ],
                          selectedLocations,
                          (location, isSelected) {
                            setModalState(() {
                              if (isSelected) {
                                selectedLocations.remove(location);
                              } else {
                                selectedLocations.add(location);
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 15),

                        // Filter Section: Brand
                        _buildFilterSection(
                          context,
                          "Brand",
                          [
                            "Eiger",
                            "Consina",
                            "Rei",
                            "Avtech",
                            "Osprey",
                            "Deuter"
                          ],
                          selectedBrands,
                          (brand, isSelected) {
                            setModalState(() {
                              if (isSelected) {
                                selectedBrands.remove(brand);
                              } else {
                                selectedBrands.add(brand);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Tombol Aksi: Reset dan Terapkan
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        // Tombol Reset Filter
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setModalState(() {
                                selectedCategories.clear();
                                selectedRatings.clear();
                                selectedLocations.clear();
                                selectedBrands.clear();
                                priceRange = const RangeValues(0, 1000000);
                                minPriceController.text = "0";
                                maxPriceController.text = "1000000";
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFA0B25E)),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Reset',
                              style: TextStyle(
                                color: Color(0xFFA0B25E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Tombol Terapkan Filter
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Terapkan filter yang sudah dipilih
                              _applyFilters();
                              Navigator.pop(context);
                              // Refresh state untuk menampilkan perubahan di halaman utama
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFA0B25E),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Terapkan',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
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

  /* Fungsi ini membangun widget item barang yang ditampilkan dalam grid.
   * * Parameter:
   * - barang: Objek Barang yang berisi data barang.
   * - context: Konteks build dari Flutter.
   * - index: Indeks barang dalam list.
   * * Return: Widget berisi tampilan kartu barang.
   */
  Widget _buildBarangItem(Barang barang, BuildContext context, int index) {
    // Mendapatkan provider yang diperlukan
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);
    // Widget GestureDetector agar kartu bisa diklik
    return GestureDetector(
      // Navigasi ke halaman detail barang saat diklik dengan barangId
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailItem(barangId: barang.id),
          ),
        );
      },
      // Widget Container sebagai card
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian gambar barang
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: Colors.grey[200],
                    ),
                    // Menampilkan gambar dari URL jika ada, jika tidak, tampilkan placeholder
                    child: barang.foto != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.network(
                              barang.foto!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildPlaceholderImage();
                              },
                            ),
                          )
                        : _buildPlaceholderImage(),
                  ),
                  // Tombol Wishlist/Favorite
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () async {
                        // Logika untuk menambah/menghapus dari wishlist
                        if (authProvider.isAuthenticated) {
                          if (barang.isWishlist == true) {
                            // Hapus dari wishlist
                            await wishlistProvider.removeFromWishlist(
                                authProvider.user!.userId, barang.id);
                          } else {
                            // Tambah ke wishlist
                            await wishlistProvider.addToWishlist(
                                authProvider.user!.userId, barang.id);
                          }
                          _loadAllItems(); // Refresh daftar barang untuk update status wishlist
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        // Ikon berubah tergantung status wishlist barang
                        child: Icon(
                          barang.isWishlist == true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Bagian informasi barang (nama, harga, rating)
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Widget Text untuk nama barang
                    Text(
                      barang.namaBarang,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Widget Text untuk harga barang per hari
                        Text(
                          NumberFormat.currency(
                                  locale: 'id', symbol: 'Rp', decimalDigits: 0)
                              .format(barang.hargaPerhari),
                          style: TextStyle(
                            color: Color(0xFFA0B25E),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Widget Row untuk menampilkan rating
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 14),
                            const SizedBox(width: 2),
                            // Teks untuk rata-rata rating
                            Text(
                              barang.meanReview.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                            // Teks untuk jumlah total review
                            Text(
                              ' (${barang.totalReview})',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
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
  }

  /* Fungsi ini membuat placeholder gambar untuk item yang tidak memiliki foto.
   * * Return: Widget container dengan icon placeholder.
   */
  Widget _buildPlaceholderImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        // Membuat container dengan sudut melengkung atas
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.grey[200], // Warna abu-abu muda
      ),
      // Menampilkan ikon gambar sebagai placeholder
      child: Icon(
        Icons.image,
        color: Colors.grey[400],
        size: 40,
      ),
    );
  }
}
