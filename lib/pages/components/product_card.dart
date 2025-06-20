/// File         : product_card.dart
/// Dibuat oleh  : Izzuddin Azzam
/// Tanggal      : 19-06-2025
/// Deskripsi    : Komponen kartu produk yang konsisten untuk digunakan di seluruh aplikasi
/// Dependencies : flutter/material.dart, provider, intl
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../detail_items/detailItem.dart';
import '../../providers/auth_provider.dart';
import '../../providers/wishlist_provider.dart';
import '../../models/models.dart';

/// Widget ProductCard
/// * Deskripsi:
/// - Komponen kartu produk yang dapat digunakan secara konsisten di berbagai halaman
/// - Menampilkan gambar, nama, harga, rating, dan tombol wishlist
/// - Dapat dikonfigurasi untuk berbagai tampilan (dengan/tanpa tombol wishlist)
class ProductCard extends StatelessWidget {
  final Barang barang;
  final bool showWishlistButton;
  final VoidCallback? onWishlistToggle;

  const ProductCard({
    super.key,
    required this.barang,
    this.showWishlistButton = true,
    this.onWishlistToggle,
  });
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailItem(barangId: barang.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [            // Bagian gambar barang
            Expanded(
              flex: 5, // Increased from 3 to 5 for better proportion
              child: Stack(
                children: [
                  // Gambar produk
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: barang.foto != null
                          ? Image.network(
                              barang.foto!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildPlaceholderImage();
                              },
                            )
                          : _buildPlaceholderImage(),
                    ),
                  ),

                  // Tombol wishlist jika diaktifkan
                  if (showWishlistButton)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Consumer<WishlistProvider>(
                        builder: (context, wishlistProvider, child) {
                          final isInWishlist = wishlistProvider.wishlistItems
                              .any((item) => item.id == barang.id);

                          return GestureDetector(
                            onTap: () async {
                              if (authProvider.isAuthenticated) {
                                if (isInWishlist) {
                                  await wishlistProvider.removeFromWishlist(
                                      authProvider.user!.userId, barang.id);
                                } else {
                                  await wishlistProvider.addToWishlist(
                                      authProvider.user!.userId, barang.id);
                                }

                                // Panggil callback jika ada
                                if (onWishlistToggle != null) {
                                  onWishlistToggle!();
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.9),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                isInWishlist
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isInWishlist
                                    ? Colors.red
                                    : Colors.grey[600],
                                size: 18,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),            // Bagian informasi produk
            Expanded(
              flex: 3, // Increased from 2 to 3 for better text space
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [                    // Nama barang dengan container yang membatasi lebar
                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(minHeight: 40),
                      child: Text(
                        barang.namaBarang,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 2),

                    // Harga per hari
                    Text(
                      'Rp ${NumberFormat('#,###', 'id_ID').format(barang.hargaPerhari)}/hari',
                      style: const TextStyle(
                        color: Color(0xFFA0B25E),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),

                    // Rating dan jumlah review
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          barang.meanReview.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
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

  /// Fungsi helper untuk membuat placeholder gambar
  Widget _buildPlaceholderImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Icon(
        Icons.image,
        color: Colors.grey[400],
        size: 40,
      ),
    );
  }
}
