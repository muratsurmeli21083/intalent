import 'package:flutter/material.dart';
import '../services/database_service.dart';

class JobWizardScreen extends StatefulWidget {
  const JobWizardScreen({super.key});

  @override
  State<JobWizardScreen> createState() => _JobWizardScreenState();
}

class _JobWizardScreenState extends State<JobWizardScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedLocation = 'Uzaktan (Remote)';
  String _selectedSeniority = 'Junior';
  
  // Liyakat Ağırlıkları (Merit Weights)
  final Map<String, int> _weights = {
    'SAYISAL MANTIK': 15,
    'SÖZEL MANTIK': 15,
    'SOYUT MANTIK': 15,
    'İNGİLİZCE': 15,
    'KİŞİLİK': 15,
    'MOTİVASYON': 25,
  };

  int get _totalWeight => _weights.values.fold(0, (sum, val) => sum + val);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF003EC7)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('İLAN SİHİRBAZI', style: TextStyle(color: Color(0xFF1A1F36), fontWeight: FontWeight.bold, fontSize: 16)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey, size: 20),
                const SizedBox(width: 20),
                const Icon(Icons.notifications_none, color: Colors.grey),
                const SizedBox(width: 20),
                CircleAvatar(backgroundColor: const Color(0xFF003EC7), radius: 14, child: const Text('ML', style: TextStyle(fontSize: 10, color: Colors.white))),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBreadcrumb(),
            const SizedBox(height: 12),
            const Text('İLAN SİHİRBAZI', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF1A1F36), letterSpacing: -1)),
            const Text('YAPAY ZEKA DESTEKLİ MERİT PUANLAMASI İÇİN KRİTERLERİNİZİ BELİRLEYİN.', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _buildLeftPanel()),
                const SizedBox(width: 40),
                Expanded(flex: 2, child: _buildRightPanel()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreadcrumb() {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Row(
        children: [
          const Icon(Icons.chevron_left, color: Colors.grey, size: 16),
          const SizedBox(width: 4),
          Text('İLAN YÖNETİMİNE DÖN', style: TextStyle(color: Colors.grey[600], fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildLeftPanel() {
    return Column(
      children: [
        _buildSectionCard(
          icon: Icons.edit_outlined,
          title: 'TEMEL BİLGİLER',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel('İLAN BAŞLIĞI'),
              _buildTextField(_titleController, 'Örn: Senior Frontend Developer'),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLabel('İŞ TANIMI'),
                  _buildAiButton(),
                ],
              ),
              _buildTextField(_descriptionController, 'Rolün gerekliliklerini ve sorumluluklarını buraya yazın...', maxLines: 6),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('KONUM'),
                      _buildDropdown(['Uzaktan (Remote)', 'İstanbul', 'Ankara'], _selectedLocation, (v) => setState(() => _selectedLocation = v!)),
                    ],
                  )),
                  const SizedBox(width: 20),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('KIDEM SEVİYESİ'),
                      _buildDropdown(['Junior', 'Mid', 'Senior', 'Lead'], _selectedSeniority, (v) => setState(() => _selectedSeniority = v!)),
                    ],
                  )),
                ],
              ),
              const SizedBox(height: 24),
              _buildLabel('SON BAŞVURU TARİHİ (DEADLINE)'),
              _buildTextField(TextEditingController(text: 'gg.aa.yyyy'), '', suffixIcon: Icons.calendar_today_outlined),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildSectionCard(
          icon: Icons.auto_awesome,
          title: 'BİLGİ TESTİ (KNOWLEDGE TEST) KÜTÜPHANESİ',
          content: Container(
            height: 100,
            alignment: Alignment.center,
            child: Text('TEST KÜTÜPHANESİ YÜKLENİYOR...', style: TextStyle(color: Colors.grey[400], fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildRightPanel() {
    return Column(
      children: [
        _buildSectionCard(
          icon: Icons.track_changes,
          title: 'LİYAKAT AĞIRLIKLARI',
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFF00C853), borderRadius: BorderRadius.circular(20)),
            child: Text('TOPLAM %$_totalWeight', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          content: Column(
            children: [
              Text('CORE METRICS (BİLİŞSEL & KİŞİLİK)', style: TextStyle(color: Colors.grey[400], fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
              const SizedBox(height: 20),
              ..._weights.entries.map((e) => _buildWeightItem(e.key, e.value)),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFEDF2FF), borderRadius: BorderRadius.circular(12)),
                child: const Text(
                  'SEÇİLEN TESTLERİN TOPLAM AĞIRLIĞI TAM %100 OLMALIDIR.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF003EC7), fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: _totalWeight == 100 ? () {} : null,
            icon: const Icon(Icons.rocket_launch_outlined),
            label: const Text('İLANI YAYINLA', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B9FED),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {},
          child: Text('TASLAK OLARAK KAYDET', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1.2)),
        ),
      ],
    );
  }

  Widget _buildSectionCard({required IconData icon, required String title, required Widget content, Widget? trailing}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 40, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF003EC7), size: 24),
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF003EC7))),
              const Spacer(),
              if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 32),
          content,
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: TextStyle(color: Colors.grey[400], fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1, IconData? suffixIcon}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[300], fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.grey[400], size: 18) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildDropdown(List<String> items, String value, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildAiButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: const Color(0xFFF0F2FF), borderRadius: BorderRadius.circular(20)),
      child: const Row(
        children: [
          Icon(Icons.auto_awesome, color: Color(0xFF003EC7), size: 12),
          SizedBox(width: 4),
          Text('AI İLE OLUŞTUR', style: TextStyle(color: Color(0xFF003EC7), fontSize: 9, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildWeightItem(String title, int value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F4F9)),
      ),
      child: Row(
        children: [
          const Icon(Icons.computer, color: Color(0xFF003EC7), size: 18),
          const SizedBox(width: 12),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF1A1F36))),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(value: value / 100, backgroundColor: const Color(0xFFF1F4F9), valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF003EC7)), minHeight: 4),
              ),
            ],
          )),
          const SizedBox(width: 20),
          Text('%', style: TextStyle(color: Colors.grey[400], fontSize: 10)),
          const SizedBox(width: 4),
          Text(value.toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF003EC7))),
        ],
      ),
    );
  }
}
