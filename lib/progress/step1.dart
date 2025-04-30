import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'step2.dart';

class Step1Page extends StatelessWidget {
  const Step1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LatLng jakartaLocation = LatLng(-6.2088, 106.8456);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengambilan Barang',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Map Container
          Container(
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
                ],
              ),
            ),
          ),
          // Stepper Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                children: [
                  // Stepper - First Step - Active
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 50,
                          child: Column(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF9BAE76),
                                    width: 6,
                                  ),
                                ),
                              ),
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
                            children: const [
                              Text(
                                'step 1',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Ambil perlengkapan sewa langsung di toko. Lokasi bisa dilihat melalui Google Maps yang telah disediakan.',
                                style: TextStyle(fontSize: 16, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Stepper - Second Step - Completed
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 50,
                          child: Column(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF9BAE76),
                                  shape: BoxShape.circle,
                                ),
                              ),
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
                        const Expanded(
                          child: Text(
                            'step 2',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Stepper - Third Step - Inactive
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 50,
                          child: Column(
                            children: [
                              const SizedBox(height: 8),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'step 3',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Next Step Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Step2Page()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF627D2C),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              child: const Text(
                'NEXT STEP',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          // Bottom Navigation
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.home, color: Colors.grey[600]),
                Icon(Icons.swap_horiz, color: Colors.grey[600]),
                Stack(
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.grey[600]),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.favorite_border, color: Colors.grey[600]),
                const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
