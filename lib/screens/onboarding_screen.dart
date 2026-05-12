import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Profilini Oluştur',
      'description': 'Kariyer hedeflerini ve yetkinliklerini belirleyerek profesyonel profilini saniyeler içinde hazırla.',
      'image': '👤',
    },
    {
      'title': 'Yolculuğunu Planla',
      'description': 'Başvuru süreçlerini ve gelişim yolculuğunu tek bir merkezden, şeffaf bir şekilde takip et.',
      'image': '🚀',
    },
    {
      'title': 'Fırsatları Keşfet',
      'description': 'Sana en uygun ilanları ve şirketleri yapay zeka destekli eşleştirme ile anında bul.',
      'image': '🔍',
    },
    {
      'title': 'AI Koç ile Geliş',
      'description': 'Profesyonel liderlik koçunla seanslar yap, yetkinliklerini bir üst seviyeye taşı.',
      'image': '🤖',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) => _buildPage(_onboardingData[index]),
          ),
          
          // Alt Kontroller
          Positioned(
            bottom: 60,
            left: 40,
            right: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Sayfa İndikatörü
                Row(
                  children: List.generate(
                    _onboardingData.length,
                    (index) => _buildDot(index),
                  ),
                ),
                
                // Buton
                _currentPage == _onboardingData.length - 1
                    ? ElevatedButton(
                        onPressed: () => context.go('/'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF003EC7),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('BAŞLA', style: TextStyle(fontWeight: FontWeight.bold)),
                      )
                    : IconButton(
                        onPressed: () => _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut),
                        icon: const Icon(Icons.arrow_forward_rounded, color: Color(0xFF003EC7), size: 32),
                      ),
              ],
            ),
          ),
          
          // Geç (Skip) Butonu
          if (_currentPage < _onboardingData.length - 1)
            Positioned(
              top: 60,
              right: 20,
              child: TextButton(
                onPressed: () => context.go('/'),
                child: const Text('GEÇ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPage(Map<String, String> data) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data['image']!,
            style: const TextStyle(fontSize: 100),
          ),
          const SizedBox(height: 60),
          Text(
            data['title']!,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A1F36),
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            data['description']!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? const Color(0xFF003EC7) : const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

// SPLASH SCREEN
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) context.go('/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003EC7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.auto_awesome, color: Colors.white, size: 80),
            const SizedBox(height: 24),
            Text(
              'intalent',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -2,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'MERIT LAB',
              style: TextStyle(color: Colors.white70, letterSpacing: 4, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
