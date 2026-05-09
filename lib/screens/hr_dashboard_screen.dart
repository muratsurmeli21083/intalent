import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' as excel_pkg;
import 'package:fl_chart/fl_chart.dart';
import '../services/database_service.dart';
import '../models/app_models.dart';

class HrDashboardScreen extends StatefulWidget {
  const HrDashboardScreen({super.key});

  @override
  State<HrDashboardScreen> createState() => _HrDashboardScreenState();
}

class _HrDashboardScreenState extends State<HrDashboardScreen> {
  final DatabaseService _dbService = DatabaseService();
  int _selectedIndex = 0;
  bool _isUploading = false;

  // Mock data for initial look, will be replaced by FutureBuilders
  final Map<String, dynamic> _stats = {
    'totalCandidates': 0,
    'activeJobs': 0,
    'completedTests': 0,
    'newApplications': 0,
  };

  @override
  void initState() {
    super.initState();
    _fetchStats();
  }

  Future<void> _fetchStats() async {
    try {
      final candidateCount = await _dbService.getCandidateCount();
      final jobCount = await _dbService.getJobCount();
      
      if (mounted) {
        setState(() {
          _stats['totalCandidates'] = candidateCount;
          _stats['activeJobs'] = jobCount;
        });
      }
    } catch (e) {
      debugPrint('Stat Fetch Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildBodyContent(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF003EC7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              const Text(
                'InTalent',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF003EC7), letterSpacing: -0.5),
              ),
            ],
          ),
          const SizedBox(height: 48),
          _buildSidebarItem(0, Icons.grid_view_rounded, 'Dashboard'),
          _buildSidebarItem(1, Icons.people_alt_rounded, 'Aday Havuzu'),
          _buildSidebarItem(2, Icons.work_rounded, 'İlan Yönetimi'),
          _buildSidebarItem(3, Icons.analytics_rounded, 'Yetenek Analizi'),
          _buildSidebarItem(4, Icons.settings_rounded, 'Ayarlar'),
          const Spacer(),
          _buildLogoutBtn(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () => setState(() => _selectedIndex = index),
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF003EC7) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: isSelected ? Colors.white : Colors.grey[600], size: 22),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[800],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        children: [
          Text(
            _getSectionTitle(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A1F36)),
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: _isUploading ? null : _pickAndUploadExcel,
            icon: _isUploading 
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Icon(Icons.add_rounded),
            label: const Text('Yeni Soru Yükle'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF003EC7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
          ),
          const SizedBox(width: 24),
          _buildUserAction(),
        ],
      ),
    );
  }

  Widget _buildBodyContent() {
    switch (_selectedIndex) {
      case 0: return _buildDashboardView();
      case 1: return _buildCandidatesView();
      case 2: return _buildJobsView();
      case 3: return _buildAnalyticsView();
      default: return const Center(child: Text('Geliştirme Aşamasında'));
    }
  }

  // --- ADAY HAVUZU SAYFASI ---
  Widget _buildCandidatesView() {
    return FutureBuilder<List<UserProfile>>(
      future: _dbService.getAllCandidates(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        final candidates = snapshot.data ?? [];

        return Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Aday Havuzu', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                  child: ListView.separated(
                    itemCount: candidates.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final c = candidates[index];
                      return ListTile(
                        leading: CircleAvatar(child: Text(c.firstName?[0] ?? 'A')),
                        title: Text('${c.firstName ?? ''} ${c.lastName ?? ''}'),
                        subtitle: Text(c.email ?? ''),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- İLAN YÖNETİMİ SAYFASI ---
  Widget _buildJobsView() {
    return FutureBuilder<List<JobModel>>(
      future: _dbService.getAllJobs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        final jobs = snapshot.data ?? [];

        return Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Aktif İlanlar', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Yeni İlan Yayınla'),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF003EC7), foregroundColor: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                  ),
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    final job = jobs[index];
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(job.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(height: 8),
                          Text(job.position ?? 'Pozisyon Belirtilmedi', style: const TextStyle(color: Colors.grey)),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(job.city ?? 'Uzaktan', style: const TextStyle(fontWeight: FontWeight.w500)),
                              const Icon(Icons.more_vert, size: 20),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- ANALİZ SAYFASI ---
  Widget _buildAnalyticsView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.insights_rounded, size: 64, color: Color(0xFF003EC7)),
          SizedBox(height: 16),
          Text('Yetenek Analizleri', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('Adayların test sonuçları burada raporlanacak.', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildDashboardView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stat Cards
          Row(
            children: [
              _buildModernStatCard('Toplam Aday', _stats['totalCandidates'].toString(), Icons.people_outline, const Color(0xFF003EC7)),
              const SizedBox(width: 24),
              _buildModernStatCard('Aktif İlan', _stats['activeJobs'].toString(), Icons.work_outline, Colors.orange),
              const SizedBox(width: 24),
              _buildModernStatCard('Testler', '24', Icons.assignment_outlined, Colors.green),
              const SizedBox(width: 24),
              _buildModernStatCard('Yeni Başvuru', '8', Icons.notifications_none_rounded, Colors.purple),
            ],
          ),
          const SizedBox(height: 32),
          // Charts and Lists
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildActivityChart()),
              const SizedBox(width: 32),
              Expanded(flex: 1, child: _buildRecentApplicants()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20, offset: const Offset(0, 10))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 20),
            Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A1F36))),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityChart() {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Başvuru Trendi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [const FlSpot(0, 3), const FlSpot(2, 5), const FlSpot(4, 4), const FlSpot(6, 7), const FlSpot(8, 6)],
                    isCurved: true,
                    color: const Color(0xFF003EC7),
                    barWidth: 4,
                    belowBarData: BarAreaData(show: true, color: const Color(0xFF003EC7).withOpacity(0.1)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentApplicants() {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Son Başvurular', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              separatorBuilder: (context, index) => const Divider(height: 24),
              itemBuilder: (context, index) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(backgroundColor: Color(0xFFF0F2F5), child: Icon(Icons.person, color: Colors.grey)),
                title: Text('Aday ${index + 1}', style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Frontend Developer'),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getSectionTitle() {
    switch (_selectedIndex) {
      case 0: return 'Dashboard Genel Bakış';
      case 1: return 'Aday Havuzu Yönetimi';
      case 2: return 'Aktif İş İlanları';
      default: return 'Yönetim Paneli';
    }
  }

  Widget _buildUserAction() {
    return Row(
      children: [
        const Icon(Icons.notifications_none_rounded, color: Colors.grey),
        const SizedBox(width: 20),
        const VerticalDivider(width: 1, indent: 20, endIndent: 20),
        const SizedBox(width: 20),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Selim Murat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text('HR Manager', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        const SizedBox(width: 12),
        const CircleAvatar(backgroundColor: Color(0xFF003EC7), child: Text('SM', style: TextStyle(color: Colors.white))),
      ],
    );
  }

  Widget _buildLogoutBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        onTap: () => Navigator.pop(context),
        leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
        title: const Text('Çıkış Yap', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Future<void> _pickAndUploadExcel() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      withData: true,
    );

    if (result != null) {
      setState(() => _isUploading = true);
      try {
        var bytes = result.files.first.bytes!;
        var excel = excel_pkg.Excel.decodeBytes(bytes);
        
        for (var table in excel.tables.keys) {
          var sheet = excel.tables[table]!;
          for (int i = 1; i < sheet.maxRows; i++) {
            var row = sheet.rows[i];
            if (row.length < 7) continue;

            final category = row[0]?.value.toString() ?? '';
            final content = row[1]?.value.toString() ?? '';
            final options = {
              'A': row[2]?.value.toString() ?? '',
              'B': row[3]?.value.toString() ?? '',
              'C': row[4]?.value.toString() ?? '',
              'D': row[5]?.value.toString() ?? '',
            };
            final correct = row[6]?.value.toString() ?? '';

            await _dbService.insert('questions', {
              'category': category,
              'content': content,
              'options': options,
              'correct_answer': correct,
            });
          }
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sorular başarıyla yüklendi!')));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hata: $e')));
        }
      } finally {
        setState(() => _isUploading = false);
      }
    }
  }
}
