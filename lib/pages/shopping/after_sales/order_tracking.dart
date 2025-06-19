/// File        : order_tracking.dart
/// Dibuat oleh  : Izzuddin Azzam, Zakiyah Hasanah (merged from step1.dart, step2.dart, step3.dart)
/// Tanggal      : 18-06-2025
/// Deskripsi    : Halaman pelacakan pesanan berdasarkan transaction ID,
/// menampilkan status real-time dari proses pengambilan hingga pengembalian barang.
/// Dependencies :
/// - flutter_map: ^ untuk menampilkan peta lokasi interaktif.
/// - latlong2: ^ untuk mengelola koordinat lintang dan bujur.
/// - dart:async untuk Timer pada countdown
library;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../beranda/home.dart'; // Import halaman Home untuk navigasi kembali setelah review selesai
import 'review.dart';
import '../../components/navbar.dart';

/// Enum untuk status pesanan
enum OrderStatus {
  pickup, // Step 1: Pengambilan barang
  borrowed, // Step 2: Barang sedang dipinjam (countdown)
  returned // Step 3: Barang telah dikembalikan
}

/// Widget [OrderTrackingPage]
///
/// Deskripsi:
/// - Widget utama untuk halaman pelacakan pesanan berdasarkan transaction ID.
/// - Menampilkan status real-time dari proses pengambilan hingga pengembalian barang.
/// - Menggunakan Stateful karena ada perubahan status dan countdown yang dinamis.
class OrderTrackingPage extends StatefulWidget {
  final int? transactionId;
  final OrderStatus? currentStatus;
  final String? statusTransaksi; // Database status

  const OrderTrackingPage({
    super.key,
    required this.transactionId,
    this.currentStatus,
    this.statusTransaksi,
  });

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  late OrderStatus _currentStatus;
  late DateTime endTime;
  Timer? _timer;
  bool _isUpdating = false; // Flag untuk loading state
  bool _hasUpdates = false; // Flag to track if any updates were made

  // API configuration
  static const String baseUrl = 'http://localhost:8000';

  // Variabel untuk countdown timer
  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  // Helper function to map database status to OrderStatus
  OrderStatus _getOrderStatusFromDatabaseStatus(String? dbStatus) {
    switch (dbStatus) {
      case 'Belum Diambil':
        return OrderStatus.pickup;
      case 'Belum Dikembalikan':
        return OrderStatus.borrowed;
      case 'Sudah Dikembalikan':
        return OrderStatus.returned;
      default:
        return OrderStatus.pickup; // Default fallback
    }
  }

  @override
  void initState() {
    super.initState();

    // Determine initial status from either currentStatus parameter or database status
    if (widget.currentStatus != null) {
      _currentStatus = widget.currentStatus!;
    } else if (widget.statusTransaksi != null) {
      _currentStatus =
          _getOrderStatusFromDatabaseStatus(widget.statusTransaksi);
    } else {
      _currentStatus = OrderStatus.pickup; // Default fallback
    }

    // Hitung waktu akhir untuk countdown (2 hari dari sekarang)
    endTime = DateTime.now().add(const Duration(days: 2));

    // Setup timer jika status borrowed
    if (_currentStatus == OrderStatus.borrowed) {
      _setupCountdownTimer();
    }
  }

  void _setupCountdownTimer() {
    _calculateTimeLeft();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _calculateTimeLeft();
    });
  }

  void _calculateTimeLeft() {
    final now = DateTime.now();
    final difference = endTime.difference(now);

    if (difference.isNegative) {
      setState(() {
        days = 0;
        hours = 0;
        minutes = 0;
        seconds = 0;
      });
    } else {
      setState(() {
        days = difference.inDays;
        hours = difference.inHours.remainder(24);
        minutes = difference.inMinutes.remainder(60);
        seconds = difference.inSeconds.remainder(60);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Function to update transaction status via API
  Future<bool> _updateTransactionStatus(String newStatus) async {
    setState(() {
      _isUpdating = true;
    });

    // DEBUG: Log transaksi_id and newStatus
    debugPrint('DEBUG: Updating transaksi_id: \\${widget.transactionId}, newStatus: \\${newStatus}');

    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/api/update_transaction_status'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'transaksi_id': widget.transactionId,
          'status_transaksi': newStatus,
        }),
      );
      if (response.statusCode == 200) {
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Status berhasil diupdate: $newStatus'),
              backgroundColor: Colors.green,
            ),
          );
        }
        return true;
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['detail'] ?? 'Failed to update status');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: \\${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return false;
    } finally {
      setState(() {
        _isUpdating = false;
      });
    }
  }

  void _nextStep() async {
    String newStatus;
    OrderStatus nextStatus;

    switch (_currentStatus) {
      case OrderStatus.pickup:
        newStatus = 'Belum Dikembalikan'; // Item has been picked up
        nextStatus = OrderStatus.borrowed;
        break;
      case OrderStatus.borrowed:
        newStatus = 'Sudah Dikembalikan'; // Item has been returned
        nextStatus = OrderStatus.returned;
        break;
      case OrderStatus.returned:
        // Navigate to review page without API call
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => CampingApp()),
          (route) => false, // Menghapus semua rute sebelumnya
        );
        return;
    } // Call API to update status
    bool success = await _updateTransactionStatus(newStatus);

    if (success) {
      setState(() {
        _currentStatus = nextStatus;
        _hasUpdates = true; // Mark that updates were made
        if (_currentStatus == OrderStatus.borrowed) {
          _setupCountdownTimer();
        } else if (_currentStatus == OrderStatus.returned) {
          _timer?.cancel();
        }
      });
    }
  }

  String _getButtonText() {
    switch (_currentStatus) {
      case OrderStatus.pickup:
        return 'SIMULASIKAN AMBIL BARANG';
      case OrderStatus.borrowed:
        return 'SIMULASIKAN KEMBALIKAN BARANG';
      case OrderStatus.returned:
        return 'KEMBALI KE HOME';
    }
  }

  @override
  Widget build(BuildContext context) {
    final LatLng jakartaLocation = LatLng(-6.2088, 106.8456);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _hasUpdates);
        return false; // Prevent default back action since we're handling it manually
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Status Penyewaan',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: IconButton(
            icon: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF627D2C),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
            onPressed: () => Navigator.pop(context, _hasUpdates),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Transaction ID Display
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.receipt_long, color: Color(0xFF627D2C)),
                  const SizedBox(width: 8),
                  Text(
                    'Transaction ID: ${widget.transactionId}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Dynamic content based on current status
            if (_currentStatus == OrderStatus.pickup)
              _buildPickupContent(jakartaLocation),
            if (_currentStatus == OrderStatus.borrowed) _buildBorrowedContent(),
            if (_currentStatus == OrderStatus.returned) _buildReturnedContent(),

            // Stepper Progress
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  children: [
                    _buildStepperItem(
                      stepNumber: 1,
                      title: 'step 1',
                      description:
                          'Pengambilan barang di lokasi yang telah ditentukan.',
                      isCompleted: _currentStatus.index >= 0,
                      isActive: _currentStatus == OrderStatus.pickup,
                      showLine: true,
                    ),
                    _buildStepperItem(
                      stepNumber: 2,
                      title: 'step 2',
                      description:
                          'Barang sedang dipinjam. Jangan lupa kembalikan tepat waktu!',
                      isCompleted: _currentStatus.index >= 1,
                      isActive: _currentStatus == OrderStatus.borrowed,
                      showLine: true,
                    ),
                    _buildStepperItem(
                      stepNumber: 3,
                      title: 'step 3',
                      description:
                          'Kembalikan barang ke toko sesuai waktu. Setelah itu, beri ulasan untuk pengalaman sewa kamu.',
                      isCompleted: _currentStatus.index >= 2,
                      isActive: _currentStatus == OrderStatus.returned,
                      showLine: false,
                    ),
                  ],
                ),
              ),
            ), // Action Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed:
                    _isUpdating ? null : _nextStep, // Disable when updating
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF627D2C),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: _isUpdating
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Updating...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        _getButtonText(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ), // Bottom Navigation Bar
            
          ],
        ),
      ),
    );
  }

  Widget _buildPickupContent(LatLng jakartaLocation) {
    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FlutterMap(
          options: MapOptions(
            center: jakartaLocation,
            zoom: 12.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: jakartaLocation,
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBorrowedContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: [
          const Text(
            'Sisa Waktu Peminjaman',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimeBox(days.toString().padLeft(2, '0'), "HARI"),
              const SizedBox(width: 8),
              _buildTimeBox(hours.toString().padLeft(2, '0'), "JAM"),
              const SizedBox(width: 8),
              _buildTimeBox(minutes.toString().padLeft(2, '0'), "MENIT"),
              const SizedBox(width: 8),
              _buildTimeBox(seconds.toString().padLeft(2, '0'), "DETIK"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReturnedContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.green.shade100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 60,
              color: Colors.green,
            ),
            const SizedBox(height: 12),
            const Text(
              'Terima kasih! Barang telah dikembalikan.\nSilakan berikan ulasan untuk pengalaman sewa kamu.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepperItem({
    required int stepNumber,
    required String title,
    required String description,
    required bool isCompleted,
    required bool isActive,
    required bool showLine,
  }) {
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: Column(
              children: [
                Container(
                  width: isActive ? 36 : 20,
                  height: isActive ? 36 : 20,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? const Color(0xFF9BAE76)
                        : isActive
                            ? Colors.transparent
                            : Colors.grey[400],
                    border: isActive
                        ? Border.all(color: const Color(0xFF9BAE76), width: 3)
                        : null,
                    shape: BoxShape.circle,
                  ),
                  child: isCompleted && !isActive
                      ? const Icon(Icons.check, color: Colors.white, size: 12)
                      : null,
                ),
                if (showLine)
                  Expanded(
                    child: Container(
                      width: 3,
                      color: Colors.grey[300],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.black : Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isActive ? Colors.black87 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBox(String number, String label) {
    return Column(
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
