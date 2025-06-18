/// File         : recommendedGearTrip.dart
/// Dibuat oleh  : Izzuddin Azzam, Al Ghifari
/// Tanggal      : 16-06-2025
/// Deskripsi    : File ini berisi halaman yang menampilkan daftar destinasi camping.
/// Setiap destinasi memiliki detail dan daftar perlengkapan yang direkomendasikan,
/// serta dilengkapi fitur pencarian.
/// Dependencies :
/// - http: (diimpor untuk masa depan) untuk melakukan permintaan jaringan.
/// - dart:convert: untuk mengonversi data JSON.
library;

import 'package:flutter/material.dart';

/// Model RecommendedGear
/// * Deskripsi:
/// - Merepresentasikan satu buah perlengkapan yang direkomendasikan untuk sebuah destinasi.
/// - Berisi informasi nama, path gambar, dan harga.
/// - Dilengkapi dengan factory constructor `fromJson` untuk mem-parsing data dari Map/JSON.
class RecommendedGear {
  final String name;
  final String imagePath;
  final double price;

  RecommendedGear({
    required this.name,
    required this.imagePath,
    required this.price,
  });

  /* Fungsi factory untuk membuat instance RecommendedGear dari Map (JSON).
   * * Parameter:
   * - json: Map<String, dynamic> yang berisi data gear.
   * * Return: Sebuah objek RecommendedGear.
   */
  factory RecommendedGear.fromJson(Map<String, dynamic> json) {
    return RecommendedGear(
      name: json['name'] ?? '',
      imagePath: json['imagePath'] ?? '',
      price: json['price'] != null
          ? (json['price'] is double
              ? json['price']
              : double.parse(json['price'].toString()))
          : 0.0,
    );
  }
}

/// Model CampingDestination
/// * Deskripsi:
/// - Merepresentasikan satu destinasi camping.
/// - Berisi informasi nama, path gambar, lokasi, deskripsi, dan daftar perlengkapan yang direkomendasikan (`RecommendedGear`).
/// - Dilengkapi dengan factory constructor `fromJson` untuk mem-parsing data dari Map/JSON, termasuk daftar objek turunannya.
class CampingDestination {
  final String name;
  final String imagePath;
  final String location;
  final List<RecommendedGear> gears;
  final String description;

  CampingDestination({
    required this.name,
    required this.imagePath,
    required this.location,
    required this.gears,
    this.description = '',
  });

  /* Fungsi factory untuk membuat instance CampingDestination dari Map (JSON).
   * * Parameter:
   * - json: Map<String, dynamic> yang berisi data destinasi.
   * * Return: Sebuah objek CampingDestination.
   */
  factory CampingDestination.fromJson(Map<String, dynamic> json) {
    List<RecommendedGear> gearsList = [];

    if (json['gears'] != null && json['gears'] is List) {
      gearsList = (json['gears'] as List)
          .map((i) =>
              RecommendedGear.fromJson(i is Map<String, dynamic> ? i : {}))
          .toList();
    }

    return CampingDestination(
      name: json['name'] ?? '',
      imagePath: json['imagePath'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      gears: gearsList,
    );
  }
}

/// Widget RecommendedGearTripPage
/// * Deskripsi:
/// - Widget utama yang menampilkan halaman daftar rekomendasi destinasi camping.
/// - Memiliki fitur pencarian untuk memfilter destinasi.
/// - Merupakan StatefulWidget karena perlu mengelola state seperti query pencarian, daftar destinasi yang difilter, dan status loading.
class RecommendedGearTripPage extends StatefulWidget {
  const RecommendedGearTripPage({super.key});

  @override
  State<RecommendedGearTripPage> createState() =>
      _RecommendedGearTripPageState();
}

/// State untuk widget RecommendedGearTripPage
/// * Deskripsi:
/// - Mengelola semua state dan logika untuk halaman RecommendedGearTripPage.
/// - Menangani pengambilan data (saat ini disimulasikan), logika filter pencarian, dan siklus hidup widget.
class _RecommendedGearTripPageState extends State<RecommendedGearTripPage> {
  // Controller untuk text field pencarian.
  final TextEditingController searchController = TextEditingController();
  // List untuk menyimpan destinasi yang sudah difilter sesuai pencarian.
  List<CampingDestination> filteredDestinations = [];
  // Status untuk menandakan proses pengambilan data sedang berlangsung.
  bool isLoading = false;
  // List untuk menyimpan semua data destinasi (saat ini hardcoded).
  late List<CampingDestination> hardcodedDestinations;

  /* Fungsi ini mengambil dan memfilter data destinasi berdasarkan query.
   * * Saat ini, fungsi ini menyimulasikan pengambilan data jaringan dengan Future.delayed dan memfilter data hardcoded.
   * * Parameter:
   * - query: String dari input pencarian untuk memfilter destinasi.
   */
  Future<void> fetchDestinations(String query) async {
    if (!mounted) return; // Mencegah error jika widget sudah di-dispose.

    setState(() {
      isLoading = true;
    });

    try {
      // Menyimulasikan jeda jaringan selama 1 detik.
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      setState(() {
        // Logika filter: mencocokkan query dengan nama atau lokasi destinasi.
        filteredDestinations = hardcodedDestinations
            .where((destination) =>
                destination.name.toLowerCase().contains(query.toLowerCase()) ||
                destination.location
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();

        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        filteredDestinations = [];
        isLoading = false;
      });
    }
  }

  /* Fungsi ini dijalankan sekali saat state pertama kali dibuat.
   * * Menginisialisasi data destinasi hardcoded dan memanggil fetchDestinations untuk memuat data awal.
   */
  @override
  void initState() {
    super.initState();

    // Inisialisasi data destinasi hardcoded.
    hardcodedDestinations = [
      CampingDestination(
        name: "Mount Fuji",
        imagePath:
            "http://localhost:8000/images/assets_DestinationCamp/gunung1.jpg",
        location: "Japan",
        description: "A beautiful mountain for hiking and camping.",
        gears: [
          RecommendedGear(
              name: "Tent",
              imagePath:
                  "http://localhost:8000/images/assets_Categories/cat_Jaket.png",
              price: 100),
          RecommendedGear(
              name: "Sleeping Bag",
              imagePath:
                  "http://localhost:8000/images/assets_Categories/cat_Sepatu.png",
              price: 50),
        ],
      ),
      CampingDestination(
        name: "Banff National Park",
        imagePath:
            "http://localhost:8000/images/assets_DestinationCamp/gunung2.jpg",
        location: "Canada",
        description: "Stunning lakes and mountainous terrain.",
        gears: [
          RecommendedGear(
              name: "Hiking Boots",
              imagePath:
                  "http://localhost:8000/images/assets_Categories/cat_Tenda.png",
              price: 120),
          RecommendedGear(
              name: "Camping Stove",
              imagePath:
                  "http://localhost:8000/images/assets_Categories/cat_Tas.png",
              price: 60),
        ],
      ),
      CampingDestination(
        name: "Mount Fuji",
        imagePath:
            "http://localhost:8000/images/assets_DestinationCamp/gunung3.jpg",
        location: "Japan",
        description: "A beautiful mountain for hiking and camping.",
        gears: [
          RecommendedGear(
              name: "Tent",
              imagePath:
                  "http://localhost:8000/images/assets_Categories/cat_Jaket.png",
              price: 100),
          RecommendedGear(
              name: "Sleeping Bag",
              imagePath:
                  "http://localhost:8000/images/assets_Categories/cat_Sepatu.png",
              price: 50),
        ],
      ),
      CampingDestination(
        name: "Banff National Park",
        imagePath:
            "http://localhost:8000/images/assets_DestinationCamp/gunung4.jpg",
        location: "Canada",
        description: "Stunning lakes and mountainous terrain.",
        gears: [
          RecommendedGear(
              name: "Hiking Boots",
              imagePath:
                  "http://localhost:8000/images/assets_Categories/cat_Tenda.png",
              price: 120),
          RecommendedGear(
              name: "Camping Stove",
              imagePath:
                  "http://localhost:8000/images/assets_Categories/cat_Tas.png",
              price: 60),
        ],
      ),
    ];

    // Mengambil data awal saat halaman dibuka.
    fetchDestinations('');
  }

  /* Fungsi ini dijalankan saat widget di-dispose dari tree.
   * * Membersihkan controller untuk mencegah memory leak.
   */
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  /* Fungsi ini membangun seluruh UI halaman.
   * * Parameter:
   * - context: Konteks build dari Flutter.
   * * Return: Widget Scaffold yang berisi AppBar, search bar, dan daftar destinasi.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Destinasi Camping",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      // Body utama menggunakan Column untuk menyusun search bar dan daftar.
      body: Column(
        children: [
          // Padding untuk search bar.
          Padding(
            padding: const EdgeInsets.all(16),
            // Container untuk styling search bar.
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: const Offset(0, 2))
                ],
              ),
              // Widget TextField untuk input pencarian.
              child: TextField(
                controller: searchController,
                onChanged:
                    fetchDestinations, // Memanggil filter setiap kali teks berubah.
                decoration: const InputDecoration(
                  hintText: 'Cari destinasi...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          // Menampilkan indikator loading atau daftar destinasi.
          isLoading
              ? const Center(
                  child:
                      CircularProgressIndicator()) // Tampilkan loading jika isLoading true.
              : Expanded(
                  // Jika tidak ada destinasi yang ditemukan, tampilkan pesan.
                  child: filteredDestinations.isEmpty
                      ? const Center(
                          child: Text("Tidak ada destinasi yang ditemukan",
                              style: TextStyle(color: Colors.grey)))
                      // Jika ada, tampilkan ListView.
                      : ListView.builder(
                          itemCount: filteredDestinations.length,
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            final destination = filteredDestinations[index];
                            // Container untuk setiap kartu destinasi.
                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2))
                                ],
                              ),
                              // ClipRRect untuk memastikan semua konten memiliki sudut melengkung.
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                // ExpansionTile untuk membuat kartu yang bisa diperluas.
                                child: Material(
                                  color: Colors.white,
                                  child: ExpansionTile(
                                    tilePadding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    childrenPadding: EdgeInsets.zero,
                                    expandedCrossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // 'title' dari ExpansionTile adalah konten yang terlihat saat kartu tertutup.
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Widget gambar utama destinasi.
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            // Menggunakan Image.network karena path dari API.
                                            destination.imagePath,
                                            width: double.infinity,
                                            height: 150,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                Container(
                                                    height: 150,
                                                    color: Colors.grey[300],
                                                    child: const Center(
                                                        child: Icon(
                                                            Icons
                                                                .image_not_supported,
                                                            color:
                                                                Colors.white))),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        // Info nama dan lokasi destinasi.
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Widget Text untuk nama destinasi.
                                                  Text(destination.name,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          color: Colors.black)),
                                                  const SizedBox(height: 4),
                                                  // Row untuk ikon lokasi dan nama lokasi.
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.location_on,
                                                          size: 16,
                                                          color: Colors.green),
                                                      const SizedBox(width: 4),
                                                      Text(destination.location,
                                                          style: TextStyle(
                                                              color: Colors.grey
                                                                  .shade700,
                                                              fontSize: 14)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Badge untuk jumlah perlengkapan yang direkomendasikan.
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                  color: Colors.green
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .shopping_bag_outlined,
                                                      size: 16,
                                                      color: Colors.green[700]),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                      "${destination.gears.length} Items",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.green[700],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        // Widget Text untuk deskripsi singkat destinasi.
                                        Text(destination.description,
                                            style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 13),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis),
                                      ],
                                    ),
                                    // 'children' dari ExpansionTile adalah konten yang terlihat saat kartu diperluas.
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Divider(),
                                            // Judul untuk daftar perlengkapan.
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8),
                                              child: Text(
                                                  "Perlengkapan yang Direkomendasikan",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14)),
                                            ),
                                            // Memetakan daftar gear menjadi list widget.
                                            ...destination.gears.map((gear) {
                                              // Container untuk setiap item gear.
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 12),
                                                padding:
                                                    const EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade50,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade200,
                                                        width: 1)),
                                                child: Row(
                                                  children: [
                                                    // Gambar kecil untuk gear.
                                                    Container(
                                                      width: 60,
                                                      height: 60,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.05),
                                                                blurRadius: 5,
                                                                offset:
                                                                    const Offset(
                                                                        0, 2))
                                                          ]),
                                                      child: Image.network(
                                                          gear.imagePath,
                                                          fit: BoxFit.contain,
                                                          errorBuilder: (context,
                                                                  error,
                                                                  stackTrace) =>
                                                              const Icon(
                                                                  Icons
                                                                      .image_not_supported,
                                                                  color: Colors
                                                                      .grey)),
                                                    ),
                                                    const SizedBox(width: 16),
                                                    // Kolom untuk nama dan harga gear.
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(gear.name,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      15)),
                                                          const SizedBox(
                                                              height: 4),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .attach_money,
                                                                  size: 16,
                                                                  color: Colors
                                                                          .green[
                                                                      700]),
                                                              const SizedBox(
                                                                  width: 4),
                                                              Text(
                                                                  gear.price
                                                                      .toStringAsFixed(
                                                                          2),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade700)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
        ],
      ),
    );
  }
}
