import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'step1.dart';
import 'review.dart';  // Tambahkan import ReviewPage

class Step3Page extends StatelessWidget {
  const Step3Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengembalian Barang', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
        children: [
          // Confirmation Content: Gambar dan teks di atas
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.green.shade100,
                  ),
                  child: const Center(
                    child: Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Terima kasih! Barang telah dikembalikan.\nSilakan berikan ulasan untuk pengalaman sewa kamu.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),

          // Stepper Content: Step 1 completed, Step 2 completed, Step 3 active
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
              child: Column(
                children: [
                  // Step 1 - Completed
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
                            'step 1',
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

                  // Step 2 - Completed
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

                  // Step 3 - Active
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
                              // last step, no line
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'step 3',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Kembalikan barang ke toko sesuai waktu. Setelah itu, beri ulasan untuk pengalaman sewa kamu.',
                                style: TextStyle(fontSize: 16, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Submit Button at bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReviewPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF627D2C),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              child: const Text(
                'SUBMIT REVIEW',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
