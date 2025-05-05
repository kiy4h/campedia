import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for RawKeyboardListener

import '../Intro/onboarding.dart';
import '../Intro/splashscreen.dart';
import '../Items/allListItem.dart';
import '../Items/category.dart';
import '../Login/forgotPassword.dart';
import '../Login/register.dart';
import '../Login/signin.dart';
import '../pages/favorite.dart';
import '../pages/home.dart';
import '../pages/recommendedGearTrip.dart';
// import '../pages/trendingGear.dart';
import '../payment/checkout.dart';
import '../payment/checkout2.dart';
import '../payment/thankyouPage.dart';
import '../profile/profile.dart';
import '../profile/settingProfile.dart';
import '../profile/notification.dart';
import '../progress/review.dart';
import '../progress/step1.dart';
import '../progress/step2.dart';
import '../progress/step3.dart';
import '../shopPage/shoping.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

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

class Tugas3ProvisPage extends StatefulWidget {
  Tugas3ProvisPage({super.key});

  @override
  _Tugas3ProvisPageState createState() => _Tugas3ProvisPageState();
}

class _Tugas3ProvisPageState extends State<Tugas3ProvisPage> {
  final List<Map<String, dynamic>> pages = [
    {'title': 'Splash Screen | Opening App', 'page': SplashScreen()},
    {'title': 'Onboarding', 'page': OnboardingScreen()},
    {'title': 'Login', 'page': SignIn()},
    {'title': 'Register', 'page': Register()},
    {'title': 'Forgot Password', 'page': ForgotPassword()},
    {'title': 'Home', 'page': HomePage()},
    {'title': 'Notification', 'page': NotificationPage()},
    {'title': 'Recommended Trip', 'page': RecommendedGearTripPage()},
    // {'title': 'Fresh Trending Gear', 'page': TrendingGearPage()},
    {'title': 'Categories', 'page': CategoriesPage()},
    {'title': 'All Item Page', 'page': AllItemList()},
    {'title': 'Favorite', 'page': FavoritePage()},
    {'title': 'Profile', 'page': ProfilePage()},
    {'title': 'Edit Profile', 'page': SettingsPage()},
    {'title': 'Shopping', 'page': Shoping()},
    {'title': 'Checkout', 'page': Checkout()},
    {'title': 'Checkout 2', 'page': Checkout2()},
    {'title': 'Thank You', 'page': ThankYouPage()},
    {'title': 'Pengambilan Barang 1', 'page': Step1Page()},
    {'title': 'Pengambilan Barang 2', 'page': Step2Page()},
    {'title': 'Pengambilan Barang 3', 'page': Step3Page()},
    {'title': 'Review dari User', 'page': ReviewPage()},
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
            // Move the notification information into the main content area below the AppBar
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
                            fontSize: 18,
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const Text(
                      "Abdurrahman Al Ghifari (2300456)\nAhmad Izzuddin Azzam (2300492)\nMuhammad Alvinza (2304879)\nMuhammad Igin Adigholib (2301125)\nZakiyah Hasanah (2305274)",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            // The rest of the page content
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        pages[index]['title'],
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => pages[index]['page'],
                          ),
                        );
                      },
                    ),
                  );
                },
                childCount: pages.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
