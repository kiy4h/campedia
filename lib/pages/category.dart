import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas3provis/pages/itemCategory.dart';
import '../components/navbar.dart';


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
  final List<Map<String, dynamic>> categories = [
    {
      "name": "Tenda",
      "icon": "assets/icons/tent.png",
      "items": 87,
    },
    {
      "name": "Alat Masak",
      "icon": "assets/icons/cooking.png",
      "items": 87,
    },
    {
      "name": "Keamanan dan\nNavigasi",
      "icon": "assets/icons/navigation.png",
      "items": 87,
    },
    {
      "name": "Sepatu",
      "icon": "assets/icons/boots.png",
      "items": 87,
    },
    {
      "name": "Senter",
      "icon": "assets/icons/flashlight.png",
      "items": 87,
    },
    {
      "name": "Jaket Gunung",
      "icon": "assets/icons/jacket.png",
      "items": 87,
    },
    {
      "name": "Tas Gunung",
      "icon": "assets/icons/backpack.png",
      "items": 27,
    },
    {
      "name": "Fasilitas\nTambahan",
      "icon": "assets/icons/facilities.png",
      "items": 120,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      bottomNavigationBar: buildBottomNavBar(
        context: context,
        currentIndex: 1,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Categories',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(16),
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
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category, context) {
    return GestureDetector(
      onTap: () {
        // Handle category tap
        print("Tapped on ${category["name"]}");
        // Bisa juga Navigate ke halaman kategori, dll
        Navigator.push(context,MaterialPageRoute(builder: (context) => ItemCategory()),);
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
            Container(
              width: 60,
              height: 60,
              child: _getCategoryIcon(category["name"]),
            ),
            SizedBox(height: 10),
            Text(
              category["name"],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5D7052),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              "${category["items"]} Items",
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


  Widget _getCategoryIcon(String categoryName) {
    // Implementasi sederhana untuk icon kategori
    // Dalam aplikasi nyata, Anda seharusnya menggunakan asset gambar SVG yang sesuai
    IconData iconData;
    switch (categoryName) {
      case "Tenda":
        return CustomPaint(
          size: Size(60, 60),
          painter: TentIconPainter(),
        );
      case "Alat Masak":
        return CustomPaint(
          size: Size(60, 60),
          painter: CookingIconPainter(),
        );
      case "Keamanan dan\nNavigasi":
        return CustomPaint(
          size: Size(60, 60),
          painter: NavigationIconPainter(),
        );
      case "Sepatu":
        return CustomPaint(
          size: Size(60, 60),
          painter: BootsIconPainter(),
        );
      case "Senter":
        return CustomPaint(
          size: Size(60, 60),
          painter: FlashlightIconPainter(),
        );
      case "Jaket Gunung":
        return CustomPaint(
          size: Size(60, 60),
          painter: JacketIconPainter(),
        );
      case "Tas Gunung":
        return CustomPaint(
          size: Size(60, 60),
          painter: BackpackIconPainter(),
        );
      case "Fasilitas\nTambahan":
        return CustomPaint(
          size: Size(60, 60),
          painter: FacilitiesIconPainter(),
        );
      default:
        return Icon(Icons.category, size: 40, color: Color(0xFF5D7052));
    }
  }

 
}

// Custom Painters untuk icon kategori
class TentIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF5D7052)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    // Draw a simple tent
    final path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.7)
      ..lineTo(size.width * 0.5, size.height * 0.3)
      ..lineTo(size.width * 0.8, size.height * 0.7)
      ..close();
    
    canvas.drawPath(path, paint);
    
    // Draw tent door
    final doorPath = Path()
      ..moveTo(size.width * 0.4, size.height * 0.5)
      ..lineTo(size.width * 0.5, size.height * 0.4)
      ..lineTo(size.width * 0.6, size.height * 0.5)
      ..lineTo(size.width * 0.6, size.height * 0.7)
      ..lineTo(size.width * 0.4, size.height * 0.7)
      ..close();
    
    final fillPaint = Paint()
      ..color = Color(0xFFFFE082)
      ..style = PaintingStyle.fill;
    
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, paint);
    canvas.drawPath(doorPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CookingIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF5D7052)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    final fillPaint = Paint()
      ..color = Color(0xFFFFE082)
      ..style = PaintingStyle.fill;
    
    // Draw cooking pot
    final rect = Rect.fromLTWH(
      size.width * 0.2, 
      size.height * 0.3, 
      size.width * 0.6, 
      size.height * 0.4
    );
    
    canvas.drawRect(rect, fillPaint);
    canvas.drawRect(rect, paint);
    
    // Draw pot handles
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.4),
      Offset(size.width * 0.1, size.height * 0.4),
      paint
    );
    
    canvas.drawLine(
      Offset(size.width * 0.8, size.height * 0.4),
      Offset(size.width * 0.9, size.height * 0.4),
      paint
    );
    
    // Draw stove base
    final stoveRect = Rect.fromLTWH(
      size.width * 0.35, 
      size.height * 0.7, 
      size.width * 0.3, 
      size.height * 0.15
    );
    
    canvas.drawOval(stoveRect, fillPaint);
    canvas.drawOval(stoveRect, paint);
    
    // Draw pot lid
    final lidRect = Rect.fromLTWH(
      size.width * 0.3, 
      size.height * 0.2, 
      size.width * 0.4, 
      size.height * 0.1
    );
    
    canvas.drawOval(lidRect, fillPaint);
    canvas.drawOval(lidRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class NavigationIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF5D7052)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    final fillPaint = Paint()
      ..color = Color(0xFFFFE082)
      ..style = PaintingStyle.fill;
    
    // Draw compass
    final compassRect = Rect.fromLTWH(
      size.width * 0.4, 
      size.height * 0.4, 
      size.width * 0.5, 
      size.height * 0.5
    );
    
    canvas.drawOval(compassRect, fillPaint);
    canvas.drawOval(compassRect, paint);
    
    // Draw compass needle
    canvas.drawLine(
      Offset(size.width * 0.65, size.height * 0.5),
      Offset(size.width * 0.65, size.height * 0.7),
      paint
    );
    
    canvas.drawLine(
      Offset(size.width * 0.55, size.height * 0.6),
      Offset(size.width * 0.75, size.height * 0.6),
      paint
    );
    
    // Draw knife/tool
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.2),
      Offset(size.width * 0.2, size.height * 0.6),
      paint
    );
    
    final knifePath = Path()
      ..moveTo(size.width * 0.15, size.height * 0.2)
      ..lineTo(size.width * 0.25, size.height * 0.2)
      ..lineTo(size.width * 0.2, size.height * 0.1)
      ..close();
    
    canvas.drawPath(knifePath, fillPaint);
    canvas.drawPath(knifePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BootsIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF5D7052)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    final fillPaint = Paint()
      ..color = Color(0xFFFFE082)
      ..style = PaintingStyle.fill;
    
    // Draw boot
    final bootPath = Path()
      ..moveTo(size.width * 0.2, size.height * 0.7)
      ..lineTo(size.width * 0.2, size.height * 0.4)
      ..quadraticBezierTo(
        size.width * 0.3, size.height * 0.3, 
        size.width * 0.4, size.height * 0.3
      )
      ..lineTo(size.width * 0.7, size.height * 0.3)
      ..quadraticBezierTo(
        size.width * 0.8, size.height * 0.3, 
        size.width * 0.8, size.height * 0.4
      )
      ..lineTo(size.width * 0.8, size.height * 0.7)
      ..lineTo(size.width * 0.2, size.height * 0.7);
    
    canvas.drawPath(bootPath, fillPaint);
    canvas.drawPath(bootPath, paint);
    
    // Draw boot sole
    final solePath = Path()
      ..moveTo(size.width * 0.2, size.height * 0.7)
      ..lineTo(size.width * 0.1, size.height * 0.75)
      ..lineTo(size.width * 0.9, size.height * 0.75)
      ..lineTo(size.width * 0.8, size.height * 0.7);
    
    canvas.drawPath(solePath, fillPaint);
    canvas.drawPath(solePath, paint);
    
    // Draw laces
    for (int i = 0; i < 3; i++) {
      double y = size.height * (0.35 + i * 0.05);
      canvas.drawLine(
        Offset(size.width * 0.5, y),
        Offset(size.width * 0.65, y),
        paint
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FlashlightIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF5D7052)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    final fillPaint = Paint()
      ..color = Color(0xFFFFE082)
      ..style = PaintingStyle.fill;
    
    // Draw flashlight body
    final bodyRect = Rect.fromLTWH(
      size.width * 0.3, 
      size.height * 0.3, 
      size.width * 0.4, 
      size.height * 0.5
    );
    
    canvas.drawRect(bodyRect, fillPaint);
    canvas.drawRect(bodyRect, paint);
    
    // Draw flashlight head
    final headRect = Rect.fromLTWH(
      size.width * 0.25, 
      size.height * 0.2, 
      size.width * 0.5, 
      size.height * 0.15
    );
    
    canvas.drawOval(headRect, fillPaint);
    canvas.drawOval(headRect, paint);
    
    // Draw light beam
    final beamPath = Path()
      ..moveTo(size.width * 0.4, size.height * 0.2)
      ..lineTo(size.width * 0.3, size.height * 0.1)
      ..lineTo(size.width * 0.7, size.height * 0.1)
      ..lineTo(size.width * 0.6, size.height * 0.2);
    
    final beamPaint = Paint()
      ..color = Color(0xFFFFE082)
      ..style = PaintingStyle.fill;
    
    canvas.drawPath(beamPath, beamPaint);
    canvas.drawPath(beamPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class JacketIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF5D7052)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    final fillPaint = Paint()
      ..color = Color(0xFFFFE082)
      ..style = PaintingStyle.fill;
    
    // Draw jacket body
    final bodyPath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.2)
      ..lineTo(size.width * 0.2, size.height * 0.8)
      ..lineTo(size.width * 0.8, size.height * 0.8)
      ..lineTo(size.width * 0.7, size.height * 0.2)
      ..close();
    
    canvas.drawPath(bodyPath, fillPaint);
    canvas.drawPath(bodyPath, paint);
    
    // Draw jacket collar
    final collarPath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.2)
      ..lineTo(size.width * 0.4, size.height * 0.3)
      ..lineTo(size.width * 0.5, size.height * 0.2)
      ..lineTo(size.width * 0.6, size.height * 0.3)
      ..lineTo(size.width * 0.7, size.height * 0.2);
    
    canvas.drawPath(collarPath, paint);
    
    // Draw zipper
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.2),
      Offset(size.width * 0.5, size.height * 0.7),
      paint
    );
    
    // Draw pocket
    final pocketRect = Rect.fromLTWH(
      size.width * 0.3, 
      size.height * 0.6, 
      size.width * 0.15, 
      size.height * 0.15
    );
    
    canvas.drawRect(pocketRect, paint);
    
    final pocketRect2 = Rect.fromLTWH(
      size.width * 0.55, 
      size.height * 0.6, 
      size.width * 0.15, 
      size.height * 0.15
    );
    
    canvas.drawRect(pocketRect2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BackpackIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF5D7052)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    final fillPaint = Paint()
      ..color = Color(0xFFFFE082)
      ..style = PaintingStyle.fill;
    
    // Draw backpack body
    final bodyPath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.2)
      ..lineTo(size.width * 0.25, size.height * 0.8)
      ..lineTo(size.width * 0.75, size.height * 0.8)
      ..lineTo(size.width * 0.7, size.height * 0.2)
      ..close();
    
    canvas.drawPath(bodyPath, fillPaint);
    canvas.drawPath(bodyPath, paint);
    
    // Draw front pocket
    final pocketPath = Path()
      ..moveTo(size.width * 0.35, size.height * 0.45)
      ..lineTo(size.width * 0.33, size.height * 0.7)
      ..lineTo(size.width * 0.67, size.height * 0.7)
      ..lineTo(size.width * 0.65, size.height * 0.45)
      ..close();
    
    canvas.drawPath(pocketPath, paint);
    
    // Draw straps
    canvas.drawLine(
      Offset(size.width * 0.35, size.height * 0.3),
      Offset(size.width * 0.25, size.height * 0.5),
      paint
    );
    
    canvas.drawLine(
      Offset(size.width * 0.65, size.height * 0.3),
      Offset(size.width * 0.75, size.height * 0.5),
      paint
    );
    
    // Draw top handle
    final handlePath = Path()
      ..moveTo(size.width * 0.4, size.height * 0.2)
      ..quadraticBezierTo(
        size.width * 0.5, size.height * 0.1, 
        size.width * 0.6, size.height * 0.2
      );
    
    canvas.drawPath(handlePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FacilitiesIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF5D7052)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    final fillPaint = Paint()
      ..color = Color(0xFFFFE082)
      ..style = PaintingStyle.fill;
    
    // Draw table
    canvas.drawLine(
      Offset(size.width * 0.1, size.height * 0.4),
      Offset(size.width * 0.9, size.height * 0.4),
      paint
    );
    
    // Draw table legs
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.4),
      Offset(size.width * 0.2, size.height * 0.6),
      paint
    );
    
    canvas.drawLine(
      Offset(size.width * 0.8, size.height * 0.4),
      Offset(size.width * 0.8, size.height * 0.6),
      paint
    );
    
    // Draw X support
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.45),
      Offset(size.width * 0.8, size.height * 0.6),
      paint
    );
    
    canvas.drawLine(
      Offset(size.width * 0.8, size.height * 0.45),
      Offset(size.width * 0.2, size.height * 0.6),
      paint
    );
    
    // Draw water bottle
    final bottleRect = Rect.fromLTWH(
      size.width * 0.75, 
      size.height * 0.5, 
      size.width * 0.15, 
      size.height * 0.3
    );
    
    canvas.drawRect(bottleRect, fillPaint);
    canvas.drawRect(bottleRect, paint);
    
    // Draw bottle cap
    final capRect = Rect.fromLTWH(
      size.width * 0.78, 
      size.height * 0.45, 
      size.width * 0.09, 
      size.height * 0.05
    );
    
    canvas.drawRect(capRect, fillPaint);
    canvas.drawRect(capRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}