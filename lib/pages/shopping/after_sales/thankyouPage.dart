// Import library Flutter material untuk membangun UI
import 'package:flutter/material.dart';

// Import halaman Step1 sebagai tujuan navigasi dari tombol pelacakan
import 'step1.dart';

// Widget Stateless untuk halaman ucapan terima kasih setelah pemesanan berhasil
class ThankYouPage extends StatelessWidget {
  const ThankYouPage({super.key});

  // Method utama untuk membangun UI halaman
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F4), // Warna latar belakang halaman
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // === Header dengan judul "Pesanan Berhasil!" ===
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  "Pesanan Berhasil!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF627D2C),
                  ),
                ),
              ),
            ),

            // === Bagian utama isi halaman ===
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // --- Ikon sukses (ikon centang dalam lingkaran) ---
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8F0DD),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: Color(0xFF627D2C),
                        size: 50,
                      ),
                    ),
                    
                    // --- Teks ucapan terima kasih dan konfirmasi ---
                    Column(
                      children: const [
                        Text(
                          "Terima Kasih!",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF627D2C),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Pesanan Anda telah dikonfirmasi",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF8A8A8A),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    
                    // --- Informasi Pesanan: Order ID dan Tanggal ---
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Baris: Order ID
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Order ID",
                                style: TextStyle(
                                  color: Color(0xFF8A8A8A),
                                ),
                              ),
                              Text(
                                "#PLT2505-001",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          // Baris: Tanggal Pesanan
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Tanggal",
                                style: TextStyle(
                                  color: Color(0xFF8A8A8A),
                                ),
                              ),
                              Text(
                                "1 Mei 2025",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                
                    // --- Gambar Ilustrasi dengan Aspect Ratio 16:9 ---
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'images/assets_OnBoarding0/onboarding4image.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
          
                    // --- Teks pengingat untuk pengguna ---
                    const Text(
                      "Pastikan untuk memeriksa daftar peralatan saat pengambilan.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // === Tombol untuk melacak pesanan ===
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, -2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF627D2C),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    // Navigasi ke halaman Step1 untuk pelacakan pesanan
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Step1Page()),
                    );
                  },
                  child: const Text(
                    "LACAK PESANAN ANDA",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
