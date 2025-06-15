import 'package:flutter/material.dart';

class DetailDendaPage extends StatelessWidget {
  const DetailDendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final namaBarang = 'Kabel HDMI';
    final deskripsi = 'Kabel rusak pada bagian ujung konektor.';
    final jenisPelanggaran = 'Kerusakan Barang';
    final nominal = 'Rp 50.000';
    final catatan = 'Harap dikembalikan meskipun rusak.';

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAF4),
      appBar: AppBar(
        title: const Text(
          'Pembayaran Denda',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.report_gmailerrorred_rounded, size: 60, color: Color(0xFF627D2C)),
            const SizedBox(height: 12),
            const Text(
              'Detail Denda',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildDetailCard('Nama Barang', namaBarang),
                  buildImageCard('../../images/assets_ItemDetails/jaket1.png'),
                  buildDetailCard('Deskripsi Barang', deskripsi),
                  buildDetailCard('Jenis Pelanggaran', jenisPelanggaran),
                  buildDetailCard('Nominal Denda', nominal),
                  buildDetailCard('Catatan Tambahan', catatan),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigasi ke metode pembayaran
                },
                icon: const Icon(
                  Icons.payment,
                  color: Color.fromARGB(255, 230, 228, 228),
                  ),
                label: const Text(
                  'LANJUT BAYAR',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1.2,
                    color: Color.fromARGB(255, 230, 228, 228),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF627D2C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailCard(String label, String value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget buildImageCard(String imageUrl) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imageUrl,
          height: 180,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
