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
          // Top Header
          Positioned(
            top: 60,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('intalent', style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.w900, color: const Color(0xFF4B3091))),
                Text('ADIM ${_onboardingData[_currentPage]['step']}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2)),
              ],
            ),
          ),
          // Progress Bar
          Positioned(
            top: 105,
            left: 24,
            right: 24,
            child: Row(
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
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 140),
          Text(
            data['title'],
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(fontSize: 32, fontWeight: FontWeight.w800, color: const Color(0xFF1A1F36), height: 1.1),
          ),
          const SizedBox(height: 16),
          Text(
            data['desc'],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
          ),
          const SizedBox(height: 32),
          _buildActionButtons(data),
          const SizedBox(height: 40),
          if (data['isProfile'] == true) _buildProfilePreview(),
          if (data['isJourney'] == true) _buildJourneyPreview(),
          if (data['isExplore'] == true) _buildExplorePreview(),
          if (data['isAiCoach'] == true) _buildAiCoachPreview(),
        ],
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
          ),
          child: Text(data['btn1'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => context.go('/'),
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFF4F0FF),
            foregroundColor: const Color(0xFF4B3091),
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(data['btn2'], style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildProfilePreview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
      ),
      child: Column(
        children: [
          const Row(
            children: [
              CircleAvatar(radius: 24, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=123')),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Elif Yılmaz', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Senior Product Designer', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              Spacer(),
              Icon(Icons.verified_user, color: Color(0xFF4B3091), size: 20),
            ],
          ),
          const SizedBox(height: 20),
          _buildSkillRow('PROFESYONEL YETKİNLİK', 0.94),
          _buildSkillRow('LİDERLİK PUANI', 0.88),
        ],
      ),
    );
  }

  Widget _buildSkillRow(String label, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: value, backgroundColor: const Color(0xFFF4F0FF), color: const Color(0xFF4B3091), minHeight: 6, borderRadius: BorderRadius.circular(3)),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildJourneyPreview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          const Text('85%', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Color(0xFF4B3091))),
          const Text('Potansiyel Skoru', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildMiniCard('Bilişsel Yetenek Testi', 'TAMAMLANDI', Colors.green),
          _buildMiniCard('Liderlik Stili Analizi', 'BEKLİYOR', Colors.orange),
        ],
      ),
    );
  }

  Widget _buildMiniCard(String title, String status, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFF9F9FB), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          Text(status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildExplorePreview() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(color: const Color(0xFF4B3091), borderRadius: BorderRadius.circular(24)),
      child: const Center(child: Icon(Icons.search, color: Colors.white, size: 48)),
    );
  }

  Widget _buildAiCoachPreview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: const Column(
        children: [
          Row(
            children: [
              Icon(Icons.psychology, color: Color(0xFF4B3091)),
              SizedBox(width: 12),
              Text('Gelecek mülakatın için hazır mısın?', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
          SizedBox(height: 12),
          Text('"...Harika olur! Özellikle kriz anlarını yönetme konusunda pratik yapmak istiyorum."', style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}

// SPLASH SCREEN REVİZYON
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text('intalent', style: GoogleFonts.plusJakartaSans(fontSize: 48, fontWeight: FontWeight.w900, color: const Color(0xFF4B3091), letterSpacing: -2)),
            const SizedBox(height: 16),
            const Text('Keşfedilme zamanı...', style: TextStyle(color: Colors.grey, letterSpacing: 1, fontSize: 16)),
            const SizedBox(height: 32),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(radius: 3, backgroundColor: Color(0xFF4B3091)),
                SizedBox(width: 8),
                CircleAvatar(radius: 3, backgroundColor: Color(0xFFD1D5DB)),
                SizedBox(width: 8),
                CircleAvatar(radius: 3, backgroundColor: Color(0xFFD1D5DB)),
              ],
            ),
            const Spacer(),
            _buildStatusCard(),
            const SizedBox(height: 60),
            const Text('● DIGITAL MERITOCRACY', style: TextStyle(color: Color(0xFFE5B26F), letterSpacing: 2, fontSize: 10, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 30, offset: const Offset(0, 10))],
      ),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('System Status', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
              Text('READY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF4B3091))),
            ],
          ),
          SizedBox(height: 16),
          LinearProgressIndicator(value: 0.8, backgroundColor: Color(0xFFF4F0FF), color: Color(0xFF4B3091), minHeight: 2),
          SizedBox(height: 16),
          Text(
            'Analyzing executive talent networks...',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
