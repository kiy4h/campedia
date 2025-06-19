/*
* File : congratulationsPopup.dart
* Deskripsi : Dialog popup animasi konfetti untuk menampilkan ucapan selamat setelah pengguna berhasil membuat akun
* Dependencies : 
*   - dart:math: untuk fungsi matematika pada animasi konfetti
*   - signin.dart: untuk navigasi ke halaman signin
*/

import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../account/signin.dart';

/*
* Class : CongratulationsPopup
* Deskripsi : Widget popup ucapan selamat dengan animasi konfetti, merupakan StatefulWidget
* Bagian Layar : Dialog popup setelah registrasi berhasil
*/
class CongratulationsPopup extends StatefulWidget {
  final String name;
  final VoidCallback onSignIn;

  const CongratulationsPopup({
    super.key,
    required this.name,
    required this.onSignIn,
  });

  @override
  State<CongratulationsPopup> createState() => CongratulationsPopupState();
}

/*
* Class : _CongratulationsPopupState
* Deskripsi : State untuk widget CongratulationsPopup dengan SingleTickerProviderStateMixin untuk animasi
* Bagian Layar : Mengatur state dan animasi popup ucapan selamat
*/
class CongratulationsPopupState extends State<CongratulationsPopup> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  /*
  * Method : initState
  * Deskripsi : Inisialisasi state awal dan controller animasi
  * Parameter : -
  * Return : void
  */
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }
  /*
  * Method : dispose
  * Deskripsi : Membersihkan resource controller animasi saat widget dihapus
  * Parameter : -
  * Return : void
  */
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  /*
  * Method : build
  * Deskripsi : Membangun UI dialog ucapan selamat dengan animasi konfetti
  * Parameter : context - BuildContext untuk akses ke fitur framework
  * Return : Widget Dialog transparan dengan konten ucapan selamat
  */
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Card background
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
                // Title
                const Text(
                  'Congratulations!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF556B2F), // Dark olive green
                  ),
                ),
                const SizedBox(height: 5),
                // User name
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 60),
                // Confetti animation space (handled by ConfettiOverlay)
                const SizedBox(height: 100),
                // Message text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'congratulations! Your account has been created. Please sign in now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignIn()),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF556B2F), // Dark olive green
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
                // Bottom text (optional)
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
          
          // Confetti overlay
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

/*
* Class : ConfettiOverlay
* Deskripsi : Widget untuk menampilkan animasi konfetti, merupakan StatelessWidget
* Bagian Layar : Lapisan animasi konfetti pada popup
*/
class ConfettiOverlay extends StatelessWidget {
  final AnimationController controller;

  const ConfettiOverlay({super.key, required this.controller});
  /*
  * Method : build
  * Deskripsi : Membangun widget AnimatedBuilder untuk animasi konfetti
  * Parameter : context - BuildContext untuk akses ke fitur framework
  * Return : Widget AnimatedBuilder dengan CustomPaint untuk animasi konfetti
  */
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

/*
* Class : ConfettiPainter
* Deskripsi : CustomPainter untuk menggambar animasi konfetti
* Bagian Layar : Rendering visual animasi konfetti
*/
class ConfettiPainter extends CustomPainter {
  final Animation<double> animation;
  
  ConfettiPainter({required this.animation}) : super(repaint: animation);
    /*
  * Method : paint
  * Deskripsi : Melakukan rendering animasi konfetti pada canvas
  * Parameter : 
  *   - canvas - Canvas untuk melukis animasi
  *   - size - Size dimensi area yang tersedia untuk melukis
  * Return : void
  */
  @override
  void paint(Canvas canvas, Size size) {
    final confettiCount = 50;
    final random = math.Random(42); // Fixed seed for consistent generation
    
    // Colors from the image
    final confettiColors = [
      const Color(0xFF556B2F), // Dark olive green
      const Color(0xFF6B8E23), // Olive drab
      const Color(0xFFFFD700), // Gold/yellow
      const Color(0xFFDAA520), // Golden rod (yellow-orange)
    ];
    
    for (int i = 0; i < confettiCount; i++) {
      // Initial random position with adjusted vertical position based on animation
      final double x = random.nextDouble() * size.width;
      final initialY = -50.0 - random.nextDouble() * 200; // Start above the visible area
      final speed = 2.0 + random.nextDouble() * 3; // Varying speeds
      
      // Current y position based on animation progress
      final y = initialY + (animation.value * speed * 500) % (size.height + 300);
      
      // Only draw if within visible area (with some margin)
      if (y > -50 && y < size.height + 50) {
        // Randomly choose type (0: rectangle, 1: wiggle line)
        final type = random.nextInt(2);
        final color = confettiColors[random.nextInt(confettiColors.length)];
        
        final paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;
          
        // Rotate the canvas for each confetti
        canvas.save();
        canvas.translate(x, y);
        canvas.rotate(animation.value * (random.nextBool() ? 1 : -1) * math.pi * 2);
        
        if (type == 0) {
          // Rectangle confetti
          final width = 4.0 + random.nextDouble() * 8;
          final height = 4.0 + random.nextDouble() * 8;
          canvas.drawRect(
            Rect.fromCenter(center: Offset.zero, width: width, height: height), 
            paint
          );
        } else {
          // Wiggle line confetti
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

// Function to show the popup
void showCongratulationsPopup(BuildContext context, String name) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CongratulationsPopup(
        name: name,
        onSignIn: () {
          Navigator.of(context).pop();
          // Add navigation to sign in page here
        },
      );
    },
  );
}

// Example usage (for reference)
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