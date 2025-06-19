/// File        : transaction_detail_page.dart
/// Dibuat oleh  : Tim Provis
/// Tanggal      : 16-06-2025
/// Deskripsi    : Halaman ini menampilkan daftar detail barang yang termasuk dalam satu transaksi.
/// Dilengkapi dengan informasi produk, tanggal transaksi, dan status review.
/// Pengguna dapat memberikan review untuk barang yang belum direview melalui tombol yang tersedia.
/// Dependencies :
/// - flutter/material.dart: Pustaka dasar Flutter untuk membangun UI.
/// - reviewItem.dart: Mengimpor halaman ProductReviewPage untuk navigasi ke halaman review produk.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../providers/transaction_detail_provider.dart';
import '../../../models/models.dart';
import 'reviewItem.dart'; // Import halaman ProductReviewPage

/// Widget [TransactionDetailPage]
///
/// Deskripsi:
/// - Halaman ini berfungsi untuk menampilkan detail item-item yang ada dalam sebuah transaksi.
/// - Ini adalah bagian dari alur riwayat transaksi pengguna, memungkinkan mereka melihat status review.
/// - Merupakan StatefulWidget karena data transaksi akan dimuat secara dinamis dari API.
class TransactionDetailPage extends StatefulWidget {
  final int transactionId;

  const TransactionDetailPage({
    super.key,
    required this.transactionId,
  });

  @override
  State<TransactionDetailPage> createState() => TransactionDetailPageState();
}

class TransactionDetailPageState extends State<TransactionDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTransactionDetail();
    });
  }

  void _loadTransactionDetail() {
    final provider =
        Provider.of<TransactionDetailProvider>(context, listen: false);
    provider.loadTransactionDetail(widget.transactionId);
  }

  /* Fungsi ini mengembalikan warna yang sesuai berdasarkan status review barang.
   *
   * Parameter:
   * - [status]: String yang menunjukkan status review barang ('Selesai', 'Belum direview').
   *
   * Return: Objek [Color] yang merepresentasikan warna status.
   */
  Color getStatusColor(String status) {
    switch (status) {
      case 'Selesai':
        return Colors.blue; // Warna biru untuk status 'Selesai'.
      case 'Belum direview':
        return Colors.orange; // Warna oranye untuk status 'Belum direview'.
      default:
        return Colors.grey; // Warna abu-abu untuk status lainnya (default).
    }
  }

  /* Fungsi ini membangun widget chip kecil.
   * Ini adalah placeholder untuk filter tambahan yang mungkin akan dikembangkan di masa depan.
   *
   * Parameter:
   * - [label]: Teks yang akan ditampilkan pada chip.
   *
   * Return: Widget [Chip] dengan teks dan gaya tertentu.
   */
  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '-';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  String _formatCurrency(int amount) {
    return 'Rp ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Belum Dibayar':
        return Colors.red;
      case 'Belum Diambil':
        return Colors.orange;
      case 'Belum Dikembalikan':
        return Colors.blue;
      case 'Sudah Dikembalikan':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Rincian Transaksi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<TransactionDetailProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text('Error: ${provider.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadTransactionDetail,
                    child: const Text('Ulangi'),
                  ),
                ],
              ),
            );
          }

          if (provider.transactionDetail == null) {
            return const Center(
              child: Text('Tidak ada detail transaksi ditemukan.'),
            );
          }

          final detail = provider.transactionDetail!;
          final transaction = detail.transaction;

          return RefreshIndicator(
            onRefresh: () async => _loadTransactionDetail(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Transaction Info Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Transaksi #${transaction.transaksiId}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(
                                          transaction.statusTransaksi)
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  transaction.statusTransaksi,
                                  style: TextStyle(
                                    color: _getStatusColor(
                                        transaction.statusTransaksi),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow('Pesanan Dibuat',
                              _formatDate(transaction.waktuPembuatan)),
                          _buildInfoRow('Tanggal Pengambilan',
                              _formatDate(transaction.tanggalPengambilan)),
                          _buildInfoRow('Tanggal Pengembalian',
                              _formatDate(transaction.tanggalPengembalian)),
                          if (transaction.tanggalPengembalianAktual != null)
                            _buildInfoRow(
                                'Tanggal Pengembalian Aktual',
                                _formatDate(
                                    transaction.tanggalPengembalianAktual)),
                          const Divider(height: 24),
                          _buildInfoRow('Biaya Harian',
                              _formatCurrency(transaction.totalBiayaHari)),
                          _buildInfoRow('Deposit',
                              _formatCurrency(transaction.totalBiayaDeposito)),
                          _buildInfoRow('Total Biaya',
                              _formatCurrency(transaction.totalBiaya),
                              isTotal: true),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Items Section
                  const Text(
                    'Barang Disewa',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: detail.items.length,
                    itemBuilder: (context, index) {
                      final item = detail.items[index];
                      return _buildItemCard(item);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(TransactionItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Item Image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: item.foto != null && item.foto!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.foto!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          print('Image load error: $error'); // Debug print
                          print('Image URL: ${item.foto}'); // Debug print
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey[500],
                              size: 30,
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.image,
                        color: Colors.grey[500],
                        size: 30,
                      ),
                    ),
            ),
            const SizedBox(width: 12),

            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.namaBarang,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_formatCurrency(item.hargaPerhari)}/day x ${item.kuantitas}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Subtotal: ${_formatCurrency(item.subtotal)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // Review Button
            if (!item.isReviewed)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductReviewPage(
                        productName: item.namaBarang,
                        productImage: item.foto ?? '',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5D6D3E),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Ulasan',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              )
            else
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Sudah Diulas',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
