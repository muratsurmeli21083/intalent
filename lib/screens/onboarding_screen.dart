import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// --- ONBOARDING SCREEN ---
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            children: [
              _buildStep(
                title: 'Profesyonel\nkimliğini oluştur',
                desc: 'Profilini oluştur ve şirketlerin seni bir CV\'nin ötesinde anlamasını sağla.',
                btn: 'Profilini Tamamla',
                content: _buildProfileCard(),
              ),
              _buildStep(
                title: 'Journey ile\nanaliz-gelişim\nsürecini başlat',
                desc: 'Değerlendirmeleri tamamla; güçlü yönlerini, potansiyelini ve gelişim alanlarını takip et.',
                btn: 'Analize Başla →',
                content: _buildJourneyCard(),
              ),
              _buildStep(
                title: 'Fırsatların\nkilidini aç',
                desc: 'Profilin yeterince güçlü olduğunda, gerçek potansiyeline uygun fırsatlara eriş.',
                btn: 'İşleri Keşfet',
                content: _buildExploreCard(),
              ),
              _buildStep(
                title: 'AI Koç ile pratik yap',
                desc: 'Mülakatlara hazırlan, iletişimini geliştir ve daha hızlı büyü.',
                btn: 'Yolculuğuna Başla →',
                content: _buildAiCoachCard(),
              ),
            ],
          ),
          // Top Header
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('intalent', style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.w900, color: const Color(0xFF4B3091))),
                  Text('ADIM ${_currentPage + 1} / 4', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep({required String title, required String desc, required String btn, required Widget content}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 140),
            Text(title, textAlign: TextAlign.center, style: GoogleFonts.plusJakartaSans(fontSize: 32, fontWeight: FontWeight.w800, height: 1.1, color: const Color(0xFF1A1F36))),
            const SizedBox(height: 16),
            Text(desc, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: Colors.grey, height: 1.5)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _currentPage < 3 ? _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut) : context.go('/'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4B3091),
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(btn, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 48),
            content,
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 30)]),
      child: Column(
        children: [
          const Row(
            children: [
              CircleAvatar(radius: 24, backgroundColor: Color(0xFFF4F0FF), child: Icon(Icons.person, color: Color(0xFF4B3091))),
              SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Elif Yılmaz', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Senior Product Designer', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ]),
              Spacer(),
              Icon(Icons.verified, color: Color(0xFF4B3091), size: 20),
            ],
          ),
          const SizedBox(height: 20),
          _buildBar('YETKİNLİK', 0.94),
          _buildBar('LİDERLİK', 0.88),
        ],
      ),
    );
  }

  Widget _buildBar(String l, double v) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(l, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
      const SizedBox(height: 6),
      LinearProgressIndicator(value: v, backgroundColor: const Color(0xFFF4F0FF), color: const Color(0xFF4B3091), minHeight: 6, borderRadius: BorderRadius.circular(3)),
      const SizedBox(height: 12),
    ]);
  }

  Widget _buildJourneyCard() => Container(
    padding: const EdgeInsets.all(32),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32)),
    child: const Column(children: [
      Text('85%', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Color(0xFF4B3091))),
      Text('EŞLEŞME SKORU', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
    ]),
  );

  Widget _buildExploreCard() => Container(
    height: 150, width: double.infinity,
    decoration: BoxDecoration(color: const Color(0xFF4B3091), borderRadius: BorderRadius.circular(32)),
    child: const Icon(Icons.rocket_launch, color: Colors.white, size: 50),
  );

  Widget _buildAiCoachCard() => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(color: const Color(0xFF1A1F36), borderRadius: BorderRadius.circular(32)),
    child: const Text('AI Koç ile mülakat simülasyonuna hazır mısın?', style: TextStyle(color: Colors.white, fontSize: 14)),
  );
}

// --- SPLASH SCREEN ---
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  void _checkAuthState() {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    
    if (user != null) {
      // Kullanıcı zaten login'se, ana sayfaya git
      _redirectUser(user);
    } else {
      // Kullanıcı login'se değilse, timer'a devam et
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted) context.go('/onboarding');
      });
    }
    
    // Auth state değişikliğini dinle (Google OAuth callback vb.)
    supabase.auth.onAuthStateChange.listen((data) {
      if (data.session != null && mounted) {
        _redirectUser(data.session!.user);
      }
    });
  }

  void _redirectUser(User user) {
    final role = user.userMetadata?['role'] ?? 'candidate';
    if (mounted) {
      if (role == 'admin' || role == 'recruiter') {
        context.go('/recruiter');
      } else {
        context.go('/candidate-home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('intalent', style: GoogleFonts.plusJakartaSans(fontSize: 56, fontWeight: FontWeight.w900, color: const Color(0xFF4B3091), letterSpacing: -3)),
            const SizedBox(height: 16),
            const Text('Keşfedilme zamanı...', style: TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 60),
            Container(
              width: 280, padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 40)]),
              child: const Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('System Status', style: TextStyle(fontSize: 10, color: Colors.grey)),
                  Text('READY', style: TextStyle(fontSize: 10, color: Color(0xFF4B3091), fontWeight: FontWeight.bold)),
                ]),
                SizedBox(height: 12),
                LinearProgressIndicator(value: 0.8, backgroundColor: Color(0xFFF4F0FF), color: Color(0xFF4B3091), minHeight: 2),
              ]),
            ),
            const SizedBox(height: 60),
            const Text('● DIGITAL MERITOCRACY', style: TextStyle(color: Color(0xFFE5B26F), letterSpacing: 4, fontSize: 10, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }
}
