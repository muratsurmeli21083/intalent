import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AiCoachScreen extends StatefulWidget {
  const AiCoachScreen({super.key});

  @override
  State<AiCoachScreen> createState() => _AiCoachScreenState();
}

class _AiCoachScreenState extends State<AiCoachScreen> {
  final List<Map<String, String>> _messages = [
    {
      'role': 'assistant',
      'content': 'Hoş geldin. Ben senin kariyer yolculuğundaki profesyonel koçunum. Bugün odaklanmak istediğin, senin için gerçekten önemli olan konu nedir?'
    }
  ];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  int _sessionCredits = 1; // Başlangıçta 1 ücretsiz kredi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      body: Row(
        children: [
          // Sol Panel: Koçluk Bilgileri ve Krediler
          _buildInfoPanel(),
          
          // Sağ Panel: Chat Alanı
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildChatList()),
                _buildInputArea(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoPanel() {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          _buildBadge('MASTER COACH (PCC)'),
          const SizedBox(height: 16),
          Text(
            'Profesyonel\nLiderlik Koçu',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.2,
              color: const Color(0xFF1A1F36),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Adler ve Gestalt ekollerini temel alan, farkındalık odaklı bir gelişim seansı.',
            style: TextStyle(color: Colors.grey, height: 1.5),
          ),
          const Spacer(),
          _buildCreditCard(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E7FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFF4F46E5), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
      ),
    );
  }

  Widget _buildCreditCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: const Color(0xFF4F46E5).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('SEANS KREDİSİ', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(
            '$_sessionCredits Seans Kaldı',
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF4F46E5),
              elevation: 0,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('KREDİ SATIN AL', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        children: [
          const Icon(Icons.psychology_outlined, color: Color(0xFF4F46E5)),
          const SizedBox(width: 12),
          Text(
            'Aktif Seans: Kariyer Dönüşümü',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, color: const Color(0xFF1A1F36)),
          ),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final msg = _messages[index];
        bool isUser = msg['role'] == 'user';
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Row(
            mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isUser) _buildAvatar('AI'),
              const SizedBox(width: 16),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isUser ? const Color(0xFF4F46E5) : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(24),
                      topRight: const Radius.circular(24),
                      bottomLeft: Radius.circular(isUser ? 24 : 4),
                      bottomRight: Radius.circular(isUser ? 4 : 24),
                    ),
                    boxShadow: [
                      if (!isUser) BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))
                    ],
                  ),
                  child: Text(
                    msg['content']!,
                    style: TextStyle(
                      color: isUser ? Colors.white : const Color(0xFF374151),
                      height: 1.6,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              if (isUser) _buildAvatar('Ben'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatar(String label) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: label == 'AI' ? const Color(0xFFEEF2FF) : const Color(0xFF4F46E5),
      child: Text(
        label[0],
        style: TextStyle(
          fontSize: 12,
          color: label == 'AI' ? const Color(0xFF4F46E5) : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 30, offset: const Offset(0, 10))],
        ),
        child: Row(
          children: [
            const SizedBox(width: 24),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Düşüncelerini buraya yaz...',
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            IconButton(
              onPressed: _sendMessage,
              icon: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(color: Color(0xFF4F46E5), shape: BoxShape.circle),
                child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    
    setState(() {
      _messages.add({'role': 'user', 'content': _controller.text});
      _isTyping = true;
    });
    
    _controller.clear();
    _scrollToBottom();
    
    // AI Cevabı (Maliyet odaklı gecikme simülasyonu)
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'role': 'assistant',
            'content': 'Anlıyorum. Bu anlattığın durumun, senin en baştaki hedefinle olan bağlantısını nasıl kurarsın?'
          });
          _isTyping = false;
        });
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}
