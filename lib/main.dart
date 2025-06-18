import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas3provis/pages/Tugas3MainPage.dart';
import 'package:tugas3provis/providers/auth_provider.dart';
import 'package:tugas3provis/providers/barang_provider.dart';
import 'package:tugas3provis/providers/cart_provider.dart';
import 'package:tugas3provis/providers/wishlist_provider.dart';
import 'package:tugas3provis/providers/detail_barang_provider.dart';
import 'package:tugas3provis/providers/checkout_provider.dart';
// import 'Intro/splashscreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BarangProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => DetailBarangProvider()),
        ChangeNotifierProvider(create: (_) => CheckoutProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
