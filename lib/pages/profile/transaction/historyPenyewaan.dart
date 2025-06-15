import 'package:flutter/material.dart';
import 'historyPenyewaanDetailBarang.dart'; // Halaman detail transaksi
import '../../shopping/after_sales/step1.dart';
import 'historyPenyewaanDetailBarang.dart'; // Halaman review

class ModernTransactionPage extends StatelessWidget {
  final List<Map<String, dynamic>> transactions = [
    {
      'id': 'TX001',
      'date': '4 Mei 2025',
      'status': 'Belum Bayar',
      'items': [
        {
          'title': 'Tenda Camping Eiger',
          'image': 'assets/images/assets_ItemDetails/tenda_bg6.png',
        },
        {
          'title': 'Sleeping Bag',
          'image': 'assets/images/assets_ItemDetails/jaket1.png',
        }
      ]
    },
    {
      'id': 'TX002',
      'date': '28 Apr 2025',
      'status': 'Sudah Dikembalikan',
      'items': [
        {
          'title': 'Carrier 40L Eiger',
          'image': 'assets/images/assets_ItemDetails/jaket1.png',
        },
      ]
    },
    {
      'id': 'TX003',
      'date': '13 Apr 2025',
      'status': 'Selesai',
      'items': [
        {
          'title': 'Sepatu Hiking Merrell',
          'image': 'assets/images/assets_ItemDetails/tas2.png',
        },
      ]
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
      case 'Belum Bayar':
        return Colors.red;
      case 'Sudah Dikembalikan':
        return Colors.green;
      default:
        return Colors.grey;
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

  Widget buildTransactionCard(Map<String, dynamic> item, BuildContext context) {
    return InkWell(
      child: Container(
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
            Text('ID: ${item['id']}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Tanggal: ${item['date']}'),
            const SizedBox(height: 4),
            Text('Status: ${item['status']}',
                style: TextStyle(color: getStatusColor(item['status']))),
            const SizedBox(height: 4),
            Text('Jumlah Barang: ${item['items'].length}'),
            const SizedBox(height: 8),
            // Tombol berdasarkan status
            if (item['status'] == 'Sudah Dikembalikan')
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman review
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          TransactionDetailPage(), // Ganti dengan halaman review
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Review Sekarang'),
              )
            else if (item['status'] == 'Belum Bayar')
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Step1Page(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Ambil Sekarang'),
              ),
          ],
        ),
      ),
    );
  }
}
