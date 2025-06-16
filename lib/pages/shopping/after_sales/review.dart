import 'package:flutter/material.dart'; // Import library Flutter Material untuk UI
import '../../beranda/home.dart'; // Import halaman Home untuk navigasi kembali setelah review selesai

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key}); // Konstruktor widget dengan optional key

  @override
  _ReviewPageState createState() => _ReviewPageState(); // Membuat state ReviewPage
}

class _ReviewPageState extends State<ReviewPage> {
  double _rating = 5.0; // Menyimpan nilai rating saat ini (default 5.0)
  final TextEditingController _controller = TextEditingController(); // Mengontrol input dari TextField review

  // Fungsi untuk membangun tampilan icon bintang berdasarkan nilai rating
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
      icon: Icon(
        icon,
        size: 36,
        color: const Color(0xFF9BAE76), // Warna bintang (olive)
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Bersihkan controller saat widget dihapus dari tree
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang halaman putih
      appBar: AppBar(
        elevation: 0, // Tanpa bayangan
        backgroundColor: Colors.white, // Warna latar AppBar
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black), // Tombol kembali/tutup
          onPressed: () => Navigator.pop(context), // Kembali ke halaman sebelumnya
        ),
        title: const Text(
          'Write Reviews', // Judul AppBar
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true, // Judul berada di tengah
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0), // Padding horizontal
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Tengah secara vertikal
            crossAxisAlignment: CrossAxisAlignment.center, // Tengah secara horizontal
            children: [
              const Text(
                'Tell Us to Improve', // Judul utama di halaman
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12), // Jarak antar elemen
              const Text(
                'Gimana pengalamanmu? Ceritain yuk biar yang lain juga bisa tahu serunya pakai alat kemah dari kami!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black54), // Teks penjelasan
              ),
              const SizedBox(height: 32),
              Text(
                _rating.toStringAsFixed(1), // Tampilkan nilai rating (1 desimal)
                style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => _buildStar(index)), // Buat 5 bintang rating
              ),
              const SizedBox(height: 32),
              Expanded(
                flex: 2, // Memperbesar TextField secara vertikal
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
              SizedBox(
                width: double.infinity, // Lebar tombol memenuhi layar
                height: 50, // Tinggi tombol
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman Home dan hapus semua halaman sebelumnya
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => CampingApp()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF627D2C), // Warna tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), // Sudut tombol membulat
                    ),
                  ),
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
