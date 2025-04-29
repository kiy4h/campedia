import 'package:flutter/material.dart';
import 'termAndCondition.dart';
import 'package:flutter/gestures.dart';
import '../Intro/onboarding.dart';

void main() {
  runApp(const MaterialApp(
    home: Register(),
    debugShowCheckedModeBanner: false,
  ));
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscurePassword = true;
  bool isChecked = false;

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
                    const Text(
                      'Create your account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                                        MaterialPageRoute(builder: (context) => const TermsConditionPage()),
                                      );
                                    },
                                ),
                                const TextSpan(text: ' and '),
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
                                        MaterialPageRoute(builder: (context) => const TermsConditionPage()),
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
                        onPressed: isChecked
                            ? () {
                                // Logika lanjut saat checkbox dicentang
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Account created successfully!')),
                                );
                              }
                            : null, // Tombol nonaktif jika belum diceklis
                        child: GestureDetector(
                          onTap: () {
                            // Aksi saat teks ditekan
                            print('NEXT button pressed!');
                            // Contoh navigasi:
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const OnboardingScreen()),
                            );
                          },
                          child: const Text(
                            'CREATE AN ACCOUNT',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color.fromARGB(255, 222, 223, 222),
                            ),
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
