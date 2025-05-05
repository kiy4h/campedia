import 'package:flutter/material.dart';
import 'package:tugas3provis/Tugas3MainPage/Tugas3MainPage.dart';
// import 'Intro/splashscreen.dart';

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
      home: Tugas3ProvisPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
