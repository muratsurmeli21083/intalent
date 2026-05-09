import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart' as excel_pkg;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildMainContent()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 260,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.auto_awesome, color: Color(0xFF003EC7), size: 32),
              const SizedBox(width: 12),
              const Text('intalent', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF003EC7))),
            ],
          ),
          const SizedBox(height: 40),
          _buildSidebarItem(0, Icons.dashboard_outlined, 'Yetenek Analiz Merkezi'),
          _buildSidebarItem(1, Icons.people_outline, 'Aday Havuzu'),
          _buildSidebarItem(2, Icons.work_outline, 'İlan Yönetimi'),
          _buildSidebarItem(3, Icons.library_books_outlined, 'Ölçme & Değerlendirme'),
          const Spacer(),
          _buildSidebarItem(4, Icons.settings_outlined, 'Ayarlar'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF003EC7).withOpacity(0.05) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF003EC7) : Colors.grey, size: 20),
            const SizedBox(width: 12),
            Text(label, style: TextStyle(color: isSelected ? const Color(0xFF003EC7) : Colors.grey[700], fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      color: Colors.white,
      child: Row(
        children: [
          const Text('Yetenek Analiz Merkezi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: _isUploading ? null : _pickAndUploadExcel,
            icon: _isUploading 
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Icon(Icons.upload_file),
            label: Text(_isUploading ? 'Yükleniyor...' : 'Soru Yükle (Excel)'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF003EC7), foregroundColor: Colors.white),
          ),
          const SizedBox(width: 24),
          const CircleAvatar(backgroundColor: Color(0xFF003EC7), child: Text('İK', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Row(
            children: [
              _buildStatCard('Toplam Aday', '342', '+%12', Icons.people, Colors.blue),
              const SizedBox(width: 24),
              _buildStatCard('Aktif İlanlar', '4', 'Sabit', Icons.work, Colors.orange),
              const SizedBox(width: 24),
              _buildStatCard('Tamamlanan Testler', '24', '+%5', Icons.assignment, Colors.green),
              const SizedBox(width: 24),
              _buildStatCard('Yeni Başvurular', '8', 'Bugün', Icons.fiber_new, Colors.purple),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, String change, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color),
                Text(change, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text(label, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
