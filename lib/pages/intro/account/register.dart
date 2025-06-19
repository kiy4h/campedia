// File: register.dart
// Deskripsi: File ini berisi implementasi halaman registrasi pengguna baru
// dengan formulir untuk mengisi data diri, validasi input, dan proses pendaftaran
// Dibuat oleh: Kelompok 4
// Tanggal: Mei 2023

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'termAndCondition.dart'
    as terms; // Tambahkan alias untuk menghindari konflik
import 'package:flutter/gestures.dart';
import '../animation/congratulationsPopup.dart'
    as popup; // Popup ucapan selamat dengan alias
import '../../../providers/auth_provider.dart';

void main() {
  runApp(const MaterialApp(
    home: Register(),
    debugShowCheckedModeBanner: false,
  ));
}

/// Widget Register
/// Widget ini bertanggung jawab untuk menampilkan antarmuka registrasi pengguna baru
/// dengan form untuk input nama depan, nama belakang, email, dan password
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => RegisterState();
}

/// State untuk widget Register
/// Mengelola state form registrasi dan proses pendaftaran pengguna
class RegisterState extends State<Register> {
  bool _obscurePassword = true; // State untuk menampilkan/menyembunyikan password
  bool isChecked = false; // State untuk checkbox syarat dan ketentuan
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Key untuk validasi form

  /// Metode dispose
  /// Membersihkan controller ketika widget tidak digunakan lagi
  /// untuk mencegah memory leak
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Metode _handleRegister
  /// Menangani proses registrasi pengguna baru
  /// Melakukan validasi form terlebih dahulu, kemudian memanggil provider
  /// untuk melakukan registrasi ke backend
  Future<void> _handleRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (!isChecked) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please accept the terms and conditions'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      String fullName =
          '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}';

      final success = await authProvider.register(
        fullName,
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (success) {
        // Show success popup
        showCongratulationsPopup(
          context,
          _firstNameController.text.isNotEmpty
              ? _firstNameController.text
              : "User",
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.error ?? 'Registration failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Metode build
  /// Membangun tampilan UI halaman registrasi dengan form input
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F1),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image.asset(
                    'images/assets_SignUp/alam_bg.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Buat Akun Anda',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                hintText: 'Nama Depan',
                                labelText: 'Nama Depan',
                                labelStyle: const TextStyle(color: Color(0xFF627D2C)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFF627D2C)),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                hintText: 'Nama Belakang',
                                labelText: 'Nama Belakang',
                                labelStyle: const TextStyle(color: Color(0xFF627D2C)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFF627D2C)),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Silakan masukkan nama belakang Anda';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Color(0xFF627D2C)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF627D2C)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Color(0xFF627D2C)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF627D2C)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Silakan masukkan kata sandi Anda';
                          }
                          if (value.length < 6) {
                            return 'Kata sandi harus terdiri dari minimal 6 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value ?? false;
                              });
                            },
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: 'Dengan mengetuk Daftar, Anda menyetujui semua ',
                                style: const TextStyle(color: Colors.black54),
                                children: [
                                  TextSpan(
                                    text: 'syarat',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const terms
                                                  .TermsConditionPage()),
                                        );
                                      },
                                  ),
                                  const TextSpan(text: ' dan '),
                                  TextSpan(
                                    text: 'ketentuan',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const terms
                                                  .TermsConditionPage()),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF566D3D),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: authProvider.isLoading
                                  ? null
                                  : _handleRegister,
                              child: authProvider.isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text(
                                      'BUAT AKUN',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 222, 223, 222),
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
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

/// Fungsi showCongratulationsPopup
/// Menampilkan dialog popup ucapan selamat setelah registrasi berhasil
/// dengan tombol navigasi ke halaman sign in
/// 
/// Parameter:
/// - context: BuildContext untuk menampilkan dialog
/// - name: String nama pengguna yang berhasil mendaftar
void showCongratulationsPopup(BuildContext context, String name) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return popup.CongratulationsPopup(
        name: name,
        onSignIn: () {
          Navigator.of(context).pop();
          // Tambahkan navigasi ke halaman sign in di sini
        },
      );
    },
  );
}
