import 'package:flutter/material.dart';

// Halaman statis yang menampilkan Terms & Conditions aplikasi
class TermsConditionPage extends StatelessWidget {
  const TermsConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F1),
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
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
              // Bagian judul "Terms"
              sectionHeader(Icons.gavel, 'Terms'),
              const SizedBox(height: 12),

              // Daftar poin Terms
              termPoint('Users must be at least 18 years old to create an account.'),
              termPoint('All information provided must be accurate and up-to-date.'),
              termPoint('Users agree not to misuse the app for illegal activities.'),
              termPoint('We may update our terms at any time with prior notice.'),

              const SizedBox(height: 24),
              Divider(color: Colors.grey.shade400, thickness: 1),
              const SizedBox(height: 24),

              // Bagian judul "Conditions"
              sectionHeader(Icons.verified_user, 'Conditions'),
              const SizedBox(height: 12),

              // Daftar poin Conditions
              termPoint('Your data will be stored securely and only used within the app context.'),
              termPoint('You agree to receive important updates related to your account.'),
              termPoint('If you violate any terms, your account may be suspended or removed.'),
              termPoint('Continued use of the app signifies acceptance of these conditions.'),

              const SizedBox(height: 40),

              // Tombol untuk menyatakan setuju dan kembali ke halaman sebelumnya
              Center(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context), // Menutup halaman
                  icon: const Icon(Icons.check_circle, color: Colors.white), // Icon tambahan
                  label: const Text('Understand and Accept'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF566D3D), // Konsisten dengan tema hijau
                    foregroundColor: Colors.white,
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

  // Widget untuk judul bagian (e.g., Terms / Conditions)
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

  // Widget untuk poin-poin isi Terms / Conditions
  Widget termPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 18)), // Bullet point
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                // textAlign: TextAlign.justify, // Optional jika ingin lebih rapi
              ),
            ),
          ),
        ],
      ),
    );
  }
}
