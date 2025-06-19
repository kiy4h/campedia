/// File        : onboarding.dart
/// Dibuat oleh  : Izzuddin Azzam
/// Tanggal      : 15-06-2025
/// Deskripsi    : File ini mengimplementasikan layar onboarding untuk aplikasi Campedia.
/// Layar ini menampilkan serangkaian halaman informatif dalam format carousel yang menjelaskan
/// fitur-fitur utama aplikasi. Di bagian bawah, terdapat tombol untuk registrasi akun baru
/// dan login bagi pengguna yang sudah memiliki akun.
/// Dependencies :
/// - dart:async: Diperlukan untuk menggunakan Timer guna mengimplementasikan fitur auto-slide carousel.
/// - flutter/material.dart: Pustaka dasar Flutter untuk membangun antarmuka pengguna.
/// - ../account/register.dart: Halaman pendaftaran akun baru.
/// - ../account/signin.dart: Halaman login pengguna.
library;

import 'dart:async'; // Mengimpor pustaka 'dart:async' untuk fungsi Timer.
import 'package:flutter/material.dart'; // Mengimpor pustaka dasar Flutter untuk UI.
import '../account/register.dart'; // Mengimpor halaman Register.
import '../account/signin.dart'; // Mengimpor halaman SignIn.

/// Widget [OnboardingScreen]
///
/// Deskripsi:
/// - Widget ini adalah layar orientasi (onboarding) utama yang memperkenalkan aplikasi kepada pengguna baru.
/// - Menampilkan carousel halaman-halaman informatif secara otomatis dan dapat digeser manual.
/// - Menyediakan tombol untuk membuat akun baru ([Register]) atau masuk ([SignIn]).
/// - Ini adalah StatefulWidget karena mengelola state untuk carousel (halaman saat ini)
/// dan timer untuk auto-slide, yang perlu diperbarui secara dinamis.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => OnboardingScreenState();
}

/// State [ _OnboardingScreenState]
///
/// Deskripsi:
/// - Mengelola state dan logika untuk [OnboardingScreen].
/// - Mengontrol [PageController] untuk carousel, indeks halaman saat ini, dan timer auto-slide.
/// - Mendefinisikan konten untuk setiap halaman onboarding.
class OnboardingScreenState extends State<OnboardingScreen> {
  // PageController untuk mengontrol perpindahan halaman pada PageView.
  final PageController _pageController = PageController();
  // Indeks halaman yang sedang aktif pada carousel.
  int _currentPage = 0;
  // Timer untuk fitur auto-slide carousel.
  Timer? _timer;

  /// Daftar halaman onboarding yang akan ditampilkan dalam carousel.
  final List<OnboardingPage> _pages = [
    OnboardingPage(
      image: 'images/assets_OnBoarding0/kompas_bg.png',
      title: 'Welcome to Campedia',
      subtitle: 'Your Ultimate Camping Companion',
      description:
          'Sewa perlengkapan kemah terbaik, dari tenda hingga kompor. Berkemah jadi mudah dan seru bersama Campedia',
      backgroundColor: Colors.white,
    ),
    OnboardingPage(
      image: 'images/assets_OnBoarding0/tenda_bg.png',
      title: 'Quality camping gear for every adventure',
      subtitle: '', // Subtitle kosong untuk halaman ini.
      description:
          'Planning your next camping trip? We\'ve got the gear you need — tents, cook sets, lights, and more!',
      backgroundColor: Colors.white,
    ),
    OnboardingPage(
      image: 'images/assets_OnBoarding0/onboarding4image.png',
      title: 'Efficient, In-Store Pickup for Your Camping Rentals',
      subtitle:
          'Simply reserve online and pick up your equipment at our store at your convenience.',
      description: '', // Deskripsi kosong untuk halaman ini.
      backgroundColor: Colors.white,
    ),
  ];

  /* Fungsi ini diinisialisasi saat State objek dibuat.
   *
   * Deskripsi:
   * - Memanggil `_startAutoSlide()` untuk memulai animasi otomatis carousel.
   *
   * Parameter: Tidak ada.
   * Return: Tidak ada (void).
   */
  @override
  void initState() {
    super.initState();
    _startAutoSlide(); // Memulai auto-slide carousel.
  }

  /* Fungsi ini memulai fitur auto-scroll carousel secara periodik setiap 3 detik.
   *
   * Deskripsi:
   * - Menggunakan [Timer.periodic] untuk mengubah halaman `_currentPage` setiap 3 detik.
   * - Melakukan `_pageController.animateToPage` untuk transisi halus antar halaman.
   *
   * Parameter: Tidak ada.
   * Return: Tidak ada (void).
   */
  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _pages.length - 1) {
        _currentPage++; // Pindah ke halaman berikutnya.
      } else {
        _currentPage =
            0; // Kembali ke halaman pertama jika sudah di halaman terakhir.
      }

      // Memastikan PageController memiliki klien (sudah terhubung dengan PageView)
      // sebelum mencoba menggerakkan halaman untuk menghindari error.
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration:
              const Duration(milliseconds: 350), // Durasi animasi transisi.
          curve: Curves.easeIn, // Kurva animasi.
        );
      }
    });
  }

  /* Fungsi ini dipanggil ketika State objek dihapus secara permanen.
   *
   * Deskripsi:
   * - Melepaskan (dispose) [PageController] untuk mencegah kebocoran memori.
   * - Membatalkan (cancel) [Timer] agar tidak berjalan di latar belakang setelah widget tidak ada.
   *
   * Parameter: Tidak ada.
   * Return: Tidak ada (void).
   */
  @override
  void dispose() {
    _pageController.dispose(); // Melepaskan PageController.
    _timer?.cancel(); // Membatalkan timer jika ada.
    super.dispose();
  }

  /* Fungsi ini menyimpan indeks halaman saat carousel (PageView) berubah.
   *
   * Parameter:
   * - [page]: Indeks halaman yang baru terpilih.
   *
   * Return: Tidak ada (void).
   */
  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page; // Memperbarui indeks halaman saat ini.
    });
  }

  /* Fungsi ini membangun seluruh struktur UI dari layar onboarding.
   *
   * Parameter:
   * - [context]: BuildContext dari widget.
   *
   * Return: Sebuah widget [Scaffold] yang berisi PageView, indikator, dan tombol aksi.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** Widget [SafeArea]
       * * Deskripsi:
       * - Memastikan konten UI tidak tumpang tindih dengan area sistem seperti status bar.
       */
      body: SafeArea(
        /** Widget [Column]
         * * Deskripsi:
         * - Mengatur tata letak elemen-elemen UI secara vertikal: carousel, indikator titik, dan tombol.
         */
        child: Column(
          children: [
            // --- Carousel Onboarding ---
            /** Widget [Expanded]
             * * Deskripsi:
             * - Memungkinkan [PageView.builder] untuk mengambil semua ruang vertikal yang tersedia.
             */
            Expanded(
              /** Widget [PageView.builder]
               * * Deskripsi:
               * - Menampilkan **halaman-halaman onboarding** dalam bentuk carousel yang dapat digeser.
               * - Menggunakan `_pageController` untuk mengontrol posisi halaman.
               * - Menggunakan `_pages` sebagai sumber data untuk halaman-halaman.
               */
              child: PageView.builder(
                controller: _pageController, // Mengontrol PageView.
                onPageChanged:
                    _onPageChanged, // Memanggil fungsi saat halaman berubah.
                itemCount: _pages.length, // Jumlah total halaman.
                itemBuilder: (context, index) {
                  return _pages[index]; // Membangun halaman individual.
                },
              ),
            ),

            // --- Indikator Posisi Slide ---
            /** Widget [Padding]
             * * Deskripsi:
             * - Memberikan padding di sekitar baris indikator titik.
             */
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              /** Widget [Row]
               * * Deskripsi:
               * - Mengatur **indikator titik** secara horizontal di tengah.
               * - Setiap titik merepresentasikan satu halaman dalam carousel.
               */
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Memusatkan titik-titik.
                children: List.generate(
                  _pages.length,
                  // Membangun setiap titik, yang aktif jika indeksnya sama dengan _currentPage.
                  (index) => _buildDot(index == _currentPage),
                ),
              ),
            ),

            // --- Tombol Register dan Login ---
            /** Widget [Padding]
             * * Deskripsi:
             * - Memberikan padding di sekitar kolom tombol.
             */
            Padding(
              padding: const EdgeInsets.all(24.0),
              /** Widget [Column]
               * * Deskripsi:
               * - Mengatur tombol "CREATE AN ACCOUNT" dan "LOGIN" secara vertikal.
               */
              child: Column(
                children: [
                  /** Widget [SizedBox]
                   * * Deskripsi:
                   * - Mengatur lebar penuh untuk tombol "CREATE AN ACCOUNT".
                   */
                  SizedBox(
                    width: double.infinity, // Lebar tombol memenuhi layar.
                    /** Widget [ElevatedButton]
                     * * Deskripsi:
                     * - Tombol utama untuk menavigasi ke halaman pendaftaran akun baru.
                     */
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigasi ke halaman Register.
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                            0xFF4A5A2A), // Warna latar belakang tombol (hijau gelap).
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30), // Sudut tombol membulat.
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16), // Padding internal tombol.
                      ),
                      /** Widget [Text]
                       * * Deskripsi:
                       * - Teks tombol "CREATE AN ACCOUNT".
                       * - Gaya teks dengan ukuran 16, warna putih, dan tebal.
                       */
                      child: const Text(
                        'CREATE AN ACCOUNT',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // Spasi vertikal antar tombol.
                  /** Widget [SizedBox]
                   * * Deskripsi:
                   * - Mengatur lebar penuh untuk tombol "LOGIN".
                   */
                  SizedBox(
                    width: double.infinity, // Lebar tombol memenuhi layar.
                    /** Widget [ElevatedButton]
                     * * Deskripsi:
                     * - Tombol untuk menavigasi ke halaman login.
                     */
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigasi ke halaman SignIn.
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                            0xFF4A5A2A), // Warna latar belakang tombol (hijau gelap).
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30), // Sudut tombol membulat.
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16), // Padding internal tombol.
                      ),
                      /** Widget [Text]
                       * * Deskripsi:
                       * - Teks tombol "LOGIN".
                       * - Gaya teks dengan ukuran 16, warna putih, dan tebal.
                       */
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* Fungsi ini membangun widget indikator titik untuk carousel.
   *
   * Parameter:
   * - [isActive]: Boolean yang menunjukkan apakah titik ini adalah halaman yang sedang aktif.
   *
   * Return: Widget [Container] yang merepresentasikan sebuah titik indikator.
   */
  Widget _buildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 4), // Margin horizontal antar titik.
      width: isActive ? 20 : 12, // Lebar titik: lebih lebar jika aktif.
      height: 8, // Tinggi titik.
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF4A5A2A)
            : Colors.grey[
                300], // Warna titik: hijau gelap jika aktif, abu-abu jika tidak.
        borderRadius:
            BorderRadius.circular(20), // Bentuk titik membulat (pill-shaped).
      ),
    );
  }
}

/// Widget [OnboardingPage]
///
/// Deskripsi:
/// - Widget ini merepresentasikan satu halaman individual dalam carousel onboarding.
/// - Menampilkan gambar, judul, subtitle, dan deskripsi.
/// - Ini adalah StatelessWidget karena kontennya (gambar, teks) bersifat statis
/// dan tidak berubah setelah dibuat.
class OnboardingPage extends StatelessWidget {
  final String image; // Path aset gambar untuk halaman ini.
  final String title; // Judul utama halaman.
  final String subtitle; // Subtitle halaman (opsional).
  final String description; // Deskripsi detail halaman (opsional).
  final Color backgroundColor; // Warna latar belakang halaman.

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.backgroundColor,
  });

  /* Fungsi ini membangun seluruh struktur UI dari satu halaman onboarding.
   *
   * Parameter:
   * - [context]: BuildContext dari widget.
   *
   * Return: Sebuah widget [Container] yang berisi konten halaman.
   */
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor, // Mengatur warna latar belakang halaman.
      /** Widget [Padding]
       * * Deskripsi:
       * - Memberikan padding horizontal di sekitar konten halaman.
       */
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        /** Widget [Center]
         * * Deskripsi:
         * - Memusatkan konten halaman secara vertikal dan horizontal.
         */
        child: Center(
          /** Widget [Column]
           * * Deskripsi:
           * - Mengatur tata letak elemen-elemen UI (gambar, judul, subtitle, deskripsi) secara vertikal.
           * - Memusatkan elemen-elemen tersebut di tengah kolom.
           */
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Memusatkan konten secara vertikal.
            children: [
              /** Widget [Image.asset]
               * * Deskripsi:
               * - Menampilkan **gambar ilustrasi** untuk halaman onboarding ini.
               * - Data dinamis dari parameter `image`.
               */
              Image.asset(
                image, // Path aset gambar.
                height: 250, // Tinggi gambar.
                fit: BoxFit
                    .contain, // Gambar akan diukur untuk masuk ke dalam kotak sumber.
              ),
              const SizedBox(height: 30), // Spasi vertikal.
              /** Widget [Text]
               * * Deskripsi:
               * - Menampilkan **judul utama halaman** (misalnya "Welcome to Campedia").
               * - Data dinamis dari parameter `title`.
               * - Gaya teks besar, tebal, dan terpusat.
               */
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24, // Ukuran font.
                  fontWeight: FontWeight.bold, // Ketebalan font.
                ),
                textAlign: TextAlign.center, // Perataan teks di tengah.
              ),
              // Menampilkan subtitle hanya jika tidak kosong.
              if (subtitle.isNotEmpty)
                /** Widget [Column]
                 * * Deskripsi:
                 * - Membungkus subtitle untuk memberikan spasi di atasnya.
                 */
                Column(
                  children: [
                    const SizedBox(height: 8), // Spasi vertikal.
                    /** Widget [Text]
                     * * Deskripsi:
                     * - Menampilkan **subtitle halaman** (misalnya "Your Ultimate Camping Companion").
                     * - Data dinamis dari parameter `subtitle`.
                     * - Gaya teks dengan ukuran 16 dan semi-bold.
                     */
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 16, // Ukuran font.
                        fontWeight: FontWeight.w500, // Ketebalan font.
                      ),
                      textAlign: TextAlign.center, // Perataan teks di tengah.
                    ),
                  ],
                ),
              // Menampilkan deskripsi hanya jika tidak kosong.
              if (description.isNotEmpty)
                /** Widget [Column]
                 * * Deskripsi:
                 * - Membungkus deskripsi untuk memberikan spasi di atasnya.
                 */
                Column(
                  children: [
                    const SizedBox(height: 16), // Spasi vertikal.
                    /** Widget [Text]
                     * * Deskripsi:
                     * - Menampilkan **deskripsi detail halaman**.
                     * - Data dinamis dari parameter `description`.
                     * - Gaya teks dengan ukuran 14 dan warna abu-abu.
                     */
                    Text(
                      description,
                      textAlign: TextAlign.center, // Perataan teks di tengah.
                      style: TextStyle(
                        fontSize: 14, // Ukuran font.
                        color: Colors.grey[700], // Warna teks abu-abu.
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
