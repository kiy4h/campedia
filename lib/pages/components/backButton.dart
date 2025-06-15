import 'package:flutter/material.dart';
import '../Tugas3MainPage.dart'; // pastikan path sesuai

class PageWrapper extends StatelessWidget {
  final String title;
  final Widget child;

  const PageWrapper({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Tugas3ProvisPage()),
              (route) => false,
            );
          },
        ),
      ),
      body: child,
    );
  }
}
