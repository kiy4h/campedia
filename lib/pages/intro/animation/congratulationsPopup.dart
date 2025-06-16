import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../account/signin.dart';

/// Popup dialog berisi ucapan selamat dengan animasi konfetti.
/// Muncul setelah pengguna berhasil membuat akun.
class CongratulationsPopup extends StatefulWidget {
  final String name;
  final VoidCallback onSignIn;

  const CongratulationsPopup({
    super.key,
    required this.name,
    required this.onSignIn,
  });

  @override
  State<CongratulationsPopup> createState() => _CongratulationsPopupState();
}

class _CongratulationsPopupState extends State<CongratulationsPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Inisialisasi animasi konfetti dan mulai animasi
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    // Hentikan dan hapus controller animasi saat tidak digunakan
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Kontainer utama untuk isi popup
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Congratulations!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF556B2F),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 60),
                const SizedBox(height: 100),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Congratulations! Your account has been created. Please sign in now.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigasi ke halaman Sign In
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignIn()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF556B2F),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'By tapping Sign in you accept all',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),

          // Area animasi konfetti
          Positioned(
            top: 80,
            left: 20,
            right: 20,
            bottom: 140,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ConfettiOverlay(controller: _controller),
            ),
          ),
        ],
      ),
    );
  }
}

/// Menampilkan animasi konfetti menggunakan CustomPaint
class ConfettiOverlay extends StatelessWidget {
  final AnimationController controller;

  const ConfettiOverlay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ConfettiPainter(animation: controller),
          child: Container(),
        );
      },
    );
  }
}

/// CustomPainter yang menggambar partikel konfetti secara dinamis
class ConfettiPainter extends CustomPainter {
  final Animation<double> animation;

  ConfettiPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final confettiCount = 50;
    final random = math.Random(42); // Seed tetap agar hasil stabil
    final confettiColors = [
      const Color(0xFF556B2F),
      const Color(0xFF6B8E23),
      const Color(0xFFFFD700),
      const Color(0xFFDAA520),
    ];

    for (int i = 0; i < confettiCount; i++) {
      final x = random.nextDouble() * size.width;
      final initialY = -50.0 - random.nextDouble() * 200;
      final speed = 2.0 + random.nextDouble() * 3;
      final y = initialY + (animation.value * speed * 500) % (size.height + 300);

      if (y > -50 && y < size.height + 50) {
        final type = random.nextInt(2);
        final color = confettiColors[random.nextInt(confettiColors.length)];
        final paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;

        canvas.save();
        canvas.translate(x, y);
        canvas.rotate(animation.value * (random.nextBool() ? 1 : -1) * math.pi * 2);

        if (type == 0) {
          final width = 4.0 + random.nextDouble() * 8;
          final height = 4.0 + random.nextDouble() * 8;
          canvas.drawRect(
            Rect.fromCenter(center: Offset.zero, width: width, height: height),
            paint,
          );
        } else {
          final path = Path();
          final length = 8.0 + random.nextDouble() * 10;
          final width = 2.0 + random.nextDouble() * 3;

          path.moveTo(-length / 2, 0);
          for (int j = 0; j < 3; j++) {
            final xOffset = -length / 2 + (j * length / 2);
            final yOffset = (j % 2 == 0) ? -width : width;
            path.lineTo(xOffset, yOffset);
          }
          path.lineTo(length / 2, 0);

          canvas.drawPath(path, paint);
        }

        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(ConfettiPainter oldDelegate) => true;
}

/// Fungsi untuk menampilkan dialog popup Congratulations
void showCongratulationsPopup(BuildContext context, String name) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CongratulationsPopup(
        name: name,
        onSignIn: () {
          Navigator.of(context).pop();
        },
      );
    },
  );
}

/// Halaman demo untuk menampilkan tombol yang memicu popup Congratulations
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showCongratulationsPopup(context, 'Rafatul Islam');
          },
          child: const Text('Show Popup'),
        ),
      ),
    );
  }
}
