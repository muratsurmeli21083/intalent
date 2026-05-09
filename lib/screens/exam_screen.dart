import 'package:flutter/material.dart';
import 'dart:async';
import '../services/database_service.dart';
import '../models/app_models.dart';

class ExamScreen extends StatefulWidget {
  final String title;

  const ExamScreen({super.key, required this.title});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final DatabaseService _dbService = DatabaseService();
  int _currentQuestionIndex = 0;
  int _timeLeft = 360; 
  Timer? _timer;
  String? _selectedOptionKey;
  List<QuestionModel> _dynamicQuestions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      final allQuestions = await _dbService.getQuestions();
      setState(() {
        _dynamicQuestions = (allQuestions..shuffle()).take(25).toList();
        _isLoading = false;
      });
      _startTimer();
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
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
    if (_currentQuestionIndex < _dynamicQuestions.length - 1) {
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
        builder: (context) => ExamResultScreen(examTitle: widget.title),
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
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_dynamicQuestions.isEmpty) return Scaffold(appBar: AppBar(title: Text(widget.title)), body: const Center(child: Text('Soru yok.')));

    final question = _dynamicQuestions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Center(child: Padding(padding: const EdgeInsets.only(right: 16), child: Text(_formatTime(_timeLeft)))),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(question.content, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            ...question.options.entries.map((e) => _buildOption(e.key, e.value.toString())),
            const Spacer(),
            ElevatedButton(
              onPressed: _selectedOptionKey != null ? _nextQuestion : null,
              child: const Text('Sonraki'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String key, String text) {
    bool isSelected = _selectedOptionKey == key;
    return ListTile(
      title: Text(text),
      leading: Radio<String>(
        value: key,
        groupValue: _selectedOptionKey,
        onChanged: (v) => setState(() => _selectedOptionKey = v),
      ),
    );
  }
}

class ExamResultScreen extends StatelessWidget {
  final String examTitle;
  const ExamResultScreen({super.key, required this.examTitle});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('$examTitle Tamamlandı')));
  }
}
