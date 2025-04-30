import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas3provis/Items/itemCategory.dart';
import '../components/navbar.dart';
import 'allListItem.dart';

void main() {
  runApp(CategoryPage());
}

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF5D7052),
        scaffoldBackgroundColor: Color(0xFFF8F8F8),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: CategoriesPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CategoriesPage extends StatelessWidget {
  // Daftar kategori dengan path asset untuk icon
  final List<Map<String, dynamic>> categories = [
    {"name": "Alat Masak", "icon": "images/assets_Categories/cat_Kompor.png", "items": 87},
    {"name": "Tenda", "icon": "images/assets_Categories/cat_Tenda.png", "items": 87},
    {"name": "Sepatu", "icon": "images/assets_Categories/cat_Sepatu.png", "items": 87},
    {"name": "Tas Gunung", "icon": "images/assets_Categories/cat_Tas.png", "items": 27},
    {"name": "Senter", "icon": "images/assets_Categories/cat_Senter.png", "items": 87},
    {"name": "Jaket Gunung", "icon": "images/assets_Categories/cat_Jaket.png", "items": 87},
    {"name": "Alat Pendukung", "icon": "images/assets_Categories/cat_KeamananNavigasi.png", "items": 87},
    {"name": "Fasilitas Tambahan", "icon": "images/assets_Categories/cat_FasilitasTambahan.png", "items": 120},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, currentIndex: 1),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return _buildCategoryCard(categories[index], context);
          },
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(
        context,
        currentIndex: 1,
      ),


    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AllItemList()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon kategori dari asset
            Container(
              width: 100,
              height: 100,
              padding: EdgeInsets.all(8),
              child: Image.asset(
                category['icon'],
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 10),
            Text(
              category['name'],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5D7052),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              "${category['items']} Items",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Fungsi untuk membangun AppBar dengan navigasi bottom
PreferredSizeWidget buildAppBar({
  required BuildContext context,
  required int currentIndex,
}) {
  String title;
  List<Widget> actions;

  switch (currentIndex) {
    case 0:
      title = 'Home';
      actions = [
        IconButton(onPressed: () {}, icon: Icon(Icons.search, color: Colors.black)),
      ];
      break;
    case 1:
      title = 'Category';
      actions = [
        
      ];
      break;
    case 2:
      title = 'Shopping Cart';
      actions = [
        TextButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Order placed!')),
          ),
          style: TextButton.styleFrom(
            foregroundColor: Colors.amber,
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          child: Text('Place Order'),
        ),
      ];
      break;
    case 3:
      title = 'Favorite';
      actions = [
        TextButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Order placed!')),
          ),
          style: TextButton.styleFrom(
            foregroundColor: Colors.amber,
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          child: Text('Place Order'),
        ),
      ];
      break;
    case 4:
      title = 'Profile';
      actions = [
        IconButton(onPressed: () {}, icon: Icon(Icons.settings, color: Colors.black)),
      ];
      break;
    default:
      title = 'App';
      actions = [];
  }
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text(title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
    actions: actions,
  );
}
