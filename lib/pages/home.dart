import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'category.dart';

void main() {
  runApp(CampingApp());
}

class CampingApp extends StatelessWidget {
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
      "image": 'assets/tenda.jpg',
      "price": 6.7,
      "rating": 4.3,
      "color": Color(0xFFFF9800),
    },
    {
      "name": "Kompor",
      "image": 'assets/kompor.jpg',
      "price": 6.7,
      "rating": 4.3,
      "color": Color(0xFFE53935),
    },
    {
      "name": "Sepatu",
      "image": 'assets/sepatu.jpg',
      "price": 6.7,
      "rating": 4.3,
      "color": Color(0xFF8D6E63),
    },
    {
      "name": "Tas Leather",
      "image": 'assets/tas.jpg',
      "price": 6.7,
      "rating": 4.3,
      "color": Color(0xFF795548),
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.outdoor_grill, "name": "Kompor"},
    {"icon": Icons.cabin, "name": "Tenda"},
    {"icon": Icons.hiking, "name": "Sepatu"},
    {"icon": Icons.backpack, "name": "Backpack"},
  ];

  final List<Map<String, dynamic>> featuredSlides = [
    {
      "title": "Recomended\nGear Trip",
      "image": "assets/gunung1.jpg",
      "color": Colors.black.withOpacity(0.6),
    },
    {
      "title": "Fresh Trending\nGear",
      "image": "assets/gunung2.jpg",
      "color": Colors.black.withOpacity(0.6),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          children: [
            // Header
            _buildHeader(),
            SizedBox(height: 20),

            // Featured Slider
            _buildFeaturedSlider(),
            SizedBox(height: 24),

            // Categories
            _buildCategoriesSection(),
            SizedBox(height: 24),

            // Trending Deals
            _buildTrendingDealsSection(),
            SizedBox(height: 24),

            // More Button
            _buildMoreButton(context),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              'Rafatul Islam',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Stack(
              children: [
                Container(
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

  Widget _buildFeaturedSlider() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: featuredSlides.length,
        itemBuilder: (context, index) {
          final slide = featuredSlides[index];
          return Container(
            width: 240,
            margin: EdgeInsets.only(right: 16),
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
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    slide["title"],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Icon(Icons.arrow_forward, size: 22),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: categories.map((category) {
            return _buildCategoryItem(category);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    return Container(
      width: 80,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              category["icon"],
              color: Color(0xFFFFD54F),
              size: 28,
            ),
          ),
          SizedBox(height: 8),
          Text(
            category["name"],
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingDealsSection() {
    return Column(
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
            Icon(Icons.arrow_forward, size: 22),
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

  Widget _buildTrendingItem(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Background image with overlay
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Image.asset(
                  item["image"],
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.9),
                      ],
                      stops: [0.0, 0.6, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Favorite icon
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
                
                // Product info at bottom
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["name"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${item["price"]}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${item["rating"]}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
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

  Widget _buildMoreButton(context) {
  return GestureDetector(
    onTap: () {
      // Aksi saat tombol More diklik
      print('Tombol More diklik!');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CategoryPage()),
      );
      // Contoh: Navigasi ke halaman baru atau munculkan pop-up
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


  Widget _buildBottomNavBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, true),
          _buildNavItem(Icons.swap_horiz, false),
          _buildNavItem(Icons.shopping_cart_outlined, false, hasNotification: true),
          _buildNavItem(Icons.favorite_border, false),
          _buildProfileNavItem(),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected, {bool hasNotification = false}) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFFEAEAEA) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 28,
            color: isSelected ? Colors.black87 : Colors.grey,
          ),
        ),
        if (hasNotification)
          Positioned(
            top: 10,
            right: 10,
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
    );
  }

  Widget _buildProfileNavItem() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
        image: DecorationImage(
          image: AssetImage('assets/profile_placeholder.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
