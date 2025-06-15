/*
* File : Tugas3MainPage.dart
* Deskripsi : Halaman navigasi utama yang berisi daftar semua halaman dalam aplikasi untuk memudahkan navigasi saat pengembangan
* Dependencies : 
*   - flutter/services.dart: untuk RawKeyboardListener
*   - Semua halaman dalam aplikasi yang dapat dinavigasi
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for RawKeyboardListener

import 'intro/animation/onboarding.dart';
import 'intro/animation/splashscreen.dart';
import 'all_items/allListItem.dart';
import 'all_items/category.dart';
import 'intro/account/forgotPassword.dart';
import 'intro/account/register.dart';
import 'intro/account/signin.dart';
import 'wishlist/favorite.dart';
import 'beranda/home.dart';
import 'beranda/recommendedGearTrip.dart';
// import '../pages/trendingGear.dart';
import 'shopping/payment_data/checkout.dart';
import 'shopping/payment_data/checkout2.dart';
import 'shopping/after_sales/thankyouPage.dart';
import 'profile/profile_detail/profile.dart';
import 'profile/profile_detail/settingProfile.dart';
import 'beranda/notification.dart';
import 'shopping/after_sales/review.dart';
import 'shopping/after_sales/step1.dart';
import 'shopping/after_sales/step2.dart';
import 'shopping/after_sales/step3.dart';
import 'shopping/cart/shoping.dart';
import 'profile/transaction/historyPenyewaan.dart';
import 'profile/transaction/historyPenyewaanDetailBarang.dart'; // Halaman detail transaksi
import 'profile/transaction/reviewItem.dart';

void main() {
  runApp(MyApp());
}

/*
* Class : MyApp
* Deskripsi : Widget root aplikasi untuk halaman navigasi
* Bagian Layar : Root aplikasi navigasi
*/
class MyApp extends StatelessWidget {
  MyApp({super.key});
  /*
  * Method : build
  * Deskripsi : Membangun widget MaterialApp dengan tema dan warna kustom
  * Parameter : context - BuildContext untuk akses ke fitur framework
  * Return : Widget MaterialApp dengan tema yang dikonfigurasi
  */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campedia Navigation',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFFF9DC), // krem muda
        primaryColor: Color(0xFF4E5C38), // hijau gelap
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF4E5C38),
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF4E5C38),
          foregroundColor: Colors.white,
        ),
        listTileTheme: ListTileThemeData(
          iconColor: Color(0xFF4E5C38),
          textColor: Color(0xFF4E5C38),
        ),
        useMaterial3: true,
      ),
      home: Tugas3ProvisPage(),
    );
  }
}

/*
* Class : Tugas3ProvisPage
* Deskripsi : Widget halaman navigasi utama, merupakan StatefulWidget
* Bagian Layar : Halaman navigasi dengan daftar semua halaman aplikasi
*/
class Tugas3ProvisPage extends StatefulWidget {
  Tugas3ProvisPage({super.key});

  @override
  _Tugas3ProvisPageState createState() => _Tugas3ProvisPageState();
}

/*
* Class : _Tugas3ProvisPageState
* Deskripsi : State untuk widget Tugas3ProvisPage
* Bagian Layar : Mengelola state dan tampilan daftar navigasi halaman
*/
class _Tugas3ProvisPageState extends State<Tugas3ProvisPage> {
  final List<Map<String, dynamic>> pageSections = [
    {
      'title': 'App Introduction',
      'pages': [
        {
          'title': 'Splash Screen',
          'description': 'Opening screen when app launches',
          'page': SplashScreen()
        },
        {
          'title': 'Onboarding',
          'description': 'Introduction screens for first-time users',
          'page': OnboardingScreen()
        },
      ]
    },
    {
      'title': 'Authentication',
      'pages': [
        {
          'title': 'Login',
          'description': 'User sign in page',
          'page': SignIn()
        },
        {
          'title': 'Register',
          'description': 'Create a new account',
          'page': Register()
        },
        {
          'title': 'Forgot Password',
          'description': 'Password recovery page',
          'page': ForgotPassword()
        },
      ]
    },
    {
      'title': 'Main App Pages',
      'pages': [
        {
          'title': 'Home',
          'description': 'Main dashboard with featured content',
          'page': HomePage()
        },
        {
          'title': 'Notification',
          'description': 'User notifications center',
          'page': NotificationPage()
        },
        {
          'title': 'Recommended Trip',
          'description': 'Gear recommendations for trips',
          'page': RecommendedGearTripPage()
        },
        {
          'title': 'Categories',
          'description': 'Browse gear by category',
          'page': CategoriesPage()
        },
        {
          'title': 'All Item Page',
          'description': 'Complete list of available items',
          'page': AllItemList()
        },
        {
          'title': 'Favorite',
          'description': 'User saved favorites',
          'page': FavoritePage()
        },
      ]
    },
    {
      'title': 'User Profile',
      'pages': [
        {
          'title': 'Profile',
          'description': 'User profile page',
          'page': ProfilePage()
        },
        {
          'title': 'Edit Profile',
          'description': 'Profile settings and editing',
          'page': SettingsPage()
        },
      ]
    },
    {
      'title': 'Shopping & Checkout',
      'pages': [
        {
          'title': 'Shopping',
          'description': 'Product browsing and selection',
          'page': Shoping()
        },
        {
          'title': 'Checkout',
          'description': 'First step of payment process',
          'page': Checkout()
        },
        {
          'title': 'Checkout 2',
          'description': 'Second step of payment process',
          'page': Checkout2()
        },
        {
          'title': 'Thank You',
          'description': 'Order confirmation page',
          'page': ThankYouPage()
        },
      ]
    },
    {
      'title': 'Order Progress',
      'pages': [
        {
          'title': 'Pengambilan Barang 1',
          'description': 'Step 1 of item pickup process',
          'page': Step1Page()
        },
        {
          'title': 'Pengambilan Barang 2',
          'description': 'Step 2 of item pickup process',
          'page': Step2Page()
        },
        {
          'title': 'Pengambilan Barang 3',
          'description': 'Step 3 of item pickup process',
          'page': Step3Page()
        },
        {
          'title': 'Review dari User',
          'description': 'User feedback and rating page',
          'page': ReviewPage()
        },
      ]
    },
    {
      'title': 'Transaction History',
      'pages': [
        {
          'title': 'History Penyewaan',
          'description': 'List of all rental transactions',
          'page': ModernTransactionPage()
        },
        {
          'title': 'Detail Barang Penyewaan',
          'description': 'Detailed view of rented items',
          'page': TransactionDetailPage()
        },
        {
          'title': 'Review Barang',
          'description': 'User review page for rented items',
          'page': ProductReviewPage(
            productImage: '../../images/assets_ItemDetails/kompor1.png',
            productName: 'Kompor Portable',
          )
        },
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        if (event.logicalKey == LogicalKeyboardKey.keyR) {
          // When 'R' key is pressed, navigate to the first screen (Splash Screen)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SplashScreen()),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Navigasi Halaman'),
        ),
        body: CustomScrollView(
          slivers: [
            // Notification and group information
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card displaying the notification message
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Color(0xFF4E5C38),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Tekan "Ctrl + R" atau refresh untuk kembali ke Splash Screen dan memulai ulang aplikasi.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    const Text(
                      "Kelompok 4",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        // color is primary color
                        color: Color(0xFF4E5C38),
                      ),
                    ),
                    const Text(
                      "Abdurrahman Al Ghifari (2300456)\nAhmad Izzuddin Azzam (2300492)\nMuhammad Alvinza (2304879)\nMuhammad Igin Adigholib (2301125)\nZakiyah Hasanah (2305274)",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Page sections with grouped navigation
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final section = pageSections[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          top: 16.0,
                          bottom: 8.0,
                        ),
                        child: Text(
                          section['title'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      ...section['pages'].map((page) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(
                                page['title'],
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                page['description'],
                                style: TextStyle(fontSize: 12),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => page['page'],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  );
                },
                childCount: pageSections.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
