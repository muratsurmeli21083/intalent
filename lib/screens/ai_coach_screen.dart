import 'package:flutter/material.dart';

class AiCoachScreen extends StatefulWidget {
  const AiCoachScreen({super.key});

  @override
  State<AiCoachScreen> createState() => _AiCoachScreenState();
}

class _AiCoachScreenState extends State<AiCoachScreen> {
  final List<Map<String, dynamic>> _messages = [
    {
      'isAi': true,
      'text': 'Merhaba, Ben Kariyer Koçun. Kariyer hedeflerin için analiz yapmaya ve en iyi fırsatları bulmaya hazırım.',
    },
    {
      'isAi': true,
      'text': 'Bugün profilini inceledim. Senior Product Designer pozisyonları için %92 uyumluluk gösteriyorsun. CV\'ni bu pozisyonlara göre optimize etmemi ister misin?',
    },
    {
      'isAi': false,
      'text': 'Evet, lütfen. Ayrıca bana uygun açık pozisyonları da listeler misin?',
    },
    {
      'isAi': true,
      'text': 'Harika fikir! İşte senin için seçtiğim, profilinle en çok eşleşen fırsat:',
      'jobCard': {
        'title': 'Senior UX/UI Designer',
        'company': 'Tech Global',
        'match': '%94 Uyum',
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2EF),
      appBar: AppBar(
        title: const Text('AI Kariyer Danışmanı'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Color(0xFF666666)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(msg);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> msg) {
    final isAi = msg['isAi'] as bool;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: isAi ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAi)
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                backgroundColor: const Color(0xFF003EC7),
                radius: 16,
                child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
              ),
            ),
          Flexible(
            child: Column(
              crossAxisAlignment: isAi ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isAi ? Colors.white : const Color(0xFF003EC7),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: Radius.circular(isAi ? 0 : 12),
                      bottomRight: Radius.circular(isAi ? 12 : 0),
                    ),
                    boxShadow: [
                      if (isAi)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                    ],
                  ),
                  child: Text(
                    msg['text'],
                    style: TextStyle(
                      color: isAi ? Colors.black87 : Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (msg['jobCard'] != null) ...[
                  const SizedBox(height: 12),
                  _buildMiniJobCard(msg['jobCard']),
                ],
              ],
            ),
          ),
          if (!isAi)
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: const CircleAvatar(
                backgroundColor: Color(0xFFEEEEEE),
                radius: 16,
                child: Icon(Icons.person, color: Color(0xFF666666), size: 16),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMiniJobCard(Map<String, String> job) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF003EC7).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            job['title']!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Text(
            job['company']!,
            style: const TextStyle(color: Color(0xFF666666), fontSize: 11),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                job['match']!,
                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 11),
              ),
              const Icon(Icons.arrow_forward_ios, size: 10, color: Color(0xFF003EC7)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Kariyer koçuna bir şey sor...',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            CircleAvatar(
              backgroundColor: const Color(0xFF003EC7),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white, size: 20),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
