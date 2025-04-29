import 'package:flutter/material.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifikasi"),
        backgroundColor: Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.notifications, color: Color(0xFF2E7D32), size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["title"]!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        item["subtitle"]!,
                        style: TextStyle(color: Colors.black54),
                      ),
                      SizedBox(height: 6),
                      Text(
                        item["time"]!,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
