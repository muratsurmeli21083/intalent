import 'package:flutter/material.dart';

class AiCoachScreen extends StatefulWidget {
  const AiCoachScreen({super.key});

  @override
  State<AiCoachScreen> createState() => _AiCoachScreenState();
}

class _AiCoachScreenState extends State<AiCoachScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'isMe': false,
      'text': 'Merhaba! Ben senin AI Kariyer Danışmanınım. Kariyer yolculuğunda sana nasıl destek olabilirim?',
      'time': '09:41'
    },
  ];

  final List<String> suggestions = [
    'CV mi nasıl iyileştirebilirim?',
    'Mülakata nasıl hazırlanabilirim?',
    'Teknik becerilerimi nasıl kanıtlarım?',
    'Maaş pazarlığı nasıl yapılır?'
  ];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        'isMe': true,
        'text': text,
        'time': '${DateTime.now().hour}:${DateTime.now().minute}'
      });
      _messageController.clear();
    });
    
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'isMe': false,
            'text': 'Harika bir soru! Bu konuda sana yardımcı olabilmem için mevcut deneyimlerini biraz daha detaylandırabilir misin?',
            'time': '${DateTime.now().hour}:${DateTime.now().minute}'
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF666666)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFF003EC7).withOpacity(0.1),
              child: const Icon(Icons.psychology, color: Color(0xFF003EC7), size: 20),
            ),
            const SizedBox(width: 12),
            const Text(
              'AI Kariyer Danışmanı',
              style: TextStyle(color: Color(0xFF191C1E), fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.length == 1 
              ? _buildWelcomeState() 
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    return _buildMessageBubble(msg['text'], msg['isMe'], msg['time']);
                  },
                ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildWelcomeState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF003EC7).withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome, size: 48, color: Color(0xFF003EC7)),
          ),
          const SizedBox(height: 24),
          const Text(
            'Hemen Sohbete Başla',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
          ),
          const SizedBox(height: 12),
          const Text(
            'Kariyerinle ilgili her türlü soruyu sorabilir, mülakat simülasyonları yapabiliriz.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Color(0xFF666666), height: 1.5),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: suggestions.map((s) => _buildSuggestionChip(s)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String text) {
    return GestureDetector(
      onTap: () => _sendMessage(text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFC3C5D9)),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF434656)),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isMe, String time) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF003EC7) : const Color(0xFFF3F2EF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(color: isMe ? Colors.white : const Color(0xFF191C1E), fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Mesajını yaz...',
                  filled: true,
                  fillColor: const Color(0xFFF3F2EF),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                ),
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(Icons.send, color: Color(0xFF003EC7)),
              onPressed: () => _sendMessage(_messageController.text),
            ),
          ],
        ),
      ),
    );
  }
}
