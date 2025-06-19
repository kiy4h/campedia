/// File        : product_review_page.dart
/// Dibuat oleh  : Tim Provis
/// Tanggal      : 16-06-2025
/// Deskripsi    : Halaman ini menyediakan antarmuka bagi pengguna untuk memberikan ulasan produk,
/// termasuk rating bintang dan kolom teks review. Setelah submit, dialog konfirmasi akan muncul.
/// Dependencies :
/// - flutter/material.dart: Pustaka dasar Flutter untuk membangun UI.
/// - ../../beranda/home.dart: Mengimpor halaman beranda aplikasi untuk navigasi setelah ulasan berhasil.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../beranda/home.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/api_service.dart';
import '../../../models/models.dart';
import 'historyPenyewaan.dart';

/// Widget [ProductReviewPage]
///
/// Deskripsi:
/// - Halaman ini adalah formulir untuk mengumpulkan ulasan produk dari pengguna.
/// - Ini adalah bagian dari alur pemberian feedback pengguna terhadap produk yang telah digunakan.
/// - Merupakan StatefulWidget karena rating dan konten review dapat berubah berdasarkan interaksi pengguna.
class ProductReviewPage extends StatefulWidget {
  // Nama produk yang akan diulas, diterima sebagai parameter wajib.
  final String productName;
  // URL gambar produk yang akan diulas, diterima sebagai parameter wajib.
  final String productImage;
  // ID barang untuk keperluan API
  final int barangId;

  const ProductReviewPage({
    super.key,
    required this.productName,
    required this.productImage,
    required this.barangId,
  });

  /* Fungsi ini membuat dan mengembalikan instance dari [_ProductReviewPageState].
   *
   * Return: Sebuah instance dari [_ProductReviewPageState].
   */
  @override
  ProductReviewPageState createState() => ProductReviewPageState();
}

/// Widget [_ProductReviewPageState]
///
/// Deskripsi:
/// - State yang terkait dengan [ProductReviewPage].
/// - Mengelola nilai rating yang dipilih pengguna dan input teks ulasan.
/// - Bertanggung jawab untuk membangun dan memperbarui UI berdasarkan interaksi pengguna.
class ProductReviewPageState extends State<ProductReviewPage> {
  // Variabel untuk menyimpan nilai rating saat ini, defaultnya 5.0 (bintang penuh).
  double _rating = 5.0;
  // Controller untuk mengelola input teks dari kolom ulasan.
  final TextEditingController _controller = TextEditingController();
  // State untuk loading submit review
  bool _isSubmittingReview = false;

  /* Fungsi ini membangun ikon bintang individual berdasarkan indeks.
   *
   * Parameter:
   * - [index]: Posisi bintang (0-4) yang akan dibangun.
   *
   * Return: Widget [IconButton] yang menampilkan ikon bintang (penuh, setengah, atau kosong).
   */
  Widget _buildStar(int index) {
    IconData icon;
    // Menentukan ikon bintang berdasarkan nilai rating saat ini.
    if (_rating >= index + 1) {
      icon = Icons
          .star; // Bintang penuh jika rating lebih besar atau sama dengan indeks + 1
    } else if (_rating > index && _rating < index + 1) {
      icon = Icons
          .star_half; // Bintang setengah jika rating di antara indeks dan indeks + 1
    } else {
      icon = Icons
          .star_border; // Bintang kosong jika rating kurang dari atau sama dengan indeks
    }

    // Mengembalikan widget IconButton yang bisa ditekan untuk memberi rating.
    return IconButton(
      onPressed: () {
        setState(() {
          _rating = index + 1.0; // Set rating berdasarkan bintang yang ditekan
        });
      },
      icon: Icon(
        icon,
        color: Colors.amber, // Warna bintang amber (kuning emas)
        size: 40, // Ukuran bintang
      ),
    );
  }

  /* Fungsi ini membersihkan controller teks saat widget ini dihapus dari pohon widget.
   * Ini penting untuk mencegah memory leak.
   *
   * Parameter: Tidak ada.
   *
   * Return: Tidak ada.
   */
  @override
  void dispose() {
    _controller.dispose(); // Membuang controller.
    super.dispose();
  }

  /* Fungsi ini menangani submit review ke API
   *
   * Parameter: Tidak ada.
   *
   * Return: Tidak ada (Future<void>).
   */
  Future<void> _submitReview() async {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);

  if (!authProvider.isAuthenticated || authProvider.user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Silakan login terlebih dahulu'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  setState(() {
    _isSubmittingReview = true;
  });

  try {
    final reviewRequest = ReviewRequest(
      rating: _rating.toInt(),
      ulasan: _controller.text.trim(),
      userId: authProvider.user!.userId,
      barangId: widget.barangId,
    );

    final response = await ApiService.addReview(reviewRequest);

    if (!mounted) return;

    if (response.success) {

      // Navigasi ke halaman ModernTransactionPage, dan hapus semua halaman sebelumnya
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const ModernTransactionPage()),
        (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error ?? 'Gagal mengirim review'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Terjadi kesalahan: $e'),
        backgroundColor: Colors.red,
      ),
    );
  } finally {
    if (mounted) {
      setState(() {
        _isSubmittingReview = false;
      });
    }
  }
}


  /* Fungsi ini menampilkan dialog konfirmasi setelah ulasan berhasil dikirim.
   *
   * Parameter:
   * - [context]: BuildContext dari widget.
   *
   * Return: Tidak ada (void).
   */
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) => AlertDialog(
        /** Widget [Text]
         * * Deskripsi:
         * - Judul dialog konfirmasi.
         */
        title: const Text('Terima Kasih!'),
        /** Widget [Text]
         * * Deskripsi:
         * - Isi pesan konfirmasi ulasan yang telah berhasil dikirim.
         */
        content: const Text(
            'Ulasan Anda telah berhasil dikirim. Kami sangat menghargai masukan Anda.'),
        actions: [
          /** Widget [TextButton]
           * * Deskripsi:
           * - Tombol 'OK' di dalam dialog.
           * - Ketika ditekan, dialog akan ditutup dan pengguna dinavigasi kembali ke halaman beranda.
           */
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Menutup dialog saat tombol 'OK' ditekan.
              // Navigasi ke halaman Home dan menghapus semua rute sebelumnya dari stack.
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

  /* Fungsi ini membangun seluruh struktur UI dari halaman ulasan produk.
   *
   * Parameter:
   * - [context]: BuildContext dari widget.
   *
   * Return: Sebuah widget [Scaffold] yang berisi AppBar dan body halaman.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Mengatur warna latar belakang halaman menjadi putih.
      /** Widget [AppBar]
       * * Deskripsi:
       * - Bilah aplikasi di bagian atas halaman.
       * - Berisi tombol kembali dan judul halaman "Ulasan Produk".
       */
      appBar: AppBar(
        elevation: 0, // Menghilangkan bayangan di bawah AppBar.
        backgroundColor: Colors.white, // Warna latar belakang AppBar.
        /** Widget [IconButton]
         * * Deskripsi:
         * - Tombol navigasi kembali ke halaman sebelumnya.
         */
        leading: IconButton(
          /** Widget [Icon]
           * * Deskripsi:
           * - Ikon panah kembali berwarna hitam.
           */
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(
              context), // Aksi untuk kembali ke halaman sebelumnya.
        ),
        /** Widget [Text]
         * * Deskripsi:
         * - Judul halaman "Ulasan Produk" di tengah AppBar.
         * - Gaya teks dengan font tebal dan ukuran 20.
         */
        title: const Text(
          'Ulasan Produk',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true, // Memusatkan judul di AppBar.
      ),
      /** Widget [SingleChildScrollView]
       * * Deskripsi:
       * - Memungkinkan konten di dalam body dapat digulir jika melebihi tinggi layar.
       * - Memberikan padding horizontal untuk konten.
       */
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        /** Widget [Column]
         * * Deskripsi:
         * - Mengatur tata letak elemen-elemen UI secara vertikal.
         * - Elemen-elemen ini dipusatkan secara horizontal.
         */
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // Spasi vertikal.

            // --- Gambar Produk ---
            /** Widget [Container]
             * * Deskripsi:
             * - Container untuk menampilkan gambar produk.
             * - Memiliki tinggi dan lebar penuh, dengan border radius dan warna latar abu-abu muda.
             */
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200,
              ),
              /** Widget [ClipRRect]
               * * Deskripsi:
               * - Memastikan gambar produk dipotong sesuai dengan border radius container.
               */
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                /** Widget [Image.network]
                 * * Deskripsi:
                 * - Menampilkan gambar produk dari URL.
                 * - Parameter `widget.productImage` adalah data dinamis.
                 * - Menyertakan `errorBuilder` untuk menampilkan ikon placeholder jika gambar gagal dimuat.
                 */
                child: Image.network(
                  widget.productImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    /** Widget [Center]
                     * * Deskripsi:
                     * - Memusatkan ikon placeholder jika gambar tidak dapat dimuat.
                     */
                    return const Center(
                      /** Widget [Icon]
                       * * Deskripsi:
                       * - Ikon placeholder 'image_not_supported' jika gambar gagal dimuat.
                       */
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

            const SizedBox(height: 24), // Spasi vertikal.

            // --- Nama Produk ---
            /** Widget [Text]
             * * Deskripsi:
             * - Menampilkan **nama produk** yang akan diulas.
             * - `widget.productName` adalah data dinamis yang diteruskan ke halaman ini.
             * - Gaya teks dengan font tebal dan ukuran 24.
             */
            Text(
              widget.productName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12), // Spasi vertikal.

            /** Widget [Text]
             * * Deskripsi:
             * - Judul ajakan untuk membagikan pengalaman.
             * - Gaya teks dengan font tebal dan ukuran 22.
             */
            const Text(
              'Bagikan Pengalaman Anda',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12), // Spasi vertikal.

            /** Widget [Text]
             * * Deskripsi:
             * - Teks deskriptif yang menjelaskan tujuan ulasan.
             * - Teks diatur di tengah dengan warna abu-abu.
             */
            const Text(
              'Bagaimana pengalaman Anda menggunakan produk ini? Berikan penilaian dan ulasan untuk membantu pengguna lain!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24), // Spasi vertikal.

            // --- Nilai Rating Angka ---
            /** Widget [Text]
             * * Deskripsi:
             * - Menampilkan **nilai rating saat ini** (misalnya "5.0") dalam format angka.
             * - Nilai ini berubah secara dinamis saat pengguna berinteraksi dengan bintang.
             */
            Text(
              _rating.toStringAsFixed(
                  1), // Menampilkan nilai rating dengan satu angka di belakang koma.
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12), // Spasi vertikal.

            // --- Bintang ---
            /** Widget [Row]
             * * Deskripsi:
             * - Mengatur tata letak lima ikon bintang rating secara horizontal di tengah.
             */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  5, (index) => _buildStar(index)), // Membangun 5 bintang.
            ),

            const SizedBox(height: 24), // Spasi vertikal.

            // --- Kolom Review ---
            /** Widget [Container]
             * * Deskripsi:
             * - Container yang membungkus [TextField] untuk kolom ulasan.
             * - Memiliki border radius dan border abu-abu muda.
             */
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              /** Widget [TextField]
               * * Deskripsi:
               * - Bidang input teks multi-baris untuk pengguna menulis ulasan produk mereka.
               * - Placeholder teks memberikan panduan kepada pengguna.
               */
              child: TextField(
                controller: _controller, // Mengikat TextField ke controller.
                maxLines: 5, // Mengizinkan maksimal 5 baris teks.
                textAlignVertical: TextAlignVertical
                    .top, // Mengatur teks agar dimulai dari atas.
                decoration: const InputDecoration(
                  hintText:
                      'Ceritakan pendapat Anda tentang kualitas, fungsi, atau kenyamanan produk ini...', // Placeholder teks.
                  contentPadding:
                      EdgeInsets.all(16.0), // Padding internal TextField.
                  border: InputBorder
                      .none, // Menghilangkan border default TextField.
                ),
              ),
            ),

            const SizedBox(height: 36), // Spasi vertikal.

            // --- Tombol Kirim ---
            /** Widget [SizedBox]
             * * Deskripsi:
             * - Menetapkan lebar penuh dan tinggi tetap untuk tombol "KIRIM ULASAN".
             */
            SizedBox(
              width: double.infinity, // Lebar tombol memenuhi lebar layar.
              height: 54, // Tinggi tombol.
              /** Widget [ElevatedButton]
               * * Deskripsi:
               * - Tombol utama untuk mengirimkan ulasan.
               * - Ketika ditekan, akan memicu submit review ke API.
               */
              child: ElevatedButton(
                onPressed: _isSubmittingReview ? null : _submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                      0xFF627D2C), // Warna latar belakang tombol (hijau zaitun).
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(25), // Sudut tombol membulat.
                  ),
                ),
                /** Widget [Text] or [CircularProgressIndicator]
                 * * Deskripsi:
                 * - Teks pada tombol "KIRIM ULASAN" atau loading indicator.
                 * - Gaya teks dengan font tebal, ukuran 18, dan warna putih.
                 */
                child: _isSubmittingReview
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'KIRIM ULASAN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 24), // Spasi vertikal di bagian bawah.
          ],
        ),
      ),
    );
  }
}