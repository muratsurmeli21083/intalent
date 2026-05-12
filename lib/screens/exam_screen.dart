import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import '../services/database_service.dart';
import '../models/app_models.dart';

class ExamScreen extends StatefulWidget {
  final String title;
  final String? taskId; // Supabase task ID - opsiyonel

  const ExamScreen({super.key, required this.title, this.taskId});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final DatabaseService _dbService = DatabaseService();
  int _currentQuestionIndex = 0;
  int _timeLeft = 1200; // 20 dakika
  Timer? _timer;
  String? _selectedOptionKey;
  List<QuestionModel> _questions = [];
  bool _isLoading = true;
  String? _errorMessage;
  int _correctCount = 0;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      List<QuestionModel> allQuestions;
      if (widget.taskId != null) {
        allQuestions = await _dbService.getQuestionsByTaskId(widget.taskId!);
      } else {
        allQuestions = await _dbService.getQuestions();
      }

      if (allQuestions.isEmpty) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'empty'; // Özel boşluk durumu
        });
        return;
      }

      setState(() {
        _questions = (allQuestions..shuffle()).take(25).toList();
        _isLoading = false;
      });
      _startTimer();
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
        });
      }
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        if (mounted) setState(() => _timeLeft--);
      } else {
        _finishExam();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _nextQuestion() {
    final q = _questions[_currentQuestionIndex];
    if (_selectedOptionKey == q.correctAnswer) _correctCount++;

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionKey = null;
      });
    } else {
      _finishExam();
    }
  }

  void _finishExam() {
    _timer?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ExamResultScreen(
          examTitle: widget.title,
          correct: _correctCount,
          total: _questions.length,
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    int mins = seconds ~/ 60;
    int secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFFF7F9FB),
        body: const Center(child: CircularProgressIndicator(color: Color(0xFF003EC7))),
      );
    }

    if (_errorMessage == 'empty') {
      return _buildEmptyState();
    }

    if (_errorMessage != null) {
      return Scaffold(
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text('Bağlantı hatası: $_errorMessage', textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () { setState(() { _isLoading = true; _errorMessage = null; }); _loadQuestions(); }, child: const Text('Tekrar Dene')),
          ],
        )),
      );
    }

    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(widget.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF191C1E))),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.close, color: Colors.grey), onPressed: () => Navigator.pop(context)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _timeLeft < 120 ? Colors.red.shade50 : const Color(0xFFDDE1FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _formatTime(_timeLeft),
              style: TextStyle(
                color: _timeLeft < 120 ? Colors.red : const Color(0xFF003EC7),
                fontWeight: FontWeight.bold, fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _questions.length,
            backgroundColor: const Color(0xFFE0E3E5),
            color: const Color(0xFF003EC7),
            minHeight: 3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Soru ${_currentQuestionIndex + 1} / ${_questions.length}', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                if (question.category.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFFDDE1FF), borderRadius: BorderRadius.circular(20)),
                    child: Text(question.category, style: const TextStyle(color: Color(0xFF003EC7), fontSize: 10, fontWeight: FontWeight.w700)),
                  ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question.content, style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w600, height: 1.5, color: const Color(0xFF191C1E))),
                  const SizedBox(height: 28),
                  ...question.options.entries.map((e) => _buildOption(e.key, e.value.toString())),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: SizedBox(
              width: double.infinity, height: 54,
              child: ElevatedButton(
                onPressed: _selectedOptionKey != null ? _nextQuestion : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003EC7),
                  disabledBackgroundColor: const Color(0xFFE0E3E5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: Text(
                  _currentQuestionIndex < _questions.length - 1 ? 'Sonraki Soru →' : 'Testi Bitir',
                  style: TextStyle(
                    color: _selectedOptionKey != null ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.w700, fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String key, String text) {
    bool isSelected = _selectedOptionKey == key;
    return GestureDetector(
      onTap: () => setState(() => _selectedOptionKey = key),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF003EC7) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? const Color(0xFF003EC7) : const Color(0xFFE0E3E5), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 30, height: 30,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.2) : const Color(0xFFDDE1FF),
                shape: BoxShape.circle,
              ),
              child: Center(child: Text(key, style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF003EC7), fontWeight: FontWeight.bold, fontSize: 13))),
            ),
            const SizedBox(width: 14),
            Expanded(child: Text(text, style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF191C1E), fontSize: 14, height: 1.4))),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF191C1E),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 48),
            const SizedBox(height: 16),
            const Text('Bu test için henüz soru eklenmemiş.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF191C1E))),
            const SizedBox(height: 12),
            Text('Supabase Dashboard → Table Editor → questions tablosuna aşağıdaki formata göre soru ekleyin:', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF0A192F), borderRadius: BorderRadius.circular(12)),
              child: const SelectableText(
                '''-- 1. Önce questions tablosunda bir task oluşturun:
-- (tasks tablosu mevcut değilse setup.sql çalıştırın)

-- 2. questions tablosuna örnek soru eklemek için:
INSERT INTO public.questions 
  (category, content, options, correct_answer, points)
VALUES 
  (
    'Sayısal',
    '15 + 7 × 2 = ?',
    \'{"A": "44", "B": "29", "C": "22", "D": "34"}\',
    'B',
    1
  ),
  (
    'Sayısal', 
    'Bir trenin hızı saatte 90 km dir. 2 saatte kaç km gider?',
    \'{"A": "45", "B": "180", "C": "270", "D": "90"}\',
    'B',
    1
  ),
  (
    'Sözel',
    '"Mütevazı" kelimesinin zıt anlamlısı hangisidir?',
    \'{"A": "Kibar", "B": "Alçakgönüllü", "C": "Mağrur", "D": "Sakin"}\',
    'C',
    1
  );

-- NOT: task_id ve tenant_id olmadan ekleyebilirsiniz,
-- sistem tüm soruları çekip karıştırır.''',
                style: TextStyle(color: Color(0xFF62FED9), fontFamily: 'monospace', fontSize: 12, height: 1.5),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Geri Dön'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF003EC7), foregroundColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class ExamResultScreen extends StatelessWidget {
  final String examTitle;
  final int correct;
  final int total;

  const ExamResultScreen({super.key, required this.examTitle, required this.correct, required this.total});

  @override
  Widget build(BuildContext context) {
    final score = total > 0 ? (correct / total * 100).toInt() : 0;
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF003EC7), size: 72),
              const SizedBox(height: 24),
              Text('$examTitle Tamamlandı!', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)), textAlign: TextAlign.center),
              const SizedBox(height: 12),
              Text('$correct / $total soru doğru', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
              const SizedBox(height: 8),
              Text('Skor: %$score', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF003EC7))),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF003EC7), foregroundColor: Colors.white, minimumSize: const Size(200, 54), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                child: const Text('Ana Sayfaya Dön', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
