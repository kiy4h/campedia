/// File         : favorite.dart
/// Dibuat oleh  : Izzuddin Azzam
/// Tanggal      : 16-06-2025
/// Deskripsi    : Halaman ini menampilkan daftar barang favorit pengguna dalam tampilan grid,
///                lengkap dengan fitur untuk menyukai/menghapus favorit dan filter tambahan.
/// Dependencies :
/// - flutter/material.dart
/// - provider
/// - intl
/// - detailItem.dart (navigasi ke halaman detail barang)
/// - navbar.dart (bottom navigation bar aplikasi)
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
import '../components/navbar.dart';
import '../components/product_card.dart';
import '../../providers/auth_provider.dart';
import '../../providers/wishlist_provider.dart';

/// Widget FavoritePage
class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

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

/// Widget ItemCategory
class ItemCategory extends StatefulWidget {
  const ItemCategory({super.key});

  @override
  ItemCategoryState createState() => ItemCategoryState();
}

class ItemCategoryState extends State<ItemCategory> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadWishlist();
    });
  }

  Future<void> _loadWishlist() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);

    if (authProvider.isAuthenticated) {
      await wishlistProvider.loadWishlist(authProvider.user!.userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WishlistProvider>(
        builder: (context, wishlistProvider, child) {
          return CustomScrollView(
            slivers: [
              // Header teks judul halaman
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Barang-Barang Favorit Kamu',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Tampilan grid daftar barang favorit atau pesan loading/error
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: _buildWishlistContent(wishlistProvider),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: buildBottomNavBar(context, currentIndex: 3),
    );
  }

  Widget _buildWishlistContent(WishlistProvider wishlistProvider) {
    if (wishlistProvider.isLoading) {
      return SliverToBoxAdapter(
        child: Container(
          height: 200,
          child: Center(
            child: CircularProgressIndicator(
              color: Color(0xFFA0B25E),
            ),
          ),
        ),
      );
    }

    if (wishlistProvider.error != null) {
      return SliverToBoxAdapter(
        child: Container(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                SizedBox(height: 16),
                Text(
                  'Error: ${wishlistProvider.error}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadWishlist,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFA0B25E),
                  ),
                  child: Text('Retry', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (wishlistProvider.wishlistItems.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          height: 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'Belum ada barang favorit',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tambahkan barang ke wishlist untuk melihatnya di sini',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ProductCard(
            barang: wishlistProvider.wishlistItems[index],
            onWishlistToggle: _loadWishlist,
          );
        },
        childCount: wishlistProvider.wishlistItems.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
