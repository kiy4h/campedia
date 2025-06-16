/**
 * File         : product_review_page.dart
 * Dibuat oleh  : Tim Provis
 * Tanggal      : 16-06-2025
 * Deskripsi    : Halaman form ulasan produk, berisi rating bintang dan kolom review.
 *                Setelah submit, pengguna akan melihat dialog konfirmasi.
 */

import 'package:flutter/material.dart';
import '../../beranda/home.dart';

class ProductReviewPage extends StatefulWidget {
  final String productName;
  final String productImage;

  const ProductReviewPage({
    super.key,
    required this.productName,
    required this.productImage,
  });

  @override
  _ProductReviewPageState createState() => _ProductReviewPageState();
}

class _ProductReviewPageState extends State<ProductReviewPage> {
  double _rating = 5.0;
  final TextEditingController _controller = TextEditingController();

  /// Widget rating bintang
  Widget _buildStar(int index) {
    IconData icon;
    if (_rating >= index + 1) {
      icon = Icons.star;
    } else if (_rating > index && _rating < index + 1) {
      icon = Icons.star_half;
    } else {
      icon = Icons.star_border;
    }

    return IconButton(
      onPressed: () {
        setState(() {
          _rating = index + 1.0;
        });
      },
      icon: Icon(
        icon,
        size: 36,
        color: const Color(0xFF9BAE76),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Menampilkan dialog konfirmasi
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terima Kasih!'),
        content: const Text(
            'Ulasan Anda telah berhasil dikirim. Kami sangat menghargai masukan Anda.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => CampingApp()),
                (route) => false,
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// UI utama
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ulasan Produk',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Gambar Produk
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.productImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Nama Produk
            Text(
              widget.productName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),
            const Text(
              'Bagikan Pengalaman Anda',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Bagaimana pengalaman Anda menggunakan produk ini? Berikan penilaian dan ulasan untuk membantu pengguna lain!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // Nilai Rating Angka
            Text(
              _rating.toStringAsFixed(1),
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // Bintang
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => _buildStar(index)),
            ),

            const SizedBox(height: 24),

            // Kolom Review
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: _controller,
                maxLines: 5,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  hintText:
                      'Ceritakan pendapat Anda tentang kualitas, fungsi, atau kenyamanan produk ini...',
                  contentPadding: EdgeInsets.all(16.0),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 36),

            // Tombol Kirim
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Simpan ke backend kalau sudah tersedia
                  _showConfirmationDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF627D2C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'KIRIM ULASAN',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
