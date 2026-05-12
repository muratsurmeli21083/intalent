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

  final List<Map<String, dynamic>> _onboardingData = [
    {
      'step': '1 / 4',
      'title': 'Profesyonel\nkimliğini oluştur',
      'desc': 'Profilini oluştur ve şirketlerin seni bir CV\'nin ötesinde anlamasını sağla.',
      'btn1': 'Profilini Tamamla',
      'btn2': 'Daha Sonra',
      'isProfile': true,
    },
    {
      'step': '2 / 4',
      'title': 'Journey ile\nanaliz-gelişim\nsürecini başlat',
      'desc': 'Değerlendirmeleri tamamla; güçlü yönlerini, potansiyelini ve gelişim alanlarını takip et.',
      'btn1': 'Analize Başla →',
      'btn2': 'Daha Sonra',
      'isJourney': true,
    },
    {
      'step': '3 / 4',
      'title': 'Fırsatların\nkilidini aç',
      'desc': 'Profilin yeterince güçlü olduğunda, gerçek potansiyeline uygun fırsatlara eriş. AI tabanlı eşleştirme motorumuz seni en doğru rollerle buluşturur.',
      'btn1': 'İşleri Keşfet',
      'btn2': 'Geri Dön',
      'isExplore': true,
    },
    {
      'step': '4 / 4',
      'title': 'AI Koç ile pratik yap',
      'desc': 'Mülakatlara hazırlan, iletişimini geliştir ve daha hızlı büyü.',
      'btn1': 'Yolculuğuna Başla →',
      'btn2': 'Atla',
      'isAiCoach': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) => _buildOnboardingPage(_onboardingData[index]),
          ),
          // --- STITCH HEADER ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('intalent', 
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 24, 
                          fontWeight: FontWeight.w900, 
                          color: const Color(0xFF4B3091),
                          letterSpacing: -1,
                        )
                      ),
                      Text('ADIM ${_onboardingData[_currentPage]['step']}', 
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2)
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Progress Bar
                  Row(
                    children: List.generate(4, (index) => Expanded(
                      child: Container(
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: index <= _currentPage ? const Color(0xFF4B3091) : const Color(0xFFE5E7EB),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(Map<String, dynamic> data) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 160),
            Text(
              data['title'],
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 32, 
                fontWeight: FontWeight.w800, 
                color: const Color(0xFF1A1F36), 
                height: 1.1
              ),
            ),
            const SizedBox(height: 16),
            Text(
              data['desc'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 40),
            _buildActionButtons(data),
            const SizedBox(height: 48),
            // --- DİNAMİK ÖNİZLEME KARTLARI (STITCH STYLE) ---
            if (data['isProfile'] == true) _buildProfilePreview(),
            if (data['isJourney'] == true) _buildJourneyPreview(),
            if (data['isExplore'] == true) _buildExplorePreview(),
            if (data['isAiCoach'] == true) _buildAiCoachPreview(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> data) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            if (_currentPage < 3) {
              _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
            } else {
              context.go('/');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4B3091),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            shadowColor: const Color(0xFF4B3091).withOpacity(0.4),
          ),
          child: Text(data['btn1'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => context.go('/'),
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFF4F0FF),
            foregroundColor: const Color(0xFF4B3091),
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: Text(data['btn2'], style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildProfilePreview() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 40, offset: const Offset(0, 10))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 56, height: 56,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage('https://i.pravatar.cc/150?u=elif'), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Elif Yılmaz', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF1A1F36))),
                  Text('Senior Product Designer', style: TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
              const Spacer(),
              const Icon(Icons.verified, color: Color(0xFF4B3091), size: 24),
            ],
          ),
          const SizedBox(height: 24),
          _buildSkillBar('PROFESYONEL YETKİNLİK', 0.94, '94%'),
          _buildSkillBar('LİDERLİK PUANI', 0.88, '88%'),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bolt, color: Colors.orange, size: 14),
              SizedBox(width: 4),
              Text('YAPAY ZEKA DESTEKLİ DOĞRULAMA', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillBar(String label, double val, String percent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
            Text(percent, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF4B3091))),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: val, 
          backgroundColor: const Color(0xFFF4F0FF), 
          color: const Color(0xFF4B3091), 
          minHeight: 6, 
          borderRadius: BorderRadius.circular(3)
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildJourneyPreview() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 30)],
      ),
      child: Column(
        children: [
          const Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(width: 120, height: 120, child: CircularProgressIndicator(value: 0.85, strokeWidth: 12, backgroundColor: Color(0xFFF4F0FF), color: Color(0xFF4B3091))),
              Column(
                children: [
                  Text('85%', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF4B3091))),
                  Text('EŞLEŞME', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Potansiyel Skoru', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 24),
          _buildStepItem('Bilişsel Yetenek Testi', 'TAMAMLANDI', Colors.green),
          _buildStepItem('Liderlik Stili Analizi', 'BEKLİYOR', Colors.orange),
        ],
      ),
    );
  }

  Widget _buildStepItem(String t, String s, Color c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFF9F9FB), borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(t, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
            child: Text(s, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: c)),
          ),
        ],
      ),
    );
  }

  Widget _buildExplorePreview() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32)),
      child: Column(
        children: [
          const Icon(Icons.rocket_launch_rounded, color: Color(0xFF4B3091), size: 64),
          const SizedBox(height: 24),
          const Text('Fırsatları Yakala', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 12),
          const Text('Yapay zeka motorumuz senin için 12 yeni ilan buldu.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildAiCoachPreview() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: const Color(0xFF1A1F36), borderRadius: BorderRadius.circular(32)),
      child: Column(
        children: [
          Row(
            children: [
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.psychology, color: Colors.white)),
              const SizedBox(width: 16),
              const Expanded(child: Text('Senin için bir mülakat simülasyonu hazırladım.', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500))),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF4B3091), borderRadius: BorderRadius.circular(16)),
            child: const Text('"Harika olur! Liderlik yetkinliklerimi test etmek istiyorum."', style: TextStyle(color: Colors.white70, fontSize: 12, fontStyle: FontStyle.italic)),
          ),
        ],
      ),
    );
  }
}

// --- STITCH SPLASH SCREEN ---
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) context.go('/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('intalent', 
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 56, 
                    fontWeight: FontWeight.w900, 
                    color: const Color(0xFF4B3091), 
                    letterSpacing: -3
                  )
                ),
                const SizedBox(height: 16),
                const Text('Keşfedilme zamanı...', style: TextStyle(color: Colors.grey, letterSpacing: 2, fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 48),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 4, backgroundColor: Color(0xFF4B3091)),
                    SizedBox(width: 12),
                    CircleAvatar(radius: 4, backgroundColor: Color(0xFFE5E7EB)),
                    SizedBox(width: 12),
                    CircleAvatar(radius: 4, backgroundColor: Color(0xFFE5E7EB)),
                  ],
                ),
              ],
            ),
          ),
          // Ready Status Card
          Positioned(
            bottom: 120,
            left: 40,
            right: 40,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 40, offset: const Offset(0, 20))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('System Status', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                      Text('READY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF4B3091))),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const LinearProgressIndicator(value: 0.8, backgroundColor: Color(0xFFF4F0FF), color: Color(0xFF4B3091), minHeight: 2),
                  const SizedBox(height: 20),
                  Text('Analyzing executive talent networks...', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Text('● DIGITAL MERITOCRACY', 
                style: TextStyle(color: Color(0xFFE5B26F), letterSpacing: 4, fontSize: 10, fontWeight: FontWeight.w900)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
