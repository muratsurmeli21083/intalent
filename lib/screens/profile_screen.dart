import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2EF),
      appBar: AppBar(
        title: const Text('Profil & Live CV'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Color(0xFF666666)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Color(0xFF666666)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // AI Analysis Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF003EC7), Color(0xFF0052FF)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'LinkedIn Profilin intalent AI Tarafından İncelendi',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Mevcut liyakat skorun ',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '%65',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Skorunu %90 ve üzerine yükseltmek için 3 önerimiz var!',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),

            // Profile Header Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF003EC7), width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0xFFF8F9FA),
                          child: Icon(Icons.person, size: 50, color: Color(0xFFCCCCCC)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.verified, color: Color(0xFF003EC7), size: 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Deniz Yılmaz',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Senior Product Designer',
                    style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildHeaderStat('Bağlantı', '500+'),
                      _buildHeaderStat('Liyakat Skoru', '85/100'),
                      _buildHeaderStat('Görüntüleme', '1.2K'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.description_outlined, size: 18),
                    label: const Text('Live CV\'yi İndir'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003EC7),
                      minimumSize: const Size(double.infinity, 45),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Experience Timeline
            _buildSection(
              'Deneyim Kronolojisi',
              Column(
                children: [
                  _buildTimelineItem(
                    'Senior Product Designer',
                    'Spotify • Stockholm, SE',
                    'Ocak 2022 - Günümüz',
                    'UX/UI süreçlerini yönetiyor, tasarım sistemini geliştiriyorum.',
                    true,
                  ),
                  _buildTimelineItem(
                    'Product Designer',
                    'Airbnb • Remote',
                    'Mart 2020 - Aralık 2021',
                    'Mobil uygulama deneyimini iyileştiren projelerde görev aldım.',
                    false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Education Section
            _buildSection(
              'Eğitim',
              _buildSimpleItem(
                'Endüstriyel Tasarım',
                'Orta Doğu Teknik Üniversitesi',
                '2014 - 2018',
                Icons.school_outlined,
              ),
            ),
            const SizedBox(height: 8),

            // Skills & Endorsements
            _buildSection(
              'Yetenek Onayları',
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildSkillChip('UI/UX Design', '42'),
                  _buildSkillChip('Figma', '38'),
                  _buildSkillChip('Product Thinking', '25'),
                  _buildSkillChip('User Research', '19'),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(color: Color(0xFF666666), fontSize: 12)),
      ],
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF666666)),
            ],
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String title, String company, String date, String desc, bool isCurrent) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: isCurrent ? const Color(0xFF003EC7) : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF003EC7), width: 2),
              ),
            ),
            Container(
              width: 2,
              height: 70,
              color: const Color(0xFFEEEEEE),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text(company, style: const TextStyle(color: Color(0xFF003EC7), fontSize: 13, fontWeight: FontWeight.w500)),
              Text(date, style: const TextStyle(color: Color(0xFF666666), fontSize: 12)),
              const SizedBox(height: 8),
              Text(desc, style: const TextStyle(color: Color(0xFF666666), fontSize: 13)),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSimpleItem(String title, String subtitle, String date, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF666666)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(subtitle, style: const TextStyle(color: Color(0xFF666666), fontSize: 13)),
              Text(date, style: const TextStyle(color: Color(0xFF999999), fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String skill, String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(skill, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          const SizedBox(width: 6),
          Text(
            count,
            style: const TextStyle(fontSize: 11, color: Color(0xFF003EC7), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
