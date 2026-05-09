import 'package:flutter/material.dart';

class JobDetailScreen extends StatelessWidget {
  final String title;
  final String company;
  final String location;

  const JobDetailScreen({
    super.key,
    required this.title,
    required this.company,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined, color: Colors.black), onPressed: () {}),
          IconButton(icon: const Icon(Icons.bookmark_border, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F2EF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.business, size: 40, color: Color(0xFF003EC7)),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$company • $location',
                    style: const TextStyle(fontSize: 16, color: Color(0xFF003EC7), fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '2 gün önce yayınlandı • 45 başvuru',
                    style: TextStyle(color: Color(0xFF666666), fontSize: 13),
                  ),
                ],
              ),
            ),

            // AI Merit Requirement Box
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEFEF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFFD1D1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.warning_amber_rounded, color: Color(0xFFD32F2F), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'BAŞVURU İÇİN EKSİK ADIM',
                        style: TextStyle(color: Color(0xFFD32F2F), fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Bu pozisyona başvurabilmek için önce şu testi çözmelisin:',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD32F2F),
                      minimumSize: const Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('UI/UX Merit Değerlendirmesini Başlat'),
                  ),
                ],
              ),
            ),

            // Job Description
            _buildSectionTitle('İş Açıklaması'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'intalent bünyesinde, veri odaklı yetenek doğrulama platformumuzun gelecek nesil arayüzlerini tasarlayacak vizyoner bir Senior Product Designer arıyoruz. Karmaşık veri setlerini basitleştirecek, "Bento Grid" estetiğine hakim ve kullanıcı deneyimini en üst seviyeye taşıyacak bir ekip arkadaşı bekliyoruz.',
                style: TextStyle(fontSize: 15, height: 1.6, color: Color(0xFF444444)),
              ),
            ),

            // Requirements
            _buildSectionTitle('Aranan Yetkinlikler'),
            _buildRequirementItem(Icons.history, 'Min. 5 Yıl Deneyim', 'SaaS veya Fintech tecrübesi.'),
            _buildRequirementItem(Icons.language, 'İleri Seviye İngilizce', 'Global ekiplerle iletişim.'),
            _buildRequirementItem(Icons.psychology, 'Tasarım Sistemleri', 'Figma ve Design Ops tecrübesi.'),

            const SizedBox(height: 100), // Bottom space for fixed button
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4)),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: null, // Disabled because of missing merit test
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003EC7),
                    minimumSize: const Size(double.infinity, 50),
                    disabledBackgroundColor: const Color(0xFFCCCCCC),
                  ),
                  child: const Text('Başvuruyu Tamamla'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRequirementItem(IconData icon, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: const Color(0xFF003EC7)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(desc, style: const TextStyle(color: Color(0xFF666666), fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
