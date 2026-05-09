import 'package:flutter/material.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2EF),
      appBar: AppBar(
        title: const Text('Analiz Merkezi'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall Completion Header
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: 0.85,
                          strokeWidth: 8,
                          backgroundColor: const Color(0xFFEEEEEE),
                          color: const Color(0xFF003EC7),
                        ),
                      ),
                      const Column(
                        children: [
                          Text(
                            '%85',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF003EC7),
                            ),
                          ),
                          Text(
                            'Tamamlandı',
                            style: TextStyle(fontSize: 10, color: Color(0xFF666666)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Profil Analiz Gücü',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Testleri tamamlayarak liyakat skorunu artır.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF666666)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Temel Analiz Section
            _buildSectionTitle('Temel Analiz'),
            _buildTestList([
              _buildTestItem('SAYISAL MUHAKEME', '5 DK', Icons.calculate_outlined),
              _buildTestItem('SÖZEL MUHAKEME', '5 DK', Icons.translate_outlined),
              _buildTestItem('MANTIKSAL MUHAKEME', '5 DK', Icons.psychology_outlined),
              _buildTestItem('İNGİLİZCE', '5 DK', Icons.language_outlined),
              _buildTestItem('MOTİVASYON ENVANTERİ', 'SÜRE SINIRI YOK', Icons.trending_up_outlined),
              _buildTestItem('KİŞİLİK ENVANTERİ (OCEAN)', 'SÜRE SINIRI YOK', Icons.person_search_outlined),
            ]),

            // Uzmanlık Section
            _buildSectionTitle('Uzmanlık Bilgi Beceriler'),
            _buildTestList([
              _buildExpertItem('JAVA TEMELLERİ', 'EXPERTISE', Icons.code),
              _buildExpertItem('İLERİ SEVİYE SQL', 'EXPERTISE', Icons.storage),
              _buildExpertItem('SATIŞ VE İKNA BECERİLERİ', 'EXPERTISE', Icons.handshake_outlined),
            ]),

            // Mülakat Lab Section
            _buildSectionTitle('Mülakat Lab (AI Interview)'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEEEEEE)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF003EC7).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.videocam_outlined, color: Color(0xFF003EC7)),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Yapay Zeka Mülakatı',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Simüle edilmiş gerçek mülakat deneyimi ile kendini geliştir.',
                      style: TextStyle(color: Color(0xFF666666)),
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInterviewMeta('SON SEANS', '12 MART 2024'),
                        _buildInterviewMeta('PERFORMANS', '%92'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF003EC7),
                        minimumSize: const Size(double.infinity, 45),
                      ),
                      child: const Text('Mülakatı Başlat'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTestList(List<Widget> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(children: items),
    );
  }

  Widget _buildTestItem(String title, String duration, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF666666)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text(duration, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right, color: Color(0xFFCCCCCC)),
      onTap: () {},
    );
  }

  Widget _buildExpertItem(String title, String type, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF003EC7)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xFF003EC7).withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          type,
          style: const TextStyle(color: Color(0xFF003EC7), fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
      trailing: const Icon(Icons.play_circle_outline, color: Color(0xFF003EC7)),
      onTap: () {},
    );
  }

  Widget _buildInterviewMeta(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF999999), fontSize: 10, fontWeight: FontWeight.bold)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }
}
