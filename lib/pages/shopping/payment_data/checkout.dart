/// File        : checkout.dart
/// Dibuat oleh : Izzuddin Azzam
/// Tanggal     : 16-06-2025
/// Deskripsi   : File ini berisi implementasi halaman checkout tahap pertama,
/// memungkinkan pengguna untuk memasukkan data alamat pengiriman
/// dan informasi kontak sebelum melanjutkan ke tahap pembayaran.
/// Dependencies : flutter/material.dart, checkout2.dart
library;

import 'package:flutter/material.dart';
import 'checkout2.dart';

/* Fungsi ini adalah titik masuk utama aplikasi Flutter.
 *
 * Parameter: Tidak ada.
 *
 * Return: Tidak ada (menjalankan aplikasi Flutter).
 */
void main() {
  runApp(const Checkout());
}

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
      home: ShippingAddressPage(),
      debugShowCheckedModeBanner:
          false, // Menghilangkan banner debug di pojok kanan atas.
    );
  }
}

/// Widget [ShippingAddressPage]
///
/// Deskripsi:
/// - Halaman ini bertanggung jawab untuk mengumpulkan informasi alamat pengiriman dari pengguna.
/// - Ini adalah bagian penting dari alur checkout di mana pengguna memasukkan detail kontak dan lokasi.
/// - Ini adalah widget stateful karena mengelola state dari input form (seperti nilai TextFormField dan DropdownButtonFormField)
/// serta melakukan validasi input pengguna.
class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({super.key});

  @override
  ShippingAddressPageState createState() => ShippingAddressPageState();
}

/// State [ShippingAddressPageState]
///
/// Deskripsi:
/// - Mengelola state internal untuk `ShippingAddressPage`, termasuk data yang dimasukkan pengguna
/// dan status validasi form.
/// - Bertanggung jawab untuk membangun UI form alamat pengiriman.
class ShippingAddressPageState extends State<ShippingAddressPage> {
  // Kunci global untuk form, digunakan untuk mengakses state form dan melakukan validasi.
  final _formKey = GlobalKey<FormState>();

  // Variabel boolean untuk menyimpan status konfirmasi (saat ini tidak digunakan di UI, namun bisa untuk fitur "Simpan Alamat").
  bool saveConfirmation = false;

  // Variabel untuk menyimpan kota yang dipilih dari dropdown.
  String? selectedCity;
  // Variabel untuk menyimpan booth yang dipilih dari dropdown.
  String? selectedBooth;

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
  Widget build(BuildContext context) {
    return Scaffold(
      /** Widget [AppBar]
       *
       * Deskripsi:
       * - Menampilkan bilah aplikasi di bagian atas layar.
       * - Berisi tombol kembali dan judul halaman 'Checkout'.
       */
      appBar: AppBar(
        /** Widget [IconButton]
         *
         * Deskripsi:
         * - Tombol ikon di AppBar untuk navigasi kembali ke layar sebelumnya.
         */
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        /** Widget [Text]
         *
         * Deskripsi:
         * - Judul halaman yang menampilkan 'Checkout'.
         */
        title: const Text('Checkout', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      /** Widget [Padding]
       *
       * Deskripsi:
       * - Memberikan padding di sekitar seluruh konten utama layar.
       */
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        /** Widget [Form]
         *
         * Deskripsi:
         * - Widget ini digunakan untuk mengelompokkan beberapa TextFormField dan DropdownButtonFormField.
         * - `_formKey` digunakan untuk mengelola validasi semua field di dalam form ini secara bersamaan.
         */
        child: Form(
          key: _formKey,
          /** Widget [ListView]
           *
           * Deskripsi:
           * - Widget ini memungkinkan konten form untuk discroll jika melebihi ukuran layar.
           * - Berguna untuk menampilkan banyak field input tanpa overflow.
           */
          child: ListView(
            children: [
              // Membangun indikator langkah proses checkout.
              buildStepIndicator(),
              const SizedBox(height: 24),
              // Field input untuk nama lengkap pengguna.
              buildTextField('Nama Lengkap'),
              const SizedBox(height: 16),
              // Field input untuk alamat email, dengan keyboard khusus email.
              buildTextField('Alamat Email',
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              // Field input untuk nomor telepon, dengan keyboard khusus angka telepon.
              buildTextField('Nomor Telepon', keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
              // Field input untuk alamat lengkap, dengan multiple baris.
              buildTextField('Alamat', maxLines: 2),
              const SizedBox(height: 16),
              // Field input untuk NIK (Nomor Induk Kependudukan).
              buildTextField('NIK'),
              const SizedBox(height: 16),
              /** Widget [Row]
               *
               * Deskripsi:
               * - Mengatur field ZIP Code dan dropdown kota secara horizontal.
               */
              Row(
                children: [
                  /** Widget [Expanded]
                   *
                   * Deskripsi:
                   * - Memungkinkan field ZIP Code mengisi ruang yang tersedia.
                   */
                  Expanded(child: buildTextField('Kode Pos')),
                  const SizedBox(width: 16),
                  /** Widget [Expanded]
                   *
                   * Deskripsi:
                   * - Memungkinkan dropdown kota mengisi ruang yang tersedia.
                   */
                  Expanded(child: buildCityDropdown()),
                ],
              ),
              const SizedBox(height: 16),
              // Dropdown untuk memilih cabang booth.
              buildBoothDropdown(),
              const SizedBox(height: 16),
              // Field input untuk pesan tambahan, dengan multiple baris.
              buildTextField('Message', maxLines: 6),
              const SizedBox(height: 24),
              /** Widget [SizedBox]
               *
               * Deskripsi:
               * - Memastikan tombol 'NEXT' memiliki lebar penuh dan tinggi tetap.
               */
              SizedBox(
                width: double.infinity,
                height: 50,
                /** Widget [ElevatedButton]
                 *
                 * Deskripsi:
                 * - Tombol utama untuk melanjutkan ke halaman checkout berikutnya.
                 * - Ketika ditekan, akan memvalidasi form dan jika valid, menavigasi ke `Checkout2`.
                 * - **Fungsi Khusus:** Logika pengiriman data form ke backend akan diimplementasikan di sini.
                 */
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Navigasi ke halaman `Checkout2` (metode pembayaran).
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
                  /** Widget [Text]
                   *
                   * Deskripsi:
                   * - Teks "NEXT" pada tombol.
                   */
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
         * - Mengatur lingkaran dan teks untuk langkah 'Rent Confirmation'.
         * - Menunjukkan langkah ini sebagai yang aktif dengan ikon centang dan teks tebal.
         */
        Column(
          children: [
            /** Widget [Container]
             *
             * Deskripsi:
             * - Lingkaran visual untuk indikator langkah 'Rent Confirmation'.
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
             * - Label teks di bawah lingkaran untuk 'Rent Confirmation'.
             */
            const Text(
              'Rent Confirmation',
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
         * - Mengatur lingkaran dan teks untuk langkah 'Payment Method'.
         * - Menunjukkan langkah ini sebagai yang belum aktif dengan lingkaran abu-abu dan teks abu-abu.
         */
        Column(
          children: [
            /** Widget [Container]
             *
             * Deskripsi:
             * - Lingkaran visual untuk indikator langkah 'Payment Method'.
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
             * - Label teks di bawah lingkaran untuk 'Payment Method'.
             */
            const Text(
              'Payment Method',
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
   *
   * Return: Sebuah widget TextFormField yang telah dikonfigurasi.
   */
  Widget buildTextField(String label,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    /** Widget [TextFormField]
     *
     * Deskripsi:
     * - Field input teks yang dapat divalidasi.
     * - Digunakan untuk mengumpulkan berbagai informasi seperti nama, email, alamat, dll.
     * - **Data Dinamis:** Nilai yang dimasukkan pengguna di sini akan menjadi data pengiriman.
     */
    return TextFormField(
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
    /** Widget [DropdownButtonFormField]
     *
     * Deskripsi:
     * - Widget dropdown untuk memilih kota.
     * - Akan memicu validasi jika tidak ada kota yang dipilih.
     * - **Data Dinamis:** Daftar kota diambil dari `cities` list.
     */
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      items: cities.map((city) {
        /** Widget [DropdownMenuItem]
         *
         * Deskripsi:
         * - Setiap item dalam daftar dropdown kota.
         * - **Data Dinamis:** Menampilkan nama kota sebagai teks.
         */
        return DropdownMenuItem(
          value: city,
          child: Text(city),
        );
      }).toList(),
      /* Fungsi callback ketika nilai dropdown berubah.
       *
       * Parameter:
       * - value: Nilai kota yang baru dipilih.
       *
       * Return: Tidak ada (mengupdate state `selectedCity`).
       */
      onChanged: (value) {
        setState(() {
          selectedCity = value;
        });
      },
      /* Fungsi validator untuk DropdownButtonFormField kota.
       *
       * Parameter:
       * - value: Nilai kota yang saat ini dipilih.
       *
       * Return: String pesan error jika tidak ada kota yang dipilih, atau null jika valid.
       */
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
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintText: 'Pilih Cabang Booth',
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

// Wrapper class to pass transaction data to existing checkout flow
class CheckoutWithData extends StatelessWidget {
  final int transactionId;
  final int totalAmount;
  final String pickupDate;
  final String returnDate;
  final int rentalDays;

  const CheckoutWithData({
    super.key,
    required this.transactionId,
    required this.totalAmount,
    required this.pickupDate,
    required this.returnDate,
    required this.rentalDays,
  });

  @override
  Widget build(BuildContext context) {
    return ShippingAddressPageWithData(
      transactionId: transactionId,
      totalAmount: totalAmount,
      pickupDate: pickupDate,
      returnDate: returnDate,
      rentalDays: rentalDays,
    );
  }
}

// Modified version of ShippingAddressPage that accepts transaction data
class ShippingAddressPageWithData extends StatefulWidget {
  final int transactionId;
  final int totalAmount;
  final String pickupDate;
  final String returnDate;
  final int rentalDays;

  const ShippingAddressPageWithData({
    super.key,
    required this.transactionId,
    required this.totalAmount,
    required this.pickupDate,
    required this.returnDate,
    required this.rentalDays,
  });

  @override
  ShippingAddressPageWithDataState createState() =>
      ShippingAddressPageWithDataState();
}

class ShippingAddressPageWithDataState
    extends State<ShippingAddressPageWithData> {
  // Kunci global untuk form, digunakan untuk mengakses state form dan melakukan validasi.
  final _formKey = GlobalKey<FormState>();

  // Variabel boolean untuk menyimpan status konfirmasi (saat ini tidak digunakan di UI, namun bisa untuk fitur "Simpan Alamat").
  bool saveConfirmation = false;

  // Variabel untuk menyimpan kota yang dipilih dari dropdown.
  String? selectedCity;
  // Variabel untuk menyimpan booth yang dipilih dari dropdown.
  String? selectedBooth;

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
  Widget build(BuildContext context) {
    return Scaffold(
      /** Widget [AppBar]
       *
       * Deskripsi:
       * - Menampilkan bilah aplikasi di bagian atas layar.
       * - Berisi tombol kembali dan judul halaman 'Checkout'.
       */
      appBar: AppBar(
        /** Widget [IconButton]
         *
         * Deskripsi:
         * - Tombol ikon di AppBar untuk navigasi kembali ke layar sebelumnya.
         */
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        /** Widget [Text]
         *
         * Deskripsi:
         * - Judul halaman yang menampilkan 'Checkout'.
         */
        title: const Text('Konfirmasi Penyewaan', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      /** Widget [Padding]
       *
       * Deskripsi:
       * - Memberikan padding di sekitar seluruh konten utama layar.
       */
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        /** Widget [Form]
         *
         * Deskripsi:
         * - Widget ini digunakan untuk mengelompokkan beberapa TextFormField dan DropdownButtonFormField.
         * - `_formKey` digunakan untuk mengelola validasi semua field di dalam form ini secara bersamaan.
         */
        child: Form(
          key: _formKey,
          /** Widget [ListView]
           *
           * Deskripsi:
           * - Widget ini memungkinkan konten form untuk discroll jika melebihi ukuran layar.
           * - Berguna untuk menampilkan banyak field input tanpa overflow.
           */
          child: ListView(
            children: [
              // Membangun indikator langkah proses checkout.
              buildStepIndicator(),
              const SizedBox(height: 24),
              // Field input untuk nama lengkap pengguna.
              buildTextField('Full Name'),
              const SizedBox(height: 16),
              // Field input untuk alamat email, dengan keyboard khusus email.
              buildTextField('Email Address',
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              // Field input untuk nomor telepon, dengan keyboard khusus angka telepon.
              buildTextField('Phone', keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
              // Field input untuk alamat lengkap, dengan multiple baris.
              buildTextField('Address', maxLines: 2),
              const SizedBox(height: 16),
              // Field input untuk NIK (Nomor Induk Kependudukan).
              buildTextField('NIK'),
              const SizedBox(height: 16),
              /** Widget [Row]
               *
               * Deskripsi:
               * - Mengatur field ZIP Code dan dropdown kota secara horizontal.
               */
              Row(
                children: [
                  /** Widget [Expanded]
                   *
                   * Deskripsi:
                   * - Memungkinkan field ZIP Code mengisi ruang yang tersedia.
                   */
                  Expanded(child: buildTextField('ZIP Code')),
                  const SizedBox(width: 16),
                  /** Widget [Expanded]
                   *
                   * Deskripsi:
                   * - Memungkinkan dropdown kota mengisi ruang yang tersedia.
                   */
                  Expanded(child: buildCityDropdown()),
                ],
              ),
              const SizedBox(height: 16),
              // Dropdown untuk memilih cabang booth.
              buildBoothDropdown(),
              const SizedBox(height: 16),
              // Field input untuk pesan tambahan, dengan multiple baris.
              buildTextField('Pesan Tambahan', maxLines: 6),
              const SizedBox(height: 24),
              /** Widget [SizedBox]
               *
               * Deskripsi:
               * - Memastikan tombol 'NEXT' memiliki lebar penuh dan tinggi tetap.
               */
              SizedBox(
                width: double.infinity,
                height: 50,
                /** Widget [ElevatedButton]
                 *
                 * Deskripsi:
                 * - Tombol utama untuk melanjutkan ke halaman checkout berikutnya.
                 * - Ketika ditekan, akan memvalidasi form dan jika valid, menavigasi ke `Checkout2`.
                 * - **Fungsi Khusus:** Logika pengiriman data form ke backend akan diimplementasikan di sini.
                 */
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Navigasi ke halaman `Checkout2` (metode pembayaran).
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
                  /** Widget [Text]
                   *
                   * Deskripsi:
                   * - Teks "NEXT" pada tombol.
                   */
                  child: const Text(
                    'Selanjutnya',
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
         * - Mengatur lingkaran dan teks untuk langkah 'Rent Confirmation'.
         * - Menunjukkan langkah ini sebagai yang aktif dengan ikon centang dan teks tebal.
         */
        Column(
          children: [
            /** Widget [Container]
             *
             * Deskripsi:
             * - Lingkaran visual untuk indikator langkah 'Rent Confirmation'.
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
             * - Label teks di bawah lingkaran untuk 'Rent Confirmation'.
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
         * - Mengatur lingkaran dan teks untuk langkah 'Payment Method'.
         * - Menunjukkan langkah ini sebagai yang belum aktif dengan lingkaran abu-abu dan teks abu-abu.
         */
        Column(
          children: [
            /** Widget [Container]
             *
             * Deskripsi:
             * - Lingkaran visual untuk indikator langkah 'Payment Method'.
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
             * - Label teks di bawah lingkaran untuk 'Payment Method'.
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
   *
   * Return: Sebuah widget TextFormField yang telah dikonfigurasi.
   */
  Widget buildTextField(String label,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    /** Widget [TextFormField]
     *
     * Deskripsi:
     * - Field input teks yang dapat divalidasi.
     * - Digunakan untuk mengumpulkan berbagai informasi seperti nama, email, alamat, dll.
     * - **Data Dinamis:** Nilai yang dimasukkan pengguna di sini akan menjadi data pengiriman.
     */
    return TextFormField(
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
    /** Widget [DropdownButtonFormField]
     *
     * Deskripsi:
     * - Widget dropdown untuk memilih kota.
     * - Akan memicu validasi jika tidak ada kota yang dipilih.
     * - **Data Dinamis:** Daftar kota diambil dari `cities` list.
     */
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
        /** Widget [DropdownMenuItem]
         *
         * Deskripsi:
         * - Setiap item dalam daftar dropdown kota.
         * - **Data Dinamis:** Menampilkan nama kota sebagai teks.
         */
        return DropdownMenuItem(
          value: city,
          child: Text(city),
        );
      }).toList(),
      /* Fungsi callback ketika nilai dropdown berubah.
       *
       * Parameter:
       * - value: Nilai kota yang baru dipilih.
       *
       * Return: Tidak ada (mengupdate state `selectedCity`).
       */
      onChanged: (value) {
        setState(() {
          selectedCity = value;
        });
      },
      /* Fungsi validator untuk DropdownButtonFormField kota.
       *
       * Parameter:
       * - value: Nilai kota yang saat ini dipilih.
       *
       * Return: String pesan error jika tidak ada kota yang dipilih, atau null jika valid.
       */
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
