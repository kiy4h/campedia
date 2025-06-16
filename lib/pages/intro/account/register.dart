import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'termAndCondition.dart';
import 'package:flutter/gestures.dart';
import '../animation/onboarding.dart';
import '../animation/congratulationsPopup.dart'; // Popup ucapan selamat
import '../../../providers/auth_provider.dart'; // Provider untuk proses registrasi

void main() {
  // Root dari aplikasi, menampilkan halaman Register
  runApp(const MaterialApp(
    home: Register(),
    debugShowCheckedModeBanner: false, // Hilangkan banner debug
  ));
}

// Stateful widget karena banyak interaksi user (input form, checkbox, toggle password)
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Untuk menyembunyikan atau menampilkan password
  bool _obscurePassword = true;

  // Untuk status checkbox terms & conditions
  bool isChecked = false;

  // Controller untuk mengambil nilai dari TextField
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Key untuk form validasi
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose controller saat widget dihancurkan
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi untuk memproses registrasi
  Future<void> _handleRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (!isChecked) {
        // Jika terms belum dicentang, munculkan snackbar error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please accept the terms and conditions'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Ambil provider dari context
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      // Gabungkan nama depan dan belakang
      String fullName =
          '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}';

      // Proses registrasi lewat AuthProvider
      final success = await authProvider.register(
        fullName,
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (success) {
        // Jika sukses, munculkan popup selamat
        showCongratulationsPopup(
          context,
          _firstNameController.text.isNotEmpty
              ? _firstNameController.text
              : "User",
        );
      } else {
        // Jika gagal, munculkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.error ?? 'Registration failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F1), // Warna latar belakang hijau muda
      body: SafeArea(
        child: Column(
          children: [
            // Bagian gambar atas + tombol back
            Stack(
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image.asset(
                    'images/assets_SignUp/alam_bg.png', // Gambar background
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context); // Tombol kembali
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24), // Padding isi form
                child: Form(
                  key: _formKey, // Kunci validasi form
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create your account', // Judul halaman
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),

                      // Input nama depan dan belakang dalam satu baris
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                hintText: 'First Name',
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
                                hintText: 'Last Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Input email
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
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
                          // Validasi format email
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Input password dengan toggle visibility
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Password',
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
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // Checkbox terms & conditions + link teks
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
                                text: 'By tapping Sign up you accept all ',
                                style: const TextStyle(color: Colors.black54),
                                children: [
                                  // Link teks 'terms'
                                  TextSpan(
                                    text: 'terms',
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
                                              builder: (context) =>
                                                  const TermsConditionPage()),
                                        );
                                      },
                                  ),
                                  const TextSpan(text: ' and '),
                                  // Link teks 'conditions'
                                  TextSpan(
                                    text: 'conditions',
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
                                              builder: (context) =>
                                                  const TermsConditionPage()),
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

                      // Tombol daftar (dengan animasi loading jika sedang register)
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF566D3D), // Hijau gelap
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: authProvider.isLoading
                                  ? null
                                  : _handleRegister, // Jalankan fungsi register
                              child: authProvider.isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white) // Loading spinner
                                  : const Text(
                                      'CREATE AN ACCOUNT', // Teks tombol
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

// Fungsi untuk menampilkan popup ucapan selamat setelah register berhasil
void showCongratulationsPopup(BuildContext context, String name) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CongratulationsPopup(
        name: name,
        onSignIn: () {
          Navigator.of(context).pop();
          // Bisa ditambahkan navigasi ke halaman sign in di sini
        },
      );
    },
  );
}
