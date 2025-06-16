/**
 * File         : transaction_detail_page.dart
 * Dibuat oleh  : Tim Provis
 * Tanggal      : 16-06-2025
 * Deskripsi    : Menampilkan daftar detail barang dalam satu transaksi,
 *                beserta tombol untuk review barang jika belum direview.
 */

import 'package:flutter/material.dart';
import 'reviewItem.dart';

/// Halaman untuk menampilkan daftar detail barang dalam satu transaksi
class TransactionDetailPage extends StatelessWidget {
  TransactionDetailPage({super.key});

  /// Data transaksi dummy
  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Tenda Camping Eiger',
      'date': '4 Mei 2025',
      'image': 'https://via.placeholder.com/300x150.png?text=Tenda+Camping+Eiger',
      'status': 'Belum direview',
    },
    {
      'title': 'Carrier 40L Eiger',
      'date': '28 Apr 2025',
      'image': 'https://via.placeholder.com/300x150.png?text=Carrier+40L+Eiger',
      'status': 'Belum direview',
    },
    {
      'title': 'Sepatu Hiking Merrell',
      'date': '13 Apr 2025',
      'image': 'https://via.placeholder.com/300x150.png?text=Sepatu+Hiking+Merrell',
      'status': 'Selesai',
    },
  ];

  /// Warna status
  Color getStatusColor(String status) {
    switch (status) {
      case 'Selesai':
        return Colors.blue;
      case 'Belum direview':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  /// Widget chip filter (placeholder untuk pengembangan)
  Widget buildChip(String label) {
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      backgroundColor: Colors.grey[200],
      padding: const EdgeInsets.symmetric(horizontal: 10),
      shape: const StadiumBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Cari barang dalam transaksi',
            hintStyle: TextStyle(color: Colors.grey[600]),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: const Icon(Icons.filter_list),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Baris filter horizontal
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildChip('Semua Status'),
                const SizedBox(width: 8),
                buildChip('Nama Produk'),
                const SizedBox(width: 8),
                buildChip('Tanggal'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Daftar barang transaksi
          ...transactions
              .map((item) => buildTransactionCard(item, context))
              .toList(),
        ],
      ),
    );
  }

  /// Widget kartu transaksi individual
  Widget buildTransactionCard(Map<String, dynamic> item, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar produk
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item['image'],
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const SizedBox(
                height: 150,
                child: Center(child: Text('Gagal memuat gambar')),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Judul dan tanggal
          Text(item['title'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text('Dipesan pada ${item['date']}',
              style: TextStyle(color: Colors.grey[600], fontSize: 13)),

          const SizedBox(height: 12),

          // Tombol aksi sesuai status
          if (item['status'] == 'Belum direview')
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman review
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductReviewPage(
                        productImage: item['image'],
                        productName: item['title'],
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Review Barang"),
              ),
            ),
          if (item['status'] == 'Selesai')
            Align(
              alignment: Alignment.centerRight,
              child: Chip(
                label: const Text("Sudah Direview"),
                backgroundColor: Colors.green[100],
                labelStyle: const TextStyle(color: Colors.green),
              ),
            ),
        ],
      ),
    );
  }
}
