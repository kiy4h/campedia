import 'package:flutter/material.dart';

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

class TrendingGearPage extends StatefulWidget {
  const TrendingGearPage({super.key});

  @override
  State<TrendingGearPage> createState() => _TrendingGearPageState();
}

class _TrendingGearPageState extends State<TrendingGearPage> {
  List<TrendingGear> trendingGears = [];

  @override
  void initState() {
    super.initState();
    trendingGears = [
      TrendingGear(
        name: "Tenda Dome", 
        imagePath: "images/assets_Categories/cat_Tenda.png", 
        price: 250.0, 
        rating: 5,
        isBestSeller: true,
        testimonials: [
          Testimonial(
            userName: "Ahmad Rizky",
            userImage: "https://randomuser.me/api/portraits/men/32.jpg",
            comment: "Tenda sangat nyaman dan mudah dipasang. Tahan hujan selama camping di Ranca Upas 2 hari.",
            rating: 5.0,
            date: "24 Apr 2025",
          ),
          Testimonial(
            userName: "Dinda Putri",
            userImage: "https://randomuser.me/api/portraits/women/44.jpg",
            comment: "Sewanya murah, kualitas tenda bagus. Recommended!",
            rating: 5.0,
            date: "15 Apr 2025",
          ),
          Testimonial(
            userName: "Budi Santoso",
            userImage: "https://randomuser.me/api/portraits/men/55.jpg",
            comment: "Sempat kebingungan saat memasang, tapi secara keseluruhan tenda berkualitas baik.",
            rating: 4.0,
            date: "30 Mar 2025",
          ),
        ],
      ),
      TrendingGear(
        name: "Sleeping Bag", 
        imagePath: "images/assets_Categories/cat_Sepatu.png", 
        price: 150.0,
        rating: 4,
        testimonials: [
          Testimonial(
            userName: "Annisa Rahma",
            userImage: "https://randomuser.me/api/portraits/women/22.jpg",
            comment: "Sleeping bag-nya hangat dan nyaman. Cocok untuk area camping dengan suhu rendah.",
            rating: 5.0,
            date: "20 Apr 2025",
          ),
          Testimonial(
            userName: "Rudi Hermawan",
            userImage: "https://randomuser.me/api/portraits/men/41.jpg",
            comment: "Ukurannya pas dan ringan untuk dibawa dalam carrier.",
            rating: 4.0,
            date: "12 Apr 2025",
          ),
        ],
      ),
      TrendingGear(
        name: "Kompor Portable", 
        imagePath: "images/assets_Categories/cat_Tas.png", 
        price: 75.0,
        rating: 3,
        isBestSeller: true,
        testimonials: [
          Testimonial(
            userName: "Maya Lestari",
            userImage: "https://randomuser.me/api/portraits/women/28.jpg",
            comment: "Kompor hemat gas dan mudah dinyalakan. Sangat membantu untuk camping.",
            rating: 4.0,
            date: "22 Apr 2025",
          ),
          Testimonial(
            userName: "Eko Purnomo",
            userImage: "https://randomuser.me/api/portraits/men/74.jpg",
            comment: "Agak lambat memanaskan air, tapi cukup baik untuk masak instan.",
            rating: 3.0,
            date: "15 Apr 2025",
          ),
          Testimonial(
            userName: "Siti Nuraini",
            userImage: "https://randomuser.me/api/portraits/women/62.jpg",
            comment: "Ringan dan praktis dibawa kemana-mana.",
            rating: 5.0,
            date: "5 Apr 2025",
          ),
        ],
      ),
    ];
  }

  void _showGearDetails(TrendingGear gear) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Untuk memungkinkan scrolling jika konten panjang
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6, // Ukuran awal sheet (60% dari layar)
          minChildSize: 0.4, // Ukuran minimum sheet (40% dari layar)
          maxChildSize: 0.9, // Ukuran maksimum sheet (90% dari layar)
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                // Handle untuk drag
                Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                // Content
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    children: [
                      // Header info
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Gambar produk
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(gear.imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Info produk
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  gear.name,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: List.generate(5, (i) {
                                    return Icon(
                                      i < gear.rating ? Icons.star : Icons.star_border,
                                      size: 18,
                                      color: Colors.amber,
                                    );
                                  }),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(Icons.attach_money, color: Colors.green[700], size: 20),
                                    Text(
                                      "${gear.price.toStringAsFixed(2)}/hari",
                                      style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      
                      // Deskripsi
                      const Text(
                        "Deskripsi",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Sewa ${gear.name} berkualitas terbaik untuk kebutuhan camping dan outdoor Anda. Peralatan kami terawat dan selalu diperiksa setelah penyewaan untuk memastikan kualitas dan keamanan.",
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                      ),

                      const SizedBox(height: 24),
                      
                      // Spesifikasi (contoh)
                      const Text(
                        "Spesifikasi",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      _buildSpecificationItem("Merek", "Adventure Pro"),
                      _buildSpecificationItem("Berat", "2.5 kg"),
                      _buildSpecificationItem("Dimensi", gear.name == "Tenda Dome" ? "210 x 150 x 110 cm" : "Standar"),
                      _buildSpecificationItem("Material", gear.name == "Tenda Dome" ? "Polyester Waterproof" : "Berkualitas"),
                      
                      const SizedBox(height: 24),
                      
                      // Tombol sewa & wishlist
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("${gear.name} ditambahkan ke keranjang!")),
                                );
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text("Sewa Sekarang", style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("${gear.name} ditambahkan ke wishlist!")),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                side: const BorderSide(color: Colors.redAccent),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Icon(Icons.favorite_border, color: Colors.redAccent),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      
                      // Testimoni section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Testimoni Pengguna",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${gear.testimonials.length} ulasan",
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Testimoni items
                      ...gear.testimonials.map((testimonial) => _buildTestimonialItem(testimonial)),
                      
                      // Tombol tutup di bagian bawah
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Tutup", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        );
      },
    );
  }

  Widget _buildSpecificationItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialItem(Testimonial testimonial) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info and rating
          Row(
            children: [
              // User avatar
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(testimonial.userImage),
              ),
              const SizedBox(width: 12),
              // User name and date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      testimonial.date,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              // Rating
              Row(
                children: List.generate(5, (i) {
                  return Icon(
                    i < testimonial.rating ? Icons.star : Icons.star_border,
                    size: 14,
                    color: Colors.amber,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Comment
          Text(
            testimonial.comment,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Trending Gear",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Implementasi pencarian
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              // Implementasi filter
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: trendingGears.length,
        itemBuilder: (context, index) {
          final gear = trendingGears[index];

          return GestureDetector(
            onTap: () => _showGearDetails(gear),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Gear Image
                  Stack(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(gear.imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (gear.isBestSeller)
                        Positioned(
                          top: 18,
                          right: 18,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "Best",
                              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      // Testimoni indicator badge
                      Positioned(
                        bottom: 18,
                        left: 18,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.comment,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Gear Info
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            gear.name,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: List.generate(5, (i) {
                              return Icon(
                                i < gear.rating ? Icons.star : Icons.star_border,
                                size: 16,
                                color: Colors.amber,
                              );
                            }),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.attach_money, size: 16, color: Colors.green[700]),
                                  Text(
                                    "${gear.price.toStringAsFixed(2)}/hari",
                                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  // Testimoni count
                                  Text(
                                    "${gear.testimonials.length}",
                                    style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(Icons.comment, size: 14, color: Colors.blue.shade700),
                                  const SizedBox(width: 8),
                                  // Wishlist icon
                                  GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("${gear.name} disimpan ke wishlist!")),
                                      );
                                    },
                                    child: const Icon(Icons.favorite_border, color: Colors.redAccent, size: 20),
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.shopping_cart),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Keranjang Sewa")),
          );
        },
      ),
    );
  }
}