/// File        : checkout2.dart
/// Dibuat oleh : Izzuddin Azzam
/// Tanggal     : 16-06-2025
/// Deskripsi   : Halaman ini menampilkan proses pembayaran, memungkinkan pengguna untuk memilih metode pembayaran (QRIS, Transfer Bank, atau Tunai)
/// dan menampilkan instruksi pembayaran yang relevan. Ini adalah bagian dari alur checkout aplikasi.
/// Dependencies : flutter/material.dart, ../after_sales/thankyouPage.dart
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
import '../../../providers/checkout_provider.dart';
import '../after_sales/thankyouPage.dart';

/// Widget [Checkout2]
///
/// Deskripsi:
/// - Ini adalah halaman kedua dalam proses checkout, berfokus pada pemilihan dan tampilan metode pembayaran.
/// - Widget ini adalah bagian dari alur konfirmasi penyewaan dan pembayaran.
/// - Ini adalah widget stateful karena mengelola state `selectedPayment` yang berubah berdasarkan interaksi pengguna.
class Checkout2 extends StatefulWidget {
  const Checkout2({super.key});

  @override
  Checkout2State createState() => Checkout2State();
}

/// State [Checkout2State]
///
/// Deskripsi:
/// - Mengelola state untuk widget Checkout2, termasuk metode pembayaran yang dipilih.
/// - Bertanggung jawab untuk membangun UI berdasarkan state saat ini.
class Checkout2State extends State<Checkout2> {
  // Menyimpan metode pembayaran yang saat ini dipilih oleh pengguna.
  String selectedPayment = 'QRIS';
  // Kunci global untuk form, digunakan untuk validasi jika diperlukan.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** Widget [AppBar]
       *
       * Deskripsi:
       * - Menampilkan bilah aplikasi di bagian atas layar.
       * - Berisi tombol kembali, judul halaman, dan diatur transparan.
       */
      appBar: AppBar(
        /** Widget [IconButton]
         *
         * Deskripsi:
         * - Tombol ikon di AppBar untuk navigasi kembali ke layar sebelumnya.
         */
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        /** Widget [Text]
         *
         * Deskripsi:
         * - Judul halaman yang menunjukkan 'Payment Method'.
         */
        title:
            const Text('Metode Pembayaran', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      /** Widget [Padding]
       *
       * Deskripsi:
       * - Memberikan padding di sekitar seluruh konten utama layar.
       */
      body: Padding(
        padding: const EdgeInsets.all(16),
        /** Widget [Column]
         *
         * Deskripsi:
         * - Mengatur widget anak-anak secara vertikal.
         * - Digunakan untuk menata indikator langkah, opsi pembayaran, konten pembayaran, dan tombol konfirmasi.
         */
        child: Column(
          children: [
            // Membangun indikator langkah untuk menunjukkan progres checkout.
            buildStepIndicator(),
            const SizedBox(height: 24),
            // Membangun opsi pilihan metode pembayaran.
            buildPaymentOptions(),
            const SizedBox(height: 24),
            /** Widget [Expanded]
             *
             * Deskripsi:
             * - Memungkinkan widget anak mengambil ruang yang tersedia.
             * - Digunakan untuk konten pembayaran yang bisa discroll jika terlalu panjang.
             */
            Expanded(
              /** Widget [Form]
               *
               * Deskripsi:
               * - Widget ini digunakan untuk mengelompokkan beberapa TextFormField dan widget form lainnya.
               * - `_formKey` digunakan untuk mengakses state form dan melakukan validasi.
               */
              child: Form(
                key: _formKey,
                /** Widget [ListView]
                 *
                 * Deskripsi:
                 * - Widget ini memungkinkan konten untuk discroll jika melebihi ukuran layar.
                 * - Berguna untuk menampilkan detail pembayaran yang bervariasi.
                 */
                child: ListView(
                  children: [
                    // Menampilkan konten pembayaran berdasarkan metode yang dipilih.
                    buildPaymentContent(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Membangun tombol konfirmasi order.
            buildConfirmButton(context, _formKey),
          ],
        ),
      ),
    );
  }

  /* Fungsi ini membangun indikator langkah visual di bagian atas layar.
   *
   * Parameter: Tidak ada.
   *
   * Return: Sebuah widget Row yang berisi lingkaran langkah dan garis penghubung.
   */
  Widget buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Lingkaran untuk langkah pertama (Rent Confirmation) - tidak aktif di layar ini.
        stepCircle(isActive: false),
        // Garis penghubung antara lingkaran langkah.
        stepLine(),
        // Lingkaran untuk langkah kedua (Payment Method) - aktif di layar ini.
        stepCircle(isActive: true),
      ],
    );
  }

  /* Fungsi ini membuat lingkaran indikator langkah tunggal.
   *
   * Parameter:
   * - isActive: Boolean yang menentukan apakah lingkaran aktif (berwarna hijau solid) atau tidak (lingkaran berbingkai).
   *
   * Return: Sebuah widget Column yang berisi lingkaran dan teks deskriptif.
   */
  Widget stepCircle({required bool isActive}) {
    return Column(
      children: [
        /** Widget [Container]
         *
         * Deskripsi:
         * - Lingkaran visual untuk indikator langkah.
         * - Warnanya berubah berdasarkan status `isActive`.
         */
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isActive
                ? null
                : Border.all(color: const Color(0xFF627D2C), width: 2),
            color: isActive ? const Color(0xFF627D2C) : Colors.transparent,
          ),
          /** Widget [Center]
           *
           * Deskripsi:
           * - Menengahkan ikon di dalam lingkaran.
           */
          child: Center(
            /** Widget [Icon]
             *
             * Deskripsi:
             * - Ikon centang di dalam lingkaran langkah.
             * - Warnanya berubah berdasarkan status `isActive`.
             */
            child: Icon(
              Icons.check,
              size: 16,
              color: isActive ? Colors.white : const Color(0xFF627D2C),
            ),
          ),
        ),
        const SizedBox(height: 4),
        /** Widget [Text]
         *
         * Deskripsi:
         * - Label teks di bawah lingkaran, menunjukkan nama langkah.
         * - Teksnya berubah berdasarkan status `isActive`.
         */
        Text(
          isActive ? 'Metode Pembayaran' : 'Konfirmasi Penyewaan',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  /* Fungsi ini membuat garis penghubung antara langkah-langkah dalam indikator.
   *
   * Parameter: Tidak ada.
   *
   * Return: Sebuah widget Container yang merepresentasikan garis.
   */
  Widget stepLine() {
    return Container(
      width: 40,
      height: 2,
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  /* Fungsi ini membangun deretan opsi tab pembayaran (QRIS, Transfer Bank, Tunai).
   *
   * Parameter: Tidak ada.
   *
   * Return: Sebuah widget Row yang berisi tiga tab pembayaran.
   */
  Widget buildPaymentOptions() {
    return Row(
      children: [
        /** Widget [Expanded]
         *
         * Deskripsi:
         * - Memungkinkan tombol opsi pembayaran mengisi ruang yang tersedia secara merata.
         */
        Expanded(
          // Tab untuk opsi pembayaran QRIS.
          child: buildPaymentTab('QRIS'),
        ),
        const SizedBox(width: 8),
        Expanded(
          // Tab untuk opsi pembayaran Transfer Bank.
          child: buildPaymentTab('Transfer Bank'),
        ),
        const SizedBox(width: 8),
        Expanded(
          // Tab untuk opsi pembayaran Tunai.
          child: buildPaymentTab('Cash'),
        ),
      ],
    );
  }

  /* Fungsi ini membuat satu tab opsi pembayaran yang dapat dipilih.
   *
   * Parameter:
   * - paymentType: String yang merepresentasikan jenis pembayaran (misal: 'QRIS', 'Transfer Bank', 'Cash').
   *
   * Return: Sebuah widget OutlinedButton yang merepresentasikan tab pembayaran.
   */
  Widget buildPaymentTab(String paymentType) {
    bool isSelected = selectedPayment == paymentType;

    /** Widget [OutlinedButton]
     *
     * Deskripsi:
     * - Tombol yang berfungsi sebagai tab untuk memilih metode pembayaran.
     * - Gaya tombol (warna border dan background) berubah berdasarkan apakah tab tersebut `isSelected`.
     */
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedPayment = paymentType;
        });
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: isSelected ? const Color(0xFF627D2C) : Colors.grey,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: isSelected ? const Color(0xFF627D2C) : Colors.white,
      ),
      /** Widget [Text]
       *
       * Deskripsi:
       * - Teks yang menampilkan nama metode pembayaran di dalam tab.
       * - Warnanya berubah berdasarkan status `isSelected`.
       */
      child: Text(
        paymentType,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /* Fungsi ini menampilkan konten pembayaran yang berbeda berdasarkan metode pembayaran yang dipilih.
   *
   * Parameter: Tidak ada.
   *
   * Return: Sebuah widget yang menampilkan detail untuk metode pembayaran yang dipilih.
   */
  Widget buildPaymentContent() {
    switch (selectedPayment) {
      case 'QRIS':
        return buildQrisPayment();
      case 'Transfer Bank':
        return buildBankTransfer();
      case 'Cash':
        return buildCashPayment();
      default:
        return buildQrisPayment();
    }
  }

  /* Fungsi ini membangun tampilan untuk pembayaran QRIS.
   *
   * Parameter: Tidak ada.
   *
   * Return: Sebuah widget Column yang berisi instruksi dan gambar QRIS.
   */
  Widget buildQrisPayment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        /** Widget [Text]
         *
         * Deskripsi:
         * - Instruksi untuk pengguna agar melakukan scan QR Code.
         */
        const Text(
          'Scan QR Code untuk Pembayaran',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        /** Widget [Center]
         *
         * Deskripsi:
         * - Menengahkan container QRIS.
         */
        Center(
          /** Widget [Container]
           *
           * Deskripsi:
           * - Container yang membungkus gambar QRIS dan nama layanan.
           * - Memiliki background putih dan shadow untuk tampilan yang lebih menonjol.
           */
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            /** Widget [Column]
             *
             * Deskripsi:
             * - Mengatur gambar QRIS dan teks "QRIS - PlantRent" secara vertikal.
             */
            child: Column(
              children: [
                /** Widget [Image.asset]
                 *
                 * Deskripsi:
                 * - Menampilkan gambar QRIS sebagai metode pembayaran.
                 * - **Data Dinamis:** Ini adalah placeholder. Di aplikasi nyata, gambar QRIS ini mungkin perlu digenerate secara dinamis berdasarkan transaksi.
                 */
                Image.asset(
                  'images/assets_PaymentMethods/contohQRIS.png',
                  width: 380,
                  height: 380,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                /** Widget [Text]
                 *
                 * Deskripsi:
                 * - Menampilkan nama layanan terkait QRIS.
                 * - **Data Dinamis:** Nama layanan ini bisa berasal dari data backend.
                 */
                const Text(
                  'QRIS - PlantRent',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        /** Widget [ElevatedButton.icon]
         *
         * Deskripsi:
         * - Tombol untuk mengunduh bukti transaksi.
         * - Saat ditekan, akan menampilkan snackbar.
         * - **Fungsi Khusus:** Logika unduh bukti transaksi perlu diimplementasikan.
         */
        
      ],
    );
  }

  /* Fungsi ini membangun tampilan untuk pembayaran Transfer Bank.
   *
   * Parameter: Tidak ada.
   *
   * Return: Sebuah widget Column yang berisi daftar rekening bank dan catatan penting.
   */
  Widget buildBankTransfer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        /** Widget [Text]
         *
         * Deskripsi:
         * - Judul yang menginstruksikan pengguna untuk transfer ke rekening tertentu.
         */
        const Text(
          'Transfer ke Rekening Berikut:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        // Kartu informasi untuk Bank BCA.
        _buildBankCard(
          bankName: 'Bank BCA',
          accountNumber: '1234 5678 9012 3456',
          accountName: 'PT PlantRent Indonesia',
          bankLogo: 'images/assets_PaymentMethods/logo_bca.png',
        ),
        const SizedBox(height: 16),
        // Kartu informasi untuk Bank Mandiri.
        _buildBankCard(
          bankName: 'Bank Mandiri',
          accountNumber: '0987 6543 2109 8765',
          accountName: 'PT PlantRent Indonesia',
          bankLogo: 'images/assets_PaymentMethods/logo_mandiri.png',
        ),
        const SizedBox(height: 24),
        /** Widget [Text]
         *
         * Deskripsi:
         * - Judul untuk bagian catatan penting.
         */
        const Text(
          'Catatan:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        /** Widget [Text]
         *
         * Deskripsi:
         * - Daftar catatan penting terkait pembayaran transfer bank.
         * - Berisi instruksi seperti "transfer sesuai jumlah", "konfirmasi pembayaran", dan "simpan bukti".
         */
        const Text(
          '• Mohon transfer sesuai dengan jumlah yang tertera\n'
          '• Konfirmasi pembayaran akan diproses dalam 1x24 jam\n'
          '• Pastikan menyimpan bukti pembayaran',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 32),
        /** Widget [Center]
         *
         * Deskripsi:
         * - Menengahkan tombol unduh bukti transaksi.
         */
        Center(
          /** Widget [ElevatedButton.icon]
           *
           * Deskripsi:
           * - Tombol untuk mengunduh bukti transaksi.
           * - Saat ditekan, akan menampilkan snackbar.
           * - **Fungsi Khusus:** Logika unduh bukti transaksi perlu diimplementasikan.
           */
          child: ElevatedButton.icon(
            onPressed: () {
              // Logic to download receipt
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bukti transaksi diunduh')),
              );
            },
            icon: const Icon(Icons.download, color: Colors.white),
            label: const Text('Download Bukti Transaksi',
                style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF627D2C),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  /* Fungsi ini membangun kartu yang menampilkan detail rekening bank.
   *
   * Parameter:
   * - bankName: Nama bank (contoh: 'Bank BCA').
   * - accountNumber: Nomor rekening bank.
   * - accountName: Nama pemilik rekening.
   * - bankLogo: Path ke logo bank.
   *
   * Return: Sebuah widget Container yang berisi informasi rekening bank.
   */
  Widget _buildBankCard({
    required String bankName,
    required String accountNumber,
    required String accountName,
    required String bankLogo,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFBCCB9F)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /** Widget [Row]
           *
           * Deskripsi:
           * - Mengatur ikon bank dan detail bank (nama bank, jenis rekening) secara horizontal.
           */
          Row(
            children: [
              /** Widget [Container]
               *
               * Deskripsi:
               * - Placeholder untuk logo bank.
               * - **Fungsi Khusus:** Di aplikasi nyata, ini akan menampilkan `Image.asset(bankLogo)` untuk logo bank yang sebenarnya.
               */
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child:
                    const Icon(Icons.account_balance, color: Color(0xFF627D2C)),
              ),
              const SizedBox(width: 12),
              /** Widget [Column]
               *
               * Deskripsi:
               * - Mengatur nama bank dan teks "Rekening [nama bank]" secara vertikal.
               */
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /** Widget [Text]
                   *
                   * Deskripsi:
                   * - Menampilkan nama bank.
                   * - **Data Dinamis:** Nama bank ini diambil dari parameter.
                   */
                  Text(
                    bankName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  /** Widget [Text]
                   *
                   * Deskripsi:
                   * - Menampilkan jenis rekening.
                   */
                  Text(
                    'Rekening $bankName',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          /** Widget [Text]
           *
           * Deskripsi:
           * - Label untuk "Nomor Rekening".
           */
          const Text(
            'Nomor Rekening:',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          /** Widget [Row]
           *
           * Deskripsi:
           * - Mengatur nomor rekening dan tombol salin secara horizontal.
           */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /** Widget [Text]
               *
               * Deskripsi:
               * - Menampilkan nomor rekening bank.
               * - **Data Dinamis:** Nomor rekening ini diambil dari parameter.
               */
              Text(
                accountNumber,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              /** Widget [IconButton]
               *
               * Deskripsi:
               * - Tombol ikon untuk menyalin nomor rekening ke clipboard.
               * - Saat ditekan, akan menampilkan snackbar.
               * - **Fungsi Khusus:** Logika penyalinan ke clipboard perlu diimplementasikan.
               */
              IconButton(
                icon:
                    const Icon(Icons.copy, size: 20, color: Color(0xFF627D2C)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Nomor rekening disalin')),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          /** Widget [Text]
           *
           * Deskripsi:
           * - Label untuk "Atas Nama".
           */
          const Text(
            'Atas Nama:',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          /** Widget [Text]
           *
           * Deskripsi:
           * - Menampilkan nama pemilik rekening.
           * - **Data Dinamis:** Nama pemilik rekening ini diambil dari parameter.
           */
          Text(
            accountName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  /* Fungsi ini membangun tampilan untuk pembayaran Tunai (Cash).
   *
   * Parameter: Tidak ada.
   *
   * Return: Sebuah widget Column yang berisi instruksi dan detail lokasi pembayaran tunai.
   */
  Widget buildCashPayment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        /** Widget [Container]
         *
         * Deskripsi:
         * - Container informasi untuk pembayaran tunai.
         * - Berisi ikon toko, judul, deskripsi, alamat, jam buka, dan catatan tambahan.
         */
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9F4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFBCCB9F)),
          ),
          /** Widget [Column]
           *
           * Deskripsi:
           * - Mengatur semua elemen informasi pembayaran tunai secara vertikal.
           */
          child: Column(
            children: [
              /** Widget [Icon]
               *
               * Deskripsi:
               * - Ikon toko untuk mewakili pembayaran di tempat.
               */
              const Icon(
                Icons.store,
                size: 60,
                color: Color(0xFF627D2C),
              ),
              const SizedBox(height: 16),
              /** Widget [Text]
               *
               * Deskripsi:
               * - Judul utama untuk opsi pembayaran tunai.
               */
              const Text(
                'Pembayaran di Tempat',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF627D2C),
                ),
              ),
              const SizedBox(height: 16),
              /** Widget [Text]
               *
               * Deskripsi:
               * - Deskripsi singkat tentang cara melakukan pembayaran tunai.
               */
              const Text(
                'Anda dapat melakukan pembayaran langsung di booth PlantRent kami yang berlokasi di:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              /** Widget [Text]
               *
               * Deskripsi:
               * - Detail alamat booth PlantRent.
               * - **Data Dinamis:** Alamat ini bisa diambil dari konfigurasi aplikasi atau data lokasi.
               */
              const Text(
                'Botanical Garden Mall\nLantai 3, Booth B12\nJl. Taman Bunga No. 123\nJakarta Selatan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              /** Widget [Text]
               *
               * Deskripsi:
               * - Jam operasional booth.
               * - **Data Dinamis:** Jam operasional ini bisa diambil dari konfigurasi aplikasi.
               */
              const Text(
                'Booth buka setiap hari:\n10:00 - 21:00 WIB',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              /** Widget [Text]
               *
               * Deskripsi:
               * - Catatan penting bagi pengguna saat melakukan pembayaran tunai.
               */
              const Text(
                'Harap bawa ID atau konfirmasi pesanan untuk mempermudah proses pembayaran.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /* Fungsi ini membangun tombol "CONFIRM ORDER" di bagian bawah layar.
   *
   * Parameter:
   * - context: BuildContext dari widget.
   * - formKey: GlobalKey<FormState> untuk mengakses state form (meskipun tidak digunakan untuk validasi di sini, tetap dipertahankan).
   *
   * Return: Sebuah widget SizedBox yang berisi tombol ElevatedButton.
   */
  Widget buildConfirmButton(
      BuildContext context, GlobalKey<FormState> formKey) {
    /** Widget [SizedBox]
     *
     * Deskripsi:
     * - Memastikan tombol konfirmasi memiliki lebar penuh dan tinggi tetap.
     */
    return SizedBox(
      width: double.infinity,
      height: 50,
      /** Widget [ElevatedButton]
       *
       * Deskripsi:
       * - Tombol utama untuk mengonfirmasi pesanan.
       * - Saat ditekan, akan menampilkan snackbar konfirmasi dan menavigasi ke halaman `ThankYouPage`.
       * - **Fungsi Khusus:** Logika konfirmasi order (misalnya, mengirim data ke backend) akan ditambahkan di sini.
       */
      child: Consumer<CheckoutProvider>(
        builder: (context, checkoutProvider, child) {
          return ElevatedButton(
            onPressed: checkoutProvider.isLoading
                ? null
                : () async {
                    // Memastikan formKey tidak null sebelum digunakan.
                    if (_formKey.currentState != null) {
                      // Memastikan salah satu metode pembayaran telah dipilih sebelum mengkonfirmasi.
                      if (selectedPayment == 'Transfer Bank' ||
                          selectedPayment == 'QRIS' ||
                          selectedPayment == 'Cash') {
                        // Process payment via FastAPI if transaction data is available
                        if (checkoutProvider.storedTransactionId != null &&
                            checkoutProvider.storedTotalAmount != null) {
                          final success = await checkoutProvider.processPayment(
                            transaksiId: checkoutProvider.storedTransactionId!,
                            metodePembayaran: selectedPayment,
                            totalPembayaran:
                                checkoutProvider.storedTotalAmount!,
                          );
                          if (success && mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Payment processed successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            // Navigasi ke halaman terima kasih setelah konfirmasi.
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ThankYouPage(
                                  transactionId:
                                      checkoutProvider.storedTransactionId,
                                ),
                              ),
                            );
                          } else if (!success && mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    checkoutProvider.error ?? 'Payment failed'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } else {
                          // Fallback for existing flow without transaction data
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Order Confirmed!')),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ThankYouPage()),
                          );
                        }
                      }
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF627D2C),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            child: checkoutProvider.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'CONFIRM ORDER',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
