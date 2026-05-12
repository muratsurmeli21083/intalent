import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),
              const SizedBox(height: 24),
              _buildScoreCard(),
              const SizedBox(height: 24),
              _buildAiCoachBanner(context),
              const SizedBox(height: 24),
              _buildSectionTitle('En İyi Eşleşmeler'),
              const SizedBox(height: 12),
              _buildJobCard(
                title: 'Senior AI Engineer',
                company: 'TechNova Systems',
                match: '%92',
                tags: ['Remote', 'Tam Zamanlı'],
              ),
              _buildJobCard(
                title: 'Product Lead',
                company: 'DataFlow Corp',
                match: '%87',
                tags: ['İstanbul', 'Hibrit'],
              ),
              _buildJobCard(
                title: 'UX Design Lead',
                company: 'Metaveri A.Ş.',
                match: '%81',
                tags: ['Ankara', 'Tam Zamanlı'],
              ),
              const SizedBox(height: 100), // FAB için boşluk
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'intalent',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF003EC7),
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Selam, Deniz 👋',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1E),
              ),
            ),
            const Text(
              'Kariyerin evriliyor',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFFDDE1FF),
          child: Icon(Icons.person, color: Color(0xFF003EC7), size: 28),
        ),
      ],
    );
  }

  Widget _buildScoreCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE0E3E5)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Yetenek Skoru', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Color(0xFF191C1E))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFDDE1FF), borderRadius: BorderRadius.circular(20)),
                child: const Text('LİYAKAT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF003EC7), letterSpacing: 1)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Geliştirmek için yolculuğunu tamamla',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMiniBar('Liderlik', 0.88),
                    _buildMiniBar('Analitik', 0.75),
                    _buildMiniBar('İletişim', 0.91),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 72, height: 72,
                    child: CircularProgressIndicator(
                      value: 0.85,
                      strokeWidth: 7,
                      backgroundColor: const Color(0xFFDDE1FF),
                      color: const Color(0xFF003EC7),
                    ),
                  ),
                  const Text('85', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF003EC7))),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniBar(String label, double val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: val,
            minHeight: 5,
            backgroundColor: const Color(0xFFDDE1FF),
            color: const Color(0xFF003EC7),
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }

  Widget _buildAiCoachBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF003EC7), Color(0xFF0052FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI Koç ile mülakat\nprovası yap',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16, height: 1.3),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Performansını gerçek zamanlı ölç',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF003EC7),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('Başla', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                ),
              ],
            ),
          ),
          const Icon(Icons.psychology_rounded, color: Colors.white38, size: 64),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF191C1E)),
    );
  }

  Widget _buildJobCard({required String title, required String company, required String match, required List<String> tags}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E3E5)),
      ),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: const Color(0xFFDDE1FF), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.business_center_outlined, color: Color(0xFF003EC7), size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF191C1E))),
                const SizedBox(height: 2),
                Text(company, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children: tags.map((t) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: const Color(0xFFF2F4F6), borderRadius: BorderRadius.circular(6)),
                    child: Text(t, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF434656))),
                  )).toList(),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFFDDE1FF), borderRadius: BorderRadius.circular(10)),
            child: Text(match, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF003EC7))),
          ),
        ],
      ),
    );
  }
}
