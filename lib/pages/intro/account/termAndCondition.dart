import 'package:flutter/material.dart';

class TermsConditionPage extends StatelessWidget {
  const TermsConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F1),
      appBar: AppBar(
        title: const Text('Syarat & Ketentuan'),
        backgroundColor: const Color(0xFF566D3D),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionHeader(Icons.gavel, 'Syarat'),
              const SizedBox(height: 12),
              termPoint('Pengguna harus berusia minimal 18 tahun untuk membuat akun.'),
              termPoint('Semua informasi yang diberikan harus akurat dan terkini.'),
              termPoint('Pengguna setuju untuk tidak menyalahgunakan aplikasi untuk aktivitas ilegal.'),
              termPoint('Kami dapat memperbarui syarat kapan saja dengan pemberitahuan sebelumnya.'),
              const SizedBox(height: 24),
              Divider(color: Colors.grey.shade400, thickness: 1),
              const SizedBox(height: 24),
              sectionHeader(Icons.verified_user, 'Ketentuan'),
              const SizedBox(height: 12),
              termPoint('Data Anda akan disimpan dengan aman dan hanya digunakan dalam konteks aplikasi.'),
              termPoint('Anda setuju untuk menerima pembaruan penting terkait akun Anda.'),
              termPoint('Jika melanggar syarat, akun Anda dapat ditangguhkan atau dihapus.'),
              termPoint('Penggunaan aplikasi secara berkelanjutan berarti Anda menerima ketentuan ini.'),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.check_circle_outline, color: Color(0xFF566D3D)),
                  label: const Text(
                    'Saya Mengerti dan Menyetujui',
                    style: TextStyle(color: Color(0xFF566D3D)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE0DFDF),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF566D3D), size: 28),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF566D3D),
          ),
        ),
      ],
    );
  }

  Widget termPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 18)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
