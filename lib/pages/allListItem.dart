import 'package:flutter/material.dart';
import 'detailItem.dart';
import '../components/navbar.dart';

void main() {
  runApp(const AllItemList());
}

class AllItemList extends StatelessWidget {
  const AllItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFA0B25E),
        scaffoldBackgroundColor: const Color(0xFFF8F8F8),
      ),
      home: ItemCategory(),
    );
  }
}

class ItemCategory extends StatelessWidget {
  ItemCategory({Key? key}) : super(key: key);

  // Data barang
  final List<Map<String, dynamic>> trendingItems = [
    {"name": "Tenda Camping", "price": 300000, "image": "images/assets_ItemDetails/tenda_bg1.png", "rating": 4.5},
    {"name": "Kompor Portable", "price": 150000, "image": "images/assets_ItemDetails/tenda_bg2.png", "rating": 4.3},
    {"name": "Sepatu Gunung", "price": 250000, "image": "images/assets_ItemDetails/tenda_bg3.png", "rating": 4.7},
    {"name": "Tas Gunung", "price": 350000, "image": "images/assets_ItemDetails/tenda_bg4.png", "rating": 4.0},
    {"name": "Senter LED", "price": 120000, "image": "images/assets_ItemDetails/tenda_bg5.png", "rating": 4.8},
    {"name": "Jaket Gunung", "price": 400000, "image": "images/assets_ItemDetails/tenda_bg6.png", "rating": 4.2},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA0B25E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Tent Category',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '87 Items',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search here',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: trendingItems.length,
                itemBuilder: (context, index) {
                  return _buildTrendingItem(trendingItems[index], context);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavBar(
        context,
        currentIndex: 1,
      ),
    );
  }

  Widget _buildTrendingItem(Map<String, dynamic> item, BuildContext context) {
    bool isLiked = false; // Status favorit, misalnya bisa disesuaikan nanti

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DetailItem()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(item['image']),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 10,
              child: Icon(
                Icons.favorite,
                color: isLiked ? Colors.red : Colors.white,
                size: 28,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${item['price']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${item['rating']}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
