import 'package:flutter/material.dart';
import '../progress/reviewItem.dart';

class TransactionDetailPage extends StatelessWidget {
  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Tenda Camping Eiger',
      'date': '4 Mei 2025',
      'image': '../../images/assets_ItemDetails/tenda_bg6.png',
      'status': 'Belum direview'
    },
    {
      'title': 'Carrier 40L Eiger',
      'date': '28 Apr 2025',
      'image': '../../images/assets_ItemDetails/jaket1.png',
      'status': 'Belum direview'
    },
    {
      'title': 'Sepatu Hiking Merrell',
      'date': '13 Apr 2025',
      'image': '../../images/assets_ItemDetails/tas2.png',
      'status': 'Selesai'
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'Berhasil':
        return const Color(0xFF4CAF50);
      case 'Selesai':
        return Colors.blue;
      case 'Diproses':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Icon getTransactionIcon(String type) {
    switch (type) {
      case 'BPJS':
        return const Icon(Icons.local_hospital, size: 20);
      case 'Pulsa':
        return const Icon(Icons.phone_android, size: 20);
      case 'Belanja':
        return const Icon(Icons.shopping_bag, size: 20);
      default:
        return const Icon(Icons.receipt_long, size: 20);
    }
  }

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
            hintText: 'Cari transaksi',
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
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildChip('Semua Status'),
                const SizedBox(width: 8),
                buildChip('Semua Produk'),
                const SizedBox(width: 8),
                buildChip('Semua Tanggal'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...transactions
              .map((item) => buildTransactionCard(item, context))
              .toList(),
        ],
      ),
    );
  }

  Widget buildTransactionCard(Map<String, dynamic> item, context) {
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
          // Gambar barang (gunakan placeholder jika tidak ada)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item['image'] ??
                  'https://via.placeholder.com/300x150.png?text=Gambar+Barang',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          // Nama Barang
          Text(item['title'],
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          // Tanggal Pemesanan
          Text('Dipesan pada ${item['date']}',
              style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          const SizedBox(height: 12),

          // Tombol sesuai status
          if (item['status'] == 'Belum direview')
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman review
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductReviewPage(
                              productImage: item['image'],
                              productName: item['title'],
                            )),
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
        ],
      ),
    );
  }
}
