import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2EF), // LinkedIn style gray background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.network(
          'https://lh3.googleusercontent.com/aida/ADBb0ui6KVrYrRA7U3VTA5a-FEciPyigrd2NoJpc8hnw5Bcs1mWiiosaWDEhUq86TfR0qA7C434myFIK1u6baB-es8yI9TqQs-d3jepof49qNDAirjRYC1L1c69z9KxYtwtGObwm_QrEQC5iozsBrflGl-0Mcdz89grGB0-A-sUDcJ0JqYV2mU5HnhvrhTSuhkV80JUCDqpyWva3Nr7XoSpKLsJXCuaV3CfFRp0rPwOIyQUDdAwjYzax9hHSkhUkvJXQoNy73V8o4rY2',
          height: 24,
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF666666)),
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
            // Header Section
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFF003EC7), Color(0xFF38DEBB)],
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuAYZvGaaE87JFMLcbHDaXzFAvz3XWJQnaXwqOa13iCNr-IH_Hd8LQdnNITa8F5E3SPAddrz_wNKb_hqWoVN4SqCGQPwXNvYgdeL97bHoMBr6ZDqEIzbs88PH9IZlurenTPL2LTl6Oc78SCFFCOe7jOmFA7lEYvsLjZinSt4-1f_bG0S_B4foikB5zelGwRypiq5cx2hixUMMgbxPv_2V8cX6sgGX4sal5QoZP5Fcfo3Idb4FwaDwQB53EzZYf7qWa8fWddRZIkNCm0'),
                        ),
                      ),
                      const CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.verified, color: Color(0xFF003EC7), size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Caner Demir',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF191C1E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Senior Product Designer & Merit Analyst',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF003EC7).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF003EC7).withOpacity(0.1)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shield_outlined, size: 16, color: Color(0xFF003EC7)),
                        SizedBox(width: 8),
                        Text(
                          'VERIFY ROZETİ AKTİF',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF003EC7),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Experience Section
            _buildSection(
              title: 'Deneyim',
              icon: Icons.work_outline,
              child: Column(
                children: [
                  _buildTimelineItem(
                    title: 'Senior Designer',
                    subtitle: 'TechLab Global • 2021 - Günümüz',
                    isLast: false,
                    isCurrent: true,
                  ),
                  _buildTimelineItem(
                    title: 'Product Designer',
                    subtitle: 'Creative Sync • 2018 - 2021',
                    isLast: true,
                    isCurrent: false,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Merit Scores Section
            _buildSection(
              title: 'Liyakat Skorları (Merit Lab)',
              icon: Icons.analytics_outlined,
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.5,
                children: [
                  _buildScoreCard('Teknik Beceri', '85/100', Colors.blue),
                  _buildScoreCard('Sosyal Uyum', '92/100', Colors.green),
                  _buildScoreCard('Analitik Zeka', '88/100', Colors.purple),
                  _buildScoreCard('Liderlik', '78/100', Colors.orange),
                ],
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Endorsements
            _buildSection(
              title: 'Yetenek Onayları',
              icon: Icons.stars_outlined,
              child: Column(
                children: [
                  _buildEndorsementItem('Ece Karahan', 'Design Director @ StudioX', 'Onaylandı'),
                  const Divider(height: 1, thickness: 0.5),
                  _buildEndorsementItem('Aslı Yılmaz', 'CTO @ Innovate', 'Beklemede'),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Profile selected
        selectedItemColor: const Color(0xFF003EC7),
        unselectedItemColor: const Color(0xFF666666),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'Keşfet'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome_outlined), label: 'Gelişim'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        onTap: (index) {
           // Navigation logic will be added here
        },
      ),
    );
  }

  Widget _buildSection({required String title, required IconData icon, required Widget child}) {
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
              Row(
                children: [
                  Icon(icon, size: 20, color: const Color(0xFF191C1E)),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF191C1E),
                    ),
                  ),
                ],
              ),
              const Icon(Icons.edit_outlined, size: 20, color: Color(0xFF666666)),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildTimelineItem({required String title, required String subtitle, required bool isLast, required bool isCurrent}) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrent ? const Color(0xFF003EC7) : const Color(0xFFC3C5D9),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1,
                    color: const Color(0xFFC3C5D9),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Color(0xFF666666), fontSize: 13),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard(String title, String score, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 11, color: Color(0xFF666666))),
          Text(score, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildEndorsementItem(String name, String role, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFF3F2EF),
            child: Text(name[0], style: const TextStyle(color: Color(0xFF666666))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(role, style: const TextStyle(fontSize: 12, color: Color(0xFF666666))),
              ],
            ),
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: status == 'Onaylandı' ? Colors.green : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
