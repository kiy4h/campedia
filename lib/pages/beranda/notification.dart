import 'package:flutter/material.dart';
import 'package:tugas3provis/pages/shopping/payment_data/checkout2.dart';
import '../shopping/payment_data/checkout.dart';

class NotificationPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      "title": "Diskon Spesial untuk Gear Baru!",
      "subtitle": "Dapatkan hingga 50% untuk tenda & kompor.",
      "time": "2 jam lalu",
    },
    {
      "title": "Barang Favoritmu Tersedia Lagi",
      "subtitle": "Tas carrier 65L kini tersedia kembali.",
      "time": "1 hari lalu",
    },
    {
      "title": "Pemesanan Berhasil",
      "subtitle": "Pesananmu telah dikonfirmasi.",
      "time": "3 hari lalu",
    },
    {
      "title": "Bayar Denda Terlambat",
      "subtitle": "Kamu dikenakan denda Rp10.000 karena terlambat mengembalikan perlengkapan.",
      "time": "5 jam lalu",
    },
  ];

  NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Kamu membuka: ${item['title']}")),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
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
                      // Different icon for penalty notification
                      Icon(
                        item["title"] == "Bayar Denda Terlambat"
                            ? Icons.money_off
                            : Icons.notifications_none,
                        size: 28,
                        color: item["title"] == "Bayar Denda Terlambat"
                            ? Colors.red
                            : Colors.green,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["title"]!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item["subtitle"]!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item["time"]!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Show the "Bayar Denda Sekarang" button only for penalty notifications
                  if (item["title"] == "Bayar Denda Terlambat")
                    Padding(
                      padding: const EdgeInsets.only(top: 16), // Add some space above the button
                      child: Align(
                        alignment: Alignment.centerRight, // Align to the right
                        child: ElevatedButton(
                          onPressed: () {
                            // Add the logic for paying the fine here
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Checkout2(), // Replace with your payment page
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.red, // Text color
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Bayar Denda Sekarang"),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
