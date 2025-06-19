/// File        : checkout.dart
/// Dibuat oleh : Izzuddin Azzam
/// Tanggal     : 16-06-2025
/// Deskripsi   : File ini berisi implementasi halaman checkout tahap pertama,
/// memungkinkan pengguna untuk memasukkan data alamat pengiriman
/// dan informasi kontak sebelum melanjutkan ke tahap pembayaran.
/// Dependencies : flutter/material.dart, checkout2.dart, provider, auth_provider, api_service
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/api_service.dart';
import '../../../models/models.dart';
import 'checkout2.dart';
import '../cart/shoping.dart';

/// Widget [Checkout]
///
/// Deskripsi:
/// - Widget root aplikasi yang membungkus keseluruhan aplikasi checkout.
/// - Ini adalah bagian dari struktur navigasi aplikasi secara keseluruhan.
/// - Ini adalah widget stateless karena tidak memiliki state internal yang perlu dikelola.
class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    /** Widget [MaterialApp]
     *
     * Deskripsi:
     * - Widget inti Flutter yang menyediakan fungsionalitas desain Material.
     * - Mengatur `ShippingAddressPage` sebagai halaman awal aplikasi.
     */
    return MaterialApp(
      home: const ShippingAddressPageWithData(),
      debugShowCheckedModeBanner:
          false, // Menghilangkan banner debug di pojok kanan atas.
    );
  }
}

/// Widget [ShippingAddressPage]
///
/// Deskripsi:
/// - Halaman ini bertanggung jawab untuk mengumpulkan informasi alamat pengiriman dari pengguna.
/// - Terintegrasi dengan AuthProvider untuk data user dan API Service untuk menyimpan data.
/// - Ini adalah widget stateful karena mengelola state dari input form dan API calls.
// Modified version of ShippingAddressPage that accepts transaction data
class ShippingAddressPageWithData extends StatefulWidget {

  const ShippingAddressPageWithData({
    super.key,
  });

  @override
  ShippingAddressPageWithDataState createState() =>
      ShippingAddressPageWithDataState();
}

class ShippingAddressPageWithDataState
    extends State<ShippingAddressPageWithData> {
  // Kunci global untuk form, digunakan untuk mengakses state form dan melakukan validasi.
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk form fields
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Variabel boolean untuk menyimpan status konfirmasi (saat ini tidak digunakan di UI, namun bisa untuk fitur "Simpan Alamat").
  bool saveConfirmation = false;

  // Variabel untuk menyimpan kota yang dipilih dari dropdown.
  String? selectedCity;
  // Variabel untuk menyimpan booth yang dipilih dari dropdown.
  String? selectedBooth;
  bool _isLoadingData = true;
  bool _hasCompleteData = false;

  // Daftar kota yang tersedia untuk dipilih.
  final List<String> cities = ['Bandung', 'Bekasi', 'Jakarta', 'Bogor'];
  // Daftar booth yang tersedia untuk dipilih.
  final List<String> booths = [
    'Gegerkalong1',
    'Lembang2',
    'Tangkuban3',
    'Cimindi4'
  ];

  @override
  void initState() {
    super.initState();
    selectedCity = null; // Selalu mulai dengan null
    selectedBooth = null; // Selalu mulai dengan null
    _loadUserData();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _alamatController.dispose();
    _nikController.dispose();
    _zipController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _loadUserData() async {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  
  if (!authProvider.isAuthenticated || authProvider.user == null) {
    Navigator.pushReplacementNamed(context, '/login');
    return;
  }

  try {
    final response = await ApiService.getUserCheckoutData(
      userId: authProvider.user!.userId
    );

    if (response.success && response.data != null) {
      final userData = response.data!;
      
      _namaController.text = userData['nama']?.toString() ?? '';
      _emailController.text = userData['email']?.toString() ?? '';
      _phoneController.text = userData['no_hp']?.toString() ?? '';
      _alamatController.text = userData['alamat']?.toString() ?? '';
      
      // JANGAN ambil kota dan booth dari database karena hardcode
      // selectedCity dan selectedBooth tetap null atau user pilih manual
      
      setState(() {
        if(userData['has_complete_checkout_data'] == 1) {
          _hasCompleteData = true;
        }
        _isLoadingData = false;
      });
    } else {
      final user = authProvider.user!;
      _namaController.text = user.nama;
      _emailController.text = user.email;
      
      setState(() {
        _isLoadingData = false;
      });
    }
  } catch (e) {
    setState(() {
      _isLoadingData = false;
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading user data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (_isLoadingData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Konfirmasi Penyewaan'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

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
            title: const Text('Konfirmasi Penyewaan', style: TextStyle(color: Colors.black)),
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
                  if (_hasCompleteData == true) ...[
                    // Hanya tampilkan dropdown booth saja
                    const Text(
                      'Pilih Cabang Pengambilan',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    buildBoothDropdown(),
                  ] else ...[
                    _buildFullForm(),
                  ],
                  const SizedBox(height: 24),
                  _buildSubmitButton(authProvider),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSavedDataCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Data Pengiriman Tersimpan',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _hasCompleteData = false;
                    });
                  },
                  child: const Text('Edit'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Nama: ${_namaController.text}'),
            Text('Email: ${_emailController.text}'),
            Text('No. HP: ${_phoneController.text}'),
            Text('Alamat: ${_alamatController.text}'),
            Text('Kota: ${selectedCity ?? ''}'),
          ],
        ),
      ),
    );
  }

  Widget _buildBoothSelectionOnly() {
    return Column(
      children: [
        const Text(
          'Pilih Cabang Pengambilan',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 16),
        buildBoothDropdown(),
      ],
    );
  }

  Widget _buildFullForm() {
    return Column(
      children: [
        buildTextField('Full Name', controller: _namaController),
        const SizedBox(height: 16),
        buildTextField('Email Address', 
          controller: _emailController,
          keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 16),
        buildTextField('Phone', 
          controller: _phoneController,
          keyboardType: TextInputType.phone),
        const SizedBox(height: 16),
        buildTextField('Address', 
          controller: _alamatController,
          maxLines: 2),
        const SizedBox(height: 16),
        buildTextField('NIK', controller: _nikController),
        const SizedBox(height: 16),
        const SizedBox(height: 16),
        buildBoothDropdown(),
        const SizedBox(height: 16),
        buildTextField('Pesan Tambahan', 
          controller: _messageController,
          maxLines: 6),
      ],
    );
  }

  Widget _buildSubmitButton(AuthProvider authProvider) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: authProvider.isLoading ? null : () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            
            // Validasi booth selection
            if (selectedBooth == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select a booth'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }
            
            // Jika belum ada data lengkap, simpan dulu
            if (!_hasCompleteData) {
              final success = await authProvider.updateUserCheckoutData(
                alamat: _alamatController.text,
                noHp: _phoneController.text,
                kota: "Bandung",
                nik: _nikController.text,
              );
              
              if (!success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(authProvider.error ?? 'Gagal menyimpan data'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
            }
            
            // Navigate to checkout2 dengan data transaksi
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Checkout2(
                ),
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
        child: authProvider.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'Selanjutnya',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  /* Fungsi ini menampilkan indikator langkah proses checkout.
   *
   * Parameter: Tidak ada.
   *
   * Return: Sebuah widget Row yang berisi lingkaran langkah dan garis penghubung.
   */
  Widget buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /** Widget [Column]
         *
         * Deskripsi:
         * - Mengatur lingkaran dan teks untuk langkah 'Konfirmasi Sewa'.
         * - Menunjukkan langkah ini sebagai yang aktif dengan ikon centang dan teks tebal.
         */
        Column(
          children: [
            /** Widget [Container]
             *
             * Deskripsi:
             * - Lingkaran visual untuk indikator langkah 'Konfirmasi Sewa'.
             * - Berwarna hijau solid dengan ikon centang, menandakan langkah aktif.
             */
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF627D2C), width: 2),
              ),
              /** Widget [Center]
               *
               * Deskripsi:
               * - Menengahkan ikon di dalam lingkaran.
               */
              child: const Center(
                /** Widget [Icon]
                 *
                 * Deskripsi:
                 * - Ikon centang di dalam lingkaran langkah.
                 */
                child: Icon(Icons.check, size: 16, color: Color(0xFF627D2C)),
              ),
            ),
            const SizedBox(height: 4),
            /** Widget [Text]
             *
             * Deskripsi:
             * - Label teks di bawah lingkaran untuk 'Konfirmasi Sewa'.
             */
            const Text(
              'Konfirmasi Sewa',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        /** Widget [Container]
         *
         * Deskripsi:
         * - Garis penghubung antara lingkaran langkah.
         */
        Container(
          width: 40,
          height: 2,
          color: Colors.grey[300],
          margin: const EdgeInsets.symmetric(horizontal: 8),
        ),
        /** Widget [Column]
         *
         * Deskripsi:
         * - Mengatur lingkaran dan teks untuk langkah 'Metode Pembayaran'.
         * - Menunjukkan langkah ini sebagai yang belum aktif dengan lingkaran abu-abu dan teks abu-abu.
         */
        Column(
          children: [
            /** Widget [Container]
             *
             * Deskripsi:
             * - Lingkaran visual untuk indikator langkah 'Metode Pembayaran'.
             * - Berwarna abu-abu, menandakan langkah yang belum aktif.
             */
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 4),
            /** Widget [Text]
             *
             * Deskripsi:
             * - Label teks di bawah lingkaran untuk 'Metode Pembayaran'.
             */
            const Text(
              'Metode Pembayaran',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  /* Fungsi ini adalah pembantu untuk membangun TextFormField dengan gaya konsisten.
   *
   * Parameter:
   * - label: String yang akan digunakan sebagai hintText di TextFormField.
   * - keyboardType: Jenis input keyboard (misal: TextInputType.emailAddress, TextInputType.phone). Defaultnya adalah TextInputType.text.
   * - maxLines: Jumlah baris maksimum untuk TextFormField. Defaultnya adalah 1.
   * - controller: TextEditingController untuk mengelola nilai input field.
   *
   * Return: Sebuah widget TextFormField yang telah dikonfigurasi.
   */
  Widget buildTextField(String label,
      {TextInputType keyboardType = TextInputType.text, 
       int maxLines = 1,
       TextEditingController? controller}) {
    /** Widget [TextFormField]
     *
     * Deskripsi:
     * - Field input teks yang dapat divalidasi.
     * - Digunakan untuk mengumpulkan berbagai informasi seperti nama, email, alamat, dll.
     * - **Data Dinamis:** Nilai yang dimasukkan pengguna di sini akan menjadi data pengiriman.
     */
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      /* Fungsi validator untuk TextFormField.
       *
       * Parameter:
       * - value: Nilai teks saat ini dari TextFormField.
       *
       * Return: String pesan error jika input tidak valid, atau null jika valid.
       */
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  /* Fungsi ini membangun widget dropdown untuk memilih kota pengiriman.
   *
   * Parameter: Tidak ada.
   *
   * Return: Sebuah widget DropdownButtonFormField<String> untuk pemilihan kota.
   */
  Widget buildCityDropdown() {
  return DropdownButtonFormField<String>(
    value: selectedCity, // Akan null sampai user memilih
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      hintText: 'Pilih Kota Anda',
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
    items: cities.map<DropdownMenuItem<String>>((String city) {
      return DropdownMenuItem<String>(
        value: city,
        child: Text(city),
      );
    }).toList(),
    onChanged: (String? value) {
      setState(() {
        selectedCity = value;
        // Reset booth ketika city berubah jika booth bergantung pada city
        selectedBooth = null;
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

  /* Fungsi ini membangun widget dropdown untuk memilih booth/cabang pengambilan.
   *
   * Parameter: Tidak ada.
   *
   * Return: Sebuah widget DropdownButtonFormField<String> untuk pemilihan booth.
   */
  Widget buildBoothDropdown() {
    /** Widget [DropdownButtonFormField]
     *
     * Deskripsi:
     * - Widget dropdown untuk memilih lokasi booth.
     * - Akan memicu validasi jika tidak ada booth yang dipilih.
     * - **Data Dinamis:** Daftar booth diambil dari `booths` list.
     */
    return DropdownButtonFormField<String>(
      value: selectedBooth,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
        /** Widget [DropdownMenuItem]
         *
         * Deskripsi:
         * - Setiap item dalam daftar dropdown booth.
         * - **Data Dinamis:** Menampilkan nama booth sebagai teks.
         */
        return DropdownMenuItem(
          value: booth,
          child: Text(booth),
        );
      }).toList(),
      /* Fungsi callback ketika nilai dropdown berubah.
       *
       * Parameter:
       * - value: Nilai booth yang baru dipilih.
       *
       * Return: Tidak ada (mengupdate state `selectedBooth`).
       */
      onChanged: (value) {
        setState(() {
          selectedBooth = value;
        });
      },
      /* Fungsi validator untuk DropdownButtonFormField booth.
       *
       * Parameter:
       * - value: Nilai booth yang saat ini dipilih.
       *
       * Return: String pesan error jika tidak ada booth yang dipilih, atau null jika valid.
       */
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your booth';
        }
        return null;
      },
    );
  }
}