import 'package:flutter/material.dart';
import 'exam_screen.dart';
import 'kisilik_envanteri_screen.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});
// ... rest of the imports and class definition ...

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
              child: const Column(
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
                          backgroundColor: Color(0xFFEEEEEE),
                          color: Color(0xFF003EC7),
                        ),
                      ),
                      Column(
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
                  SizedBox(height: 16),
                  Text(
                    'Profil Analiz Gücü',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
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
              _buildTestItem(context, 'SAYISAL MUHAKEME', '5 DK', Icons.calculate_outlined),
              _buildTestItem(context, 'SÖZEL MUHAKEME', '5 DK', Icons.translate_outlined),
              _buildTestItem(context, 'MANTIKSAL MUHAKEME', '5 DK', Icons.psychology_outlined),
              _buildTestItem(context, 'İNGİLİZCE', '5 DK', Icons.language_outlined),
              _buildTestItem(context, 'MOTİVASYON ENVANTERİ', 'SÜRE SINIRI YOK', Icons.trending_up_outlined),
              _buildTestItem(context, 'KİŞİLİK ENVANTERİ (OCEAN)', 'SÜRE SINIRI YOK', Icons.person_search_outlined),
            ]),

            // Uzmanlık Section
            _buildSectionTitle('Uzmanlık Bilgi Beceriler'),
            _buildTestList([
              _buildExpertItem(context, 'JAVA TEMELLERİ', 'EXPERTISE', Icons.code),
              _buildExpertItem(context, 'İLERİ SEVİYE SQL', 'EXPERTISE', Icons.storage),
              _buildExpertItem(context, 'SATIŞ VE İKNA BECERİLERİ', 'EXPERTISE', Icons.handshake_outlined),
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
    List<Widget> separatedItems = [];
    for (int i = 0; i < items.length; i++) {
      separatedItems.add(items[i]);
      if (i < items.length - 1) {
        separatedItems.add(const Divider(height: 1, indent: 56, endIndent: 16, color: Color(0xFFEEEEEE)));
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(children: separatedItems),
    );
  }

  Widget _buildTestItem(BuildContext context, String title, String duration, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF666666), size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        subtitle: Text(duration, style: const TextStyle(fontSize: 11, color: Color(0xFF999999))),
        trailing: _buildStartButton(context, title),
        onTap: () => _navigateToExam(context, title),
      ),
    );
  }

  Widget _buildExpertItem(BuildContext context, String title, String type, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF003EC7).withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF003EC7), size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        subtitle: Text(type, style: const TextStyle(color: Color(0xFF003EC7), fontSize: 10, fontWeight: FontWeight.bold)),
        trailing: _buildStartButton(context, title),
        onTap: () => _navigateToExam(context, title),
      ),
    );
  }

  void _navigateToExam(BuildContext context, String title) {
    if (title == 'KİŞİLİK ENVANTERİ (OCEAN)') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const KisilikEnvanteriScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ExamScreen(title: title)),
      );
    }
  }

  Widget _buildStartButton(BuildContext context, String title) {
    return InkWell(
      onTap: () => _navigateToExam(context, title),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF003EC7).withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Text(
          'Başla',
          style: TextStyle(
            color: Color(0xFF003EC7),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
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


