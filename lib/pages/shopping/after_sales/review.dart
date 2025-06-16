/**
 * File        : review_page.dart
 * Dibuat oleh  : Izzuddin Azzam
 * Tanggal      : 16-06-2025
 * Deskripsi    : Halaman ini memungkinkan pengguna untuk memberikan rating dan menulis ulasan/review
 * terhadap pengalaman mereka dalam menggunakan layanan atau produk.
 * Dependencies :
 * - flutter/material.dart: Mengimpor komponen dan widget dasar Flutter Material Design.
 * - ../../beranda/home.dart: Mengimpor halaman utama (Home) untuk navigasi setelah proses review selesai.
 */

import 'package:flutter/material.dart'; // Import library Flutter Material untuk membangun UI
import '../../beranda/home.dart'; // Import halaman Home untuk navigasi kembali setelah review selesai

/** Widget [ReviewPage]
 *
 * Deskripsi:
 * - Ini adalah widget utama untuk halaman pemberian ulasan.
 * - Widget ini memungkinkan pengguna memilih rating bintang dan menulis komentar.
 * - Ini adalah widget StatefulWidget karena memiliki state yang dapat berubah (nilai rating dan teks review).
 */
class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key}); // Konstruktor widget dengan optional key

  /* Fungsi ini membuat dan mengembalikan instance dari [_ReviewPageState].
   *
   * Return: Sebuah instance dari [_ReviewPageState].
   */
  @override
  _ReviewPageState createState() => _ReviewPageState(); // Membuat state ReviewPage
}

/** Widget [_ReviewPageState]
 *
 * Deskripsi:
 * - Ini adalah state yang terkait dengan widget [ReviewPage].
 * - Mengelola nilai rating yang dipilih pengguna dan input teks ulasan.
 * - Bertanggung jawab untuk membangun dan memperbarui UI berdasarkan interaksi pengguna.
 */
class _ReviewPageState extends State<ReviewPage> {
  double _rating = 5.0; // Menyimpan nilai rating saat ini (default 5.0), dapat berubah.
  final TextEditingController _controller = TextEditingController(); // Mengontrol input dari TextField review.

  /* Fungsi ini membangun tampilan ikon bintang individual berdasarkan indeks dan nilai rating saat ini.
   *
   * Parameter:
   * - [index]: Indeks bintang (0 hingga 4) yang sedang dibangun.
   *
   * Return: Sebuah widget [IconButton] yang merepresentasikan bintang dengan status (penuh, setengah, kosong).
   */
  Widget _buildStar(int index) {
    IconData icon;

    // Tentukan ikon yang digunakan: penuh, setengah, atau kosong
    if (_rating >= index + 1) {
      icon = Icons.star;
    } else if (_rating > index && _rating < index + 1) {
      icon = Icons.star_half;
    } else {
      icon = Icons.star_border;
    }

    // Kembalikan widget IconButton yang bisa ditekan untuk memberi rating
    return IconButton(
      onPressed: () {
        setState(() {
          _rating = index + 1.0; // Update rating saat bintang ditekan
        });
      },
      /** Widget [Icon]
       * * Deskripsi:
       * - Menampilkan ikon bintang (penuh, setengah, atau border) dengan ukuran dan warna tertentu.
       * - Warna bintang konsisten dengan tema aplikasi.
       */
      icon: Icon(
        icon,
        size: 36,
        color: const Color(0xFF9BAE76), // Warna bintang (hijau zaitun)
      ),
    );
  }

  /* Fungsi ini membersihkan sumber daya (controller) ketika widget dihapus dari pohon widget.
   *
   * Parameter:
   * - Tidak ada.
   *
   * Return: Tidak ada.
   */
  @override
  void dispose() {
    _controller.dispose(); // Bersihkan controller saat widget dihapus dari tree untuk mencegah memory leak.
    super.dispose();
  }

  /* Fungsi ini membangun seluruh struktur visual halaman ulasan.
   *
   * Parameter:
   * - [context]: BuildContext dari widget.
   *
   * Return: Sebuah widget [Scaffold] yang berisi AppBar dan body halaman.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang halaman putih

      /** Widget [AppBar]
       * * Deskripsi:
       * - Bilah aplikasi di bagian atas halaman ulasan.
       * - Menampilkan tombol "close" dan judul halaman.
       */
      appBar: AppBar(
        elevation: 0, // Tanpa bayangan di bawah AppBar
        backgroundColor: Colors.white, // Warna latar AppBar putih
        /** Widget [IconButton]
         * * Deskripsi:
         * - Tombol di sisi kiri AppBar untuk menutup halaman ulasan.
         */
        leading: IconButton(
          /** Widget [Icon]
           * * Deskripsi:
           * - Ikon silang berwarna hitam sebagai indikator tombol tutup.
           */
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Kembali ke halaman sebelumnya
        ),
        /** Widget [Text]
         * * Deskripsi:
         * - Judul halaman "Write Reviews" di tengah AppBar.
         * - Diberi gaya font **bold** dan ukuran 20.
         */
        title: const Text(
          'Write Reviews', // Judul AppBar
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true, // Judul berada di tengah AppBar
      ),

      /** Widget [Center]
       * * Deskripsi:
       * - Menempatkan konten utama halaman di tengah layar.
       */
      body: Center(
        /** Widget [Padding]
         * * Deskripsi:
         * - Memberikan padding horizontal pada konten utama halaman.
         */
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0), // Padding horizontal
          /** Widget [Column]
           * * Deskripsi:
           * - Mengatur tata letak elemen-elemen UI (teks, rating, TextField, tombol) secara vertikal.
           * - Elemen-elemen ini akan di tengah secara vertikal dan horizontal.
           */
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Tengah secara vertikal
            crossAxisAlignment: CrossAxisAlignment.center, // Tengah secara horizontal
            children: [
              /** Widget [Text]
               * * Deskripsi:
               * - Judul besar di tengah halaman yang mengajak pengguna untuk memberikan feedback.
               * - Diberi gaya font **bold** dan ukuran 24.
               */
              const Text(
                'Tell Us to Improve', // Judul utama di halaman
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12), // Jarak antar elemen

              /** Widget [Text]
               * * Deskripsi:
               * - Teks deskriptif yang menjelaskan tujuan ulasan.
               * - Teks diatur di tengah (textAlign: Center).
               */
              const Text(
                'Gimana pengalamanmu? Ceritain yuk biar yang lain juga bisa tahu serunya pakai alat kemah dari kami!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black54), // Teks penjelasan
              ),
              const SizedBox(height: 32),

              /** Widget [Text]
               * * Deskripsi:
               * - Menampilkan **nilai rating saat ini** (misalnya, "5.0").
               * - Nilai ini diperbarui secara dinamis saat pengguna memilih bintang.
               */
              Text(
                _rating.toStringAsFixed(1), // Tampilkan nilai rating (1 desimal)
                style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              /** Widget [Row]
               * * Deskripsi:
               * - Mengatur lima ikon bintang rating secara horizontal di tengah.
               */
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => _buildStar(index)), // Buat 5 bintang rating
              ),
              const SizedBox(height: 32),

              /** Widget [Expanded]
               * * Deskripsi:
               * - Memungkinkan [TextField] untuk mengambil ruang vertikal yang tersisa.
               * - `flex: 2` memberikan proporsi ruang yang lebih besar.
               */
              Expanded(
                flex: 2, // Memperbesar TextField secara vertikal
                /** Widget [TextField]
                 * * Deskripsi:
                 * - Area input teks multi-baris bagi pengguna untuk menulis ulasan mereka.
                 * - Memiliki border membulat dan placeholder teks.
                 */
                child: TextField(
                  controller: _controller, // Controller untuk input review
                  maxLines: null, // Tidak dibatasi jumlah baris
                  expands: true, // Mengisi ruang yang tersedia
                  textAlignVertical: TextAlignVertical.top, // Mulai dari atas
                  decoration: InputDecoration(
                    hintText: 'Write your review here', // Placeholder
                    contentPadding: const EdgeInsets.all(16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20), // Border membulat
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade500), // Border saat fokus
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              /** Widget [SizedBox]
               * * Deskripsi:
               * - Menetapkan lebar penuh dan tinggi tetap untuk tombol "DONE".
               */
              SizedBox(
                width: double.infinity, // Lebar tombol memenuhi layar
                height: 50, // Tinggi tombol
                /** Widget [ElevatedButton]
                 * * Deskripsi:
                 * - Tombol untuk mengirimkan ulasan.
                 * - Ketika ditekan, akan menavigasi pengguna kembali ke halaman Home dan menghapus riwayat navigasi sebelumnya.
                 */
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman Home dan hapus semua halaman sebelumnya dari stack navigasi.
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => CampingApp()),
                      (route) => false, // Menghapus semua rute sebelumnya
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF627D2C), // Warna tombol (hijau zaitun)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), // Sudut tombol membulat
                    ),
                  ),
                  /** Widget [Text]
                   * * Deskripsi:
                   * - Teks "DONE" pada tombol.
                   * - Diberi gaya font **bold**, ukuran 18, dan warna putih.
                   */
                  child: const Text(
                    'DONE', // Teks tombol
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24), // Jarak bawah tombol
            ],
          ),
        ),
      ),
    );
  }
}