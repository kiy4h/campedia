import 'dart:async';
import 'package:flutter/material.dart';
import '../account/register.dart';
import '../account/signin.dart';

// Onboarding Screen with Carousel
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // Onboarding pages (excluding splash screen)
  final List<OnboardingPage> _pages = [
    OnboardingPage(
      image: 'images/assets_OnBoarding0/kompas_bg.png',
      title: 'Welcome to Campedia',
      subtitle: 'Your Ultimate Camping Companion',
      description:
          'Sewa perlengkapan kemah terbaik, dari tenda hingga kompor. Berkemah jadi mudah dan seru bersama Campedia',
      backgroundColor: Colors.white,
    ),
    OnboardingPage(
      image: 'images/assets_OnBoarding0/tenda_bg.png',
      title: 'Quality camping gear for every adventure',
      subtitle: '',
      description:
          'Planning your next camping trip? We\'ve got the gear you need — tents, cook sets, lights, and more!',
      backgroundColor: Colors.white,
    ),
    OnboardingPage(
      image: 'images/assets_OnBoarding0/onboarding4image.png',
      title: 'Efficient, In-Store Pickup for Your Camping Rentals',
      subtitle:
          'Simply reserve online and pick up your equipment at our store at your convenience.',
      description: '',
      backgroundColor: Colors.white,
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Start auto-slide timer
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _pages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // Loop back to first page
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Carousel content - takes most of the screen for easy swiping
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _pages[index];
                },
              ),
            ),

            // Pagination dots - show for onboarding pages
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length, // Show dots for each onboarding page
                  (index) => _buildDot(index == _currentPage),
                ),
              ),
            ),

            // Action buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A5A2A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'CREATE AN ACCOUNT',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A5A2A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 20 : 12,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF4A5A2A) : Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String description;
  final Color backgroundColor;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image
              Image.asset(
                image,
                height: 250,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),

              // Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              if (subtitle.isNotEmpty)
                Column(
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

              if (description.isNotEmpty)
                Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
