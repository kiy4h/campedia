import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas3provis/components/navbar.dart';
import 'package:tugas3provis/pages/notification.dart';

void main() {
  runApp(CampingApp());
}

class CampingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF2E7D32),
        scaffoldBackgroundColor: Color(0xFFF8F8F8),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: PurchaseHistoryPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PurchaseHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase History', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF2E7D32),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          children: [
            _buildRentalHistorySection(),
            SizedBox(height: 24),
            _buildPaymentHistorySection(),
            SizedBox(height: 24),
            _buildReturnStatusSection(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(
        context,
        currentIndex: 3, // Bisa disesuaikan jika riwayat ada di index ke-3
      ),
    );
  }

  Widget _buildRentalHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rental History',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        _buildHistoryRow('Tent:', 'Camping Tent X100'),
        SizedBox(height: 12),
        _buildHistoryRow('Sleeping Bag:', 'Super Comfort Sleeping Bag'),
        SizedBox(height: 12),
        _buildHistoryRow('Backpack:', 'Mountain Explorer Backpack'),
        SizedBox(height: 16),
        _buildHistoryRow('Total Rental:', '3 Items'),
      ],
    );
  }

  Widget _buildPaymentHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment History',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        _buildHistoryRow('Total Payment:', 'IDR 1,500,000'),
        SizedBox(height: 12),
        _buildHistoryRow('Payment Status:', 'Paid'),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            // Arahkan ke halaman detail pembayaran jika diperlukan
            // Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentDetailsPage()));
          },
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              'See Payment Details',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReturnStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Return Status',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        _buildHistoryRow('Tent:', 'Returned'),
        SizedBox(height: 12),
        _buildHistoryRow('Sleeping Bag:', 'Pending'),
        SizedBox(height: 12),
        _buildHistoryRow('Backpack:', 'Returned'),
      ],
    );
  }

  Widget _buildHistoryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
