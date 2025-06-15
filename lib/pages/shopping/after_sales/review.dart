/*
* File : review.dart
* Deskripsi : Halaman untuk memberikan ulasan setelah pengguna mengembalikan barang sewaan
* Dependencies : 
*   - home.dart: untuk navigasi kembali ke halaman beranda
*/

import 'package:flutter/material.dart';
import '../../beranda/home.dart'; 

/*
* Class : ReviewPage
* Deskripsi : Widget halaman ulasan, merupakan StatefulWidget
* Bagian Layar : Halaman pemberian rating dan ulasan setelah pengembalian barang
*/
class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

/*
* Class : _ReviewPageState
* Deskripsi : State untuk widget ReviewPage
* Bagian Layar : Mengelola state dan tampilan halaman ulasan
*/
class _ReviewPageState extends State<ReviewPage> {
  double _rating = 5.0;
  final TextEditingController _controller = TextEditingController();

  /*
  * Method : _buildStar
  * Deskripsi : Membangun widget bintang untuk rating
  * Parameter : index - int posisi bintang (0-4)
  * Return : Widget IconButton bintang sesuai nilai rating
  */
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
  /*
  * Method : dispose
  * Deskripsi : Membersihkan controller text field saat widget dihapus
  * Parameter : -
  * Return : void
  */
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  /*
  * Method : build
  * Deskripsi : Membangun UI untuk halaman ulasan
  * Parameter : context - BuildContext untuk akses ke fitur framework
  * Return : Widget Scaffold berisi form ulasan dengan rating dan komentar
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Write Reviews',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Tell Us to Improve',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Gimana pengalamanmu? Ceritain yuk biar yang lain juga bisa tahu serunya pakai alat kemah dari kami!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(height: 32),
              Text(
                _rating.toStringAsFixed(1),
                style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => _buildStar(index)),
              ),
              const SizedBox(height: 32),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: 'Write your review here',
                    contentPadding: const EdgeInsets.all(16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade500),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman Home dan buang semua route sebelumnya
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => CampingApp()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF627D2C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'DONE',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
