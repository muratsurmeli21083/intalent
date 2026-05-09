import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2EF),
      appBar: AppBar(
        title: const Text('Profil'),
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
                      // Verified Badge
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.verified, color: Color(0xFF003EC7), size: 24),
                        ),
                      ),
                      // Edit Image Button
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            // Image picker logic here
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF003EC7),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.camera_alt, color: Colors.white, size: 14),
                          ),
                        ),
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
                    icon: const Icon(Icons.cloud_upload_outlined, size: 18),
                    label: const Text('CV Yükle/Güncelle'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003EC7),
                      minimumSize: const Size(double.infinity, 45),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Career Section
            _buildSection(
              'Kariyer',
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

            // Certificates Section
            _buildSection(
              'Sertifikalar',
              Column(
                children: [
                  _buildSimpleItem(
                    'Google UX Design Professional Certificate',
                    'Coursera • Google',
                    '2021',
                    Icons.workspace_premium_outlined,
                  ),
                  const SizedBox(height: 12),
                  _buildSimpleItem(
                    'Advanced Design Systems',
                    'Design+Code',
                    '2022',
                    Icons.workspace_premium_outlined,
                  ),
                ],
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
            const SizedBox(height: 8),

            // Interests Section
            _buildSection(
              'İlgi Alanları',
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildSimpleChip('Generative AI'),
                  _buildSimpleChip('Fintech'),
                  _buildSimpleChip('Sustainable Design'),
                  _buildSimpleChip('Motion Graphics'),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // References Section
            _buildSection(
              'Referanslar',
              Column(
                children: [
                  _buildReferenceItem(
                    'Ahmet Yılmaz',
                    'Design Director @ Spotify',
                    'Deniz ile çalışmak büyük bir keyifti. Vizyoner ve teknik becerisi yüksek bir tasarımcı.',
                    true,
                  ),
                  const Divider(height: 24),
                  _buildReferenceItem(
                    'Sarah Connor',
                    'Lead Developer @ Airbnb',
                    'Harika bir takım oyuncusu. Tasarımları her zaman geliştirilebilir ve kullanıcı odaklı.',
                    false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 13, color: Color(0xFF666666)),
      ),
    );
  }

  Widget _buildReferenceItem(String name, String title, String quote, bool isVerified) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(width: 8),
                      if (isVerified)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.check_circle, size: 10, color: Colors.green),
                              SizedBox(width: 4),
                              Text('Onaylandı', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                    ],
                  ),
                  Text(title, style: const TextStyle(color: Color(0xFF003EC7), fontSize: 12, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 16, color: Color(0xFFCCCCCC)),
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '"$quote"',
          style: const TextStyle(color: Color(0xFF666666), fontSize: 13, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 12),
        if (!isVerified)
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF003EC7)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              minimumSize: const Size(0, 30),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: const Text(
              'ONAY İSTE',
              style: TextStyle(color: Color(0xFF003EC7), fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
      ],
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
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF003EC7).withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, size: 18, color: Color(0xFF003EC7)),
              ),
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
              height: 85,
              color: const Color(0xFFEEEEEE),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  const Icon(Icons.edit_outlined, size: 16, color: Color(0xFFCCCCCC)),
                ],
              ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  ),
                  const Icon(Icons.edit_outlined, size: 16, color: Color(0xFFCCCCCC)),
                ],
              ),
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
