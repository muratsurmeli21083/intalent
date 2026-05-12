import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  // Simüle edilmiş profil skoru (Gerçekte veritabanından gelecek)
  double profileScore = 0.65; // %65 olsun (Kilitli kalması için)

  @override
  Widget build(BuildContext context) {
    bool isLocked = profileScore < 0.70;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: Stack(
                children: [
                  // --- İŞ İLANLARI LİSTESİ ---
                  _buildJobList(),
                  
                  // --- KİLİT KATMANI (OVERLAY) ---
                  if (isLocked) _buildLockOverlay(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('İşleri Keşfet', 
            style: GoogleFonts.plusJakartaSans(
              fontSize: 28, 
              fontWeight: FontWeight.w800, 
              color: const Color(0xFF1A1F36)
            )
          ),
          const SizedBox(height: 8),
          Text(
            'Sana en uygun fırsatları liyakat bazlı eşleştiriyoruz.',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildJobList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildJobCard(index);
      },
    );
  }

  Widget _buildJobCard(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20)],
      ),
      child: Row(
        children: [
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(color: const Color(0xFFF4F0FF), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.business, color: Color(0xFF4B3091)),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Senior Product Designer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text('Google • Remote', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLockOverlay() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white.withOpacity(0.4),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 40)],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: const Color(0xFFF4F0FF), shape: BoxShape.circle),
                      child: const Icon(Icons.lock_rounded, color: Color(0xFF4B3091), size: 48),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Fırsatlar Kilitli',
                      style: GoogleFonts.plusJakartaSans(fontSize: 22, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 12),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
                        children: [
                          const TextSpan(text: 'İş ilanlarını görebilmek için profil skorunu '),
                          TextSpan(
                            text: '%70', 
                            style: TextStyle(color: const Color(0xFF4B3091), fontWeight: FontWeight.bold)
                          ),
                          const TextSpan(text: ' ve üzerine çıkarman gerekiyor.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildProgressBar(),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        // Profil tamamlama ekranına yönlendir
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4B3091),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: const Text('Profilini Tamamla', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Profil Skorun', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[700])),
            Text('${(profileScore * 100).toInt()}%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF4B3091))),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: profileScore,
            minHeight: 8,
            backgroundColor: const Color(0xFFF4F0FF),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4B3091)),
          ),
        ),
      ],
    );
  }
}
