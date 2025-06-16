/**
 * File         : detail_denda_page.dart
 * Dibuat oleh  : Izzuddin Azzam
 * Tanggal      : 16-06-2025
 * Deskripsi    : Halaman detail denda kerusakan/pelanggaran pada penyewaan barang.
 *                Menampilkan informasi barang, pelanggaran, nominal denda, dan tombol pembayaran.
 */

import 'package:flutter/material.dart';

/// Halaman untuk menampilkan detail denda barang sewaan
class DetailDendaPage extends StatelessWidget {
  const DetailDendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data (bisa diganti dengan data dari model/parameter)
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

            // Daftar detail dalam ListView agar bisa di-scroll
            Expanded(
              child: ListView(
                children: [
                  _buildDetailCard('Nama Barang', namaBarang),
                  _buildImageCard('https://via.placeholder.com/300x180.png?text=Gambar+Barang'), // Ganti path asset jika perlu
                  _buildDetailCard('Deskripsi Barang', deskripsi),
                  _buildDetailCard('Jenis Pelanggaran', jenisPelanggaran),
                  _buildDetailCard('Nominal Denda', nominal),
                  _buildDetailCard('Catatan Tambahan', catatan),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Tombol lanjut ke pembayaran
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Navigasi ke halaman metode pembayaran
                },
                icon: const Icon(Icons.payment, color: Colors.white),
                label: const Text(
                  'LANJUT BAYAR',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1.2,
                    color: Colors.white,
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

  /// Widget untuk menampilkan kartu detail dengan label dan isinya
  Widget _buildDetailCard(String label, String value) {
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

  /// Widget untuk menampilkan gambar barang dalam kartu
  Widget _buildImageCard(String imageUrl) {
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
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox(
              height: 180,
              child: Center(child: Text('Gagal memuat gambar')),
            );
          },
        ),
      ),
    );
  }
}
