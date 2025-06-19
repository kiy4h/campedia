import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas3provis/pages/Tugas3MainPage.dart';
import 'package:tugas3provis/providers/auth_provider.dart';
import 'package:tugas3provis/providers/barang_provider.dart';
import 'package:tugas3provis/providers/cart_provider.dart';
import 'package:tugas3provis/providers/wishlist_provider.dart';
import 'package:tugas3provis/providers/detail_barang_provider.dart';
import 'package:tugas3provis/providers/checkout_provider.dart';
import 'package:tugas3provis/providers/transaction_provider.dart';
import 'package:tugas3provis/providers/transaction_detail_provider.dart';
import 'package:tugas3provis/providers/profile_provider.dart';
import 'package:tugas3provis/providers/kategori_provider.dart';
import 'package:tugas3provis/providers/brand_provider.dart';
import 'package:tugas3provis/providers/notification_provider.dart';
import 'package:tugas3provis/providers/gunung_provider.dart';
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
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => TransactionDetailProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => KategoriProvider()),
        ChangeNotifierProvider(create: (_) => BrandProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(
            create: (_) => GunungProvider()), // Tambah GunungProvider
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
