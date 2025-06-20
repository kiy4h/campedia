/// File         : notification.dart
/// Dibuat oleh  : Izzuddin Azzam, Al Ghifari
/// Tanggal      : 16-06-2025
/// Deskripsi    : File ini berisi halaman yang menampilkan berbagai notifikasi sistem seperti promo,
/// ketersediaan barang, dan informasi pembayaran denda.
/// Dependencies :
/// - checkout2.dart: digunakan untuk berpindah ke halaman pembayaran denda.
/// - notification_provider.dart: untuk mengelola state notifikasi
/// - auth_provider.dart: untuk mendapatkan user_id
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas3provis/pages/shopping/payment_data/checkout2.dart';
import 'package:tugas3provis/providers/notification_provider.dart';
import 'package:tugas3provis/providers/auth_provider.dart';
import 'package:tugas3provis/models/models.dart';

/// Widget NotificationPage
/// * Deskripsi:
/// - Menampilkan daftar notifikasi dalam bentuk kartu yang informatif.
/// - Setiap kartu notifikasi berisi ikon, judul, deskripsi, dan waktu.
/// - Menggunakan data dinamis dari API backend.
/// - Merupakan StatefulWidget untuk mengelola state loading dan refresh notifikasi.
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  late NotificationProvider _notificationProvider;
  late AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadNotifications();
    });
  }

  void _loadNotifications() {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);

    if (_authProvider.isAuthenticated && _authProvider.user != null) {
      _notificationProvider.fetchNotifications(_authProvider.user!.userId);
    }
  }

  Future<void> _refreshNotifications() async {
    if (_authProvider.isAuthenticated && _authProvider.user != null) {
      await _notificationProvider
          .refreshNotifications(_authProvider.user!.userId);
    }
  }

  Widget _buildNotificationIcon(NotificationItem notification) {
    IconData iconData;
    Color iconColor;

    switch (notification.jenis) {
      case 'denda':
        iconData = Icons.money_off;
        iconColor = Colors.red;
        break;
      case 'transaksi':
        iconData = Icons.receipt_long;
        iconColor = Colors.blue;
        break;
      case 'pengumuman':
        iconData = Icons.campaign;
        iconColor = Colors.orange;
        break;
      default:
        iconData = Icons.notifications_none;
        iconColor = Colors.green;
    }

    return Icon(
      iconData,
      size: 28,
      color: iconColor,
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    return GestureDetector(
      // onTap: () {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text("Kamu membuka: ${notification.judul}")),
      //   );
      // },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNotificationIcon(notification),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.judul,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notification.deskripsi,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notification.getFormattedTime(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ), // Show penalty payment button if it's a penalty notification with actual denda data
            if (notification.isPenalty() && notification.detailDenda != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: notification.detailDenda?.statusDenda ==
                          'Sudah Dibayar'
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.1),
                            border: Border.all(
                              color: Colors.green.withValues(alpha: 0.3),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 14,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "Denda Telah Dibayar",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Checkout2(
                                  isDendaPayment: true,
                                  dendaAmount:
                                      notification.detailDenda?.jumlahDenda ??
                                          0,
                                  transaksiId:
                                      notification.detailDenda?.transaksiId ??
                                          0,
                                ),
                              ),
                            );
                            // Auto-reload notifications when returning from payment page
                            _refreshNotifications();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                              "Bayar Denda (Rp${notification.detailDenda?.jumlahDenda.toString() ?? '0'})"),
                        ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Gagal memuat notifikasi',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadNotifications,
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.notifications_off_outlined,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum ada notifikasi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Notifikasi akan muncul di sini ketika ada update terbaru',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  /* Fungsi ini membangun seluruh UI untuk halaman notifikasi.
   * * Parameter:
   * - context: Digunakan untuk mengakses tema, navigasi, dan menampilkan SnackBar.
   * * Return: Menghasilkan widget Scaffold lengkap dengan AppBar dan body yang berisi
   *          loading state, error state, empty state, atau ListView notifikasi.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifikasi",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshNotifications,
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      body: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
          // Show loading state
          if (notificationProvider.isLoading) {
            return _buildLoadingState();
          }

          // Show error state
          if (notificationProvider.error != null) {
            return _buildErrorState(notificationProvider.error!);
          }

          // Show empty state
          if (notificationProvider.notifications.isEmpty) {
            return _buildEmptyState();
          }

          // Show notifications list
          return RefreshIndicator(
            onRefresh: _refreshNotifications,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notificationProvider.notifications.length,
              itemBuilder: (context, index) {
                final notification = notificationProvider.notifications[index];
                return _buildNotificationCard(notification);
              },
            ),
          );
        },
      ),
    );
  }
}
