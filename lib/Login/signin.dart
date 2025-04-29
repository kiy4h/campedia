import 'package:flutter/material.dart';
import 'package:tugas3provis/pages/home.dart';
import 'forgotPassword.dart';

void main() {
  runApp(const MaterialApp(
    home: SignIn(),
    debugShowCheckedModeBanner: false,
  ));
}

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _obscurePassword = true;

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
                    'images/assets_SignUp/alam_bg.png', // ganti sesuai gambar kamu
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create your account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                  
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black54),
                        children: [
                          const TextSpan(text: 'Forgot your password? '),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ForgotPassword()),
                                );
                              },
                              child: Text(
                                'Reset here',
                                style: const TextStyle(
                                  color: Color(0xFF566D3D),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),              
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF566D3D),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          // Aksi saat tombol ditekan
                          print('NEXT button pressed!');
                          // Contoh navigasi:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: const Text(
                          'SIGN IN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color.fromARGB(255, 206, 203, 203),
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
