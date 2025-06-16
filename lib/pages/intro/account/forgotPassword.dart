import 'package:flutter/material.dart';

void main() {
  // MaterialApp adalah root dari aplikasi Flutter berbasis Material Design
  runApp(const MaterialApp(
    home: ForgotPassword(), // Menampilkan halaman ForgotPassword saat aplikasi dijalankan
    debugShowCheckedModeBanner: false, // Menghilangkan banner "debug" di pojok kanan atas
  ));
}

// Stateful widget karena ada input yang bisa berubah (email)
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController(); // Mengontrol teks yang dimasukkan di TextField

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F1), // Warna latar belakang halaman
      body: SafeArea( // Supaya isi tidak tertutup status bar / notch
        child: Column(
          children: [
            // Bagian atas yang berisi gambar dan tombol kembali
            Stack(
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image.asset(
                    'images/assets_SignUp/alam_bg.png', // Gambar latar belakang (alam)
                    fit: BoxFit.cover, // Mengisi seluruh area dengan menjaga proporsi
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white), // Icon kembali
                    onPressed: () {
                      Navigator.pop(context); // Kembali ke halaman sebelumnya
                    },
                  ),
                ),
              ],
            ),
            // Konten utama halaman (form)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24), // Padding dari tepi layar
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Teks rata kiri
                  children: [
                    const Text(
                      'Forgot Password?', // Judul halaman
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your email address below and we\'ll send you a link to reset your password.',
                      // Penjelasan singkat untuk user
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: _emailController, // Menghubungkan input dengan controller
                      decoration: InputDecoration(
                        hintText: 'Enter your email', // Teks placeholder
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20), // Border dengan ujung melengkung
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      keyboardType: TextInputType.emailAddress, // Keyboard khusus untuk email
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF566D3D), // Warna tombol hijau
                          padding: const EdgeInsets.symmetric(vertical: 16), // Padding atas bawah tombol
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Tombol bulat panjang
                          ),
                        ),
                        onPressed: () {
                          // Aksi saat tombol ditekan (simulasi kirim email)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Reset link has been sent to your email!'), // Pesan notifikasi
                              backgroundColor: Color.fromARGB(255, 163, 165, 163), // Warna snackbar
                            ),
                          );

                          // Navigasi kembali ke halaman pertama setelah 2 detik
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.popUntil(context, (route) => route.isFirst);
                          });
                        },
                        child: const Text(
                          'SEND RESET LINK', // Teks pada tombol
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color.fromARGB(255, 235, 233, 233), // Warna teks putih keabu-abuan
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Kembali ke halaman login
                        },
                        child: const Text(
                          'Back to Login', // Teks tombol untuk kembali
                          style: TextStyle(
                            color: Color(0xFF566D3D), // Warna teks hijau
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
}
