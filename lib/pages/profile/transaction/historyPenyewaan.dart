/// File        : modern_transaction_page.dart
/// Dibuat oleh  : Tim Provis
/// Tanggal      : 16-06-2025
/// Deskripsi    : Halaman ini menampilkan riwayat transaksi penyewaan pengguna.
/// Setiap transaksi mencakup informasi seperti ID, tanggal, status, dan daftar item yang disewa.
/// Pengguna juga dapat melakukan tindakan seperti melihat detail review atau melanjutkan pembayaran
/// berdasarkan status transaksi.
/// Dependencies :
/// - flutter/material.dart: Pustaka dasar Flutter untuk membangun UI.
/// - historyPenyewaanDetailBarang.dart: Mengimpor halaman detail barang yang direview (TransactionDetailPage).
/// - ../../shopping/after_sales/step1.dart: Mengimpor halaman langkah pertama setelah penjualan (pembayaran/pengambilan).
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../../../providers/transaction_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../models/models.dart';
import 'historyPenyewaanDetailBarang.dart';
import '../../shopping/after_sales/step1.dart';
import '../../shopping/payment_data/checkout2.dart';

/// Widget [ModernTransactionPage]
///
/// Deskripsi:
/// - Halaman ini berfungsi sebagai tampilan riwayat transaksi penyewaan untuk pengguna.
/// - Merupakan bagian dari fitur riwayat atau profil pengguna yang menunjukkan semua transaksi mereka.
/// - Ini adalah StatefulWidget karena data transaksi akan dimuat secara dinamis dari API.
class ModernTransactionPage extends StatefulWidget {
  const ModernTransactionPage({super.key});

  @override
  State<ModernTransactionPage> createState() => _ModernTransactionPageState();
}

class _ModernTransactionPageState extends State<ModernTransactionPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadTransactions();
    _startPeriodicRefresh(); // Start periodic refresh for ongoing transactions
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadTransactions() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);

    if (authProvider.isAuthenticated && authProvider.user != null) {
      transactionProvider.loadTransactions(authProvider.user!.userId);
    }
  }

  // Add auto-refresh for ongoing transactions
  void _startPeriodicRefresh() {
    // Refresh transactions every 30 seconds if there are ongoing transactions
    Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final transactionProvider =
            Provider.of<TransactionProvider>(context, listen: false);

        if (authProvider.isAuthenticated &&
            authProvider.user != null &&
            transactionProvider.ongoingTransactions.isNotEmpty) {
          transactionProvider.loadTransactions(authProvider.user!.userId);
        } else {
          timer.cancel(); // Stop refresh if no ongoing transactions
        }
      } else {
        timer.cancel(); // Stop refresh if widget is not mounted
      }
    });
  }

  /* Fungsi ini mengembalikan warna yang sesuai berdasarkan status transaksi.
   *
   * Parameter:
   * - [status]: String yang menunjukkan status transaksi (misalnya 'Belum Bayar', 'Sudah Dikembalikan', 'Selesai').
   *
   * Return: Objek [Color] yang merepresentasikan warna status.
   */
  Color getStatusColor(String status) {
    switch (status) {
      case 'Belum Dibayar':
        return Colors.red; // Red for unpaid
      case 'Belum Diambil':
        return Colors.orange; // Orange for not picked up
      case 'Belum Dikembalikan':
        return Colors.blue; // Blue for not returned
      case 'Sudah Dikembalikan':
        return const Color(0xFF4CAF50); // Green for returned/completed
      default:
        return Colors.grey; // Grey for unknown status
    }
  }

  /* Fungsi ini membangun widget chip kecil yang digunakan sebagai filter.
   *
   * Parameter:
   * - [label]: Teks yang akan ditampilkan pada chip.
   *
   * Return: Widget [Chip] dengan teks dan gaya tertentu.
   */
  Widget buildChip(String label) {
    return Chip(
      /** Widget [Text]
       * * Deskripsi:
       * - Label teks pada chip filter, misalnya "Semua Status".
       * - Gaya teks dengan ukuran 12.
       */
      label: Text(label, style: const TextStyle(fontSize: 12)),
      backgroundColor: Colors.grey[200], // Warna latar belakang chip.
      padding: const EdgeInsets.symmetric(
          horizontal: 10), // Padding horizontal chip.
      shape: const StadiumBorder(), // Bentuk chip seperti stadion.
    );
  }

  /* Fungsi ini membangun seluruh struktur UI dari halaman riwayat transaksi.
   *
   * Parameter:
   * - [context]: BuildContext dari widget.
   *
   * Return: Sebuah widget [Scaffold] yang berisi AppBar dan body halaman.
   */
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Transaction History',
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
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF5D6D3E),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF5D6D3E),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Ongoing'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: Consumer2<TransactionProvider, AuthProvider>(
        builder: (context, transactionProvider, authProvider, child) {
          if (transactionProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (transactionProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${transactionProvider.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadTransactions,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!authProvider.isAuthenticated) {
            return const Center(
              child: Text('Please login to view transactions'),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildTransactionList(transactionProvider.transactions),
              _buildTransactionList(transactionProvider.ongoingTransactions),
              _buildTransactionList(transactionProvider.completedTransactions),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTransactionList(List<UserTransaction> transactions) {
    if (transactions.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No transactions found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
        onRefresh: () async => _loadTransactions(),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return _buildTransactionCard(transaction, context);
          },
        ));
  }

  Widget _buildTransactionCard(
      UserTransaction transaction, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaction #${transaction.transaksiId}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: getStatusColor(transaction.statusTransaksi)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  transaction.statusTransaksi,
                  style: TextStyle(
                    color: getStatusColor(transaction.statusTransaksi),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                _formatDate(transaction.waktuPembuatan),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.shopping_bag, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                '${transaction.jumlahBarang} item${transaction.jumlahBarang > 1 ? 's' : ''}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Builder(
                  builder: (ctx) => OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        ctx,
                        MaterialPageRoute(
                          builder: (context) => TransactionDetailPage(
                            transactionId: transaction.transaksiId,
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF5D6D3E)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(color: Color(0xFF5D6D3E)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () =>
                      _handleTransactionAction(transaction, context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5D6D3E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    _getActionButtonText(transaction.statusTransaksi),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateString; // Return original string if parsing fails
    }
  }

  String _getActionButtonText(String status) {
    switch (status) {
      case 'Belum Dibayar':
        return 'Pay Now';
      case 'Belum Diambil':
        return 'Track Order';
      case 'Belum Dikembalikan':
        return 'Track Return';
      case 'Sudah Dikembalikan':
        return 'Leave Review';
      default:
        return 'View Details';
    }
  }

  void _handleTransactionAction(
      UserTransaction transaction, BuildContext context) {
    switch (transaction.statusTransaksi) {
      case 'Belum Dibayar':
        // Navigate to payment page using existing checkout system
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Checkout2(),
          ),
        );
        break;
      case 'Belum Diambil':
      case 'Belum Dikembalikan':
        // Navigate to tracking page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Step1Page()),
        );
        break;
      case 'Sudah Dikembalikan':
        // Navigate to review page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailPage(
              transactionId: transaction.transaksiId,
            ),
          ),
        );
        break;
      default:
        // Default action - show transaction details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailPage(
              transactionId: transaction.transaksiId,
            ),
          ),
        );
    }
  }
}
