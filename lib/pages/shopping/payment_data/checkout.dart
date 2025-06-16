/**
 * File         : checkout.dart
 * Dibuat oleh  : Izzuddin Azzam
 * Tanggal      : 15-06-2025
 * Deskripsi    : File ini berisi implementasi halaman checkout tahap pertama
 *                untuk memasukkan data alamat pengiriman
 * Dependencies : flutter/material.dart, halaman checkout2
 */

import 'package:flutter/material.dart';
import 'checkout2.dart';

void main() {
  runApp(const Checkout());
}

/// Widget Checkout
///
/// Deskripsi:
/// - Widget root yang digunakan sebagai entry point aplikasi.
/// - Merupakan StatelessWidget karena tidak memiliki state yang berubah.
/// - Menjalankan halaman ShippingAddressPage sebagai halaman awal.
class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShippingAddressPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Widget ShippingAddressPage
///
/// Deskripsi:
/// - Halaman pengisian alamat pengiriman yang digunakan dalam proses checkout.
/// - Stateful karena perlu menyimpan dan memvalidasi input pengguna.
class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({super.key});

  @override
  _ShippingAddressPageState createState() => _ShippingAddressPageState();
}

/// State dari ShippingAddressPage
///
/// - Mengelola input pengguna seperti nama, email, alamat, NIK, kota, booth, dan lainnya.
/// - Melakukan validasi form sebelum melanjutkan ke halaman berikutnya.
class _ShippingAddressPageState extends State<ShippingAddressPage> {
  final _formKey = GlobalKey<FormState>();

  bool saveConfirmation = false;

  String? selectedCity;
  String? selectedBooth;

  final List<String> cities = ['Bandung', 'Bekasi', 'Jakarta', 'Bogor'];
  final List<String> booths = ['Gegerkalong1', 'Lembang2', 'Tangkuban3', 'Cimindi4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Checkout', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildStepIndicator(),
              const SizedBox(height: 24),
              buildTextField('Full Name'),
              const SizedBox(height: 16),
              buildTextField('Email Address', keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              buildTextField('Phone', keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
              buildTextField('Address', maxLines: 2),
              const SizedBox(height: 16),
              buildTextField('NIK'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: buildTextField('ZIP Code')),
                  const SizedBox(width: 16),
                  Expanded(child: buildCityDropdown()),
                ],
              ),
              const SizedBox(height: 16),
              buildBoothDropdown(),
              const SizedBox(height: 16),
              buildTextField('Message', maxLines: 6),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Checkout2(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF627D2C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget untuk menampilkan indikator langkah proses checkout.
  /// Menampilkan dua tahap: Rent Confirmation (aktif) dan Payment Method (belum aktif).
  Widget buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF627D2C), width: 2),
              ),
              child: const Center(
                child: Icon(Icons.check, size: 16, color: Color(0xFF627D2C)),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Rent Confirmation',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Container(
          width: 40,
          height: 2,
          color: Colors.grey[300],
          margin: const EdgeInsets.symmetric(horizontal: 8),
        ),
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Payment Method',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  /// Fungsi pembantu untuk membangun TextFormField
  /// Parameter:
  /// - label: teks hint
  /// - keyboardType: jenis input (default: text)
  /// - maxLines: jumlah baris (default: 1)
  Widget buildTextField(String label, {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFFBCCB9F)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF627D2C)),
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  /// Widget dropdown untuk memilih kota pengiriman
  Widget buildCityDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintText: 'Choose your city',
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFFBCCB9F)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF627D2C)),
        ),
      ),
      items: cities.map((city) {
        return DropdownMenuItem(
          value: city,
          child: Text(city),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCity = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your city';
        }
        return null;
      },
    );
  }

  /// Widget dropdown untuk memilih booth/cabang pengambilan
  Widget buildBoothDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintText: 'Choose Branch Booth',
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFFBCCB9F)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF627D2C)),
        ),
      ),
      items: booths.map((booth) {
        return DropdownMenuItem(
          value: booth,
          child: Text(booth),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedBooth = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your booth';
        }
        return null;
      },
    );
  }
}