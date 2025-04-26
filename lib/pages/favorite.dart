import 'package:flutter/material.dart';
import '../components/navbar.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Item> favoriteItems = [
    Item(
      name: 'Kompor Portable',
      type: 'PERALATAN',
      price: 5.0,
      quantity: 1,
      imageUrl: 'https://via.placeholder.com/100',
    ),
    Item(
      name: 'Sleeping Bag',
      type: 'PERALATAN',
      price: 3.5,
      quantity: 1,
      imageUrl: 'https://via.placeholder.com/100',
    ),
    Item(
      name: 'Matras Camping',
      type: 'PERALATAN',
      price: 2.0,
      quantity: 1,
      imageUrl: 'https://via.placeholder.com/100',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Favorite Items',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final item = favoriteItems[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Image
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(item.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Item details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.type,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Favorite Icon
                      IconButton(
                        onPressed: () {
                          setState(() {
                            favoriteItems.removeAt(index);
                          });
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavBar(
        context: context,
        currentIndex: 3, // sesuai navbar tombol "Love"
      ),
    );
  }
}

// Item class bisa pake yang sudah kamu buat
class Item {
  final String name;
  final String type;
  final double price;
  int quantity;
  final String imageUrl;

  Item({
    required this.name,
    required this.type,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}
