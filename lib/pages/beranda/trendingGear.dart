/**
 * File         : trendingGear.dart
 * Dibuat oleh  : Izzuddin Azzam, Al Ghifari
 * Tanggal      : 16-06-2025
 * Deskripsi    : File ini berisi model data dan komponen UI untuk menampilkan peralatan camping 
 * yang sedang populer, lengkap dengan detail produk dan testimoni pengguna.
 * Ketergantungan (Dependencies) : 
 * - flutter/material.dart: digunakan untuk membuat seluruh antarmuka pengguna dan komponen visual.
 */

import 'package:flutter/material.dart';

/** Model TrendingGear
 * * Deskripsi:
 * - Kelas ini adalah model data yang merepresentasikan satu item peralatan camping yang sedang tren.
 * - Menyimpan properti seperti nama, gambar, harga, rating, status best seller, dan daftar testimoni.
 * - Bukan merupakan widget, melainkan kelas biasa untuk struktur data.
 */
class TrendingGear {
  final String name;
  final String imagePath;
  final double price;
  final int rating;
  final bool isBestSeller;
  final List<Testimonial> testimonials;

  TrendingGear({
    required this.name,
    required this.imagePath,
    required this.price,
    this.rating = 0,
    this.isBestSeller = false,
    this.testimonials = const [],
  });
}

/** Model Testimonial
 * * Deskripsi:
 * - Kelas model data yang menyimpan informasi satu buah testimoni dari pengguna.
 * - Berisi nama pengguna, gambar profil, isi komentar, rating yang diberikan, dan tanggal testimoni.
 */
class Testimonial {
  final String userName;
  final String userImage;
  final String comment;
  final double rating;
  final String date;

  Testimonial({
    required this.userName,
    required this.userImage,
    required this.comment,
    required this.rating,
    required this.date,
  });
}

/** Widget TrendingGearPage
 * * Deskripsi:
 * - Widget utama yang menampilkan seluruh halaman "Trending Gear".
 * - Menampilkan daftar peralatan populer dalam bentuk kartu yang interaktif.
 * - Merupakan StatefulWidget karena menampung data yang diinisialisasi dalam state.
 */
class TrendingGearPage extends StatefulWidget {
  const TrendingGearPage({super.key});

  @override
  State<TrendingGearPage> createState() => _TrendingGearPageState();
}

/** State untuk widget TrendingGearPage
 * * Deskripsi:
 * - Mengelola state dan logika untuk halaman TrendingGearPage.
 * - Menginisialisasi daftar peralatan trending (saat ini dengan data statis).
 * - Mengatur logika untuk menampilkan detail produk dalam modal bottom sheet.
 */
class _TrendingGearPageState extends State<TrendingGearPage> {
  // List untuk menyimpan objek-objek TrendingGear.
  List<TrendingGear> trendingGears = [];

  /* Fungsi ini dijalankan sekali saat state pertama kali dibuat.
   * * Menginisialisasi state `trendingGears` dengan data peralatan statis/hardcoded.
   */
  @override
  void initState() {
    super.initState();
    // Mengisi list dengan data contoh peralatan trending.
    trendingGears = [
      TrendingGear(name: "Tenda Dome", imagePath: "images/assets_Categories/cat_Tenda.png", price: 250.0, rating: 5, isBestSeller: true, testimonials: [Testimonial(userName: "Ahmad Rizky", userImage: "https://randomuser.me/api/portraits/men/32.jpg", comment: "Tenda sangat nyaman dan mudah dipasang. Tahan hujan selama camping di Ranca Upas 2 hari.", rating: 5.0, date: "24 Apr 2025"), Testimonial(userName: "Dinda Putri", userImage: "https://randomuser.me/api/portraits/women/44.jpg", comment: "Sewanya murah, kualitas tenda bagus. Recommended!", rating: 5.0, date: "15 Apr 2025"), Testimonial(userName: "Budi Santoso", userImage: "https://randomuser.me/api/portraits/men/55.jpg", comment: "Sempat kebingungan saat memasang, tapi secara keseluruhan tenda berkualitas baik.", rating: 4.0, date: "30 Mar 2025"), ], ),
      TrendingGear(name: "Sleeping Bag", imagePath: "images/assets_Categories/cat_Sepatu.png", price: 150.0, rating: 4, testimonials: [Testimonial(userName: "Annisa Rahma", userImage: "https://randomuser.me/api/portraits/women/22.jpg", comment: "Sleeping bag-nya hangat dan nyaman. Cocok untuk area camping dengan suhu rendah.", rating: 5.0, date: "20 Apr 2025"), Testimonial(userName: "Rudi Hermawan", userImage: "https://randomuser.me/api/portraits/men/41.jpg", comment: "Ukurannya pas dan ringan untuk dibawa dalam carrier.", rating: 4.0, date: "12 Apr 2025"), ], ),
      TrendingGear(name: "Kompor Portable", imagePath: "images/assets_Categories/cat_Tas.png", price: 75.0, rating: 3, isBestSeller: true, testimonials: [Testimonial(userName: "Maya Lestari", userImage: "https://randomuser.me/api/portraits/women/28.jpg", comment: "Kompor hemat gas dan mudah dinyalakan. Sangat membantu untuk camping.", rating: 4.0, date: "22 Apr 2025"), Testimonial(userName: "Eko Purnomo", userImage: "https://randomuser.me/api/portraits/men/74.jpg", comment: "Agak lambat memanaskan air, tapi cukup baik untuk masak instan.", rating: 3.0, date: "15 Apr 2025"), Testimonial(userName: "Siti Nuraini", userImage: "https://randomuser.me/api/portraits/women/62.jpg", comment: "Ringan dan praktis dibawa kemana-mana.", rating: 5.0, date: "5 Apr 2025"), ], ),
    ];
  }

  /* Fungsi ini menampilkan detail peralatan dalam sebuah modal bottom sheet yang dapat di-scroll.
   * * Parameter:
   * - gear: Objek TrendingGear yang akan ditampilkan detailnya.
   */
  void _showGearDetails(TrendingGear gear) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Memungkinkan sheet menempati lebih dari separuh layar dan dapat di-scroll.
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        // DraggableScrollableSheet untuk membuat sheet yang ukurannya bisa diubah dengan drag.
        return DraggableScrollableSheet(
          initialChildSize: 0.6, // Ukuran awal sheet saat pertama kali muncul (60% layar).
          minChildSize: 0.4,     // Ukuran minimum saat di-drag ke bawah.
          maxChildSize: 0.9,     // Ukuran maksimum saat di-drag ke atas.
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                // Handle (garis abu-abu) sebagai indikator visual untuk drag.
                Container(width: 40, height: 5, margin: const EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2.5))),
                // Expanded agar konten ListView mengisi sisa ruang di dalam sheet.
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    children: [
                      // Bagian header yang berisi gambar dan info utama produk.
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Gambar produk
                          Container(width: 100, height: 100, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(image: AssetImage(gear.imagePath), fit: BoxFit.cover))),
                          const SizedBox(width: 16),
                          // Info teks produk (nama, rating, harga).
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(gear.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 6),
                                // Menampilkan rating bintang secara dinamis.
                                Row(children: List.generate(5, (i) => Icon(i < gear.rating ? Icons.star : Icons.star_border, size: 18, color: Colors.amber))),
                                const SizedBox(height: 6),
                                // Menampilkan harga sewa per hari.
                                Row(children: [Icon(Icons.attach_money, color: Colors.green[700], size: 20), Text("${gear.price.toStringAsFixed(2)}/hari", style: TextStyle(fontSize: 16, color: Colors.grey.shade700))]),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Bagian deskripsi produk.
                      const Text("Deskripsi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text("Sewa ${gear.name} berkualitas terbaik untuk kebutuhan camping dan outdoor Anda. Peralatan kami terawat dan selalu diperiksa setelah penyewaan untuk memastikan kualitas dan keamanan.", style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
                      const SizedBox(height: 24),
                      // Bagian spesifikasi produk (contoh data statis).
                      const Text("Spesifikasi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      _buildSpecificationItem("Merek", "Adventure Pro"),
                      _buildSpecificationItem("Berat", "2.5 kg"),
                      _buildSpecificationItem("Dimensi", gear.name == "Tenda Dome" ? "210 x 150 x 110 cm" : "Standar"),
                      _buildSpecificationItem("Material", gear.name == "Tenda Dome" ? "Polyester Waterproof" : "Berkualitas"),
                      const SizedBox(height: 24),
                      // Bagian tombol aksi (Sewa dan Wishlist).
                      Row(
                        children: [
                          // Tombol "Sewa Sekarang".
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${gear.name} ditambahkan ke keranjang!")));
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                              child: const Text("Sewa Sekarang", style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Tombol "Wishlist" (ikon hati).
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${gear.name} ditambahkan ke wishlist!")));
                              },
                              style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12), side: const BorderSide(color: Colors.redAccent), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                              child: const Icon(Icons.favorite_border, color: Colors.redAccent),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Bagian header untuk testimoni.
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Testimoni Pengguna", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("${gear.testimonials.length} ulasan", style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Menampilkan daftar testimoni dengan memetakan list testimoni menjadi widget.
                      ...gear.testimonials.map((testimonial) => _buildTestimonialItem(testimonial)),
                      const SizedBox(height: 24),
                      // Tombol untuk menutup bottom sheet.
                      SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => Navigator.pop(context), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text("Tutup", style: TextStyle(fontWeight: FontWeight.bold)))),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /* Fungsi helper untuk membangun satu baris item spesifikasi.
   * * Parameter:
   * - label: Teks untuk label spesifikasi (misal: "Merek").
   * - value: Teks untuk nilai spesifikasi (misal: "Adventure Pro").
   * * Return: Widget Row yang berisi label dan nilai.
   */
  Widget _buildSpecificationItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label, style: TextStyle(fontSize: 14, color: Colors.grey.shade600))),
          Expanded(flex: 3, child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  /* Fungsi helper untuk membangun satu kartu testimoni.
   * * Parameter:
   * - testimonial: Objek Testimonial yang berisi data testimoni.
   * * Return: Widget Container yang berisi visual satu testimoni.
   */
  Widget _buildTestimonialItem(Testimonial testimonial) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row untuk info pengguna dan rating.
          Row(
            children: [
              // Avatar pengguna.
              CircleAvatar(radius: 20, backgroundImage: NetworkImage(testimonial.userImage)),
              const SizedBox(width: 12),
              // Nama dan tanggal.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(testimonial.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(testimonial.date, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              // Rating bintang.
              Row(children: List.generate(5, (i) => Icon(i < testimonial.rating ? Icons.star : Icons.star_border, size: 14, color: Colors.amber))),
            ],
          ),
          const SizedBox(height: 12),
          // Teks komentar dari pengguna.
          Text(testimonial.comment, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  /* Fungsi ini membangun seluruh UI untuk halaman "Trending Gear".
   * * Parameter:
   * - context: Konteks build dari Flutter.
   * * Return: Widget Scaffold yang berisi AppBar, daftar peralatan, dan Floating Action Button.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar halaman.
      appBar: AppBar(
        title: const Text("Trending Gear", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        // Tombol aksi untuk pencarian dan filter (fungsionalitas belum diimplementasikan).
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Colors.black), onPressed: () {}),
          IconButton(icon: const Icon(Icons.filter_list, color: Colors.black), onPressed: () {}),
        ],
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      // Body utama menggunakan ListView untuk menampilkan daftar gear.
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: trendingGears.length,
        itemBuilder: (context, index) {
          final gear = trendingGears[index];
          // GestureDetector untuk membuat setiap item list dapat diklik.
          return GestureDetector(
            onTap: () => _showGearDetails(gear), // Menampilkan detail saat diklik.
            // Container sebagai kartu untuk setiap item.
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))]),
              child: Row(
                children: [
                  // Gambar produk dengan badge.
                  Stack(
                    children: [
                      Container(width: 90, height: 90, margin: const EdgeInsets.all(12), decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), image: DecorationImage(image: AssetImage(gear.imagePath), fit: BoxFit.cover))),
                      // Badge "Best" jika item adalah best seller.
                      if (gear.isBestSeller)
                        Positioned(top: 18, right: 18, child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(12)), child: const Text("Best", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
                      // Badge ikon komentar sebagai indikator adanya testimoni.
                      Positioned(bottom: 18, left: 18, child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.8), shape: BoxShape.circle), child: const Icon(Icons.comment, color: Colors.white, size: 12))),
                    ],
                  ),
                  // Informasi teks produk.
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(gear.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Row(children: List.generate(5, (i) => Icon(i < gear.rating ? Icons.star : Icons.star_border, size: 16, color: Colors.amber))),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [Icon(Icons.attach_money, size: 16, color: Colors.green[700]), Text("${gear.price.toStringAsFixed(2)}/hari", style: TextStyle(fontSize: 14, color: Colors.grey.shade700))]),
                              Row(
                                children: [
                                  // Menampilkan jumlah testimoni.
                                  Text("${gear.testimonials.length}", style: TextStyle(fontSize: 12, color: Colors.blue.shade700)),
                                  const SizedBox(width: 4),
                                  Icon(Icons.comment, size: 14, color: Colors.blue.shade700),
                                  const SizedBox(width: 8),
                                  // Ikon Wishlist.
                                  GestureDetector(onTap: () {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${gear.name} disimpan ke wishlist!")));}, child: const Icon(Icons.favorite_border, color: Colors.redAccent, size: 20)),
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
      // Tombol Aksi Mengambang (Floating Action Button) untuk keranjang.
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.shopping_cart),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Keranjang Sewa")));
        },
      ),
    );
  }
}