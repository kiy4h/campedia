import 'package:flutter/material.dart';
import 'Intro/splashscreen.dart';
import 'shopPage/shoping.dart';
import 'payment/bayarDenda.dart';
import 'Items/detailItem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campedia',
      theme: ThemeData(
        primaryColor: const Color(0xFF4A5A2A),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Shoping(),
      // home: const SplashScreen(),
      // home: DetailDendaPage(),
      // home: const DetailItem(),
      debugShowCheckedModeBanner: false,
    );
  }
}
