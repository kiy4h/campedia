import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas3provis/Items/allListItem.dart';
import '../Items/category.dart';
import 'recommendedGearTrip.dart';
import '../components/navbar.dart';
import 'trendingGear.dart';
import '../profile/notification.dart';

void main() {
  runApp(CampingApp());
}

class CampingApp extends StatelessWidget {
  const CampingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF2E7D32),
        scaffoldBackgroundColor: Color(0xFFF8F8F8),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> trendingItems = [
    {
      "name": "Tenda",
      "image": 'images/assets_ItemDetails/tenda1.png',
      "price": 500000,
      "rating": 4.3,
      "color": Color(0xFFFF9800),
    },
    {
      "name": "Kompor",
      "image": 'images/assets_ItemDetails/kompor1.png',
      "price": 200000,
      "rating": 4.3,
      "color": Color(0xFFE53935),
    },
    {
      "name": "Sepatu",
      "image": 'images/assets_ItemDetails/sepatu1.png',
      "price": 300000,
      "rating": 4.3,
      "color": Color(0xFF8D6E63),
    },
    {
      "name": "Tas Leather",
      "image": 'images/assets_ItemDetails/tas1.png',
      "price": 600000,
      "rating": 4.3,
      "color": Color(0xFF795548),
    },
  ];

  final List<Map<String, String>> categories = [
    {"icon": "images/assets_Categories/cat_Kompor.png",   "name": "Kompor"},
    {"icon": "images/assets_Categories/cat_Tenda.png",    "name": "Tenda"},
    {"icon": "images/assets_Categories/cat_Sepatu.png",   "name": "Sepatu"},
    {"icon": "images/assets_Categories/cat_Tas.png",      "name": "Tas"},
    {"icon": "images/assets_Categories/cat_Senter.png",    "name": "Senter"},
    {"icon": "images/assets_Categories/cat_Jaket.png",  "name": "Jaket"},
    {"icon": "images/assets_Categories/cat_KeamananNavigasi.png",     "name": "Keamanan"},
    {"icon": "images/assets_Categories/cat_FasilitasTambahan.png", "name": "Lainnya"},
  ];

  final List<Map<String, dynamic>> featuredSlides = [
    {
      "key": "1",
      "title": "Recommended\nGear Trip",
      "image": "images/assets_Home/gunung1.png",
      "color": Colors.black.withOpacity(0.6),
    },
    {
      "key": "2",
      "title": "Fresh Trending\nGear",
      "image": "images/assets_Home/gunung2.png",
      "color": Colors.black.withOpacity(0.6),
    },
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          children: [
            _buildHeader(context),
            SizedBox(height: 20),
            _buildFeaturedSlider(context),
            SizedBox(height: 24),
            _buildCategoriesSection(context),
            SizedBox(height: 24),
            _buildTrendingDealsSection(),
            SizedBox(height: 24),
            _buildMoreButton(context),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(
        context,
        currentIndex: 0,
      ),
    );
  }

  Widget _buildHeader(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Bar
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search camping gear...',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    // Jika ingin menyimpan hasil pencarian untuk digunakan nanti
                  },
                  onSubmitted: (value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllItemList()),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
        SizedBox(height: 16), // Spacer antara search bar dan greeting

        Text(
          'Good Morning',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Izzuddin Azzam',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationPage()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(Icons.notifications_none, size: 24, color: Colors.black87),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }


  Widget _buildFeaturedSlider(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: featuredSlides.length,
        itemBuilder: (context, index) {
          final slide = featuredSlides[index];

          return GestureDetector(
            onTap: () {
              if (slide["key"] == "1") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecommendedGearTripPage(),
                  ),
                );
              }
              if (slide["key"] == "2") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TrendingGearPage(),
                  ),
                );
              }
            },
            child: Container(
              width: 240,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(slide["image"]),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    slide["color"],
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      slide["title"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesSection(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward, size: 22),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryPage()), // Ganti dengan page kamu
                );
              },
            ),

          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return _buildCategoryItem(categories[index], context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(Map<String, String> category, context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryPage(),
          ),
        );
      },
      child: Container(
        width: 100, // Dulu: 80
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
              width: 80, // Dulu: 60
              height: 80, // Dulu: 60
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18), // Dulu: 15
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(14), // Dulu: 12
                child: Image.asset(
                  category["icon"]!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 10), // Dulu: 8
            Text(
              category["name"]!,
              style: const TextStyle(
                fontSize: 13, // Dulu: 12
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildTrendingItem(Map<String, dynamic> item) {
  return Container(
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 237, 236, 236),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.05),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              item['image'],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    NumberFormat.currency(locale: 'id', symbol: 'Rp').format(item['price']),
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        item['rating'].toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}



 Widget _buildTrendingDealsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Trending Deals',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      SizedBox(height: 16),
      GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: trendingItems.length,
        itemBuilder: (context, index) {
          return _buildTrendingItem(trendingItems[index]);
        },
      ),
    ],
  );
}



  Widget _buildMoreButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AllItemList()),
        );
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Color(0xFF5D7052),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            'More',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
